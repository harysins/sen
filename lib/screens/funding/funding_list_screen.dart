import 'package:flutter/material.dart';

class FundingMainScreen extends StatefulWidget {
  const FundingMainScreen({super.key});

  @override
  State<FundingMainScreen> createState() => _FundingMainScreenState();
}

class _FundingMainScreenState extends State<FundingMainScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                  colors: [Colors.green, Colors.teal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.account_balance,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'التمويل والاستثمار',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'حلول تمويلية شاملة',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'نظرة عامة'),
            Tab(icon: Icon(Icons.search), text: 'مصادر التمويل'),
            Tab(icon: Icon(Icons.calculate), text: 'حاسبة التمويل'),
            Tab(icon: Icon(Icons.trending_up), text: 'الاستثمار'),
          ],
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.green,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildFundingSourcesTab(),
          _buildCalculatorTab(),
          _buildInvestmentTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الملف المالي
          _buildFinancialProfile(),
          
          const SizedBox(height: 24),
          
          // فرص التمويل المقترحة
          _buildRecommendedFunding(),
          
          const SizedBox(height: 24),
          
          // أدوات سريعة
          _buildQuickTools(),
          
          const SizedBox(height: 24),
          
          // نصائح مالية
          _buildFinancialTips(),
        ],
      ),
    );
  }

  Widget _buildFinancialProfile() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green, Colors.teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.account_balance_wallet, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                'الملف المالي',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildProfileMetric('رأس المال المطلوب', '250,000 ريال'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildProfileMetric('التمويل المتاح', '180,000 ريال'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildProfileMetric('التقييم الائتماني', 'ممتاز (A+)'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildProfileMetric('مستوى المخاطر', 'متوسط'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMetric(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedFunding() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'فرص التمويل المقترحة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // TODO: عرض جميع الفرص
              },
              child: const Text('عرض الكل'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildFundingOpportunityCard(
          'صندوق دعم المنشآت الصغيرة',
          'تمويل حكومي بفائدة منخفضة',
          'حتى 500,000 ريال',
          '2.5% سنوياً',
          Colors.blue,
          'حكومي',
          95,
        ),
        const SizedBox(height: 12),
        _buildFundingOpportunityCard(
          'برنامج كفالة للتمويل',
          'ضمان حكومي للقروض البنكية',
          'حتى 2,000,000 ريال',
          '4.5% سنوياً',
          Colors.green,
          'مضمون',
          88,
        ),
        const SizedBox(height: 12),
        _buildFundingOpportunityCard(
          'مستثمرون ملائكة',
          'استثمار مقابل حصة في الشركة',
          '100,000 - 1,000,000 ريال',
          '15-25% حصة',
          Colors.purple,
          'استثماري',
          72,
        ),
      ],
    );
  }

  Widget _buildFundingOpportunityCard(
    String title,
    String description,
    String amount,
    String terms,
    Color color,
    String type,
    int matchPercentage,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المبلغ',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      amount,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الشروط',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      terms,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    'التطابق',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '$matchPercentage%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: التقديم للتمويل
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('التقديم الآن'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickTools() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'أدوات سريعة',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _buildToolCard(
              'حاسبة القروض',
              'احسب الأقساط والفوائد',
              Icons.calculate,
              Colors.blue,
              () {
                _tabController.animateTo(2);
              },
            ),
            _buildToolCard(
              'تقييم الجدارة الائتمانية',
              'اعرف تقييمك الائتماني',
              Icons.assessment,
              Colors.green,
              () {
                // TODO: تقييم الجدارة الائتمانية
              },
            ),
            _buildToolCard(
              'مقارنة العروض',
              'قارن بين خيارات التمويل',
              Icons.compare,
              Colors.orange,
              () {
                // TODO: مقارنة العروض
              },
            ),
            _buildToolCard(
              'خطة السداد',
              'خطط لسداد التمويل',
              Icons.schedule,
              Colors.purple,
              () {
                // TODO: خطة السداد
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToolCard(String title, String description, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'نصائح مالية',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildTipCard(
          'حافظ على سجل ائتماني نظيف',
          'سدد التزاماتك في الوقت المحدد لتحسين تقييمك الائتماني',
          Icons.credit_score,
          Colors.green,
        ),
        const SizedBox(height: 8),
        _buildTipCard(
          'نوع مصادر التمويل',
          'لا تعتمد على مصدر واحد، نوع بين القروض والاستثمار',
          Icons.diversity_3,
          Colors.blue,
        ),
        const SizedBox(height: 8),
        _buildTipCard(
          'خطط للطوارئ',
          'احتفظ بصندوق طوارئ يغطي 6 أشهر من المصروفات',
          Icons.emergency,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildTipCard(String title, String description, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFundingSourcesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // شريط البحث
          TextField(
            decoration: InputDecoration(
              hintText: 'ابحث عن مصادر التمويل...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // فلاتر
          _buildFilters(),
          
          const SizedBox(height: 20),
          
          // قائمة مصادر التمويل
          const Text(
            'مصادر التمويل المتاحة',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          
          _buildFundingSourceCard(
            'البنك الأهلي السعودي',
            'قروض المنشآت الصغيرة والمتوسطة',
            '50,000 - 5,000,000 ريال',
            '5.5% - 7.5%',
            'بنكي',
            Colors.green,
            4.2,
          ),
          const SizedBox(height: 12),
          _buildFundingSourceCard(
            'صندوق التنمية الصناعية',
            'تمويل المشاريع الصناعية والتقنية',
            '100,000 - 20,000,000 ريال',
            '2% - 4%',
            'حكومي',
            Colors.blue,
            4.8,
          ),
          const SizedBox(height: 12),
          _buildFundingSourceCard(
            'شركة كفالة',
            'ضمان القروض للمنشآت الصغيرة',
            'حتى 2,000,000 ريال',
            'رسوم ضمان 2.5%',
            'ضمان',
            Colors.orange,
            4.5,
          ),
          const SizedBox(height: 12),
          _buildFundingSourceCard(
            'صندوق الاستثمارات العامة',
            'استثمار في الشركات الناشئة',
            '500,000 - 50,000,000 ريال',
            '15% - 30% حصة',
            'استثماري',
            Colors.purple,
            4.7,
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('الكل', true),
          const SizedBox(width: 8),
          _buildFilterChip('بنكي', false),
          const SizedBox(width: 8),
          _buildFilterChip('حكومي', false),
          const SizedBox(width: 8),
          _buildFilterChip('استثماري', false),
          const SizedBox(width: 8),
          _buildFilterChip('إسلامي', false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        // TODO: تطبيق الفلتر
      },
      selectedColor: Colors.green.withOpacity(0.2),
      checkmarkColor: Colors.green,
    );
  }

  Widget _buildFundingSourceCard(
    String name,
    String description,
    String amount,
    String terms,
    String type,
    Color color,
    double rating,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المبلغ',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      amount,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الشروط',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      terms,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    rating.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      // TODO: عرض التفاصيل
                    },
                    child: const Text('التفاصيل'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: التقديم
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('تقديم'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'حاسبة التمويل',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // نوع الحاسبة
          _buildCalculatorTypes(),
          
          const SizedBox(height: 20),
          
          // حاسبة القروض
          _buildLoanCalculator(),
        ],
      ),
    );
  }

  Widget _buildCalculatorTypes() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'اختر نوع الحاسبة',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildCalculatorTypeButton(
                  'حاسبة القروض',
                  Icons.calculate,
                  true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildCalculatorTypeButton(
                  'حاسبة الاستثمار',
                  Icons.trending_up,
                  false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorTypeButton(String title, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // TODO: تغيير نوع الحاسبة
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.withOpacity(0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.green : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanCalculator() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'حاسبة القروض',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // مبلغ القرض
          _buildCalculatorField('مبلغ القرض (ريال)', '250,000'),
          const SizedBox(height: 16),
          
          // معدل الفائدة
          _buildCalculatorField('معدل الفائدة السنوي (%)', '5.5'),
          const SizedBox(height: 16),
          
          // مدة القرض
          _buildCalculatorField('مدة القرض (سنوات)', '5'),
          const SizedBox(height: 20),
          
          // زر الحساب
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: حساب القرض
                _showCalculationResults();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'احسب',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  void _showCalculationResults() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'نتائج الحساب',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildResultRow('القسط الشهري', '5,247 ريال'),
            _buildResultRow('إجمالي الفوائد', '64,820 ريال'),
            _buildResultRow('إجمالي المبلغ المسدد', '314,820 ريال'),
            _buildResultRow('نسبة الدين للدخل', '35%'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إغلاق'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'فرص الاستثمار',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // ملخص المحفظة
          _buildPortfolioSummary(),
          
          const SizedBox(height: 24),
          
          // الاستثمارات المقترحة
          _buildRecommendedInvestments(),
          
          const SizedBox(height: 24),
          
          // أدوات الاستثمار
          _buildInvestmentTools(),
        ],
      ),
    );
  }

  Widget _buildPortfolioSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.deepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.account_balance_wallet, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                'محفظة الاستثمار',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildPortfolioMetric('القيمة الحالية', '125,000 ريال'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPortfolioMetric('العائد', '+12.5%'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildPortfolioMetric('الاستثمارات النشطة', '3'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPortfolioMetric('المخاطر', 'متوسط'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioMetric(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedInvestments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'استثمارات مقترحة',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildInvestmentCard(
          'صندوق الأسهم السعودية',
          'استثمار في الشركات السعودية الكبرى',
          '15.2%',
          'متوسط',
          Colors.green,
        ),
        const SizedBox(height: 12),
        _buildInvestmentCard(
          'صندوق الريت العقاري',
          'استثمار في القطاع العقاري',
          '8.7%',
          'منخفض',
          Colors.blue,
        ),
        const SizedBox(height: 12),
        _buildInvestmentCard(
          'صندوق التقنية',
          'استثمار في شركات التقنية الناشئة',
          '22.1%',
          'عالي',
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildInvestmentCard(
    String name,
    String description,
    String returns,
    String risk,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  risk,
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'العائد السنوي',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    returns,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: الاستثمار
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                ),
                child: const Text('استثمر'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentTools() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'أدوات الاستثمار',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _buildToolCard(
              'تحليل المخاطر',
              'قيم مستوى المخاطر',
              Icons.analytics,
              Colors.red,
              () {
                // TODO: تحليل المخاطر
              },
            ),
            _buildToolCard(
              'محاكي الاستثمار',
              'جرب استراتيجيات مختلفة',
              Icons.psychology,
              Colors.blue,
              () {
                // TODO: محاكي الاستثمار
              },
            ),
            _buildToolCard(
              'تنويع المحفظة',
              'نوع استثماراتك',
              Icons.pie_chart,
              Colors.green,
              () {
                // TODO: تنويع المحفظة
              },
            ),
            _buildToolCard(
              'تقارير الأداء',
              'تتبع أداء استثماراتك',
              Icons.trending_up,
              Colors.purple,
              () {
                // TODO: تقارير الأداء
              },
            ),
          ],
        ),
      ],
    );
  }
}

