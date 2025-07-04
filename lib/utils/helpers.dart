import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppHelpers {
  // تنسيق الأرقام
  static String formatNumber(double number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}م';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}ك';
    } else {
      return number.toStringAsFixed(0);
    }
  }
  
  // تنسيق العملة
  static String formatCurrency(double amount, {String currency = 'ريال'}) {
    return '${formatNumber(amount)} $currency';
  }
  
  // تنسيق التاريخ
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'الآن';
        } else {
          return 'منذ ${difference.inMinutes} دقيقة';
        }
      } else {
        return 'منذ ${difference.inHours} ساعة';
      }
    } else if (difference.inDays == 1) {
      return 'أمس';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} أيام';
    } else if (difference.inDays < 30) {
      return 'منذ ${(difference.inDays / 7).floor()} أسابيع';
    } else if (difference.inDays < 365) {
      return 'منذ ${(difference.inDays / 30).floor()} أشهر';
    } else {
      return 'منذ ${(difference.inDays / 365).floor()} سنوات';
    }
  }
  
  // التحقق من صحة البريد الإلكتروني
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  // التحقق من صحة رقم الهاتف
  static bool isValidPhoneNumber(String phone) {
    return RegExp(r'^[+]?[0-9]{10,15}$').hasMatch(phone);
  }
  
  // التحقق من قوة كلمة المرور
  static Map<String, dynamic> checkPasswordStrength(String password) {
    int score = 0;
    List<String> feedback = [];
    
    if (password.length >= 8) {
      score += 1;
    } else {
      feedback.add('يجب أن تحتوي على 8 أحرف على الأقل');
    }
    
    if (RegExp(r'[A-Z]').hasMatch(password)) {
      score += 1;
    } else {
      feedback.add('يجب أن تحتوي على حرف كبير واحد على الأقل');
    }
    
    if (RegExp(r'[a-z]').hasMatch(password)) {
      score += 1;
    } else {
      feedback.add('يجب أن تحتوي على حرف صغير واحد على الأقل');
    }
    
    if (RegExp(r'[0-9]').hasMatch(password)) {
      score += 1;
    } else {
      feedback.add('يجب أن تحتوي على رقم واحد على الأقل');
    }
    
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      score += 1;
    } else {
      feedback.add('يجب أن تحتوي على رمز خاص واحد على الأقل');
    }
    
    String strength;
    Color color;
    
    if (score <= 2) {
      strength = 'ضعيفة';
      color = Colors.red;
    } else if (score <= 3) {
      strength = 'متوسطة';
      color = Colors.orange;
    } else if (score <= 4) {
      strength = 'قوية';
      color = Colors.blue;
    } else {
      strength = 'قوية جداً';
      color = Colors.green;
    }
    
    return {
      'score': score,
      'strength': strength,
      'color': color,
      'feedback': feedback,
    };
  }
  
  // نسخ النص إلى الحافظة
  static Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
  
  // عرض رسالة نجاح
  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  
  // عرض رسالة خطأ
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  
  // عرض رسالة تحذير
  static void showWarningSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  
  // عرض رسالة معلومات
  static void showInfoSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  
  // عرض مربع حوار تأكيد
  static Future<bool> showConfirmDialog(
    BuildContext context,
    String title,
    String message,
  ) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('تأكيد'),
          ),
        ],
      ),
    ) ?? false;
  }
  
  // عرض مربع حوار تحميل
  static void showLoadingDialog(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(message ?? 'جاري التحميل...'),
          ],
        ),
      ),
    );
  }
  
  // إخفاء مربع حوار التحميل
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  // تحويل النص إلى عنوان URL صالح
  static String slugify(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'[-\s]+'), '-')
        .trim();
  }
  
  // حساب النسبة المئوية
  static double calculatePercentage(double value, double total) {
    if (total == 0) return 0;
    return (value / total) * 100;
  }
  
  // تقريب الرقم إلى أقرب عدد صحيح
  static int roundToNearest(double value, int nearest) {
    return ((value / nearest).round()) * nearest;
  }
  
  // تحويل الثواني إلى تنسيق وقت قابل للقراءة
  static String formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;
    
    if (hours > 0) {
      return '${hours}س ${minutes}د ${remainingSeconds}ث';
    } else if (minutes > 0) {
      return '${minutes}د ${remainingSeconds}ث';
    } else {
      return '${remainingSeconds}ث';
    }
  }
  
  // تحديد لون النص بناءً على لون الخلفية
  static Color getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
  
  // إنشاء لون عشوائي
  static Color generateRandomColor() {
    final random = DateTime.now().millisecondsSinceEpoch;
    return Color((random & 0xFFFFFF) | 0xFF000000);
  }
  
  // تحويل الحجم بالبايت إلى تنسيق قابل للقراءة
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes بايت';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} كيلوبايت';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} ميجابايت';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} جيجابايت';
    }
  }
  
  // التحقق من اتصال الإنترنت (محاكاة)
  static Future<bool> checkInternetConnection() async {
    // في التطبيق الحقيقي، يمكن استخدام مكتبة connectivity_plus
    await Future.delayed(const Duration(milliseconds: 500));
    return true; // افتراض وجود اتصال
  }
  
  // تشفير بسيط للنصوص الحساسة
  static String simpleEncrypt(String text) {
    return text.split('').map((char) {
      return String.fromCharCode(char.codeUnitAt(0) + 1);
    }).join('');
  }
  
  // فك تشفير النصوص
  static String simpleDecrypt(String encryptedText) {
    return encryptedText.split('').map((char) {
      return String.fromCharCode(char.codeUnitAt(0) - 1);
    }).join('');
  }
}

