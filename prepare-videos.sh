#!/bin/bash

mkdir -p videos
cd videos

wget http://shengbin-static.stor.sinaapp.com/bmw.mp4 -O in.mp4

# MP4
ffmpeg -i in.mp4 out.mp4
ffmpeg -i in.mp4 -encryption_scheme cenc-aes-ctr -encryption_key 00112233445566778899aabbccddeeff -encryption_kid 0123456789abcdef0123456789abcdef out_encrypted.mp4

# HLS
ffmpeg -i in.mp4 out.m3u8
ffmpeg -i in.mp4 -hls_enc 1 -hls_enc_key 0123456789abcdef -hls_enc_key_url out_key.ts out_encrypted.m3u8

# DASH
ffmpeg -i in.mp4 -f dash out.mpd

# DASH with Widevide DRM. See https://www.bento4.com/developers/dash/encryption-and-drm/.
# mp4fragment in.mp4 in-fragment.mp4
# mp4dash --widevine-header provider:widevine_test#content_id:7465737420636f6e74656e74206964 --encryption-key abba271e8bcf552bbd2e86a434a9a5d9:69eaa802a6763af979e8d1940fb88392 in-fragment.mp4
# mv output widevine

cd -
