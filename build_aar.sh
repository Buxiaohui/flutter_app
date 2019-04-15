#!/usr/bin/env bash

# ---定义方法 start---
copyPluginAars(){
    for line in $(cat .flutter-plugins)
    do
        echo $line
        plugin_name=${line%%=*}
        echo $plugin_name
        if [ "$gradle_com" == "assembleDebug" ]
        then
              cp  build/$plugin_name/outputs/aar/*debug.aar outputs/android-arm-debug/
        else
              cp  build/$plugin_name/outputs/aar/*release.aar outputs/android-arm-release/
        fi

    done
}
copyAppAars(){
    if [ "$gradle_com" == "assembleDebug" ]
    then
         cp  build/app/outputs/aar/*debug.aar outputs/android-arm-debug/
    else
         cp  build/app/outputs/aar/*release.aar outputs/android-arm-release/
    fi

}

copyFlutterJar(){
   cp /Users/buxiaohui/flutter/bin/cache/artifacts/engine/android-arm-release/flutter.jar outputs/android-arm-release/
   cp /Users/buxiaohui/flutter/bin/cache/artifacts/engine/android-arm/flutter.jar outputs/android-arm-release/
}


# 修改AndroidManifest.xml 仅保留权限相关的line
changAndroidManifest(){
#  application_tag_content_str=$(grep -i '<application' android/app/src/main/AndroidManifest.xml)
#  echo "---changAndroidManifest--application_tag_content_str---$application_tag_content_str"
#  sed -i '.backup' "s/$application_tag_content_str/''/g"  android/app/src/main/AndroidManifest.xml
   mv  "android/app/src/main/AndroidManifest.xml" "android/app/src/main/AndroidManifest.xml.backup"
   mv  "android/app/src/main/AndroidManifest.xml.aar_backup" "android/app/src/main/AndroidManifest.xml"
}

# 修改AndroidManifest.xml 仅保留权限相关的line
recoveryAndroidMainfest(){
  mv  "android/app/src/main/AndroidManifest.xml" "android/app/src/main/AndroidManifest.xml.aar_backup"
  mv  "android/app/src/main/AndroidManifest.xml.backup" "android/app/src/main/AndroidManifest.xml"
}

# ---定义方法 end---


#---start-----
basepath=$(cd `dirname $0`; pwd)
echo "current directory is: $basepath"
# 修改build.gradle
echo -e "\033[4;35m 修改build.gradle \033[0;0m"
sed -i '.backup' "s/apply plugin: 'com.android.application'/apply plugin: 'com.android.library'/g"  android/app/build.gradle

# 修改AndroidManifest.xml
echo -e "\033[4;35m 修改AndroidManifest.xml \033[0;0m"
changAndroidManifest

# 执行构建
echo -e "\033[4;35m 执行构建 \033[0;0m"
cd android
gradle_com="$1"
if [ "$gradle_com" == "assembleDebug" ]
then
	./gradlew $1
else
	./gradlew assembleRelease
fi

# 撤销对build.gradle的修改
echo -e "\033[4;35m 撤销对build.gradle的修改 \033[0;0m"
cd ..
sed -i '.temp_backup' "s/apply plugin: 'com.android.library'/apply plugin: 'com.android.application'/g"  android/app/build.gradle

# 撤销对AndroidManifest.xml 的修改
echo -e "\033[4;35m 撤销对AndroidManifest.xml的修改\033[0;0m"
recoveryAndroidMainfest
# 重置产物收集目录 & 收集产物到产物收集目录
echo -e "\033[4;35m 重置产物收集目录 & 收集产物到产物收集目录 \033[0;0m"
echo -e "\033[4;35m 构建命令：$gradle_com \033[0;0m"
if [ "$gradle_com" == "assembleDebug" ]
then
     find . -name "android-arm-debug" | xargs rm -rf
     mkdir -p outputs/android-arm-debug
else
     find . -name "android-arm-release" | xargs rm -rf
     mkdir -p outputs/android-arm-release
fi

# 收集plugin -> aar
echo -e "\033[4;35m 收集plugin -> aar \033[0;0m"
copyPluginAars

# 收集app -> aar
echo -e "\033[4;35m 收集app -> aar \033[0;0m"
copyAppAars

# Copy flutter.jar
echo -e "\033[4;35m Copy flutter.jar \033[0;0m"
copyFlutterJar

#---end-----

