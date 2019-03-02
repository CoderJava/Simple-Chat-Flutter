import 'dart:convert';

class Data {
  String message;
  int typeMessage;

  Data(this.message, this.typeMessage);

  @override
  String toString() {
    return 'Data{message: $message, typeMessage: $typeMessage}';
  }


}