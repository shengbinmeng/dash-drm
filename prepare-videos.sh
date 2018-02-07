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

cd -
