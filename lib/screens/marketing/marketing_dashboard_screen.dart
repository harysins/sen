import 'package:flutter/material.dart';

class MarketingMainScreen extends StatefulWidget {
  const MarketingMainScreen({super.key});

  @override
  State<MarketingMainScreen> createState() => _MarketingMainScreenState();
}

class _MarketingMainScreenState extends State<MarketingMainScreen>
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
                  colors: [Colors.orange, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.campaign,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'التسويق والإعلانات',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'أدوات تسويقية متقدمة',
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
            Tab(icon: Icon(Icons.dashboard), text: 'لوحة التحكم'),
            Tab(icon: Icon(Icons.create), text: 'إنشاء المحتوى'),
            Tab(icon: Icon(Icons.analytics), text: 'التحليلات'),
            Tab(icon: Icon(Icons.settings), text: 'الإعدادات'),
          ],
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.orange,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildContentCreationTab(),
          _buildAnalyticsTab(),
          _buildSettingsTab(),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // إحصائيات سريعة
          _buildQuickStats(),
          
          const SizedBox(height: 24),
          
          // الحملات النشطة
          _buildActiveCampaigns(),
          
          const SizedBox(height: 24),
          
          // أدوات سريعة
          _buildQuickTools(),
          
          const SizedBox(height: 24),
          
          // نصائح تسويقية
          _buildMarketingTips(),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'إحصائيات سريعة',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'الحملات النشطة',
                '3',
                Icons.campaign,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'المحتوى المنشور',
                '24',
                Icons.article,
                Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'معدل التفاعل',
                '4.2%',
                Icons.favorite,
                Colors.red,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                'الوصول الشهري',
                '1.2K',
                Icons.visibility,
                Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
              Icon(icon, color: color, size: 24),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCampaigns() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'الحملات النشطة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // TODO: الانتقال لصفحة جميع الحملات
              },
              child: const Text('عرض الكل'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildCampaignCard(
          'حملة إطلاق المنتج',
          'فيسبوك وإنستغرام',
          '85%',
          Colors.blue,
          'نشطة',
        ),
        const SizedBox(height: 8),
        _buildCampaignCard(
          'حملة العروض الصيفية',
          'تويتر ولينكد إن',
          '92%',
          Colors.green,
          'مكتملة',
        ),
        const SizedBox(height: 8),
        _buildCampaignCard(
          'حملة التوعية بالعلامة التجارية',
          'جميع المنصات',
          '67%',
          Colors.orange,
          'قيد التنفيذ',
        ),
      ],
    );
  }

  Widget _buildCampaignCard(String title, String platform, String progress, Color color, String status) {
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
                    fontSize: 14,
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
                  status,
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
            platform,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: double.parse(progress.replaceAll('%', '')) / 100,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                progress,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
              'منشئ المحتوى',
              'إنشاء منشورات تسويقية',
              Icons.create,
              Colors.blue,
              () {
                // TODO: الانتقال لمنشئ المحتوى
              },
            ),
            _buildToolCard(
              'مخطط الحملات',
              'تخطيط الحملات الإعلانية',
              Icons.calendar_today,
              Colors.green,
              () {
                // TODO: الانتقال لمخطط الحملات
              },
            ),
            _buildToolCard(
              'تحليل الجمهور',
              'فهم العملاء المستهدفين',
              Icons.people,
              Colors.purple,
              () {
                // TODO: الانتقال لتحليل الجمهور
              },
            ),
            _buildToolCard(
              'قوالب التصميم',
              'قوالب جاهزة للتصميم',
              Icons.palette,
              Colors.orange,
              () {
                // TODO: الانتقال لقوالب التصميم
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

  Widget _buildMarketingTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'نصائح تسويقية',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildTipCard(
          'أفضل أوقات النشر',
          'انشر محتواك بين الساعة 9-11 صباحاً و 7-9 مساءً للحصول على أفضل تفاعل',
          Icons.schedule,
          Colors.blue,
        ),
        const SizedBox(height: 8),
        _buildTipCard(
          'استخدم الهاشتاغات بذكاء',
          'استخدم 3-5 هاشتاغات ذات صلة بمحتواك لزيادة الوصول',
          Icons.tag,
          Colors.green,
        ),
        const SizedBox(height: 8),
        _buildTipCard(
          'تفاعل مع جمهورك',
          'رد على التعليقات والرسائل خلال ساعتين لبناء علاقة قوية',
          Icons.chat,
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

  Widget _buildContentCreationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'إنشاء المحتوى التسويقي',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // أنواع المحتوى
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
            children: [
              _buildContentTypeCard(
                'منشور فيسبوك',
                'إنشاء منشور تفاعلي',
                Icons.facebook,
                Colors.blue,
              ),
              _buildContentTypeCard(
                'قصة إنستغرام',
                'تصميم قصة جذابة',
                Icons.camera_alt,
                Colors.purple,
              ),
              _buildContentTypeCard(
                'تغريدة تويتر',
                'كتابة تغريدة مؤثرة',
                Icons.chat_bubble,
                Colors.lightBlue,
              ),
              _buildContentTypeCard(
                'منشور لينكد إن',
                'محتوى مهني احترافي',
                Icons.business,
                Colors.indigo,
              ),
              _buildContentTypeCard(
                'إعلان مدفوع',
                'تصميم إعلان فعال',
                Icons.ads_click,
                Colors.orange,
              ),
              _buildContentTypeCard(
                'رسالة إيميل',
                'حملة تسويق إلكتروني',
                Icons.email,
                Colors.green,
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // أدوات إضافية
          const Text(
            'أدوات إضافية',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          
          _buildAdditionalTool(
            'مولد الأفكار',
            'احصل على أفكار محتوى جديدة',
            Icons.lightbulb,
            Colors.yellow.shade700,
          ),
          const SizedBox(height: 8),
          _buildAdditionalTool(
            'جدولة المنشورات',
            'جدول منشوراتك مسبقاً',
            Icons.schedule_send,
            Colors.teal,
          ),
          const SizedBox(height: 8),
          _buildAdditionalTool(
            'بنك الصور',
            'مكتبة صور مجانية للاستخدام',
            Icons.photo_library,
            Colors.pink,
          ),
        ],
      ),
    );
  }

  Widget _buildContentTypeCard(String title, String description, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // TODO: الانتقال لصفحة إنشاء المحتوى المحدد
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('سيتم تطوير $title قريباً')),
        );
      },
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

  Widget _buildAdditionalTool(String title, String description, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('سيتم تطوير $title قريباً')),
        );
      },
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
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'تحليلات الأداء',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // مؤشرات الأداء الرئيسية
          _buildPerformanceMetrics(),
          
          const SizedBox(height: 24),
          
          // أفضل المنشورات
          _buildTopPosts(),
          
          const SizedBox(height: 24),
          
          // تحليل الجمهور
          _buildAudienceAnalysis(),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'مؤشرات الأداء الرئيسية',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard('الوصول', '12.5K', '+15%', Colors.blue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard('التفاعل', '892', '+8%', Colors.green),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard('النقرات', '234', '+22%', Colors.orange),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard('التحويلات', '45', '+12%', Colors.purple),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, String change, Color color) {
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.trending_up, size: 12, color: Colors.green),
              const SizedBox(width: 4),
              Text(
                change,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopPosts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'أفضل المنشورات',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _buildPostCard(
          'منشور حول نصائح ريادة الأعمال',
          '1.2K إعجاب • 89 تعليق',
          '4.8%',
          Colors.green,
        ),
        const SizedBox(height: 8),
        _buildPostCard(
          'إعلان عن المنتج الجديد',
          '856 إعجاب • 45 تعليق',
          '3.2%',
          Colors.blue,
        ),
        const SizedBox(height: 8),
        _buildPostCard(
          'قصة نجاح أحد العملاء',
          '634 إعجاب • 67 تعليق',
          '2.9%',
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildPostCard(String title, String stats, String engagement, Color color) {
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
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.article, color: color),
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
                  stats,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              engagement,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudienceAnalysis() {
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
            'تحليل الجمهور',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildAudienceMetric('العمر الأكثر تفاعلاً', '25-34 سنة', '45%'),
          const SizedBox(height: 12),
          _buildAudienceMetric('الجنس', 'ذكور 60% • إناث 40%', ''),
          const SizedBox(height: 12),
          _buildAudienceMetric('أفضل وقت للنشر', '9:00 صباحاً', ''),
          const SizedBox(height: 12),
          _buildAudienceMetric('المنصة الأكثر تفاعلاً', 'إنستغرام', '38%'),
        ],
      ),
    );
  }

  Widget _buildAudienceMetric(String title, String value, String percentage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Row(
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            if (percentage.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                percentage,
                style: const TextStyle(fontSize: 12, color: Colors.green),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'إعدادات التسويق',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // ربط الحسابات
          _buildSettingsSection(
            'ربط الحسابات',
            [
              _buildSocialAccountSetting('فيسبوك', Icons.facebook, Colors.blue, true),
              _buildSocialAccountSetting('إنستغرام', Icons.camera_alt, Colors.purple, false),
              _buildSocialAccountSetting('تويتر', Icons.chat_bubble, Colors.lightBlue, true),
              _buildSocialAccountSetting('لينكد إن', Icons.business, Colors.indigo, false),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // إعدادات الإشعارات
          _buildSettingsSection(
            'الإشعارات',
            [
              _buildNotificationSetting('تنبيهات الحملات', 'تلقي إشعارات حول أداء الحملات', true),
              _buildNotificationSetting('اقتراحات المحتوى', 'تلقي اقتراحات لمحتوى جديد', true),
              _buildNotificationSetting('تقارير أسبوعية', 'تلقي تقرير أسبوعي عن الأداء', false),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // إعدادات عامة
          _buildSettingsSection(
            'إعدادات عامة',
            [
              _buildGeneralSetting('اللغة المفضلة', 'العربية'),
              _buildGeneralSetting('المنطقة الزمنية', 'توقيت الرياض'),
              _buildGeneralSetting('العملة', 'ريال سعودي (SAR)'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
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
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSocialAccountSetting(String platform, IconData icon, Color color, bool isConnected) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(platform),
      subtitle: Text(isConnected ? 'متصل' : 'غير متصل'),
      trailing: Switch(
        value: isConnected,
        onChanged: (value) {
          // TODO: تنفيذ ربط/إلغاء ربط الحساب
        },
        activeColor: color,
      ),
    );
  }

  Widget _buildNotificationSetting(String title, String description, bool isEnabled) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      trailing: Switch(
        value: isEnabled,
        onChanged: (value) {
          // TODO: تنفيذ تغيير إعدادات الإشعارات
        },
      ),
    );
  }

  Widget _buildGeneralSetting(String title, String value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // TODO: تنفيذ تغيير الإعدادات العامة
      },
    );
  }
}

