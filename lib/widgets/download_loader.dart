import 'package:flutter/material.dart';
import 'dart:async';

/// FileDownloadLoader is a custom widget that visually simulates a file download process.
///
/// It takes the following parameters:
///
/// - **totalSize** : double - the total size of the file to download (in MB).
///
/// - **downloadSpeed** : double - the download speed (in MB/s).
///
/// The widget calculates the download progress over time and displays a progress bar along with
/// the estimated time remaining until the download completes.
///
/// ### Example:
/// ```dart
/// child: FileDownloadLoader(
///  totalSize: file.size,
/// downloadSpeed: stream.downloadSpeed,
/// color : Colors.blue ,
/// );
/// This widget will create a progress bar that fills based on the download speed and total file size.
/// ```
///

class FileDownloadLoader extends StatefulWidget {
  final double totalSize; // Total file size in MB
  final double downloadSpeed; // Download speed in MB/s
  final Color color;
  final double size; //Bar color

  const FileDownloadLoader({
    super.key,
    required this.totalSize,
    required this.downloadSpeed,
    required this.color,
    required this.size,
  })  : assert(totalSize > 0, 'Total size must be greater than 0'),
        assert(downloadSpeed > 0, 'Download speed must be greater than 0');

  @override
  State<FileDownloadLoader> createState() => _FileDownloadLoaderState();
}

class _FileDownloadLoaderState extends State<FileDownloadLoader> {
  double downloaded = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startDownloading();
  }

  void startDownloading() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        downloaded += widget.downloadSpeed;
        if (downloaded >= widget.totalSize) {
          downloaded = widget.totalSize;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = downloaded / widget.totalSize;
    double timeLeft = (widget.totalSize - downloaded) / widget.downloadSpeed;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomPaint(
            key: const Key('progressBar'),
            size: Size(widget.size, widget.size / 30),
            painter: FileDownloadPainter(progress, widget.color),
          ),
          SizedBox(height: widget.size / 20),
          Text(
            'Progress: ${(progress * 100).toStringAsFixed(1)}%',
            style: TextStyle(fontSize: widget.size / 8),
          ),
          Text(
            'Time left: ${timeLeft.toStringAsFixed(1)} s',
            style: TextStyle(fontSize: widget.size / 8, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class FileDownloadPainter extends CustomPainter {
  final double progress;
  final Color color;
  FileDownloadPainter(this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), paint);

    paint.color = color;

    canvas.drawLine(const Offset(0, 0), Offset(size.width * progress, 0), paint);
  }

  @override
  bool shouldRepaint(covariant FileDownloadPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
