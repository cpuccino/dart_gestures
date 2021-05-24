import 'dart:ui';

class Touch {
  final int id;
  Offset startOffset;
  Offset currentOffset;

  Touch({
    required this.id,
    required this.startOffset,
    Offset? currentOffset,
  }) : currentOffset = currentOffset ?? startOffset;
}
