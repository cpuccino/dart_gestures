import 'package:flutter/widgets.dart';

class GestureEvent {
  final int _id;
  int get id => _id;

  final Offset _position;
  Offset get position => _position;

  GestureEvent({
    required int id,
    required Offset position,
  })   : _id = id,
        _position = position;

  GestureEvent.fromPointerEvent(PointerEvent event)
      : _id = event.pointer,
        _position = Offset(
          event.localPosition.dx,
          event.localPosition.dy,
        );
}
