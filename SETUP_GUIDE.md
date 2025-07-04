# دليل إعداد وتشغيل تطبيق ميم

## المتطلبات الأساسية

### 1. تثبيت Flutter
```bash
# تحميل Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# التحقق من التثبيت
flutter doctor
```

### 2. إعداد بيئة التطوير
**Android Studio:**
- تحميل وتثبيت Android Studio
- تثبيت Android SDK
- إنشاء محاكي Android

**VS Code (اختياري):**
- تثبيت إضافة Flutter
- تثبيت إضافة Dart

### 3. إعداد الجهاز
**للاختبار على جهاز حقيقي:**
- تفعيل وضع المطور
- تفعيل USB Debugging
- توصيل الجهاز بالكمبيوتر

## إعداد المشروع

### 1. نسخ ملفات المشروع
```bash
# إنشاء مشروع Flutter جديد
flutter create meem
cd meem

# نسخ ملفات المشروع المطور
# انسخ جميع ملفات lib/ إلى مجلد lib/ في المشروع الجديد
# انسخ ملف pubspec.yaml
```

### 2. تثبيت التبعيات
```bash
# تثبيت الحزم المطلوبة
flutter pub get

# التحقق من عدم وجود أخطاء
flutter analyze
```

### 3. اختبار التطبيق
```bash
# تشغيل التطبيق
flutter run

# أو تشغيل في وضع التطوير
flutter run --debug
```

## إعداد خدمات API

### 1. الحصول على مفاتيح API

**OpenAI:**
1. اذهب إلى https://platform.openai.com
2. أنشئ حساب أو سجل دخول
3. اذهب إلى API Keys
4. أنشئ مفتاح API جديد
5. انسخ المفتاح واحفظه بأمان

**DeepSeek:**
1. اذهب إلى https://platform.deepseek.com
2. أنشئ حساب أو سجل دخول
3. اذهب إلى API Keys
4. أنشئ مفتاح API جديد
5. انسخ المفتاح واحفظه بأمان

### 2. تكوين المفاتيح في التطبيق
1. شغل التطبيق
2. اذهب إلى بوت ميم الذكي
3. اضغط على أيقونة الإعدادات
4. اختر مزود الذكاء الاصطناعي
5. أدخل مفتاح API
6. احفظ الإعدادات

## حل المشاكل الشائعة

### مشكلة: Flutter command not found
**الحل:**
```bash
# إضافة Flutter إلى PATH
export PATH="$PATH:/path/to/flutter/bin"

# أو إضافة إلى .bashrc/.zshrc
echo 'export PATH="$PATH:/path/to/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
```

### مشكلة: Android SDK not found
**الحل:**
```bash
# تحديد مسار Android SDK
export ANDROID_HOME=/path/to/android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# أو من خلال Android Studio:
# File > Settings > Appearance & Behavior > System Settings > Android SDK
```

### مشكلة: No connected devices
**الحل:**
```bash
# التحقق من الأجهزة المتصلة
flutter devices

# تشغيل محاكي Android
flutter emulators
flutter emulators --launch <emulator_id>

# أو استخدام Chrome للاختبار
flutter run -d chrome
```

### مشكلة: Build failed
**الحل:**
```bash
# تنظيف المشروع
flutter clean
flutter pub get

# إعادة البناء
flutter build apk --debug
```

### مشكلة: API calls not working
**الحل:**
1. تحقق من صحة مفتاح API
2. تحقق من اتصال الإنترنت
3. تحقق من إعدادات الشبكة في المحاكي
4. راجع رسائل الخطأ في وحدة التحكم

## اختبار الميزات

### 1. اختبار الشاشة الرئيسية
- تحقق من ظهور جميع التبويبات
- اختبر التنقل بين الصفحات
- تحقق من عرض الإحصائيات

### 2. اختبار دراسة الجدوى
- املأ نموذج وصف المشروع
- انتقل إلى صفحة الأسئلة
- تحقق من إنشاء التقرير

### 3. اختبار البوت الذكي
- أدخل مفتاح API صحيح
- أرسل رسالة اختبار
- تحقق من الاستجابة
- اختبر الاستجابات الاحتياطية

### 4. اختبار التسويق
- تصفح جميع التبويبات
- اختبر منشئ المحتوى
- تحقق من عرض التحليلات

### 5. اختبار التمويل
- تصفح مصادر التمويل
- استخدم حاسبة التمويل
- تحقق من عرض النتائج

## نصائح للتطوير

### 1. استخدام Hot Reload
```bash
# تشغيل مع Hot Reload
flutter run

# في وحدة التحكم:
# r - إعادة تحميل سريع
# R - إعادة تشغيل كامل
# q - إنهاء التطبيق
```

### 2. تصحيح الأخطاء
```bash
# تشغيل مع معلومات تصحيح مفصلة
flutter run --verbose

# عرض سجلات النظام
flutter logs
```

### 3. بناء التطبيق للإنتاج
```bash
# بناء APK للأندرويد
flutter build apk --release

# بناء AAB للنشر في Google Play
flutter build appbundle --release

# بناء للـ iOS
flutter build ios --release
```

### 4. اختبار الأداء
```bash
# تشغيل مع مراقب الأداء
flutter run --profile

# تحليل حجم التطبيق
flutter build apk --analyze-size
```

## إعدادات متقدمة

### 1. تخصيص الألوان
عدل ملف `lib/utils/constants.dart`:
```dart
static const Color primaryColor = Color(0xFF2E7D32); // لونك المفضل
```

### 2. إضافة لغات جديدة
1. أضف ملفات الترجمة في `assets/translations/`
2. حدث `pubspec.yaml` لتضمين الملفات
3. عدل الكود لدعم اللغات الجديدة

### 3. تخصيص الخطوط
1. أضف ملفات الخطوط في `assets/fonts/`
2. حدث `pubspec.yaml`
3. عدل `lib/config/theme.dart`

### 4. إضافة أيقونات مخصصة
1. أضف ملفات الأيقونات في `assets/icons/`
2. حدث `pubspec.yaml`
3. استخدم `Image.asset()` في الكود

## الأمان والخصوصية

### 1. حماية مفاتيح API
- لا تضع مفاتيح API في الكود مباشرة
- استخدم متغيرات البيئة أو ملفات التكوين
- فعل التشفير للبيانات الحساسة

### 2. إعدادات الشبكة
```dart
// في android/app/src/main/AndroidManifest.xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

### 3. إعدادات iOS
```xml
<!-- في ios/Runner/Info.plist -->
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

## الدعم والمساعدة

### موارد مفيدة
- **Flutter Documentation**: https://flutter.dev/docs
- **Dart Language**: https://dart.dev/guides
- **Flutter Community**: https://flutter.dev/community

### الحصول على المساعدة
- **البريد الإلكتروني**: support@meem.app
- **GitHub Issues**: [رابط المستودع]
- **Stack Overflow**: استخدم تاج `flutter` و `meem-app`

### تقديم التقارير
عند الإبلاغ عن مشكلة، يرجى تضمين:
- إصدار Flutter (`flutter --version`)
- نظام التشغيل
- وصف المشكلة
- خطوات إعادة الإنتاج
- رسائل الخطأ (إن وجدت)

---

**نتمنى لك تجربة تطوير ممتعة مع تطبيق ميم!** 🚀

