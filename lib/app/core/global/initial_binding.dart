import 'package:get/get.dart';
import 'package:ilu/app/core/di/dependency_injection.dart';

class InitialBinding extends Bindings{

  InitialBinding();

  @override
  void dependencies() async{
    await DependencyInjection.initDependency();
  }
}