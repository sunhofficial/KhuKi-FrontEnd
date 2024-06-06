import "package:flutter/cupertino.dart";
import "package:khukiting/src/domain/repository/UserRepository.dart";

class SettingViewModel extends ChangeNotifier {
  final UserRepository _repository;
  SettingViewModel(this._repository);

  Future<bool> postlogout() async {
    try {
      var res = await _repository.postLogout();
      return res;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<bool> deleteUser() async {
    try {
      var result = await _repository.deleteUser();
      return result;
    } catch (err) {
      throw Exception(err);
    }
  }
}
