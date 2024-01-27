import 'task.dart';


class Plan {  
//create a class name Plan 
 final String name;
 final List<Task> tasks;
 const Plan({this.name = '', this.tasks = const []}); 


  int get completedCount => tasks.where((task) => task.complete).length;
  // tasks list filter a boolean condition(complete) and length  calculates the length of the filtered list.
String get completenessMessage =>
 '$completedCount out of ${tasks.length} tasks';
 //completenessMessage this getter is show filtered list and also tasks list length
 
}










