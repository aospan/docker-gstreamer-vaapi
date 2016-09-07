#!/bin/bash

time /opt/gstreamer-dist-master/bin/gst-launch-1.0 \
    --gst-plugin-path=/opt/gstreamer-dist-master/lib \
    -v --gst-debug-level=0 --gst-debug-no-color \
    filesrc location=/opt/moscow24.ts ! queue ! tsdemux name=tdemux \
    tdemux. ! queue ! audio/mpeg ! mpegaudioparse ! avdec_mp3 ! audioresample ! audioconvert ! faac bitrate=64000 ! queue ! tmux. \
    tdemux. ! queue ! mpegvideoparse ! vaapidecodebin ! \
    vaapipostproc force-aspect-ratio=false scale-method=2 width=320 height=240 deinterlace-method=2 deinterlace-mode=1 ! \
    video/x-raw,interlace-mode=progressive ! \
    vaapih264enc bitrate=256 tune=1 rate-control=2 ! \
    video/x-h264,profile=baseline ! h264parse ! queue ! tmux. \
    mpegtsmux name=tmux ! filesink location=/opt/moscow24-out.ts
