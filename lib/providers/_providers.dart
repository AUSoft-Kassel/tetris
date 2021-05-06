import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tetris/entities/animations.dart';
import 'package:tetris/entities/game.dart';
import 'package:tetris/entities/sounds.dart';
import 'package:tetris/providers/game_provider.dart';

///Reference to the GameProvider
final providerGameProvider =
    StateNotifierProvider<GameProvider, Game>((ref) => GameProvider());

///Reference to the Soundobject
final providerSoundProvider = Provider((ref) => Sounds());

///Reference to the Animation Controller
final providerAnimationProvider = Provider((ref) => Animations());
