#!/usr/bin/env sh

msg() {
	tput smso
	echo "$1"
	tput rmso
}

msg "Set virtual camera device to /dev/video10 with v4l2loopback"
sudo modprobe v4l2loopback devices=1 video_nr=10 card_label="OBS Feed" exclusive_caps=1

mkdir obs-build
msg "Made obs-build dir for building OBS v4l2sink"
cd obs-build

msg "Build OBS v4l2sink"
git clone --recursive https://github.com/obsproject/obs-studio.git
git clone https://github.com/CatxFish/obs-v4l2sink.git
mkdir obs-v4l2sink/build
cd obs-v4l2sink/build
cmake -DLIBOBS_INCLUDE_DIR="../../obs-studio/libobs" -DCMAKE_INSTALL_PREFIX=/usr ..
make -j4
sudo make install
cd ../../

tput smso
msg "Build complete, now configure OBS"
cat << EOF
Open OBS
Tools > V4l2sink
Settings:
- AutoStart: true
- Device: /dev/video10
EOF

echo ""
echo "When complete, sources are in ./obs-build/ you may want to delete the directory"
