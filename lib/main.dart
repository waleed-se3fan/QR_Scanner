import 'package:flutter/material.dart';
import 'package:qr_scanner/app.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://rzxtgrivfjveezskarrq.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ6eHRncml2Zmp2ZWV6c2thcnJxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwNTc5NzksImV4cCI6MjA1OTYzMzk3OX0.xX27xrMGF1V-e31e1EwVJqV6nhQpZQ6SFH6t2EJeMBA');
  runApp(const MyApp());
}
