import 'package:flutter/material.dart';

class AppConstants {
  // معلومات التطبيق
  static const String appName = 'ميم';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'تطبيق ميم لريادة الأعمال';
  
  // الألوان الرئيسية
  static const Color primaryColor = Color(0xFF2E7D32);
  static const Color secondaryColor = Color(0xFF4CAF50);
  static const Color accentColor = Color(0xFF81C784);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color infoColor = Color(0xFF2196F3);
  
  // ألوان إضافية للخدمات
  static const Color feasibilityColor = Color(0xFF2196F3);
  static const Color botColor = Color(0xFF9C27B0);
  static const Color marketingColor = Color(0xFFFF9800);
  static const Color fundingColor = Color(0xFF4CAF50);
  
  // أحجام النصوص
  static const double titleLarge = 24.0;
  static const double titleMedium = 20.0;
  static const double titleSmall = 16.0;
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;
  static const double caption = 10.0;
  
  // المسافات والحشو
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  
  static const double marginSmall = 8.0;
  static const double marginMedium = 16.0;
  static const double marginLarge = 24.0;
  static const double marginXLarge = 32.0;
  
  // نصف أقطار الحدود
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  
  // ارتفاعات الظلال
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  
  // مدة الرسوم المتحركة
  static const Duration animationDurationShort = Duration(milliseconds: 200);
  static const Duration animationDurationMedium = Duration(milliseconds: 300);
  static const Duration animationDurationLong = Duration(milliseconds: 500);
  
  // أحجام الأيقونات
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeXLarge = 48.0;
  
  // أبعاد الشاشة
  static const double maxWidthMobile = 600.0;
  static const double maxWidthTablet = 1024.0;
  
  // رسائل النظام
  static const String loadingMessage = 'جاري التحميل...';
  static const String errorMessage = 'حدث خطأ غير متوقع';
  static const String noDataMessage = 'لا توجد بيانات متاحة';
  static const String networkErrorMessage = 'تحقق من اتصال الإنترنت';
  static const String successMessage = 'تمت العملية بنجاح';
  
  // مفاتيح التخزين المحلي
  static const String userDataKey = 'user_data';
  static const String appSettingsKey = 'app_settings';
  static const String chatHistoryKey = 'chat_history';
  static const String projectsKey = 'user_projects';
  static const String feasibilityStudiesKey = 'feasibility_studies';
  static const String marketingCampaignsKey = 'marketing_campaigns';
  static const String apiKeysKey = 'api_keys';
  
  // إعدادات API
  static const String openaiApiUrl = 'https://api.openai.com/v1/chat/completions';
  static const String deepseekApiUrl = 'https://api.deepseek.com/v1/chat/completions';
  static const int apiTimeoutSeconds = 30;
  static const int maxTokens = 1000;
  static const double temperature = 0.7;
  
  // أنواع المشاريع
  static const List<String> projectTypes = [
    'مطعم',
    'متجر إلكتروني',
    'تطبيق موبايل',
    'خدمات استشارية',
    'منتجات يدوية',
    'خدمات تقنية',
    'تجارة تجزئة',
    'خدمات تعليمية',
    'خدمات صحية',
    'أخرى',
  ];
  
  // مراحل المشروع
  static const List<String> projectStages = [
    'فكرة',
    'تخطيط',
    'تطوير',
    'اختبار',
    'إطلاق',
    'نمو',
    'نضج',
  ];
  
  // مصادر التمويل
  static const List<String> fundingSources = [
    'تمويل ذاتي',
    'قروض بنكية',
    'مستثمرون ملائكة',
    'رأس المال الجريء',
    'التمويل الجماعي',
    'حاضنات الأعمال',
    'مسرعات الأعمال',
    'منح حكومية',
  ];
  
  // منصات التواصل الاجتماعي
  static const List<String> socialPlatforms = [
    'فيسبوك',
    'إنستغرام',
    'تويتر',
    'لينكد إن',
    'يوتيوب',
    'تيك توك',
    'سناب شات',
    'واتساب',
  ];
  
  // أنواع المحتوى التسويقي
  static const List<String> contentTypes = [
    'منشور نصي',
    'صورة مع نص',
    'فيديو قصير',
    'قصة',
    'إعلان مدفوع',
    'مقال',
    'إنفوجرافيك',
    'بودكاست',
  ];
  
  // مؤشرات الأداء الرئيسية
  static const List<String> kpiMetrics = [
    'الوصول',
    'التفاعل',
    'النقرات',
    'التحويلات',
    'المبيعات',
    'العائد على الاستثمار',
    'تكلفة الاكتساب',
    'القيمة الدائمة للعميل',
  ];
  
  // أسئلة دراسة الجدوى الأساسية
  static const List<Map<String, dynamic>> basicFeasibilityQuestions = [
    {
      'id': 'project_type',
      'question': 'ما نوع المشروع الذي تريد تنفيذه؟',
      'type': 'single_choice',
      'options': projectTypes,
      'required': true,
    },
    {
      'id': 'target_market',
      'question': 'من هو جمهورك المستهدف؟',
      'type': 'text',
      'required': true,
    },
    {
      'id': 'budget',
      'question': 'ما هي الميزانية المتاحة للمشروع؟',
      'type': 'number',
      'required': true,
    },
    {
      'id': 'experience',
      'question': 'ما مستوى خبرتك في هذا المجال؟',
      'type': 'single_choice',
      'options': ['مبتدئ', 'متوسط', 'متقدم', 'خبير'],
      'required': true,
    },
    {
      'id': 'timeline',
      'question': 'ما هو الجدول الزمني المتوقع للمشروع؟',
      'type': 'single_choice',
      'options': ['أقل من 3 أشهر', '3-6 أشهر', '6-12 شهر', 'أكثر من سنة'],
      'required': true,
    },
  ];
  
  // نصائح سريعة
  static const List<String> quickTips = [
    'ابدأ بدراسة جدوى شاملة قبل الاستثمار في أي مشروع جديد',
    'حدد جمهورك المستهدف بدقة لضمان نجاح استراتيجيتك التسويقية',
    'احتفظ بسجل مالي دقيق لجميع المعاملات منذ بداية المشروع',
    'استثمر في التسويق الرقمي للوصول إلى أكبر عدد من العملاء المحتملين',
    'ابحث عن مرشد أو مستشار ذو خبرة في مجال عملك',
    'لا تتردد في طلب التمويل إذا كان مشروعك يحتاج إلى رأس مال إضافي',
    'راقب منافسيك باستمرار وتعلم من نجاحاتهم وأخطائهم',
    'استمع إلى ملاحظات عملائك وطور منتجك أو خدمتك بناءً عليها',
  ];
  
  // معلومات الاتصال والدعم
  static const String supportEmail = 'support@meem.app';
  static const String websiteUrl = 'https://meem.app';
  static const String privacyPolicyUrl = 'https://meem.app/privacy';
  static const String termsOfServiceUrl = 'https://meem.app/terms';
}

