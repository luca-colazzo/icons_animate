<h1 align="center">Icons Animate</h1>

<p align="center">
  This is a Flutter package to make a custom <a href="https://api.flutter.dev/flutter/material/AnimatedIcon-class.html">AnimatedIcon</a> from two Icons.<br/>
  This package is born to make AnimatedIcons easily available for any Icon and not only the few default ones
</p>

<p align="center">
  <img alt="GitHub branch checks state" src="https://img.shields.io/github/checks-status/luca-colazzo/icons_animate/master">
  <img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/luca-colazzo/icons_animate">
  <br/>
  <img alt="Pub Version" src="https://img.shields.io/pub/v/icons_animate">
  <img alt="Pub Points" src="https://img.shields.io/pub/points/icons_animate">
  <br/>
  <img alt="GitHub license" src="https://img.shields.io/github/license/luca-colazzo/icons_animate">
  <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/luca-colazzo/icons_animate">
  <img alt="GitHub issues" src="https://img.shields.io/github/issues/luca-colazzo/icons_animate">
  <img alt="GitHub closed issues" src="https://img.shields.io/github/issues-closed/luca-colazzo/icons_animate">

</p>

## Features

Here are some examples of animated icons.
> Note that you can provide any Icon that is of type `IconData` to the animator

![example gif](https://raw.githubusercontent.com/luca-colazzo/icons_animate/master/.media/example.gif)

You can see an example of some icons being animated in the [Sample Project](example/lib/main.dart)

## Getting started

To install the package just do:
```
flutter pub add icons_animate
flutter pub get
```
OR add the dependency manually to your `pubspec.yaml` file:
```yaml
dependencies:
  icons_animate: ^0.0.2
```
Then depend on it in your class:
```dart
import 'package:icons_animate/icons_animate.dart';
```

## Usage

Here is a simple implementation:
```dart
AnimateIcons(
    startIcon: Icons.add_circle,
    endIcon: Icons.add_circle_outline,
    size: 100.0,
    controller: controller,
    startTooltip: 'Icons.add_circle',
    endTooltip: 'Icons.add_circle_outline',
    // add this for splashColor, default is Colors.transparent means no click effect
    splashColor: Colors.blueAccent.shade100.withAlpha(50),
    // add this to specify a custom splashRadius
    // default is Material.defaultSplashRadius (35)
    splashRadius: 24,
    onStartIconPress: () {
        print("Clicked on Add Icon");
        return true;
    },
    onEndIconPress: () {
        print("Clicked on Close Icon");
        return true;
    },
    duration: Duration(milliseconds: 500),
    startIconColor: Colors.deepPurple,
    endIconColor: Colors.deepOrange,
    clockwise: false,
),
```


See [Example Code](example/lib/main.dart) for more info.

### Issues & Feedback

Please file an [issue](https://github.com/luca-colazzo/icons_animate/issues) to send feedback or report a bug,
If you want to ask a question or suggest an idea then you can [open an discussion](https://github.com/luca-colazzo/icons_animate/discussions).
Thank you!

### Contributing

Every PR is welcome.
