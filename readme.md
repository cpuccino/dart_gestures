# Dart Gestures

Dart gestures is a multi-touch gesture package built with dart that supports various prebuilt multi-touch actions

<br />

### Supported gestures
- Tap
- Double Tap
- Long Press
- Single Pointer Move Start
- Single Pointer Update
- Single Pointer End
- Two Pointers Move Start
- Two Pointers Update
- Two Pointers End
- Three Pointers Update Start
- Three Pointers Move Update
- Three Pointers Move End

#### Gesture customizations
- `doubleTapConsiderDuration` - delay between the tap and double tap 
- `longPressConsiderDuration` - delay between the tap and the long press
- `bypassTapEventOnDoubleTap` - whether to ignore tap events once double tap has been confirmed **(NOTE: if this is set to false, there's no delay between the tap event being registered)**
- `bypassMoveEventAfterLongPress` - whether to ignore single pointer move events once long press has been confirmed
- `moveTolerance` - minimum offset required for a `move` to register (same regardless of the number of touch inputs)