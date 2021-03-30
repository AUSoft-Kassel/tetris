import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tetris/providers/game_provider.dart';

///Reference to the GameProvider
final providerGameProvider = StateNotifierProvider((ref) => GameProvider());
