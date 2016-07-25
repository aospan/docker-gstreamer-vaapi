#!/bin/bash 
set -e

#change 'master' to '1.8' if you want to build stable gstreamer branch
GST_BRANCH="master"
VAAPI_BRANCH="master"

DIST_DIR=/opt/gstreamer-dist-$GST_BRANCH
BUILD_DIR=/opt/gstreamer-build-$GST_BRANCH

[ ! -d $BUILD_DIR ] && mkdir $BUILD_DIR
[ ! -d $DIST_DIR ] && mkdir $DIST_DIR

cd $BUILD_DIR

[ ! -d gstreamer ] && git clone -b $GST_BRANCH git://anongit.freedesktop.org/git/gstreamer/gstreamer
[ ! -d gst-plugins-base ] && git clone -b $GST_BRANCH git://anongit.freedesktop.org/git/gstreamer/gst-plugins-base
[ ! -d gst-plugins-good ] && git clone -b $GST_BRANCH git://anongit.freedesktop.org/git/gstreamer/gst-plugins-good
[ ! -d gst-plugins-bad ] && git clone -b $GST_BRANCH git://anongit.freedesktop.org/git/gstreamer/gst-plugins-bad
[ ! -d gst-plugins-ugly ] && git clone -b $GST_BRANCH git://anongit.freedesktop.org/git/gstreamer/gst-plugins-ugly
[ ! -d gst-libav ] && git clone -b $GST_BRANCH git://anongit.freedesktop.org/git/gstreamer/gst-libav
[ ! -d gstreamer-vaapi ] && git clone -b $VAAPI_BRANCH https://anongit.freedesktop.org/git/gstreamer/gstreamer-vaapi.git
[ ! -d drm ] && git clone http://anongit.freedesktop.org/git/mesa/drm.git
[ ! -d libva ] && git clone http://anongit.freedesktop.org/git/libva.git
[ ! -d intel-driver ] && git clone http://anongit.freedesktop.org/git/vaapi/intel-driver.git

export PKG_CONFIG_PATH=$DIST_DIR/lib/pkgconfig

#unset intel media sdk variables
unset LIBVA_DRIVERS_PATH
unset LIBVA_DRIVER_NAME

for prj in gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav drm libva intel-driver gstreamer-vaapi
do
    (cd $prj && ./autogen.sh --prefix=$DIST_DIR --disable-gtk-doc --disable-oss4 && make -j 4 && make -j 4 install)
done

echo "environment settings:"
echo "export PKG_CONFIG_PATH=$DIST_DIR/lib/pkgconfig"
