import 'package:flutter/material.dart';
import 'package:mim_app/services/ai_service.dart';

class MeemBotScreen extends StatefulWidget {
  const MeemBotScreen({super.key});

  @override
  State<MeemBotScreen> createState() => _MeemBotScreenState();
}

class _MeemBotScreenState extends State<MeemBotScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  final AIService _aiService = AIService();
  
  bool _isTyping = false;
  bool _showSettings = false;
  late AnimationController _typingAnimationController;
  late Animation<double> _typingAnimation;

  // إعدادات الذكاء الاصطناعي
  AIProvider _selectedProvider = AIProvider.openai;
  String _openaiKey = '';
  String _deepseekKey = '';

  @override
  void initState() {
    super.initState();
    _typingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _typingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _typingAnimationController,
      curve: Curves.easeInOut,
    ));

    // رسالة ترحيب
    _addMessage(ChatMessage(
      text: 'مرحباً! أنا بوت ميم الذكي 🤖\n\nأنا هنا لمساعدتك في رحلة ريادة الأعمال. يمكنني مساعدتك في:\n\n• تطوير أفكار المشاريع\n• دراسات الجدوى\n• استراتيجيات التسويق\n• مصادر التمويل\n• تحليل المنافسين\n\nكيف يمكنني مساعدتك اليوم؟',
      isUser: false,
      timestamp: DateTime.now(),
    ));

    _loadSettings();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _typingAnimationController.dispose();
    super.dispose();
  }

  void _loadSettings() {
    // TODO: تحميل الإعدادات من التخزين المحلي
    // يمكن استخدام SharedPreferences هنا
  }

  void _saveSettings() {
    // TODO: حفظ الإعدادات في التخزين المحلي
    // يمكن استخدام SharedPreferences هنا
  }

  void _addMessage(ChatMessage message) {
    setState(() {
      _messages.add(message);
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // إضافة رسالة المستخدم
    _addMessage(ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    ));

    _messageController.clear();

    // بدء الكتابة
    setState(() {
      _isTyping = true;
    });
    _typingAnimationController.repeat();

    try {
      // إعداد مفاتيح الذكاء الاصطناعي
      if (_selectedProvider == AIProvider.openai && _openaiKey.isNotEmpty) {
        _aiService.setOpenAIKey(_openaiKey);
      } else if (_selectedProvider == AIProvider.deepseek && _deepseekKey.isNotEmpty) {
        _aiService.setDeepSeekKey(_deepseekKey);
      }

      // إرسال الرسالة للذكاء الاصطناعي
      final response = await _aiService.sendMessage(
        text,
        _messages.map((m) => {'role': m.isUser ? 'user' : 'assistant', 'content': m.text}).toList(),
        provider: _selectedProvider,
      );

      // إضافة رد البوت
      _addMessage(ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      // في حالة الخطأ، استخدم استجابة احتياطية
      String fallbackResponse = _getFallbackResponse(text);
      _addMessage(ChatMessage(
        text: fallbackResponse,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } finally {
      setState(() {
        _isTyping = false;
      });
      _typingAnimationController.stop();
    }
  }

  String _getFallbackResponse(String message) {
    final lowerMessage = message.toLowerCase();
    
    if (lowerMessage.contains('فكرة') || lowerMessage.contains('مشروع')) {
      return 'لتطوير فكرة مشروع ناجحة، أنصحك بـ:\n\n1. تحديد المشكلة التي تريد حلها\n2. دراسة السوق والعملاء المستهدفين\n3. تحليل المنافسين\n4. وضع خطة عمل واضحة\n5. تحديد مصادر التمويل\n\nهل تريد مساعدة في أي من هذه النقاط؟';
    }
    
    if (lowerMessage.contains('جدوى') || lowerMessage.contains('دراسة')) {
      return 'دراسة الجدوى مهمة جداً لنجاح أي مشروع! تشمل:\n\n📊 الجدوى التسويقية\n💰 الجدوى المالية\n⚙️ الجدوى التقنية\n👥 الجدوى الإدارية\n\nيمكنك استخدام أداة دراسة الجدوى في التطبيق للحصول على تحليل مفصل لمشروعك.';
    }
    
    if (lowerMessage.contains('تسويق') || lowerMessage.contains('إعلان')) {
      return 'استراتيجيات التسويق الفعالة:\n\n🎯 تحديد الجمهور المستهدف\n📱 التسويق الرقمي (وسائل التواصل)\n🤝 التسويق بالمحتوى\n📧 التسويق عبر البريد الإلكتروني\n🎁 العروض والحوافز\n\nأي استراتيجية تريد التركيز عليها؟';
    }
    
    if (lowerMessage.contains('تمويل') || lowerMessage.contains('استثمار')) {
      return 'مصادر التمويل المتاحة:\n\n💰 التمويل الذاتي\n🏦 القروض البنكية\n👥 المستثمرين الملائكة\n🚀 صناديق رأس المال الجريء\n🏛️ الدعم الحكومي\n👨‍👩‍👧‍👦 الأصدقاء والعائلة\n\nما نوع التمويل الذي تبحث عنه؟';
    }
    
    return 'شكراً لسؤالك! أنا هنا لمساعدتك في جميع جوانب ريادة الأعمال. يمكنك سؤالي عن:\n\n• تطوير أفكار المشاريع\n• دراسات الجدوى\n• استراتيجيات التسويق\n• مصادر التمويل\n• تحليل المنافسين\n\nما الذي تريد معرفته تحديداً؟';
  }

  void _clearChat() {
    setState(() {
      _messages.clear();
    });
    _addMessage(ChatMessage(
      text: 'تم مسح المحادثة. كيف يمكنني مساعدتك؟',
      isUser: false,
      timestamp: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purple.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'بوت ميم الذكي',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'مساعدك في ريادة الأعمال',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              setState(() {
                _showSettings = !_showSettings;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _clearChat,
          ),
        ],
      ),
      body: Column(
        children: [
          // إعدادات الذكاء الاصطناعي
          if (_showSettings) _buildSettingsPanel(),
          
          // قائمة الرسائل
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          
          // الاقتراحات السريعة
          if (_messages.length <= 1) _buildQuickSuggestions(),
          
          // حقل إدخال الرسالة
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildSettingsPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'إعدادات الذكاء الاصطناعي',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          
          // اختيار المزود
          Row(
            children: [
              const Text('المزود: '),
              DropdownButton<AIProvider>(
                value: _selectedProvider,
                onChanged: (AIProvider? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedProvider = newValue;
                    });
                    _saveSettings();
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: AIProvider.openai,
                    child: Text('OpenAI'),
                  ),
                  DropdownMenuItem(
                    value: AIProvider.deepseek,
                    child: Text('DeepSeek'),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // مفتاح OpenAI
          if (_selectedProvider == AIProvider.openai)
            TextField(
              decoration: const InputDecoration(
                labelText: 'مفتاح OpenAI',
                hintText: 'sk-...',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (value) {
                _openaiKey = value;
                _saveSettings();
              },
              obscureText: true,
            ),
          
          // مفتاح DeepSeek
          if (_selectedProvider == AIProvider.deepseek)
            TextField(
              decoration: const InputDecoration(
                labelText: 'مفتاح DeepSeek',
                hintText: 'sk-...',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (value) {
                _deepseekKey = value;
                _saveSettings();
              },
              obscureText: true,
            ),
          
          const SizedBox(height: 8),
          
          // مؤشر حالة الاتصال
          Row(
            children: [
              Icon(
                _aiService.isConnected ? Icons.check_circle : Icons.error,
                color: _aiService.isConnected ? Colors.green : Colors.red,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                _aiService.isConnected ? 'متصل' : 'غير متصل',
                style: TextStyle(
                  color: _aiService.isConnected ? Colors.green : Colors.red,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purple.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isUser ? Colors.white : Colors.black87,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      color: message.isUser
                          ? Colors.white70
                          : Colors.grey.shade500,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.grey,
                size: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purple.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.smart_toy,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: AnimatedBuilder(
              animation: _typingAnimation,
              builder: (context, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDot(0),
                    const SizedBox(width: 4),
                    _buildDot(1),
                    const SizedBox(width: 4),
                    _buildDot(2),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    double delay = index * 0.2;
    return AnimatedBuilder(
      animation: _typingAnimation,
      builder: (context, child) {
        double animationValue = (_typingAnimation.value - delay).clamp(0.0, 1.0);
        return Transform.translate(
          offset: Offset(0, -10 * (1 - (animationValue * 2 - 1).abs())),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickSuggestions() {
    final suggestions = [
      'كيف أطور فكرة مشروع؟',
      'ما هي دراسة الجدوى؟',
      'استراتيجيات التسويق',
      'مصادر التمويل',
    ];

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ActionChip(
              label: Text(
                suggestions[index],
                style: const TextStyle(fontSize: 12),
              ),
              onPressed: () => _sendMessage(suggestions[index]),
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.grey.shade300),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك هنا...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: _sendMessage,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purple.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => _sendMessage(_messageController.text),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

