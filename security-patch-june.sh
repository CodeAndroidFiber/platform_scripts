#!/bin/bash
# android 6.0.1 security bulletin - june 2016
# config
REPO=https://android.googlesource.com/platform
build_root=/home/olddroid/android/mm
paths=('frameworks/av' 'external/libvpx' 'hardware/qcom/media' 'system/core' 'frameworks/native' 'frameworks/base' 'packages/apps/PackageInstaller')
patches=(
  # 1. frameworks/av
  '2b6f22dc64d456471a1dc6df09d515771d1427c8 295c883fe3105b19bcd0f9e07d54c6b589fc5bff 94d9e646454f6246bf823b6897bd6aea5f08eda3 0bb5ced60304da7f61478ffd359e7ba65d72f181 db829699d3293f254a7387894303451a91278986 7cea5cb64b83d690fe02bc210bbdf08f5a87636f ad40e57890f81a3cf436c5f06da66396010bd9e5 918eeaa29d99d257282fafec931b4bda0e3bae12 d2f47191538837e796e2b10c1ff7e1ee35f6e0ab 4e32001e4196f39ddd0b86686ae0231c8f5ed944 45737cb776625f17384540523674761e6313e6d4 b57b3967b1a42dd505dbe4fcf1e1d810e3ae3777 dd3546765710ce8dd49eb23901d90345dec8282f'
  # 2. external/libvpx
  'cc274e2abe8b2a6698a5c47d8aa4bb45f1f9538d 65c49d5b382de4085ee5668732bcb0f6ecaf7148'
  # 3. hardware/qcom/media
  'f22c2a0f0f9e030c240468d9d18b9297f001bcf0 46e305be6e670a5a0041b0b4861122a0f1aabefa 560ccdb509a7b86186fac0fce1b25bd9a3e6a6e8 89913d7df36dbeb458ce165856bd6505a2ec647d'
  # 4. system/core
  '864e2e22fcd0cba3f5e67680ccabd0302dfda45d'
  # 5. frameworks/native
  '03a53d1c7765eeb3af0bc34c3dff02ada1953fbf'
  # 6. frameworks/base
  '613f63b938145bb86cd64fe0752eaf5e99b5f628 9878bb99b77c3681f0fda116e2964bac26f349c3'
  # 7. packages/apps/PackageInstaller
  '2068c7997265011ddc5e4dfa3418407881f7f81e'
)

function apply() {
  for((i=0; i<${#paths[@]}; i++))
  do
    cd $build_root/${paths[$i]}
    [ $(git remote | egrep \^aosp) ] && git remote rm aosp
    git remote add aosp $REPO/${paths[$i]}/
    git fetch aosp
    git cherry-pick ${patches[$i]}
    git remote rm aosp
  done
}

apply

cd $build_root
