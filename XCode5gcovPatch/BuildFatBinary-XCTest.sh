#!/bin/bash

 xcodebuild -sdk iphoneos        -configuration Release -target XCode5gcovPatch
 xcodebuild -sdk iphonesimulator -configuration Release -target XCode5gcovPatch


lipo -create \
    -output ./libXCode5gcovPatch.a \
    "/Users/dodikk/projects/tools/XCode5gcovPatch/XCode5gcovPatch/build/Release-iphoneos/libXCode5gcovPatch.a" \
    "/Users/dodikk/projects/tools/XCode5gcovPatch/XCode5gcovPatch/build/Release-iphonesimulator/libXCode5gcovPatch.a"
