#!/bin/sh

# 删除pods缓存
PODS_CACHE_DIR=~/Library/Caches/Cocoapods/Pods
rm -rf $PODS_CACHE_DIR

# 打包framework
pod package ACEasyKit.podspec --force
