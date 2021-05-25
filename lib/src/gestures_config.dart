import 'package:dart_gestures/dart_gestures.dart';

import 'package:flutter/widgets.dart';

class GesturesConfig {
  static const int DOUBLE_TAP_CONSIDERATION_DEFAULT = 200;
  static const int LONG_PRESS_CONSIDERATION_DEFAULT = 350;

  static const double INITIAL_SCALE_DEFAULT = 1;
  static const double MOVE_TOLERANCE_DEFAULT = 5;

  final void Function(GestureEvent)? _onTap;
  Function(GestureEvent)? get onTap => _onTap;

  final void Function(GestureEvent)? _onDoubleTap;
  Function(GestureEvent)? get onDoubleTap => _onDoubleTap;

  final void Function(GestureEvent)? _onLongPress;
  Function(GestureEvent)? get onLongPress => _onLongPress;

  final void Function(SinglePointerGestureEvent)? _onSinglePointerMoveStart;
  Function(SinglePointerGestureEvent)? get onSinglePointerMoveStart => _onSinglePointerMoveStart;

  final void Function(SinglePointerGestureEvent)? _onSinglePointerMoveUpdate;
  Function(SinglePointerGestureEvent)? get onSinglePointerMoveUpdate => _onSinglePointerMoveUpdate;

  final void Function(SinglePointerGestureEvent)? _onSinglePointerMoveEnd;
  Function(SinglePointerGestureEvent)? get onSinglePointerMoveEnd => _onSinglePointerMoveEnd;

  final void Function(TwoPointersGestureEvent)? _onTwoPointersMoveStart;
  Function(TwoPointersGestureEvent)? get onTwoPointersMoveStart => _onTwoPointersMoveStart;

  final void Function(TwoPointersGestureEvent)? _onTwoPointersMoveUpdate;
  Function(TwoPointersGestureEvent)? get onTwoPointersMoveUpdate => _onTwoPointersMoveUpdate;

  final void Function(TwoPointersGestureEvent)? _onTwoPointersMoveEnd;
  Function(TwoPointersGestureEvent)? get onTwoPointersMoveEnd => _onTwoPointersMoveEnd;

  final void Function(ThreePointersGestureEvent)? _onThreePointersMoveStart;
  Function(ThreePointersGestureEvent)? get onThreePointersMoveStart => _onThreePointersMoveStart;

  final void Function(ThreePointersGestureEvent)? _onThreePointersMoveUpdate;
  Function(ThreePointersGestureEvent)? get onThreePointersMoveUpdate => _onThreePointersMoveUpdate;

  final void Function(ThreePointersGestureEvent)? _onThreePointersMoveEnd;
  Function(ThreePointersGestureEvent)? get onThreePointersMoveEnd => _onThreePointersMoveEnd;

  final Duration _doubleTapConsiderDuration;
  Duration get doubleTapConsiderDuration => _doubleTapConsiderDuration;

  final Duration _longPressConsiderDuration;
  Duration get longPressConsiderDuration => _longPressConsiderDuration;

  final Offset _moveTolerance;
  Offset get moveTolerance => _moveTolerance;

  final bool _bypassMoveEventAfterLongPress;
  bool get bypassMoveEventAfterLongPress => _bypassMoveEventAfterLongPress;

  final bool _bypassTapEventOnDoubleTap;
  bool get bypassTapEventOnDoubleTap => _bypassTapEventOnDoubleTap;

  GesturesConfig({
    Function(GestureEvent)? onTap,
    Function(GestureEvent)? onDoubleTap,
    Function(GestureEvent)? onLongPress,
    Function(SinglePointerGestureEvent)? onSinglePointerMoveStart,
    Function(SinglePointerGestureEvent)? onSinglePointerMoveUpdate,
    Function(SinglePointerGestureEvent)? onSinglePointerMoveEnd,
    Function(TwoPointersGestureEvent)? onTwoPointersMoveStart,
    Function(TwoPointersGestureEvent)? onTwoPointersMoveUpdate,
    Function(TwoPointersGestureEvent)? onTwoPointersMoveEnd,
    Function(ThreePointersGestureEvent)? onThreePointersMoveStart,
    Function(ThreePointersGestureEvent)? onThreePointersMoveUpdate,
    Function(ThreePointersGestureEvent)? onThreePointersMoveEnd,
    double? moveTolerance,
    Duration? doubleTapConsiderDuration,
    Duration? longPressConsiderDuration,
    bool bypassTapEventOnDoubleTap = false,
    bool bypassMoveEventAfterLongPress = false,
  })  : _onTap = onTap,
        _onDoubleTap = onDoubleTap,
        _onLongPress = onLongPress,
        _onSinglePointerMoveStart = onSinglePointerMoveStart,
        _onSinglePointerMoveUpdate = onSinglePointerMoveUpdate,
        _onSinglePointerMoveEnd = onSinglePointerMoveEnd,
        _onTwoPointersMoveStart = onTwoPointersMoveStart,
        _onTwoPointersMoveUpdate = onTwoPointersMoveUpdate,
        _onTwoPointersMoveEnd = onTwoPointersMoveEnd,
        _onThreePointersMoveStart = onThreePointersMoveStart,
        _onThreePointersMoveUpdate = onThreePointersMoveUpdate,
        _onThreePointersMoveEnd = onThreePointersMoveEnd,
        _doubleTapConsiderDuration =
            doubleTapConsiderDuration ?? Duration(milliseconds: DOUBLE_TAP_CONSIDERATION_DEFAULT),
        _longPressConsiderDuration =
            longPressConsiderDuration ?? Duration(milliseconds: LONG_PRESS_CONSIDERATION_DEFAULT),
        _moveTolerance = Offset(
          moveTolerance ?? MOVE_TOLERANCE_DEFAULT,
          moveTolerance ?? MOVE_TOLERANCE_DEFAULT,
        ),
        _bypassTapEventOnDoubleTap = bypassTapEventOnDoubleTap,
        _bypassMoveEventAfterLongPress = bypassMoveEventAfterLongPress;
}
