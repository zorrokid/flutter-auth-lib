import 'package:get/get.dart';

import '../auth_lib.dart';

void initializeAuthLib() {
  Get.lazyPut(() => AuthenticationService(), fenix: true);
  Get.lazyPut(() => UserFormController(), fenix: true);
}
