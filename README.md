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


SceneKit tutorials:

- https://developer.apple.com/documentation/scenekit/organizing_a_scene_with_nodes

- https://code.tutsplus.com/tutorials/combining-the-power-of-spritekit-and-scenekit--cms-24049
- https://code.tutsplus.com/tutorials/an-introduction-to-scenekit-user-interaction-animations-physics--cms-23877
- https://code.tutsplus.com/tutorials/an-introduction-to-scenekit-fundamentals--cms-23847
- https://www.raywenderlich.com/1260-scene-kit-tutorial-with-swift-part-2-nodes
- https://github.com/rogerboesch/SceneKitTutorial

visualization ideas that I think I'd like to try and enable with these experiments (maybe creating a basic gallery):

- 1-dimensional plot 
  - (single axis) with color/size of resulting object representing something (capacity/util of a set of nodes)
  
- 2-dimensional plot
  - classic time series data, single series - time as one axis, values at time the other
  - "layered" 2-dimensional plots (mult time series data, for example sharing the same time axis)

- 3-dimensional plots
  - a classic 2D plot layed out against a dimension of time
  - a 2D time series plot folded up to provide a day-of-week against a year, or hour against a day aggregate view
  - a 2D layout/structure repeated in layers showing progression in time (maybe set of services, connected to show relations, and laying out over time - showing most recent, and then past states at various time intervals)
  - a full 3 dimensional plot (3 dimensions of data - but what?)
    - x,y (map) location and count/value at that dimension?
