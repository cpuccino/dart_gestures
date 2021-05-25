import 'package:flutter/widgets.dart';

import 'package:dart_gestures/dart_gestures.dart';

class MoveGestureEvent extends GestureEvent {
  final Offset _delta;
  Offset get delta => _delta;

  MoveGestureEvent({
    required int id,
    required Offset position,
    required Offset delta,
  })   : _delta = delta,
        super(
          id: id,
          position: position,
        );

  MoveGestureEvent.fromPointerEvent(PointerEvent event)
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
