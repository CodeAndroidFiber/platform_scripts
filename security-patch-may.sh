#!/bin/bash
# android 6.0.1 security bulletin - may 2016
# config
REPO=https://android.googlesource.com/platform
build_root=/home/olddroid/android/mm
paths=('external/aac' 'external/flac' 'system/core' 'system/bt' 'frameworks/native' 'external/wpa_supplicant_8' 'frameworks/av' 'external/conscrypt' 'external/boringssl' 'frameworks/base' 'packages/apps/UnifiedEmail' 'packages/apps/Email')
patches=(
  # 1. external/aac
  '5d4405f601fa11a8955fd7611532c982420e4206'
  # 2. external/flac
  'b499389da21d89d32deff500376c5ee4f8f0b04c'
  # 3. system/core
  'ad54cfed4516292654c997910839153264ae00a0'
  # 4. system/bt
  '9b534de2aca5d790c2a1c4d76b545f16137d95dd'
  # 5. frameworks/native
  'a59b827869a2ea04022dd225007f29af8d61837a a30d7d90c4f718e46fb41a99b3d52800e1011b73'
  # 6. external/wpa_supplicant_8
  'b79e09574e50e168dd5f19d540ae0b9a05bd1535 b845b81ec6d724bd359cdb77f515722dd4066cf8'
  # 7. frameworks/av
  'a2d1d85726aa2a3126e9c331a8e00a8c319c9e2b b04aee833c5cfb6b31b8558350feb14bb1a0f353 7fd96ebfc4c9da496c59d7c45e1f62be178e626d f9ed2fe6d61259e779a37d4c2d7edb33a1c1f8ba 44749eb4f273f0eb681d0fa013e3beef754fa687 65756b4082cd79a2d99b2ccb5b392291fd53703f daa85dac2055b22dabbb3b4e537597e6ab73a866'
  # 8. external/conscrypt
  '50d0447566db4a77d78d592f1c1b5d31096fac8f 1638945d4ed9403790962ec7abed1b7a232a9ff8 8bec47d2184fca7e8b7337d2a65b2b75a9bc8f54'
  # 9. external/boringssl
  '591be84e89682622957c8f103ca4be3a5ed0f800'
  # 10. frameworks/base
  '12332e05f632794e18ea8c4ac52c98e82532e5db'
  # 11. packages/apps/UnifiedEmail
  'a55168330d9326ff2120285763c818733590266a'
  # 12. packages/apps/Email
  '2791f0b33b610247ef87278862e66c6045f89693'
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
