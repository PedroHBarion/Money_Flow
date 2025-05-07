import 'package:get_it/get_it.dart';
import '../services/toast_service.dart';
import '../../widgets/toast/animated_toast.dart';

class Toast {
  static void success(String message) {
    GetIt.I<ToastService>().show(
      message: message,
      type: ToastType.success,
    );
  }

  static void error(String message) {
    GetIt.I<ToastService>().show(
      message: message,
      type: ToastType.error,
    );
  }
}
