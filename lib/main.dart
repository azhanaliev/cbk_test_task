import 'package:cbk_test/provider/credit_provider.dart';
import 'package:cbk_test/screens/credit_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'cbk test task';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CreditProvider>(create: (_) => CreditProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.cyan),
        title: _title,
        home: Scaffold(
          appBar: AppBar(title: const Text(_title)),
          body: const CreditList(),
        ),
      ),
    );
  }
}
