import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const String _openaiApiUrl = 'https://api.openai.com/v1/chat/completions';
  static const String _deepseekApiUrl = 'https://api.deepseek.com/v1/chat/completions';
  
  static String? _apiKey;
  static String _provider = 'openai'; // 'openai' or 'deepseek'
  
  static void setApiKey(String apiKey) {
    _apiKey = apiKey;
  }
  
  static void setProvider(String provider) {
    _provider = provider;
  }
  
  static String get currentProvider => _provider;
  
  static bool get isConfigured => _apiKey != null && _apiKey!.isNotEmpty;
  
  static Future<String> sendMessage(String message, {List<Map<String, String>>? conversationHistory}) async {
    if (!isConfigured) {
      return 'يرجى تكوين مفتاح API أولاً في الإعدادات';
    }
    
    try {
      final String apiUrl = _provider == 'openai' ? _openaiApiUrl : _deepseekApiUrl;
      
      // إعداد رسائل المحادثة
      List<Map<String, String>> messages = [
        {
          'role': 'system',
          'content': 'أنت مساعد ذكي متخصص في ريادة الأعمال والاستشارات التجارية. اسمك "ميم" وأنت جزء من تطبيق ميم لريادة الأعمال. قدم إجابات مفيدة ومفصلة باللغة العربية.'
        }
      ];
      
      // إضافة تاريخ المحادثة إن وجد
      if (conversationHistory != null) {
        messages.addAll(conversationHistory);
      }
      
      // إضافة الرسالة الحالية
      messages.add({
        'role': 'user',
        'content': message
      });
      
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': _provider == 'openai' ? 'gpt-3.5-turbo' : 'deepseek-chat',
          'messages': messages,
          'max_tokens': 1000,
          'temperature': 0.7,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        return 'عذراً، حدث خطأ في الاتصال بخدمة الذكاء الاصطناعي. يرجى المحاولة مرة أخرى.';
      }
    } catch (e) {
      return 'عذراً، حدث خطأ غير متوقع. يرجى التحقق من اتصال الإنترنت والمحاولة مرة أخرى.';
    }
  }
  
  static Future<String> getBusinessAdvice(String businessType, String question) async {
    final String prompt = '''
    أنا أعمل في مجال: $businessType
    سؤالي هو: $question
    
    يرجى تقديم نصيحة مفصلة ومفيدة تتعلق بريادة الأعمال في هذا المجال.
    ''';
    
    return await sendMessage(prompt);
  }
  
  static Future<String> analyzeFeasibility(Map<String, dynamic> projectData) async {
    final String prompt = '''
    أريد تحليل جدوى مشروع بالمعلومات التالية:
    
    نوع المشروع: ${projectData['projectType'] ?? 'غير محدد'}
    الميزانية المتاحة: ${projectData['budget'] ?? 'غير محدد'}
    السوق المستهدف: ${projectData['targetMarket'] ?? 'غير محدد'}
    الخبرة السابقة: ${projectData['experience'] ?? 'غير محدد'}
    
    يرجى تقديم تحليل شامل لجدوى هذا المشروع مع التركيز على:
    1. نقاط القوة والضعف
    2. الفرص والتحديات
    3. التوصيات والنصائح
    4. خطوات البدء المقترحة
    ''';
    
    return await sendMessage(prompt);
  }
  
  static Future<String> generateMarketingContent(String businessType, String contentType, String targetAudience) async {
    final String prompt = '''
    أريد إنشاء محتوى تسويقي للمشروع التالي:
    
    نوع المشروع: $businessType
    نوع المحتوى المطلوب: $contentType
    الجمهور المستهدف: $targetAudience
    
    يرجى إنشاء محتوى تسويقي جذاب ومناسب لوسائل التواصل الاجتماعي.
    ''';
    
    return await sendMessage(prompt);
  }
  
  static Future<String> getFundingAdvice(String businessType, String fundingAmount, String businessStage) async {
    final String prompt = '''
    أحتاج نصيحة حول التمويل للمشروع التالي:
    
    نوع المشروع: $businessType
    مبلغ التمويل المطلوب: $fundingAmount
    مرحلة المشروع: $businessStage
    
    يرجى تقديم نصائح حول:
    1. أفضل مصادر التمويل المناسبة
    2. كيفية التحضير لطلب التمويل
    3. المستندات المطلوبة
    4. نصائح لزيادة فرص الحصول على التمويل
    ''';
    
    return await sendMessage(prompt);
  }
  
  // استجابات احتياطية عند عدم توفر الاتصال
  static String getOfflineResponse(String message) {
    final String lowerMessage = message.toLowerCase();
    
    if (lowerMessage.contains('مرحبا') || lowerMessage.contains('السلام') || lowerMessage.contains('أهلا')) {
      return '''
مرحباً بك في ميم! 👋

أنا مساعدك الذكي في رحلة ريادة الأعمال. يمكنني مساعدتك في:

🔍 دراسة الجدوى
📈 التسويق والإعلانات  
💰 التمويل والاستثمار
📊 تحليل السوق
💡 الأفكار والنصائح

كيف يمكنني مساعدتك اليوم؟
      ''';
    }
    
    if (lowerMessage.contains('جدوى') || lowerMessage.contains('مشروع')) {
      return '''
دراسة الجدوى خطوة أساسية لنجاح أي مشروع! 📊

العناصر الأساسية لدراسة الجدوى:
• تحليل السوق والمنافسين
• الدراسة المالية والتكاليف
• الدراسة التقنية والتشغيلية
• تحليل المخاطر
• خطة التنفيذ

يمكنك استخدام أداة دراسة الجدوى في التطبيق للحصول على تحليل مفصل!
      ''';
    }
    
    if (lowerMessage.contains('تسويق') || lowerMessage.contains('إعلان')) {
      return '''
التسويق الفعال مفتاح نجاح أي مشروع! 📢

استراتيجيات التسويق الأساسية:
• تحديد الجمهور المستهدف
• إنشاء محتوى جذاب
• استخدام وسائل التواصل الاجتماعي
• التسويق الرقمي والإعلانات المدفوعة
• قياس وتحليل النتائج

استخدم أدوات التسويق في التطبيق لإنشاء حملات ناجحة!
      ''';
    }
    
    if (lowerMessage.contains('تمويل') || lowerMessage.contains('استثمار')) {
      return '''
التمويل خطوة حاسمة في رحلة ريادة الأعمال! 💰

مصادر التمويل الرئيسية:
• التمويل الذاتي
• القروض البنكية
• المستثمرون الملائكة
• صناديق رأس المال الجريء
• التمويل الجماعي
• الحاضنات والمسرعات

تصفح قسم التمويل في التطبيق لاكتشاف الفرص المتاحة!
      ''';
    }
    
    return '''
شكراً لك على تواصلك معي! 🤖

للأسف، أحتاج إلى اتصال بالإنترنت لتقديم إجابات مفصلة ومخصصة.

في هذه الأثناء، يمكنك:
• استكشاف أدوات دراسة الجدوى
• تصفح قسم التسويق والإعلانات
• البحث عن فرص التمويل
• مراجعة النصائح والإرشادات

سأكون هنا لمساعدتك عند عودة الاتصال! 💪
    ''';
  }
}

