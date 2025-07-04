import 'package:flutter/material.dart';
import 'dart:math' as math;

class FeasibilityReportScreen extends StatefulWidget {
  final Map<String, dynamic> answers;

  const FeasibilityReportScreen({super.key, required this.answers});

  @override
  State<FeasibilityReportScreen> createState() =>
      _FeasibilityReportScreenState();
}

class _FeasibilityReportScreenState extends State<FeasibilityReportScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  double _feasibilityScore = 0;
  String _feasibilityLevel = '';
  Color _feasibilityColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _calculateFeasibilityScore();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _calculateFeasibilityScore() {
    double score = 0;
    int totalQuestions = 0;

    // تحليل الإجابات وحساب النقاط
    final ratings = [
      'market_need',
      'funding_confidence',
      'revenue_confidence',
      'readiness_level',
    ];
    for (String key in ratings) {
      if (widget.answers[key] != null) {
        score += (widget.answers[key] as int) * 20;
        totalQuestions += 5;
      }
    }

    // إضافة نقاط للإجابات النصية المفصلة
    final textAnswers = [
      'target_customers',
      'competitive_advantage',
      'main_challenges',
    ];
    for (String key in textAnswers) {
      if (widget.answers[key] != null &&
          widget.answers[key].toString().length > 50) {
        score += 15;
        totalQuestions += 1;
      }
    }

    // حساب النسبة المئوية
    if (totalQuestions > 0) {
      _feasibilityScore = (score / (totalQuestions * 20)) * 100;
    }

    // تحديد مستوى الجدوى
    if (_feasibilityScore >= 80) {
      _feasibilityLevel = 'ممتاز - مشروع واعد جداً';
      _feasibilityColor = Colors.green;
    } else if (_feasibilityScore >= 65) {
      _feasibilityLevel = 'جيد - مشروع قابل للتطبيق';
      _feasibilityColor = Colors.blue;
    } else if (_feasibilityScore >= 50) {
      _feasibilityLevel = 'متوسط - يحتاج تطوير';
      _feasibilityColor = Colors.orange;
    } else {
      _feasibilityLevel = 'ضعيف - يحتاج إعادة نظر';
      _feasibilityColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تقرير دراسة الجدوى'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: _shareReport),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadReport,
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildFeasibilityScore(),
              _buildFinancialAnalysis(),
              _buildSWOTAnalysis(),
              _buildRecommendations(),
              _buildNextSteps(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Icon(Icons.analytics, size: 60, color: Colors.white),
            const SizedBox(height: 15),
            const Text(
              'تقرير دراسة الجدوى',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'تم إنشاؤه في ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeasibilityScore() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const Text(
                'نتيجة تقييم الجدوى',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // دائرة النتيجة
              SizedBox(
                width: 150,
                height: 150,
                child: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: CircularProgressIndicator(
                          value: _feasibilityScore / 100,
                          strokeWidth: 12,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _feasibilityColor,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${_feasibilityScore.round()}%',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: _feasibilityColor,
                            ),
                          ),
                          const Text(
                            'جدوى',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: _feasibilityColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: _feasibilityColor),
                ),
                child: Text(
                  _feasibilityLevel,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _feasibilityColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFinancialAnalysis() {
    final initialInvestment =
        double.tryParse(widget.answers['initial_investment'] ?? '0') ?? 0;
    final monthlyCosts =
        double.tryParse(widget.answers['monthly_costs'] ?? '0') ?? 0;
    final expectedRevenue =
        double.tryParse(widget.answers['expected_revenue'] ?? '0') ?? 0;

    final monthlyProfit = expectedRevenue - monthlyCosts;
    final breakEvenMonths = initialInvestment > 0 && monthlyProfit > 0
        ? (initialInvestment / monthlyProfit).ceil()
        : 0;
    final annualProfit = monthlyProfit * 12;
    final roi = initialInvestment > 0
        ? (annualProfit / initialInvestment) * 100
        : 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'التحليل المالي',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildFinancialItem(
                'الاستثمار المطلوب',
                '${initialInvestment.toStringAsFixed(0)} ر.س',
                Colors.red,
              ),
              _buildFinancialItem(
                'التكاليف الشهرية',
                '${monthlyCosts.toStringAsFixed(0)} ر.س',
                Colors.orange,
              ),
              _buildFinancialItem(
                'الإيراد المتوقع شهرياً',
                '${expectedRevenue.toStringAsFixed(0)} ر.س',
                Colors.green,
              ),
              _buildFinancialItem(
                'الربح الشهري المتوقع',
                '${monthlyProfit.toStringAsFixed(0)} ر.س',
                monthlyProfit > 0 ? Colors.green : Colors.red,
              ),
              _buildFinancialItem(
                'نقطة التعادل',
                '$breakEvenMonths شهر',
                Colors.blue,
              ),
              _buildFinancialItem(
                'العائد على الاستثمار سنوياً',
                '${roi.toStringAsFixed(1)}%',
                roi > 20
                    ? Colors.green
                    : roi > 10
                    ? Colors.orange
                    : Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFinancialItem(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSWOTAnalysis() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.analytics_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'تحليل SWOT',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _buildSWOTItem(
                      'نقاط القوة',
                      _getStrengths(),
                      Colors.green,
                      Icons.trending_up,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildSWOTItem(
                      'نقاط الضعف',
                      _getWeaknesses(),
                      Colors.red,
                      Icons.trending_down,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildSWOTItem(
                      'الفرص',
                      _getOpportunities(),
                      Colors.blue,
                      Icons.lightbulb_outline,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildSWOTItem(
                      'التهديدات',
                      _getThreats(),
                      Colors.orange,
                      Icons.warning_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSWOTItem(
    String title,
    List<String> items,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text('• $item', style: const TextStyle(fontSize: 12)),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  List<String> _getStrengths() {
    List<String> strengths = [];

    if ((widget.answers['market_need'] ?? 0) >= 4) {
      strengths.add('حاجة السوق عالية');
    }
    if ((widget.answers['funding_confidence'] ?? 0) >= 4) {
      strengths.add('ثقة في التمويل');
    }
    if (widget.answers['competitive_advantage']?.toString().isNotEmpty ==
        true) {
      strengths.add('ميزة تنافسية واضحة');
    }
    if ((widget.answers['readiness_level'] ?? 0) >= 4) {
      strengths.add('استعداد عالي للبدء');
    }

    if (strengths.isEmpty) {
      strengths.add('يحتاج تحديد نقاط القوة');
    }

    return strengths;
  }

  List<String> _getWeaknesses() {
    List<String> weaknesses = [];

    if ((widget.answers['market_need'] ?? 0) <= 2) {
      weaknesses.add('حاجة السوق منخفضة');
    }
    if ((widget.answers['funding_confidence'] ?? 0) <= 2) {
      weaknesses.add('صعوبة في التمويل');
    }
    if ((widget.answers['competition_intensity'] ?? 0) >= 4) {
      weaknesses.add('منافسة شديدة');
    }
    if ((widget.answers['readiness_level'] ?? 0) <= 2) {
      weaknesses.add('عدم الاستعداد الكافي');
    }

    if (weaknesses.isEmpty) {
      weaknesses.add('نقاط ضعف محدودة');
    }

    return weaknesses;
  }

  List<String> _getOpportunities() {
    List<String> opportunities = [];

    if (widget.answers['market_size'] == 'كبير (وطني)' ||
        widget.answers['market_size'] == 'عالمي') {
      opportunities.add('سوق كبير للتوسع');
    }
    if (widget.answers['revenue_model'] == 'اشتراكات شهرية') {
      opportunities.add('دخل متكرر مستقر');
    }
    if (widget.answers['team_status'] != 'أعمل بمفردي') {
      opportunities.add('وجود فريق عمل');
    }

    opportunities.add('نمو السوق الرقمي');
    opportunities.add('دعم الحكومة للمشاريع');

    return opportunities;
  }

  List<String> _getThreats() {
    List<String> threats = [];

    if ((widget.answers['competition_intensity'] ?? 0) >= 4) {
      threats.add('منافسة شديدة');
    }
    if (widget.answers['break_even'] == 'أكثر من سنتين') {
      threats.add('فترة استرداد طويلة');
    }

    threats.add('تغيرات السوق');
    threats.add('التحديات الاقتصادية');

    return threats;
  }

  Widget _buildRecommendations() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.recommend, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 10),
                  const Text(
                    'التوصيات والنصائح',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              ..._getRecommendations()
                  .map(
                    (recommendation) =>
                        _buildRecommendationItem(recommendation),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(String recommendation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb, color: Colors.blue, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(recommendation, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  List<String> _getRecommendations() {
    List<String> recommendations = [];

    if (_feasibilityScore >= 80) {
      recommendations.add(
        'مشروعك واعد جداً! ابدأ في التنفيذ مع التركيز على التسويق الفعال.',
      );
      recommendations.add('احرص على بناء فريق عمل قوي لضمان النجاح.');
    } else if (_feasibilityScore >= 65) {
      recommendations.add('مشروعك قابل للتطبيق مع بعض التحسينات.');
      recommendations.add('ركز على تطوير الميزة التنافسية وتحسين خطة التسويق.');
    } else if (_feasibilityScore >= 50) {
      recommendations.add('يحتاج مشروعك إلى تطوير أكثر قبل البدء.');
      recommendations.add('راجع دراسة السوق وتأكد من وجود حاجة حقيقية للمنتج.');
    } else {
      recommendations.add(
        'يُنصح بإعادة النظر في فكرة المشروع أو تطويرها بشكل جذري.',
      );
      recommendations.add(
        'ابحث عن فرص أخرى أو اطلب استشارة من خبراء في المجال.',
      );
    }

    // توصيات عامة
    if ((widget.answers['funding_confidence'] ?? 0) <= 3) {
      recommendations.add(
        'ابحث عن مصادر تمويل إضافية أو قلل من التكاليف الأولية.',
      );
    }

    if ((widget.answers['competition_intensity'] ?? 0) >= 4) {
      recommendations.add('طور استراتيجية تنافسية قوية للتميز عن المنافسين.');
    }

    return recommendations;
  }

  Widget _buildNextSteps() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.checklist, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 10),
                  const Text(
                    'الخطوات التالية',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              ..._getNextSteps()
                  .asMap()
                  .entries
                  .map((entry) => _buildStepItem(entry.key + 1, entry.value))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepItem(int stepNumber, String step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                stepNumber.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(child: Text(step, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  List<String> _getNextSteps() {
    List<String> steps = [];

    if (_feasibilityScore >= 65) {
      steps.add('إعداد خطة عمل تفصيلية');
      steps.add('البحث عن التمويل المناسب');
      steps.add('تسجيل المشروع والحصول على التراخيص');
      steps.add('بناء فريق العمل الأساسي');
      steps.add('تطوير المنتج أو الخدمة الأولية');
      steps.add('إطلاق حملة تسويقية تجريبية');
    } else {
      steps.add('إعادة تقييم فكرة المشروع');
      steps.add('إجراء بحث سوق أكثر تفصيلاً');
      steps.add('تطوير الميزة التنافسية');
      steps.add('البحث عن شركاء أو مستشارين');
      steps.add('تقليل المخاطر والتكاليف');
      steps.add('إعادة إجراء دراسة الجدوى');
    }

    return steps;
  }

  Widget _buildActionButtons() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _saveReport,
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text(
                'حفظ التقرير',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _shareReport,
                  icon: const Icon(Icons.share),
                  label: const Text('مشاركة'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _downloadReport,
                  icon: const Icon(Icons.download),
                  label: const Text('تحميل PDF'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/home'),
              icon: const Icon(Icons.home),
              label: const Text('العودة للرئيسية'),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حفظ التقرير بنجاح!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _shareReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('سيتم إضافة ميزة المشاركة قريباً!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _downloadReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('سيتم إضافة ميزة تحميل PDF قريباً!'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
