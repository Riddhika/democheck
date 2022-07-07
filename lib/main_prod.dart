import 'package:flutter_mvvm_structure/variant/app_config.dart';
import 'main.dart';

void main(){
  ConstantEnvironment.setEnvironment(Environment.prod);
  mainDelegate();
}
