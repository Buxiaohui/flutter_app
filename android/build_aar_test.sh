#!/usr/bin/env bash

# ---定义方法 start---

uploadAars(){
dir=././outputs/android-arm-release
for file in $dir/*
do
# ././outputs/android-arm-release/app-release.aar
# ././outputs/android-arm-release/audioplayers-release.aar
# /./outputs/android-arm-release/flutter_webview_plugin-release.aar
# ././outputs/android-arm-release/path_provider-release.aar
# ././outputs/android-arm-release/fluttertoast-release.aar
# /./outputs/android-arm-release/simple_permissions-release.aar
# ././outputs/android-arm-release/video_player-release.aar
    echo $file
    mvn deploy:deploy-file -e -Dfile=$file -DgroupId=com.baidu.bnavi -DartifactId=flutter_lib -Dversion=0.0.1 -Durl='http://127.0.0.1:8081/nexus/content/repositories/com.baidu.bnavi/'  -Dpackaging='aar'  -DrepositoryId=nexus-snapshots

done
}
# ---定义方法 end---

#---start-----
# ././outputs/android-arm-release/app-release.aar
# ././outputs/android-arm-release/audioplayers-release.aar
# /./outputs/android-arm-release/flutter_webview_plugin-release.aar
# ././outputs/android-arm-release/path_provider-release.aar
# ././outputs/android-arm-release/fluttertoast-release.aar
# /./outputs/android-arm-release/simple_permissions-release.aar
# ././outputs/android-arm-release/video_player-release.aar

dir=././outputs/android-arm-release
file1=././outputs/android-arm-release/app-release.aar
file2=././outputs/android-arm-release/audioplayers-release.aar
file3=././outputs/android-arm-release/flutter_webview_plugin-release.aar
file4=././outputs/android-arm-release/path_provider-release.aar
file5=././outputs/android-arm-release/fluttertoast-release.aar
file6=/./outputs/android-arm-release/simple_permissions-release.aar
file7=././outputs/android-arm-release/video_player-release.aar
#uploadAars
mvn deploy:deploy-file -e -Dfile=$dir  -DgroupId=com.baidu.bnavi -DartifactId=flutter_lib -Dversion=0.0.5 -Durl='http://127.0.0.1:8081/nexus/content/repositories/com.baidu.bnavi/'  -Dpackaging='aar'  -DrepositoryId=nexus-snapshots

#---end-----

