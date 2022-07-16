import 'package:flutter_mvvm_structure/main.dart';
import 'package:flutter_mvvm_structure/variant/app_config.dart';

void main(){
  ConstantEnvironment.setEnvironment(Environment.dev);
  mainDelegate();

  // main dev file is updated
}
