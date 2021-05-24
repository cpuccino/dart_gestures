import 'dart:ui';

class Touch {
  final int _id;
  int get id => _id;

  Offset _startOffset;
  Offset get startOffset => _startOffset;

  Offset _currentOffset;
  Offset get currentOffset => _currentOffset;

  Touch({
    required int id,
    required Offset startOffset,
    Offset? currentOffset,
  })  : _id = id,
        _startOffset = startOffset,
        _currentOffset = currentOffset ?? startOffset;
}
