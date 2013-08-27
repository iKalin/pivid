#!/bin/bash 

#url=rtmp://newstream.hexten.net:1935/throne/tc1
url=rtmp://newstream.fenkle:1935/src/mag
fifo="live.fifo.h264"
bitrate="3800000"
gop="200"

set -x

rm -f "$fifo"
mkfifo "$fifo"

raspivid \
  -w 1280 -h 720 -fps 25 -g $gop \
  -hf -vf \
  -t 0 -b $bitrate -o - | psips > "$fifo" &

ffmpeg -y \
  -an \
  -f h264 \
  -i "$fifo" \
  -c:v copy \
  -map 0:0 \
  -f flv "$url"

# vim:ts=2:sw=2:sts=2:et:ft=sh
