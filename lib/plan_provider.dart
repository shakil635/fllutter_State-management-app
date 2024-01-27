import 'package:flutter/material.dart';
import 'package:flutter_chap7/models/plan.dart';

class PlanProvider extends InheritedNotifier<ValueNotifier<List<Plan>>> {
  // make a class name PlanProvider and it extends InheritedNotifier.
  // InheritedNotifier make it type restriced,
  //ValueNotifier mutable data types take a list and this list take a class name plan only this type is allowed.
  //when PlanProvider update notifier send a notification 
  const PlanProvider(
      {super.key,
      required Widget child,
      required ValueNotifier<List<Plan>> notifier})
      : super(child: child, notifier: notifier);
  static ValueNotifier<List<Plan>> of(BuildContext context) {
    //ValueNotifier build in class make it static.
    //ValueNotifier mutable data types returns nearest widget of the given [InheritedWidget] subclass if its null or value
    return context
        .dependOnInheritedWidgetOfExactType<PlanProvider>()!
        .notifier!;
  }

  
}
