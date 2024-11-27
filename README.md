# Micro Loaders

[![Format, Analyze and Test](https://github.com/MicroClub-USTHB/flutter_loaders/actions/workflows/main.yml/badge.svg)](https://github.com/MicroClub-USTHB/flutter_loaders/actions/workflows/main.yml)

A collection of animated loaders with flutter made by [Micro Club - USTHB](https://github.com/MicroClub-USTHB).

## What is Micro Club ?

Micro Club is a scientific club established in 1985 at USTHB. It is the first Algerian scientific club dedicated to computer science and technology, with over 1000 members passionate about technology and collaboration. MicroClub fosters scientific innovation and nurtures young talents in the field of technology through various activities, events, and projects.

## Installing

```yaml
dependencies:
  micro_loaders: ^0.0.1
```

### Import

```dart
import 'package:micro_loaders/micro_loaders.dart';
```

## How To Use

```dart
const circleDots = CircleDotsLoader(
  size: 100,
  color: Colors.blue,
  duration: 1
);
```

```dart
final loader = GrowingArcLoader(
  size: 80,
  primaryColor: Colors.white,
  arcColor: Colors.red,
  strokeWidth: 6,
  duration: 1500
);
```

```dart
Center (
  child: FileDownloadLoader(
  totalSize: 100.0,
  downloadSpeed: 5.0
)
) 
```

## Demo

<table>
  <tr>
    <td align="center">
      <img src="demos/CircleArc.gif" width="100px" height="100px"><br />
      CircleArc
    </td>
    <td align="center">
      <img src="demos/CircleDots.gif" width="100px" height="100px"><br />
      CircleDots
    </td>
    <td align="center">
      <img src="demos/CircleRotatingDots.gif" width="100px" height="100px"><br />
      CircleRotating
    </td>
    <td align="center">
      <img src="demos/Circles.gif" width="100px" height="100px"><br />
      Circles
    </td>
    <td align="center">
      <img src="demos/CircularOrbit.gif" width="100px" height="100px"><br />
      CircularOrbit
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="demos/ColorfulDots.gif" width="100px" height="100px"><br />
      ColorfulDots
    </td>
    <td align="center">
      <img src="demos/CrlMug.gif" width="100px" height="100px"><br />
      CrlMug
    </td>
    <td align="center">
      <img src="demos/Dots.gif" width="100px" height="100px"><br />
      Dots
    </td>
    <td align="center">
      <img src="demos/DotsProgress.gif" width="100px" height="100px"><br />
      DotsProgress
    </td>
    <td align="center">
      <img src="demos/DualDots.gif" width="100px" height="100px"><br />
      DualDots
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="demos/DualRotatingExpandingArc.gif" width="100px" height="100px"><br />
      DualRotating
    </td>
    <td align="center">
      <img src="demos/Edge.gif" width="100px" height="100px"><br />
      Edge
    </td>
    <td align="center">
      <img src="demos/ExpandedDualArc.gif" width="100px" height="100px"><br />
      ExpandedDual
    </td>
    <td align="center">
      <img src="demos/ExpandingArc.gif" width="100px" height="100px"><br />
      ExpandingArc
    </td>
    <td align="center">
      <img src="demos/ExpandingTwoHalvesArc.gif" width="100px" height="100px"><br />
      ExpandingHalves
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="demos/Explosion.gif" width="100px" height="100px"><br />
      Explosion
    </td>
    <td align="center">
      <img src="demos/FadeScale.gif" width="100px" height="100px"><br />
      FadeScale
    </td>
    <td align="center">
      <img src="demos/FileDownload.gif" width="100px" height="100px"><br />
      FileDownload
    </td>
    <td align="center">
      <img src="demos/Flowers.gif" width="100px" height="100px"><br />
      Flowers
    </td>
    <td align="center">
      <img src="demos/FourDots.gif" width="100px" height="100px"><br />
      FourDots
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="demos/GrowingArc.gif" width="100px" height="100px"><br />
      GrowingArc
    </td>
    <td align="center">
      <img src="demos/Pendulum.gif" width="100px" height="100px"><br />
      Pendulum
    </td>
    <td align="center">
      <img src="demos/Points.gif" width="100px" height="100px"><br />
      Points
    </td>
    <td align="center">
      <img src="demos/Progress.gif" width="100px" height="100px"><br />
      Progress
    </td>
    <td align="center">
      <img src="demos/PulseRing.gif" width="100px" height="100px"><br />
      PulseRing
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="demos/Rotating.gif" width="100px" height="100px"><br />
      Rotating
    </td>
    <td align="center">
      <img src="demos/RotatingArc.gif" width="100px" height="100px"><br />
      RotatingArc
    </td>
    <td align="center">
      <img src="demos/RotatingDual.gif" width="100px" height="100px"><br />
      RotatingDual
    </td>
    <td align="center">
      <img src="demos/RotatingTwoArc.gif" width="100px" height="100px"><br />
      RotatingTwoArc
    </td>
    <td align="center">
      <img src="demos/ScaleDots.gif" width="100px" height="100px"><br />
      ScaleDots
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="demos/SlidingDots.gif" width="100px" height="100px"><br />
      SlidingDots
    </td>
    <td align="center">
      <img src="demos/SlidingSquare.gif" width="100px" height="100px"><br />
      SlidingSquare
    </td>
    <td align="center">
      <img src="demos/Spinning.gif" width="100px" height="100px"><br />
      Spinning
    </td>
    <td align="center">
      <img src="demos/SpinningBars.gif" width="100px" height="100px"><br />
      SpinningBars
    </td>
    <td align="center">
      <img src="demos/Spiral.gif" width="100px" height="100px"><br />
      Spiral
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="demos/Sun.gif" width="100px" height="100px"><br />
      Sun
    </td>
    <td align="center">
      <img src="demos/Sunchine.gif" width="100px" height="100px"><br />
      Sunchine
    </td>
    <td align="center">
      <img src="demos/Text.gif" width="100px" height="100px"><br />
      Text
    </td>
  </tr>
</table>

## Bugs/Requests

If you encounter any problems, feel free to open an issue. If you feel the library is missing a feature, please raise a ticket on Github and we'll look into it.

### Note

For help getting started with Flutter, the official
[documentation](https://docs.flutter.dev/).

## Authors

<table>
  <tr>
  <td align="center">
      <a href = "https://github.com/MoussaabBadla"><img src="https://avatars.githubusercontent.com/u/106885435?v=4" width="72" alt="Badla Moussaab" /></a>
    </td>
    <td align="center">
      <a href = "https://github.com/slimo30"><img src="https://avatars.githubusercontent.com/u/101450092?v=4" width="72" alt="Slimane Houache" /></a>
    </td>
    <td align="center">
      <a href = "https://github.com/01amine"><img src="https://avatars.githubusercontent.com/u/113193160?v=4" width="72" alt="Heddouche Amine" /></a>
    </td>
    <td align="center">
      <a href = "https://github.com/yasminezegaoui"><img src="https://avatars.githubusercontent.com/u/165675540?v=4" width="72" alt="Zegaoui Yasmine" /></a>
    </td>
    <td align="center">
      <a href = "https://github.com/ramzy1453"><img src="https://media.licdn.com/dms/image/v2/D4E03AQHTotujK0-kBg/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1710199237350?e=1737590400&v=beta&t=2TJNBWi9zdoFA2azJ7LsRxtAfD4apGHJDOya8CqZuKE" width="72" alt="Kemmoun Ramzy" /></a>
    </td>

  </tr> 
</table>

##  License

MIT License
