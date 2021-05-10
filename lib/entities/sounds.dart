import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'package:tetris/entities/rotation.dart';

class Sounds {
  Soundpool _soundpool = Soundpool(maxStreams: 3);
  Soundpool _soundpool_bg = Soundpool();
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

  Future<void> playSoundRotate(Rotation rotation) async {
    if (rotation == Rotation.left) {
      await _soundpool.play(_idRotateLeft!);
      return;
    }
    await _soundpool.play(_idRotateRight!);
  }

  Future<void> playShapeSetOnGround() async {
    await _soundpool.play(_idShapeSetOnGround!);
  }

  Future<void> playSoundSpawnOfShapes() async {
    await _soundpool.play(_idSpawnOfShapes!);
  }

  Future<void> playSoundDifficultyUp() async {
    await _soundpool.play(_idDifficultyUp!);
  }

  Future<void> playSoundGameover() async {
    await _soundpool.play(_idGameover!);
  }

  Future<int> _loadSound(String path) async {
    var asset = await rootBundle.load(path);
    return await _soundpool.load(asset);
  }
}
