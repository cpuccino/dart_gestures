import 'package:flutter/widgets.dart';

import 'package:dart_gestures/dart_gestures.dart';

class SinglePointerGestureEvent extends GestureEvent {
  final Offset _delta;
  Offset get delta => _delta;

  SinglePointerGestureEvent({
    required int id,
    required Offset position,
    required Offset delta,
  })  : _delta = delta,
        super(
          id: id,
          position: position,
        );

  SinglePointerGestureEvent.fromPointerEvent(PointerEvent event)
      : _delta = Offset(
          event.delta.dx,
          event.delta.dy,
        ),
        super(
          id: event.pointer,
          position: Offset(
            event.localPosition.dx,
            event.localPosition.dy,
          ),
        );
}
