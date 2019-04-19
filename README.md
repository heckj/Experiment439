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

    xcodebuild -scheme Experiment439 -showdestinations

do a build:

    xcodebuild -scheme Experiment439 -configuration Debug
    xcodebuild -scheme Experiment439 -configuration Release

run the tests:

    xcodebuild clean test -scheme Experiment439 | xcpretty --color


