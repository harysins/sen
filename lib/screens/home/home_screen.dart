import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            _buildMainDashboard(),
            _buildServicesPage(),
            _buildProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'الخدمات'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الملف الشخصي',
          ),
        ],
      ),
    );
  }

  Widget _buildMainDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ترحيب وإحصائيات سريعة
          _buildWelcomeSection(),

          const SizedBox(height: 24),

          // الخدمات الرئيسية
          _buildMainServices(),

          const SizedBox(height: 24),

          // آخر النشاطات
          _buildRecentActivities(),

          const SizedBox(height: 24),

          // نصائح سريعة
          _buildQuickTips(),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.waving_hand,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مرحباً بك في ميم!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'رفيقك في رحلة ريادة الأعمال',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildWelcomeMetric('المشاريع', '2')),
              const SizedBox(width: 16),
              Expanded(child: _buildWelcomeMetric('دراسات الجدوى', '3')),
              const SizedBox(width: 16),
              Expanded(child: _buildWelcomeMetric('الحملات التسويقية', '5')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeMetric(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMainServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'الخدمات الرئيسية',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            _buildServiceCard(
              'دراسة الجدوى',
              'تحليل شامل لمشروعك',
              Icons.analytics,
              Colors.blue,
              () {
                Navigator.pushNamed(context, '/feasibility_questionnaire');
              },
            ),
            _buildServiceCard(
              'بوت ميم الذكي',
              'مساعدك الذكي في ريادة الأعمال',
              Icons.smart_toy,
              Colors.purple,
              () {
                Navigator.pushNamed(context, '/bot');
              },
            ),
            _buildServiceCard(
              'التسويق والإعلانات',
              'أدوات تسويقية متقدمة',
              Icons.campaign,
              Colors.orange,
              () {
                Navigator.pushNamed(context, '/marketing');
              },
            ),
            _buildServiceCard(
              'التمويل والاستثمار',
              'حلول تمويلية شاملة',
              Icons.account_balance,
              Colors.green,
              () {
                Navigator.pushNamed(context, '/funding');
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceCard(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Icon(Icons.arrow_forward, color: color, size: 20)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'آخر النشاطات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // TODO: عرض جميع النشاطات
              },
              child: const Text('عرض الكل'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildActivityCard(
          'تم إكمال دراسة جدوى مشروع المطعم',
          'منذ ساعتين',
          Icons.check_circle,
          Colors.green,
        ),
        const SizedBox(height: 8),
        _buildActivityCard(
          'تم إنشاء حملة تسويقية جديدة',
          'منذ 4 ساعات',
          Icons.campaign,
          Colors.orange,
        ),
        const SizedBox(height: 8),
        _buildActivityCard(
          'محادثة جديدة مع بوت ميم',
          'منذ يوم واحد',
          Icons.chat,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildActivityCard(
    String title,
    String time,
    IconData icon,
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
            blurRadius: 5,
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
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'نصائح سريعة',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber.shade100, Colors.orange.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.lightbulb,
                  color: Colors.orange,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نصيحة اليوم',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'ابدأ بدراسة جدوى شاملة قبل الاستثمار في أي مشروع جديد',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServicesPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'جميع الخدمات',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'اكتشف جميع الأدوات والخدمات المتاحة',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),

          // خدمات التحليل والتخطيط
          _buildServiceCategory('التحليل والتخطيط', [
            _buildServiceListItem(
              'دراسة الجدوى الذكية',
              'تحليل شامل ومفصل لمشروعك',
              Icons.analytics,
              Colors.blue,
              () => Navigator.pushNamed(context, '/feasibility_questionnaire'),
            ),
            _buildServiceListItem(
              'تحليل السوق',
              'فهم السوق والمنافسين',
              Icons.trending_up,
              Colors.indigo,
              () {
                // TODO: تحليل السوق
              },
            ),
            _buildServiceListItem(
              'خطة العمل',
              'إنشاء خطة عمل احترافية',
              Icons.description,
              Colors.teal,
              () {
                // TODO: خطة العمل
              },
            ),
          ]),

          const SizedBox(height: 24),

          // خدمات التسويق
          _buildServiceCategory('التسويق والإعلانات', [
            _buildServiceListItem(
              'منشئ المحتوى',
              'إنشاء محتوى تسويقي جذاب',
              Icons.create,
              Colors.orange,
              () => Navigator.pushNamed(context, '/marketing'),
            ),
            _buildServiceListItem(
              'إدارة الحملات',
              'تخطيط وإدارة الحملات الإعلانية',
              Icons.campaign,
              Colors.deepOrange,
              () => Navigator.pushNamed(context, '/marketing'),
            ),
            _buildServiceListItem(
              'تحليل الأداء',
              'تتبع وتحليل أداء التسويق',
              Icons.bar_chart,
              Colors.red,
              () => Navigator.pushNamed(context, '/marketing'),
            ),
          ]),

          const SizedBox(height: 24),

          // خدمات التمويل
          _buildServiceCategory('التمويل والاستثمار', [
            _buildServiceListItem(
              'مصادر التمويل',
              'اكتشف أفضل خيارات التمويل',
              Icons.account_balance,
              Colors.green,
              () => Navigator.pushNamed(context, '/funding'),
            ),
            _buildServiceListItem(
              'حاسبة التمويل',
              'احسب الأقساط والفوائد',
              Icons.calculate,
              Colors.teal,
              () => Navigator.pushNamed(context, '/funding'),
            ),
            _buildServiceListItem(
              'فرص الاستثمار',
              'استثمر أموالك بذكاء',
              Icons.trending_up,
              Colors.lightGreen,
              () => Navigator.pushNamed(context, '/funding'),
            ),
          ]),

          const SizedBox(height: 24),

          // خدمات الدعم
          _buildServiceCategory('الدعم والمساعدة', [
            _buildServiceListItem(
              'بوت ميم الذكي',
              'مساعد ذكي متاح 24/7',
              Icons.smart_toy,
              Colors.purple,
              () => Navigator.pushNamed(context, '/bot'),
            ),
            _buildServiceListItem(
              'مركز المساعدة',
              'أسئلة شائعة وإرشادات',
              Icons.help_center,
              Colors.deepPurple,
              () {
                // TODO: مركز المساعدة
              },
            ),
            _buildServiceListItem(
              'تواصل معنا',
              'تواصل مع فريق الدعم',
              Icons.contact_support,
              Colors.indigo,
              () {
                // TODO: تواصل معنا
              },
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildServiceCategory(String title, List<Widget> services) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          child: Column(children: services),
        ),
      ],
    );
  }

  Widget _buildServiceListItem(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(description),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildProfilePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // معلومات المستخدم
          _buildUserProfile(),

          const SizedBox(height: 24),

          // إحصائيات المستخدم
          _buildUserStats(),

          const SizedBox(height: 24),

          // إعدادات الحساب
          _buildAccountSettings(),

          const SizedBox(height: 24),

          // معلومات التطبيق
          _buildAppInfo(),
        ],
      ),
    );
  }

  Widget _buildUserProfile() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Icon(
              Icons.person,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'أحمد محمد',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'رائد أعمال',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProfileStat('المشاريع', '3'),
              _buildProfileStat('دراسات الجدوى', '5'),
              _buildProfileStat('الحملات', '8'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildUserStats() {
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
            'إحصائيات الاستخدام',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildStatRow('إجمالي الجلسات', '24', Icons.access_time),
          _buildStatRow('وقت الاستخدام', '12 ساعة', Icons.schedule),
          _buildStatRow('آخر نشاط', 'منذ ساعتين', Icons.history),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Container(
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
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'إعدادات الحساب',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          _buildSettingItem('تعديل الملف الشخصي', Icons.edit, () {}),
          _buildSettingItem('الإشعارات', Icons.notifications, () {}),
          _buildSettingItem('الخصوصية والأمان', Icons.security, () {}),
          _buildSettingItem('اللغة', Icons.language, () {}),
          _buildSettingItem('تسجيل الخروج', Icons.logout, () {}),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  Widget _buildAppInfo() {
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
            'معلومات التطبيق',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildInfoRow('الإصدار', '1.0.0'),
          _buildInfoRow('آخر تحديث', '15 ديسمبر 2024'),
          _buildInfoRow('المطور', 'فريق ميم'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  // TODO: شروط الاستخدام
                },
                child: const Text('شروط الاستخدام'),
              ),
              TextButton(
                onPressed: () {
                  // TODO: سياسة الخصوصية
                },
                child: const Text('سياسة الخصوصية'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
