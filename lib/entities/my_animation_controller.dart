import 'dart:developer';

class MyAnimationController {
  final int _duration; //duration in ms
  final double _lowerBound; //
  final double _upperBound;
  final double _startValue;
  double _value;
  final double _changePerTick;
  bool _increaseInProgress;
  bool _decreaseInProgress;

  get value => _value;

  MyAnimationController(
      {required duration, lowerBound = 0, upperBound = 1, startValue = 0})
      : _duration = duration,
        _lowerBound = lowerBound,
        _upperBound = upperBound,
        _value = startValue,
        _startValue = startValue,
        _changePerTick = (upperBound - lowerBound) / duration * 20,
        _increaseInProgress = false,
        _decreaseInProgress = false;

  ///Increase to upperBound
  Future<void> increase({reset = true}) async {
    log('value = $_value');
    if (reset == true) _value = _startValue;
    if (_decreaseInProgress == true) return;
    if (_value != _upperBound) {
      Future.delayed(const Duration(milliseconds: 20), () {
        if (_value + _changePerTick > _upperBound) {
          _value = _upperBound;
        } else {
          _value += _changePerTick;
        }
        _increaseInProgress = true;
        increase(reset: false);
      });
      return;
    }
    if (_value >= _upperBound) {
      _increaseInProgress = false;
    }
  }

  ///Decrease to lowerBound
  Future<void> decrease({reset = true}) async {
    if (reset = true) _value = _startValue;
    if (_increaseInProgress == true) return;
    if (_value != _lowerBound) {
      Future.delayed(const Duration(milliseconds: 20), () {
        if (_value + _changePerTick > _lowerBound) {
          _value = _lowerBound;
        } else {
          _value -= _changePerTick;
        }
        _decreaseInProgress = true;
        decrease(reset: false);
        return;
      });
    }
    if (_value <= _lowerBound) {
      _increaseInProgress = false;
    }
  }

  ///Sets value to startValue
  void reset() {
    _value = _startValue;
  }
}
