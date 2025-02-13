// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:ui';

import 'package:app/models/bitmap_extensions.dart';
import 'package:app/screens/drawing/widgets/drawing_canvas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphics/src/core/bitmap.dart';

import 'package:app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  test("CanvasPainter maintains correct aspect ratio for artboardRect", () async {
    final dummyBitmap = GBitmap(40, 90, config: GBitmapConfig.rgba);
    final image = await dummyBitmap.toFlutterImage();
    final painter = CanvasPainter(image, 0, Offset.zero);

    const dummyWidth = 400.0;
    const dummyHeight = 800.0;
    
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder, const Rect.fromLTWH(0, 0, dummyWidth, dummyHeight));
    painter.paint(canvas, const Size(dummyWidth, dummyHeight));

    expect(painter.artboardRect.width / dummyBitmap.width == painter.artboardRect.height / dummyBitmap.height, isTrue);
  });
}
