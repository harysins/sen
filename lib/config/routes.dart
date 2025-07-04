import 'package:flutter/material.dart';
import 'package:meem/screens/splash/splash_screen.dart';
import 'package:meem/screens/auth/login_screen.dart';
import 'package:meem/screens/auth/register_screen.dart';
import 'package:meem/screens/home/home_screen.dart';
import 'package:meem/screens/bot/bot_screen.dart';
import 'package:meem/screens/projects/projects_library_screen.dart';
import 'package:meem/screens/projects/create_project_screen.dart';
import 'package:meem/screens/feasibility/feasibility_questionnaire_screen.dart';
import 'package:meem/screens/feasibility/feasibility_questions_screen.dart';
import 'package:meem/screens/feasibility/feasibility_report_screen.dart';
import 'package:meem/screens/marketing/marketing_dashboard_screen.dart';
import 'package:meem/screens/marketing/ad_generator_screen.dart';
import 'package:meem/screens/marketing/competitor_analysis_screen.dart';
import 'package:meem/screens/marketing/social_share_screen.dart';
import 'package:meem/screens/funding/funding_list_screen.dart';
import 'package:meem/screens/funding/funding_details_screen.dart';
import 'package:meem/screens/funding/internal_investment_screen.dart';
import 'package:meem/screens/profile/user_profile_screen.dart';
import 'package:meem/screens/settings/settings_screen.dart';
import 'package:meem/screens/notifications/notifications_screen.dart';
import 'package:meem/screens/search/search_screen.dart';
import 'package:meem/screens/location/country_city_selection_screen.dart';

class AppRoutes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String botRoute = '/bot';
  static const String projectsLibraryRoute = '/projects_library';
  static const String createProjectRoute = '/create_project';
  static const String feasibilityQuestionnaireRoute = '/feasibility_questionnaire';
  static const String feasibilityQuestionsRoute = '/feasibility_questions';
  static const String feasibilityReportRoute = '/feasibility_report';
  static const String marketingRoute = '/marketing';
  static const String marketingDashboardRoute = '/marketing_dashboard';
  static const String adGeneratorRoute = '/ad_generator';
  static const String competitorAnalysisRoute = '/competitor_analysis';
  static const String socialShareRoute = '/social_share';
  static const String fundingRoute = '/funding';
  static const String fundingListRoute = '/funding_list';
  static const String fundingDetailsRoute = '/funding_details';
  static const String internalInvestmentRoute = '/internal_investment';
  static const String userProfileRoute = '/user_profile';
  static const String settingsRoute = '/settings';
  static const String notificationsRoute = '/notifications';
  static const String searchRoute = '/search';
  static const String countryCitySelectionRoute = '/country_city_selection';

  static Map<String, WidgetBuilder> routes = {
    splashRoute: (context) => const SplashScreen(),
    loginRoute: (context) => const LoginScreen(),
    registerRoute: (context) => const RegisterScreen(),
    homeRoute: (context) => const HomeScreen(),
    botRoute: (context) => const BotScreen(),
    projectsLibraryRoute: (context) => const ProjectsLibraryScreen(),
    createProjectRoute: (context) => const CreateProjectScreen(),
    feasibilityQuestionnaireRoute: (context) => const ProjectDescriptionScreen(),
    marketingRoute: (context) => const MarketingDashboardScreen(),
    marketingDashboardRoute: (context) => const MarketingDashboardScreen(),
    adGeneratorRoute: (context) => const AdGeneratorScreen(),
    competitorAnalysisRoute: (context) => const CompetitorAnalysisScreen(),
    socialShareRoute: (context) => const SocialShareScreen(),
    fundingRoute: (context) => const FundingListScreen(),
    fundingListRoute: (context) => const FundingListScreen(),
    fundingDetailsRoute: (context) => const FundingDetailsScreen(),
    internalInvestmentRoute: (context) => const InternalInvestmentScreen(),
    userProfileRoute: (context) => const UserProfileScreen(),
    settingsRoute: (context) => const SettingsScreen(),
    notificationsRoute: (context) => const NotificationsScreen(),
    searchRoute: (context) => const SearchScreen(),
    countryCitySelectionRoute: (context) => const CountryCitySelectionScreen(),
  };

  // مسارات ديناميكية للشاشات التي تحتاج معاملات
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case feasibilityQuestionsRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => FeasibilityQuestionsScreen(
            projectDescription: args?['projectDescription'] ?? '',
          ),
        );

      case feasibilityReportRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => FeasibilityReportScreen(answers: args ?? {}),
        );

      default:
        // إذا لم يتم العثور على المسار، استخدم المسارات العادية
        final routeBuilder = routes[settings.name];
        if (routeBuilder != null) {
          return MaterialPageRoute(builder: routeBuilder);
        }

        // صفحة خطأ إذا لم يتم العثور على المسار
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('خطأ')),
            body: const Center(child: Text('الصفحة غير موجودة')),
          ),
        );
    }
  }
}
