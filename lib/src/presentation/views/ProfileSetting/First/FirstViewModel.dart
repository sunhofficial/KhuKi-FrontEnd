import 'package:flutter/foundation.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';

class FirstViewModel extends ChangeNotifier {
  bool _isMaleSelected = false;
  bool _isFemaleSelected = false;
  int _selectedAgeGroup = -1;
  double _distanceValue = 0;

  final UserRepository _userRepository;
  FirstViewModel(this._userRepository);
  bool get isMaleSelected => _isMaleSelected;
  bool get isFemaleSelected => _isFemaleSelected;
  int get selectedAgeGroup => _selectedAgeGroup;
  double get distanceValue => _distanceValue;
  bool get canSubmit =>
      (_isMaleSelected || _isFemaleSelected) &&
      _selectedAgeGroup != -1 &&
      _distanceValue != 0;
  void selectGender(bool isMale) {
    _isMaleSelected = isMale;
    _isFemaleSelected = !isMale;
    notifyListeners();
  }

  void selectAgeGroup(int index) {
    _selectedAgeGroup = index;
    notifyListeners();
  }

  void updateDistance(double distance) {
    _distanceValue = distance;
    notifyListeners();
  }

  Future<bool> submitProfile() async {
    if (!canSubmit) return false;

    final response = await _userRepository.putFirstProfile(
        _isMaleSelected ? "man" : "girl",
        _selectedAgeGroup,
        _distanceValue.toInt());
    if (response.status == 200) {
      return true;
    } else {
      return false;
    }
  }
}
