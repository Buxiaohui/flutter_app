#!/usr/bin/env bash
################### for test   ###############
################### for test   ###############
################### for test   ###############
################### for test   ###############
################### for test   ###############
################### for test   ###############

basepath=$(cd `dirname $0`; pwd)
echo "current directory is: $basepath"

echo -e "\033[4;35m Clean old build \033[0;0m"
find . -d -name "build" | xargs rm -rf
flutter clean

echo -e "\033[4;35m Get packages \033[0;0m"
flutter packages get

echo -e "\033[4;35m Build release AOT \033[0;0m"
flutter build aot --release  --output-dir=build/flutteroutput/aot

echo -e "\033[4;35m Build release Bundle \033[0;0m"
flutter build bundle --precompiled  --asset-dir=build/flutteroutput/flutter_assets


echo -e "\033[4;35m Clean packflutter input(flutter build) \033[0;0m"
rm -f -r android/packflutter/flutter/

# 拷贝flutter.jar
echo -e "\033[4;35m Copy flutter jar \033[0;0m"
mkdir -p android/packflutter/flutter/flutter/android-arm-release && cp /Users/buxiaohui/flutter/bin/cache/artifacts/engine/android-arm-release/flutter.jar "$_"


# 拷贝asset
echo -e "\033[4;35m Copy flutter asset \033[0;0m"
mkdir -p android/packflutter/flutter/assets/release && cp -r build/flutteroutput/aot/* "$_"
mkdir -p android/packflutter/flutter/assets/release/flutter_assets && cp -r build/flutteroutput/flutter_assets/* "$_"

# 将flutter库和flutter_app打成aar 同时publish到Ali-maven
echo -e "\033[4;35m Build and publish idlefish flutter to aar \033[0;0m"
cd android
#if [ -n "$1" ]
#then
#	./gradlew :packflutter:clean :packflutter:publish -PAAR_VERSION=$1
#else
#	./gradlew :packflutter:clean :packflutter:publish
#fi
#cd ../
./gradlew :packflutter:clean :packflutter:uploadArchives
