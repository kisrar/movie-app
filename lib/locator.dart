import 'package:get_it/get_it.dart';

import 'repo/home_repo.dart';
import 'services/services.dart';
final GetIt locator  = GetIt.instance;

void setupLocator(){
  locator.registerFactory<HomeRepository>(() => HomeRepositoryImp(apiClient:NetworkService()));
}