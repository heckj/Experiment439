# Experiment439

An experiment in creating useful 3D visualizations using Apple's SceneKit. The visualizations are aimed at 
general data visualization, similiar to charts and graphs, and taking quite a bit of inspiration from D3. The resulting
SceneKit files are aimed at being animatable, dynamic, and interactive, depending on the visualization.

The experiment is partially about the visualizations, and partially to work out an effect API for a 3D visualization toolkit,
inspired by D3 and other charting libraries (such as IOSCharts).

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


scenekit tutorials:
- https://code.tutsplus.com/tutorials/combining-the-power-of-spritekit-and-scenekit--cms-24049
- https://code.tutsplus.com/tutorials/an-introduction-to-scenekit-user-interaction-animations-physics--cms-23877
- https://github.com/rogerboesch/SceneKitTutorial
- https://www.raywenderlich.com/1260-scene-kit-tutorial-with-swift-part-2-nodes
- https://code.tutsplus.com/tutorials/an-introduction-to-scenekit-fundamentals--cms-23847
- https://developer.apple.com/documentation/scenekit/organizing_a_scene_with_nodes

