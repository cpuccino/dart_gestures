import 'package:flutter/widgets.dart';

import 'package:dart_gestures/dart_gestures.dart';

class ThreePointersGestureEvent extends GestureEvent {
  ThreePointersGestureEvent({
    required int id,
    required Offset position,
  }) : super(
          id: id,
          position: position,
        );

  ThreePointersGestureEvent.fromPointerEvent(PointerEvent event)
      : super(
          id: event.pointer,
          position: Offset(
            event.position.dx,
            event.position.dy,
          ),
        );
}
