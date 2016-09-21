#!/bin/bash

# receive video (MJPEG) from camera (Foscam FI8919W Outdoor Wireless)
# decode on Intel GPU
# convert to RGB and apply opencv text overlay
# convert to I420
# encode to H264 on Intel GPU
# export to HLS directory /var/www/html/

time /opt/gstreamer-dist-master/bin/gst-launch-1.0 \
    --gst-plugin-path=/opt/gstreamer-dist-master/lib \
    -v --gst-debug-level=0 --gst-debug-no-color \
    souphttpsrc location="http://admin:netup123@192.168.1.129/videostream.cgi?resolution=32&rate=0" do-timestamp=true ! \
    queue ! decodebin name=dec ! identity silent=false ! \
    queue ! videoconvert ! \
    opencvtextoverlay text="cam0-test" xpos="10" ypos="450" colorR="255" colorG="255" colorB="255" ! \
    videoconvert ! video/x-raw, format=I420, interlace-mode=progressive ! \
    vaapih264enc ! \
    video/x-h264,profile=baseline ! \
    h264parse ! queue ! tmux. \
    mpegtsmux name=tmux ! \
    queue ! hlssink location=/var/www/html/segment%05d.ts playlist-location=/var/www/html/p.m3u8
