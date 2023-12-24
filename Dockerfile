# syntax=docker/dockerfile:1.6.0
FROM debian:12-slim AS builder

# GitHubからGitのソースをADD
ADD https://github.com/git/git.git /tmp/src/

# Gitをソースからビルド
RUN <<EOF
# ビルドに必要なツールをインストール
apt-get update
apt-get install -y libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev g++ make autoconf

# ソースからインストール
cd /tmp/src/
make configure
./configure --prefix=/usr
make all
make install

# ゴミ掃除
apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/src/
EOF
