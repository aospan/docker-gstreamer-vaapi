# gstreamer + gstreamer-vaapi docker image for Intel Quick Sync decode/encode/vpp processing

## For starting need to run following command:
`make`

this command will create docker image based on 'ubuntu:16.04' and compile all gstreamer related projects. Here is a list compiled projects:
**gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav drm libva intel-driver gstreamer-vaapi**

projects compiled from git repositories using 'master' branch (should be latest and full of new features/bugs). If you want to build stable release please change `opt/build-gstreamer-vaapi.sh` file.

## Run container
`make run`

After starting container you will see something like this:
`root@dbbc5ddfc092:/#`

Now you can run test MPEG2 to H264 transcoding using following command:
`/opt/transode-file.sh`

On my NUC (i5-4250U) it takes 6 seconds to transcode file with about 100 sec length.

Input file is `/opt/moscow24.ts`:
```
 Stream #0:0[0x145]: Video: mpeg2video (Main) ([2][0][0][0] / 0x0002), yuv420p(tv), 720x576 [SAR 16:15 DAR 4:3]
 Stream #0:1[0x195](rus): Audio: mp2 ([4][0][0][0] / 0x0004), 48000 Hz, stereo, s16p, 192 kb/s (clean effects)
```

Output file is `/opt/moscow24-out.ts`:
```
 Stream #0:0[0x41](ru): Audio: aac (LC) ([15][0][0][0] / 0x000F), 48000 Hz, stereo, fltp, 150 kb/s
 Stream #0:1[0x42]: Video: h264 (Constrained Baseline) (HDMV / 0x564D4448), yuv420p, 320x240 [SAR 1:1 DAR 4:3], 50 fps, 50 tbr, 90k tbn, 100 tbc
```
For more info please check this article:
https://jokersys.com/2016/12/02/video-decode-encode-intel-gpu-intel-quick-sync-joker/
