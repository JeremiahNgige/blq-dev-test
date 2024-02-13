import 'package:stacked/stacked.dart';

class CustomTextFieldViewModel extends BaseViewModel {
  String? validate(String? value, String? errorTextId) {
    if (value!.isEmpty) {
      return 'Please enter a $errorTextId';
    }
  }
}
