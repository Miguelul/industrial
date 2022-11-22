import 'package:flutter/cupertino.dart';

class ValidatorForm extends ChangeNotifier {

GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isValidForm() {
   return formKey.currentState?.validate() ?? false;
  }

}
