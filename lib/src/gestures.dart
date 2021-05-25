import 'dart:async';
import 'package:flutter/widgets.dart';

import 'package:dart_gestures/dart_gestures.dart';

class GesturesBuilder {
  double _initialScale;

  final GesturesConfig _config;
  GestureType _gestureType;

  Timer? _doubleTapTimer;
  Timer? _longPressTimer;
  Offset? _previousCoordinate;

  final List<Touch> _touches;

  GesturesBuilder({
    required GesturesConfig config,
  })   : _config = config,
        _initialScale = GesturesConfig.INITIAL_SCALE_DEFAULT,
        _gestureType = GestureType.Unknown,
        _touches = [];

  void _clearDoubleTapTimer() {
    if (_doubleTapTimer == null) return;
    _doubleTapTimer?.cancel();
    _doubleTapTimer = null;
  }

  void _clearLongPressTimer() {
    if (_longPressTimer == null) return;
    _longPressTimer?.cancel();
    _longPressTimer = null;
  }

  void _clearGestureTimer() {
    _clearDoubleTapTimer();
    _clearLongPressTimer();
  }

  void _initializeLongPress(GestureEvent event) {
    if (_config.onLongPress == null) return;
    _clearLongPressTimer();

    _longPressTimer = Timer(_config.longPressConsiderDuration, () {
      if (_touches.length != 1 || _touches[0].id != event.id) return;
      _gestureType = GestureType.SinglePointerLongPress;
      _config.onLongPress?.call(event);
      _clearGestureTimer();
    });
  }

  void _initializeDoubleTap(GestureEvent event) {
    if (_config.onDoubleTap == null) return;
    if (_doubleTapTimer != null) _clearDoubleTapTimer();

    _doubleTapTimer = Timer(_config.doubleTapConsiderDuration, () {
      _gestureType = GestureType.Unknown;
      _clearGestureTimer();

      if (_config.bypassTapEventOnDoubleTap) return;
      _config.onTap?.call(event);
    });
  }

  void _transitionSinglePointerLongPressToMove(SinglePointerGestureEvent event) {
    var touch = _touches.firstWhere((t) => t.id == event.id);
    if (!_config.bypassMoveEventAfterLongPress) {
      _transitionSinglePointerDownToMove(event);
      return;
    }
    touch.startOffset = touch.currentOffset;
  }

  void _transitionSinglePointerDownToMove(SinglePointerGestureEvent event) {
    _gestureType = GestureType.SinglePointerMove;

    var touch = _touches.firstWhere((t) => t.id == event.id);
    touch.startOffset = event.position;
    _config.onSinglePointerMoveStart?.call(event);
  }

  void _transitionSinglePointerMoveLoop(SinglePointerGestureEvent event) {
    _config.onSinglePointerMoveUpdate?.call(event);
  }

  void _transitionTwoPointersDownToMove(TwoPointersGestureEvent event) {
    var touch = _touches.firstWhere((t) => t.id == event.id);
    var focalPoint = _touches[0].currentOffset - _touches[1].currentOffset;
    _initialScale = focalPoint.distance;
    touch.startOffset = touch.currentOffset;

    _gestureType = GestureType.TwoPointersMove;

    _config.onTwoPointersMoveStart?.call(
      TwoPointersGestureEvent(
        id: event.id,
        touches: _touches,
        initialScale: _initialScale,
      ),
    );
  }

  void _transitionTwoPointersMoveLoop(TwoPointersGestureEvent event) {
    _config.onTwoPointersMoveUpdate?.call(event);
  }

  void _transitionThreePointersDownToMove(ThreePointersGestureEvent event) {
    var touch = _touches.firstWhere((t) => t.id == event.id);
    touch.startOffset = touch.currentOffset;
    _gestureType = GestureType.ThreePointersMove;
    _config.onThreePointersMoveStart?.call(event);
  }

  void _transitionThreePointersMoveLoop(ThreePointersGestureEvent event) {
    _config.onThreePointersMoveUpdate?.call(event);
  }

  void _transitionPointerDownToPointerUp(GestureEvent event) {
    var gestureEvent = event;
    var bypassDoubleTap = !_config.bypassTapEventOnDoubleTap || _config.onDoubleTap == null;
    if (bypassDoubleTap) _config.onTap?.call(gestureEvent);

    if (_config.onDoubleTap == null) return;
    if (_doubleTapTimer == null) {
      _initializeDoubleTap(gestureEvent);
      return;
    }

    _clearGestureTimer();
    var focalPoint = (event.position - _previousCoordinate!);
    if (_previousCoordinate != null &&
        focalPoint.distance < GesturesConfig.DOUBLE_TAP_CONSIDERATION_DEFAULT) {
      _config.onDoubleTap?.call(gestureEvent);
    } else {
      _initializeDoubleTap(gestureEvent);
    }
  }

