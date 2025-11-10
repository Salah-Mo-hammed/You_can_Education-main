import 'package:get_it/get_it.dart';
import 'package:grad_project_ver_1/injection_container.dart'; // هذا هو ملفك الحالي

class DependencyManager {
  static final GetIt sl = GetIt.instance;

  /// 🧹 تستخدم عند تسجيل خروج أو تبديل role
  static Future<void> resetDependencies() async {
    // تمسح كل التسجيلات
    await sl.reset();

    // تعيد تسجيل الأساسيات فقط (اللي دائمًا لازم تكون موجودة)
    await initialaizedDependencies();
  }

  /// 🧠 في حال حبيت تعمل setup مخصص لكل Role
  static Future<void> setupForRole(String role) async {
    await resetDependencies();

    if (role == 'center') {
      // ممكن تسجّل هنا أي bloc أو usecase خاص بالـ center فقط
    } else if (role == 'trainer') {
      // تسجّل الحاجات الخاصة بالـ trainer
    } else if (role == 'student') {
      // تسجّل الخاصة بالـ student
    }
  }
}
