import 'package:flutter/material.dart';
import 'package:flutter_chap7/models/plan.dart';



class PlanProvider extends InheritedNotifier<ValueNotifier<List<Plan>>> {
 const PlanProvider({super.key, required Widget child, required
ValueNotifier<List<Plan>> notifier})
 : super(child: child, notifier: notifier);
 static ValueNotifier<List<Plan>> of(BuildContext context) {
 return context.
dependOnInheritedWidgetOfExactType<PlanProvider>()!.notifier!;
 }



}













