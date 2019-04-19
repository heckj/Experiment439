# Experiment439

## build and dev tooling

Xcode and a few helpers:

    brew install swiftlint
    brew install swiftformat

(because I tend to be pretty inconsistent and like the warnings)

## Command Line Building

view all the settings:

    xcodebuild -showBuildSettings

view the schemes and targets:

    xcodebuild -list

view destinations:

    xcodebuild -scheme picturegrid -showdestinations

do a build:

    xcodebuild -scheme picturegrid -sdk iphoneos12.2 -configuration Debug
    xcodebuild -scheme picturegrid -sdk iphoneos12.2 -configuration Release

run the tests:

    xcodebuild clean test -scheme picturegrid -sdk iphoneos12.2 -destination 'platform=iOS Simulator,OS=12.2,name=iPhone 5s' | xcpretty --color


