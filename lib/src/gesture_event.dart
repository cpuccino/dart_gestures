import 'package:flutter/widgets.dart';

class GestureEvent {
  final int id;
  final Offset position;

  GestureEvent({
    required this.id,
    required this.position,
  });

  GestureEvent.fromPointerEvent(PointerEvent event)
      : id = event.pointer,
        position = Offset(
          event.localPosition.dx,
          event.localPosition.dy,
        );
}
