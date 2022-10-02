import 'package:flutter/cupertino.dart';

class LoadingSnakBar extends ChangeNotifier {
  bool loading = false;
  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  bool get isLoading => loading;
}
