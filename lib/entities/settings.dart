/// Settings
class Settings {
  /// the level of game sounds
  final String _gameSound;

  /// All sounds on or off
  final bool _soundOn;

  /// The Volume of the Sound
  final int _soundVolume;

  ///Set and change the nickname
  final String _nickName;

  ///Change the difficult of the game
  final double _gameDifficult;

  ///change the Gamemusic
  final String _gameMusic;

  Settings(
      {String gameSound = 'levelOne',
      bool soundOn = true,
      int soundVolume = 100,
      String nickName = 'Nick',
      double gameDifficult = 1,
      String gameMusic = 'musicOne'})
      : _gameSound = gameSound,
        _soundOn = soundOn,
        _soundVolume = soundVolume,
        _nickName = nickName,
        _gameDifficult = gameDifficult,
        _gameMusic = gameMusic;

  Settings copyWith(
          {String? gameSound,
          bool? soundOn,
          int? soundVolume,
          String? nickName,
          double? gameDifficult,
          String? gameMusic}) =>
      Settings(
          gameSound: gameSound ?? _gameSound,
          soundOn: soundOn ?? _soundOn,
          soundVolume: soundVolume ?? _soundVolume,
          nickName: nickName ?? _nickName,
          gameDifficult: gameDifficult ?? _gameDifficult,
          gameMusic: gameMusic ?? _gameMusic);
}
