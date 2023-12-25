import 'package:flutter/material.dart';
import 'package:flutter_chap7/models/plan.dart';
import 'package:flutter_chap7/plan_creator_screen.dart';
import 'package:flutter_chap7/plan_provider.dart';


void main() {
  runApp(const MasterPlanApp());
}

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlanProvider(
      notifier: ValueNotifier<List<Plan>>(const []),
      child: MaterialApp(
        title: 'State management app',
        theme: ThemeData(
          primaryColor: Colors.purple,
        ),
        home:  const PlanCreatorScreen(),
      ),
    );
  }
}




