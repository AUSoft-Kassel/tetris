import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'package:tetris/entities/rotation.dart';

/// Defines all sounds the application will play and handles all sound events
class Sounds {
  final Soundpool _soundpool = Soundpool(maxStreams: 3);
  final Soundpool _soundpoolBg = Soundpool();
  int? _idRowDestroy1;
  int? _idRowDestroy2;
  int? _idRowDestroy3;
  int? _idRowDestroy4;
  int? _idRotateLeft;
  int? _idRotateRight;
  int? _idShapeSetOnGround;
  int? _idSpawnOfShapes;
  int? _idDifficultyUp;
  int? _idGameover;

  /// Constructs Sounds object from Sounds class. Loads sound files, for them to be usable.
  Sounds() {
    _loadSounds();
  }

  void _loadSounds() async {
    _idRowDestroy1 = await _loadSound('assets/sfx/singlerow.mp3');
    _idRowDestroy2 = await _loadSound('assets/sfx/doublerow.mp3');
    _idRowDestroy3 = await _loadSound('assets/sfx/triplerow.mp3');
    _idRowDestroy4 = await _loadSound('assets/sfx/tetris.mp3');
    _idRotateLeft = await _loadSound('assets/sfx/rotate_left.mp3');
    _idRotateRight = await _loadSound('assets/sfx/rotate_right.mp3');
    _idShapeSetOnGround = await _loadSound('assets/sfx/shape_set_on_ground.mp3');
    _idSpawnOfShapes = await _loadSound('assets/sfx/spawn_of_shapes.mp3');
    _idDifficultyUp = await _loadSound('assets/sfx/difficultyup.mp3');
    _idGameover = await _loadSound('assets/sfx/gameover.mp3');
  }

  /// Plays sound for destroyed lines (1-4 lines)
  Future<void> playSoundDestroy(int n) async {
    if (n <= 1 && _idRowDestroy1 != null) {
      await _soundpool.play(_idRowDestroy1!);
      return;
    }
    if (n == 2 && _idRowDestroy2 != null) {
      await _soundpool.play(_idRowDestroy2!);
      return;
    }
    if (n == 3 && _idRowDestroy3 != null) {
      await _soundpool.play(_idRowDestroy3!);
      return;
    }
    if (n >= 4 && _idRowDestroy4 != null) {
      await _soundpool.play(_idRowDestroy4!);
      return;
    }
  }

  /// Plays sound for shape rotation (different sound for rotation to the left / right)
  Future<void> playSoundRotate(Rotation rotation) async {
    if (rotation == Rotation.left) {
      await _soundpool.play(_idRotateLeft!);
      return;
    }
    await _soundpool.play(_idRotateRight!);
  }

  /// Plays sound for a shape bumping on the ground
  Future<void> playShapeSetOnGround() async {
    await _soundpool.play(_idShapeSetOnGround!);
  }

  /// Plays sound for creation of a new shape
  Future<void> playSoundSpawnOfShapes() async {
    await _soundpool.play(_idSpawnOfShapes!);
  }

  /// Plays the sound for when the difficulty level is raised
  Future<void> playSoundDifficultyUp() async {
    await _soundpool.play(_idDifficultyUp!);
  }

  /// Plays sound when the game is lost
  Future<void> playSoundGameover() async {
    await _soundpool.play(_idGameover!);
  }

  Future<int> _loadSound(String path) async {
    final asset = await rootBundle.load(path);
    return await _soundpool.load(asset);
  }
}
