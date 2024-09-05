import 'package:flutter/material.dart';
import 'package:xefi/src/core/helper/colors_helper.dart';

class TagRightCorner extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ColorsHelper.beige // Màu sắc của tam giác
      ..style = PaintingStyle.fill; // Vẽ tam giác được tô màu
    // draw shadow
    Path path = Path();
    path.moveTo(0, 0); // Điểm đỉnh của tam giác
    path.lineTo(size.width, 0); // Điểm góc trái dưới
    path.lineTo(size.width, size.height); // Điểm góc phải dưới
    path.close(); // Đóng đường Path để hoàn thành tam giác

    canvas.drawShadow(path, ColorsHelper.black, 10, false);
    canvas.drawPath(path, paint); // Vẽ tam giác lên canvas

    Paint dashedLinePaint = Paint()
      ..color = Colors.transparent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..blendMode = BlendMode.clear;

    final dashedLine = _dashedLine(5.0, 0, 6.0, 0.0, size.width, size.height);
    canvas.drawPath(dashedLine, dashedLinePaint);

    final dashedLine2 = _dashedLine(5.0, 0.5, 39, 0.0, size.width, size.height);
    canvas.drawPath(dashedLine2, dashedLinePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

_dashedLine(
  double dashWidth,
  double dashSpace,
  double startX,
  double startY,
  double endX,
  double endY,
) {
  Path dashedPath = Path();
  bool drawDash = true;

  while (startX < endX && startY < endY) {
    if (drawDash) {
      dashedPath.moveTo(startX, startY);
      dashedPath.lineTo(
        startX + dashWidth > endX ? endX : startX + dashWidth,
        startY + dashWidth > endY ? endY : startY + dashWidth,
      );
    }

    startX += dashWidth + dashSpace;
    startY += dashWidth + dashSpace;
    drawDash = !drawDash;
  }
  dashedPath.close();
  return dashedPath;
}
