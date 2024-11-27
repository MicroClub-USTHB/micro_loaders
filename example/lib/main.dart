import 'package:flutter/material.dart';

import 'package:micro_loaders/micro_loaders.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Micro Loaders',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home:  MyWebApp(),
    );
  }
}




class MyWebApp extends StatelessWidget {
   MyWebApp({super.key});



final loaders = <Widget> [
    const CircleDotsLoader(color: Colors.white, size: 50),
    const CirclesLoader(color: Colors.white, size: 50),
    const CircularOrbitLoader(size: 50, color: Colors.white),
    const CrlMugLoader(size: 50),
    const DotsLoaderView(dotSize: 5, dotColor: Colors.white),
    const DotsProgressLoader(secondColor: Colors.white, size: 5),
    const FileDownloadLoader(totalSize: 500, downloadSpeed: 5, color: Colors.white, size: 50),
    const DualRotatingExpandingArcLoader(outerColor: Colors.white, size: 50),
    const DualExpandingArcLoader(outerColor: Colors.white, size: 50),
    const ExpandingArcLoader(color: Colors.white, size: 50),
    const ExpandingArcTwoColorsLoader(color1: Colors.white, size: 50),
    const ExpandingTwoHalvesArcLoader(color1: Colors.white, size: 50),
    const ExplosionLoader(color: Colors.white, size: 20),
    const FadeScaleLoader(color: Colors.white, size: 50),
    const FlowerLoader(size: 25),
    const FourRotatingDots(size: 50),
    const GrowingArcLoader(primaryColor: Colors.white, size: 75),
    const PendulumLoader(color: Colors.white, size: 20),
    const PointsLoader(color: Colors.white, size: 75),
    const ProgressLoader(borderColor: Colors.white, height: 20, width: 100),
    const PulseRingLoader(color: Colors.white, size: 50),
    const RotatingArcLoader(primaryColor: Colors.white, size: 75),
    const RotatingDualHalfArcLoader(color: Colors.white, size: 50),
    const RotatingLoader(color: Colors.white, size: 50),
    const RotatingTwoArcLoader(outerArcColor: Colors.white, arcSize: 50),
    const ScaleDotsLoader(color: Colors.white, size: 5),
    const SlidingDotsLoader(color: Colors.white, size: 5),
    const SlidingSquareLoaderView(
      squareColor: Colors.white,
      squareSize: 8,
      squareCount: 3,
    ),
    const SpinningBarsLoader(color: Colors.white, size: 50),
    const SpinningLoader(),
    const SpiralLoader(color: Colors.white, size: 50, duration: 3000),
    const SunLoader(size: 25, color: Colors.white),
    const SunshineLoader(size: 25, color: Colors.white),
  ];


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Micro Loaders',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.adaptiveCrossAxisCount,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1,
          ),
          itemCount: loaders.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    color: Colors.grey[900],
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: loaders[index],
                      ),
                    ),
                  ),
                ),
                Text(
                  loaders[index].toString(),
                  style: TextStyle(
                    fontSize: width * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

extension on BuildContext {
  int get adaptiveCrossAxisCount {
    final width = MediaQuery.of(this).size.width;
    if (width > 1024) {
      return 5;
    } else if (width > 720 && width < 1024) {
      return 4;
    } else if (width > 480) {
      return 3;
    } else if (width > 320) {
      return 2;
    }
    return 1;
  }
}