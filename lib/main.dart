import 'package:flutter/material.dart';
import 'package:flutter_first_app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://frdkorkyxdypcmkqifvd.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZyZGtvcmt5eGR5cGNta3FpZnZkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc2Nzc2OTQsImV4cCI6MjA3MzI1MzY5NH0.bF-VTqbx3nAMisPNlY7wa6czLRJLA3FcrM6alUiyAVo",
  );

  runApp(const MyApp());
}
