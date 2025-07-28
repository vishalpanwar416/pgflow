import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://dummy.supabase.co';
  
  static const String supabaseAnonKey = 'dummy-key';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
  
  static GoTrueClient get auth => client.auth;
  
  static PostgrestClient get database => client.rest;
  
  static RealtimeClient get realtime => client.realtime;
} 