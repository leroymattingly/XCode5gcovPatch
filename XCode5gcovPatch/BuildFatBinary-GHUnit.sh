#!/bin/bash


 xcodebuild -sdk iphoneos        -configuration Release -target XCode5gcovPatch-Automation
 xcodebuild -sdk iphonesimulator -configuration Release -target XCode5gcovPatch-Automation


lipo -create \
    -output ./libXCode5gcovPatch-Automation.a \
    "/Users/dodikk/projects/tools/XCode5gcovPatch/XCode5gcovPatch/build/Release-iphoneos/libXCode5gcovPatch-Automation.a" \
    "/Users/dodikk/projects/tools/XCode5gcovPatch/XCode5gcovPatch/build/Release-iphonesimulator/libXCode5gcovPatch-Automation.a"
