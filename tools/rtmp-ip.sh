#!/bin/bash 

host=mohair.local
fifo="live.fifo.h264"
bitrate="800000"
gop="200"

set -x

rm -f "$fifo"
mkfifo "$fifo"

raspivid \
  -w 1280 -h 720 -fps 25 -g $gop \
  -hf -vf \
  -t 0 -b $bitrate -o - | psips | nc $host 1616

# vim:ts=2:sw=2:sts=2:et:ft=sh
