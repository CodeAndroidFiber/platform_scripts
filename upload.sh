#!/bin/bash
paths=('frameworks/av' 'external/libvpx' 'hardware/qcom/media' 'system/core' 'frameworks/native' 'frameworks/base' 'packages/apps/PackageInstaller')
upload_url=git@github.com:CodeAndroidFiber/platform_
remote_branch=oneplusX/6.0.1
build_root=/home/olddroid/android/mm

function upload() {
  for((i=0; i<${#paths[@]}; i++))
  do
    trimmed_path=$(sed 's/\//\_/g' <<< "${paths[i]}")
    cd $build_root/${paths[$i]}
    [ $(git remote | egrep \^caf-m) ] && git remote rm caf-m
    git remote add caf-m $upload_url$trimmed_path.git
    git branch $remote_branch
    git checkout $remote_branch
    git push caf-m $remote_branch
    #echo "$upload_url$trimmed_path.git"
  done
}

upload

cd $build_root