  void _transitionSinglePointerMoveToPointerUp(SinglePointerGestureEvent event) {
    _gestureType = GestureType.Unknown;
    _config.onSinglePointerMoveEnd?.call(event);
  }

  void _transitionTwoPointersDownToPointerUp(TwoPointersGestureEvent event) {
    _gestureType = GestureType.Unknown;
    _config.onTwoPointersMoveEnd?.call(event);
  }

  void _transitionTwoPointersMoveToPointerUp(TwoPointersGestureEvent event) {
    _transitionTwoPointersDownToPointerUp(event);
  }

  void _transitionThreePointersDownToPointerUp(ThreePointersGestureEvent event) {
    _gestureType = GestureType.Unknown;
    _config.onThreePointersMoveEnd?.call(event);
  }

  void _transitionThreePointersMoveToPointerUp(ThreePointersGestureEvent event) {
    _transitionThreePointersDownToPointerUp(event);
  }

  void onPointerDown(PointerEvent event) {
    _touches.add(Touch(id: event.pointer, startOffset: event.position));
    var gestureEvent = GestureEvent.fromPointerEvent(event);

    switch (_touches.length) {
      case 1:
        _gestureType = GestureType.SinglePointerDown;
        _initializeLongPress(gestureEvent);
        break;
      case 2:
        _gestureType = GestureType.TwoPointersDown;
        break;
      case 3:
        _gestureType = GestureType.ThreePointersDown;
        break;
      default:
        break;
    }
  }

  void onPointerMove(PointerEvent event) {
    var touch = _touches.firstWhere((t) => t.id == event.pointer);
    if ((event.localPosition - touch.startOffset) < _config.moveTolerance) {
      return;
    }
    touch.currentOffset = event.position;

    var singlePointerGestureEvent = SinglePointerGestureEvent.fromPointerEvent(event);
    var twoPointersGestureEvent = TwoPointersGestureEvent.fromPointerEvent(event, _touches);
    var threePointersGestureEvent = ThreePointersGestureEvent.fromPointerEvent(event);
    _clearGestureTimer();

    switch (_gestureType) {
      case GestureType.SinglePointerLongPress:
        _transitionSinglePointerLongPressToMove(singlePointerGestureEvent);
        break;

      case GestureType.SinglePointerDown:
        _transitionSinglePointerDownToMove(singlePointerGestureEvent);
        break;

      case GestureType.SinglePointerMove:
        _transitionSinglePointerMoveLoop(singlePointerGestureEvent);
        break;

      case GestureType.TwoPointersDown:
        _transitionTwoPointersDownToMove(twoPointersGestureEvent);
        break;

      case GestureType.TwoPointersMove:
        _transitionTwoPointersMoveLoop(twoPointersGestureEvent);
        break;

      case GestureType.ThreePointersDown:
        _transitionThreePointersDownToMove(threePointersGestureEvent);
        break;

      case GestureType.ThreePointersMove:
        _transitionThreePointersMoveLoop(threePointersGestureEvent);
        break;

      default:
        break;
    }
  }

  void onPointerUp(PointerEvent event) {
    _touches.removeWhere((t) => t.id == event.pointer);
    var gestureEvent = GestureEvent.fromPointerEvent(event);
    var singlePointerGestureEvent = SinglePointerGestureEvent.fromPointerEvent(event);
    var twoPointersGestureEvent =
        TwoPointersGestureEvent.fromPointerEvent(event, _touches, _initialScale);
    var threePointersGestureEvent = ThreePointersGestureEvent.fromPointerEvent(event);

    switch (_gestureType) {
      case GestureType.SinglePointerDown:
        _transitionPointerDownToPointerUp(gestureEvent);
        break;

      case GestureType.SinglePointerMove:
        _transitionSinglePointerMoveToPointerUp(singlePointerGestureEvent);
        break;

      case GestureType.TwoPointersDown:
        _transitionTwoPointersDownToPointerUp(twoPointersGestureEvent);
        break;

      case GestureType.TwoPointersMove:
        _transitionTwoPointersMoveToPointerUp(twoPointersGestureEvent);
        break;

      case GestureType.ThreePointersDown:
        _transitionThreePointersDownToPointerUp(threePointersGestureEvent);
        break;

      case GestureType.ThreePointersMove:
        _transitionThreePointersMoveToPointerUp(threePointersGestureEvent);
        break;

      default:
        _gestureType = GestureType.Unknown;
        break;
    }

    _previousCoordinate = Offset(
      event.localPosition.dx,
      event.localPosition.dy,
    );
  }
}
