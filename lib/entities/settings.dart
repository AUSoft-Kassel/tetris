/// Settings
class Settings {
  /// the level of game sounds
  final String _gamesound;

  /// All sounds on or off
  final bool _soundOn;

  ///Set and change the nickname
  final String _nickName;

  ///Change the difficult of the game
  final double _gameDifficult;

  ///change the Gamemusic
  final String _gameMusic;

  Settings(this._gamesound, this._soundOn, this._nickName, this._gameDifficult,
      this._gameMusic);
}
