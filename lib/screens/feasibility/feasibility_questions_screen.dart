import 'package:flutter/material.dart';

class FeasibilityQuestionsScreen extends StatefulWidget {
  final String projectDescription;

  const FeasibilityQuestionsScreen({
    super.key,
    required this.projectDescription,
  });

  @override
  State<FeasibilityQuestionsScreen> createState() =>
      _FeasibilityQuestionsScreenState();
}

class _FeasibilityQuestionsScreenState
    extends State<FeasibilityQuestionsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 5;

  // متحكمات النصوص
  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, dynamic> _answers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final textFields = [
      'target_customers',
      'market_size',
      'initial_investment',
      'monthly_costs',
      'expected_revenue',
      'main_competitors',
      'competitive_advantage',
      'main_challenges',
      'launch_timeline',
    ];

    for (String field in textFields) {
      _textControllers[field] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _textControllers.values.forEach((controller) => controller.dispose());
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _generateReport();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _generateReport() {
    // جمع جميع الإجابات
    final allAnswers = {
      'projectDescription': widget.projectDescription,
      ..._answers,
    };

    // الانتقال لشاشة التقرير
    Navigator.pushNamed(context, '/feasibility_report', arguments: allAnswers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أسئلة دراسة الجدوى'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // شريط التقدم
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'السؤال ${_currentPage + 1} من $_totalPages',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${((_currentPage + 1) / _totalPages * 100).round()}%',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: (_currentPage + 1) / _totalPages,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // محتوى الأسئلة
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                _buildMarketQuestionsPage(),
                _buildFinancialQuestionsPage(),
                _buildRevenueQuestionsPage(),
                _buildCompetitionQuestionsPage(),
                _buildTimelineQuestionsPage(),
              ],
            ),
          ),

          // أزرار التنقل
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                if (_currentPage > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousPage,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('السابق'),
                    ),
                  ),
                if (_currentPage > 0) const SizedBox(width: 15),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      _currentPage == _totalPages - 1
                          ? 'إنشاء التقرير'
                          : 'التالي',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketQuestionsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'معلومات السوق والعملاء',
            Icons.people,
            'فهم السوق المستهدف أساسي لنجاح أي مشروع',
          ),
          const SizedBox(height: 20),

          _buildTextQuestion(
            'من هم عملاؤك المستهدفون؟',
            'target_customers',
            'مثال: الشباب من عمر 18-35، أصحاب الدخل المتوسط...',
          ),

          _buildMultipleChoiceQuestion(
            'ما حجم السوق المستهدف؟',
            'market_size',
            ['صغير (محلي)', 'متوسط (إقليمي)', 'كبير (وطني)', 'عالمي'],
          ),

          _buildRatingQuestion(
            'ما مدى حاجة السوق لمنتجك/خدمتك؟',
            'market_need',
          ),

          _buildMultipleChoiceQuestion(
            'كيف ستصل إلى عملائك؟',
            'marketing_channels',
            [
              'وسائل التواصل الاجتماعي',
              'الإعلانات المدفوعة',
              'التسويق الشفهي',
              'المتاجر الفعلية',
              'الموقع الإلكتروني',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialQuestionsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'التكاليف والاستثمار',
            Icons.attach_money,
            'تحديد التكاليف بدقة يساعد في التخطيط المالي السليم',
          ),
          const SizedBox(height: 20),

          _buildNumberQuestion(
            'كم المبلغ المطلوب لبدء المشروع؟ (ريال)',
            'initial_investment',
            'مثال: 50000',
          ),

          _buildNumberQuestion(
            'كم التكاليف الشهرية المتوقعة؟ (ريال)',
            'monthly_costs',
            'مثال: 15000',
          ),

          _buildMultipleChoiceQuestion(
            'ما مصادر التمويل المتاحة لك؟',
            'funding_sources',
            ['مدخرات شخصية', 'قرض بنكي', 'مستثمرين', 'شراكة', 'منح حكومية'],
          ),

          _buildRatingQuestion(
            'ما مدى ثقتك في توفر التمويل المطلوب؟',
            'funding_confidence',
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueQuestionsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'الإيرادات المتوقعة',
            Icons.trending_up,
            'توقع الإيرادات بواقعية يساعد في تقييم جدوى المشروع',
          ),
          const SizedBox(height: 20),

          _buildNumberQuestion(
            'كم الإيراد الشهري المتوقع في السنة الأولى؟ (ريال)',
            'expected_revenue',
            'مثال: 25000',
          ),

          _buildMultipleChoiceQuestion(
            'ما نموذج الإيراد الخاص بك؟',
            'revenue_model',
            [
              'بيع منتجات',
              'تقديم خدمات',
              'اشتراكات شهرية',
              'عمولات',
              'إعلانات',
            ],
          ),

          _buildRatingQuestion(
            'ما مدى ثقتك في تحقيق هذه الإيرادات؟',
            'revenue_confidence',
          ),

          _buildMultipleChoiceQuestion(
            'متى تتوقع تحقيق التعادل (عدم الخسارة)؟',
            'break_even',
            ['خلال 6 أشهر', 'خلال سنة', 'خلال سنتين', 'أكثر من سنتين'],
          ),
        ],
      ),
    );
  }

  Widget _buildCompetitionQuestionsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'المنافسة والتميز',
            Icons.emoji_events,
            'فهم المنافسة يساعدك في تطوير استراتيجية تنافسية قوية',
          ),
          const SizedBox(height: 20),

          _buildTextQuestion(
            'من هم منافسوك الرئيسيون؟',
            'main_competitors',
            'اذكر أسماء الشركات أو المشاريع المنافسة...',
          ),

          _buildTextQuestion(
            'ما الذي يميز مشروعك عن المنافسين؟',
            'competitive_advantage',
            'مثال: أسعار أقل، جودة أعلى، خدمة أفضل...',
          ),

          _buildRatingQuestion(
            'ما مدى شدة المنافسة في السوق؟',
            'competition_intensity',
          ),

          _buildMultipleChoiceQuestion(
            'ما استراتيجيتك للتفوق على المنافسين؟',
            'competitive_strategy',
            [
              'التسعير التنافسي',
              'الجودة العالية',
              'الابتكار',
              'خدمة العملاء',
              'التسويق القوي',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineQuestionsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'الجدول الزمني والتحديات',
            Icons.schedule,
            'التخطيط الزمني الواقعي مفتاح النجاح في تنفيذ المشروع',
          ),
          const SizedBox(height: 20),

          _buildMultipleChoiceQuestion(
            'متى تخطط لإطلاق المشروع؟',
            'launch_timeline',
            [
              'خلال شهر',
              'خلال 3 أشهر',
              'خلال 6 أشهر',
              'خلال سنة',
              'أكثر من سنة',
            ],
          ),

          _buildTextQuestion(
            'ما التحديات الرئيسية التي تتوقعها؟',
            'main_challenges',
            'مثال: نقص الخبرة، صعوبة التمويل، المنافسة الشديدة...',
          ),

          _buildRatingQuestion(
            'ما مدى استعدادك لبدء المشروع؟',
            'readiness_level',
          ),

          _buildMultipleChoiceQuestion('هل لديك فريق عمل؟', 'team_status', [
            'أعمل بمفردي',
            'لدي شريك واحد',
            'لدي فريق صغير (2-5)',
            'لدي فريق كبير (أكثر من 5)',
          ]),

          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'ممتاز! أكملت جميع الأسئلة. اضغط "إنشاء التقرير" للحصول على دراسة الجدوى الكاملة.',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, String description) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).primaryColor, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextQuestion(String question, String key, String hint) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _textControllers[key],
              maxLines: 3,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              onChanged: (value) {
                _answers[key] = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberQuestion(String question, String key, String hint) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                prefixText: 'ر.س ',
              ),
              onChanged: (value) {
                _answers[key] = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultipleChoiceQuestion(
    String question,
    String key,
    List<String> options,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...options
                .map(
                  (option) => RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: _answers[key],
                    onChanged: (value) {
                      setState(() {
                        _answers[key] = value;
                      });
                    },
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingQuestion(String question, String key) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                final rating = index + 1;
                final isSelected = _answers[key] == rating;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _answers[key] = rating;
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        rating.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ضعيف',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'ممتاز',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
