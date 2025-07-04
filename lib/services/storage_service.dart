import 'dart:convert';
import 'package:flutter/foundation.dart';

class StorageService {
  static final Map<String, dynamic> _storage = {};
  
  // حفظ البيانات
  static Future<bool> saveData(String key, dynamic value) async {
    try {
      _storage[key] = value;
      if (kDebugMode) {
        print('تم حفظ البيانات: $key');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في حفظ البيانات: $e');
      }
      return false;
    }
  }
  
  // استرجاع البيانات
  static T? getData<T>(String key) {
    try {
      return _storage[key] as T?;
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في استرجاع البيانات: $e');
      }
      return null;
    }
  }
  
  // حذف البيانات
  static Future<bool> removeData(String key) async {
    try {
      _storage.remove(key);
      if (kDebugMode) {
        print('تم حذف البيانات: $key');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في حذف البيانات: $e');
      }
      return false;
    }
  }
  
  // مسح جميع البيانات
  static Future<bool> clearAll() async {
    try {
      _storage.clear();
      if (kDebugMode) {
        print('تم مسح جميع البيانات');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('خطأ في مسح البيانات: $e');
      }
      return false;
    }
  }
  
  // التحقق من وجود البيانات
  static bool hasData(String key) {
    return _storage.containsKey(key);
  }
  
  // حفظ بيانات المستخدم
  static Future<bool> saveUserData(Map<String, dynamic> userData) async {
    return await saveData('user_data', userData);
  }
  
  // استرجاع بيانات المستخدم
  static Map<String, dynamic>? getUserData() {
    return getData<Map<String, dynamic>>('user_data');
  }
  
  // حفظ إعدادات التطبيق
  static Future<bool> saveAppSettings(Map<String, dynamic> settings) async {
    return await saveData('app_settings', settings);
  }
  
  // استرجاع إعدادات التطبيق
  static Map<String, dynamic> getAppSettings() {
    return getData<Map<String, dynamic>>('app_settings') ?? {
      'language': 'ar',
      'theme': 'light',
      'notifications': true,
      'ai_provider': 'openai',
    };
  }
  
  // حفظ تاريخ المحادثة
  static Future<bool> saveChatHistory(List<Map<String, String>> chatHistory) async {
    return await saveData('chat_history', chatHistory);
  }
  
  // استرجاع تاريخ المحادثة
  static List<Map<String, String>> getChatHistory() {
    final history = getData<List<dynamic>>('chat_history');
    if (history != null) {
      return history.map((item) => Map<String, String>.from(item)).toList();
    }
    return [];
  }
  
  // حفظ مشاريع المستخدم
  static Future<bool> saveProjects(List<Map<String, dynamic>> projects) async {
    return await saveData('user_projects', projects);
  }
  
  // استرجاع مشاريع المستخدم
  static List<Map<String, dynamic>> getProjects() {
    final projects = getData<List<dynamic>>('user_projects');
    if (projects != null) {
      return projects.map((item) => Map<String, dynamic>.from(item)).toList();
    }
    return [];
  }
  
  // حفظ دراسات الجدوى
  static Future<bool> saveFeasibilityStudies(List<Map<String, dynamic>> studies) async {
    return await saveData('feasibility_studies', studies);
  }
  
  // استرجاع دراسات الجدوى
  static List<Map<String, dynamic>> getFeasibilityStudies() {
    final studies = getData<List<dynamic>>('feasibility_studies');
    if (studies != null) {
      return studies.map((item) => Map<String, dynamic>.from(item)).toList();
    }
    return [];
  }
  
  // حفظ الحملات التسويقية
  static Future<bool> saveMarketingCampaigns(List<Map<String, dynamic>> campaigns) async {
    return await saveData('marketing_campaigns', campaigns);
  }
  
  // استرجاع الحملات التسويقية
  static List<Map<String, dynamic>> getMarketingCampaigns() {
    final campaigns = getData<List<dynamic>>('marketing_campaigns');
    if (campaigns != null) {
      return campaigns.map((item) => Map<String, dynamic>.from(item)).toList();
    }
    return [];
  }
  
  // حفظ مفاتيح API
  static Future<bool> saveApiKeys(Map<String, String> apiKeys) async {
    return await saveData('api_keys', apiKeys);
  }
  
  // استرجاع مفاتيح API
  static Map<String, String> getApiKeys() {
    return getData<Map<String, String>>('api_keys') ?? {};
  }
}

