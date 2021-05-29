import 'dart:math';
import 'package:vector_math/vector_math.dart';
import 'package:flutter/widgets.dart';

import 'package:dart_gestures/dart_gestures.dart';

class TwoPointersGestureEvent extends GestureEvent {
  final double _rotation;
  double get rotation => _rotation;

  final double _initialScale;
  double get initialScale => _initialScale;

  final double _scale;
  double get scale => _scale;

  TwoPointersGestureEvent({
    required int id,
    required List<Touch> touches,
    required double initialScale,
  })  : _rotation = _angleBetweenTouches(touches),
        _initialScale = initialScale,
        _scale = _calculateScale(touches),
        super(
          id: id,
          position: _calculateFocalPoint(touches),
        );

  TwoPointersGestureEvent.fromPointerEvent(
    PointerEvent event,
    List<Touch> touches, [
    double initialScale = 1,
  ])  : _rotation = _angleBetweenTouches(touches),
        _initialScale = initialScale,
        _scale = _calculateScale(touches),
        super(
          id: event.pointer,
          position: _calculateFocalPoint(touches),
        );

  static Offset _calculateFocalPoint(List<Touch> touches) {
    return touches.length == 2
        ? (touches[0].currentOffset + touches[1].currentOffset) / 2
        : Offset(0, 0);
  }

  static double _calculateScale(List<Touch> touches) {
    return touches.length == 2 ? (touches[0].currentOffset - touches[1].currentOffset).distance : 0;
  }

  static double _angleBetweenTouches(List<Touch> touches) {
    if (touches.length < 2) return 0;

    var angle1 = atan2(
      touches[0].startOffset.dy - touches[1].startOffset.dy,
      touches[0].startOffset.dx - touches[1].startOffset.dx,
    );
    var angle2 = atan2(
      touches[0].currentOffset.dy - touches[1].currentOffset.dy,
      touches[0].currentOffset.dx - touches[1].currentOffset.dx,
    );

    var angle = degrees(angle1 - angle2) % 360;
    if (angle < -180.0) angle += 360.0;
    if (angle > 180.0) angle -= 360.0;

    return radians(angle);
  }
}
