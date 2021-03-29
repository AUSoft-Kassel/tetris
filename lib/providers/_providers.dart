import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tetris/providers/game_provider.dart';

final providerGameProvider = StateNotifierProvider((ref) => GameProvider());
