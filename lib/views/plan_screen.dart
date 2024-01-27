import 'package:flutter/material.dart';
import 'package:flutter_chap7/models/plan.dart';
import 'package:flutter_chap7/models/task.dart';
import 'package:flutter_chap7/plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});
  @override
  State createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  
  //use late and make variable name scrollController,monitor the scroll position
  // make a getter name plan

   late ScrollController scrollController;
  Plan get plan => widget.plan; //why use widget?
  
  //dispos method is a part of statefull widget.
  //when ever textController work finish dispos method close textControler
@override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

//initState is a part of statefull widget.
//we call initState method rebuild our updateable widget state
//call scrollController,when user scroll this widget state are chage need rebuild
// cascade (..) operator, allowing you to chain multiple operations on the created ScrollController.
/*
FocusScope.of(context).requestFocus(FocusNode());: 
Inside the listener, this code is requesting the focus for an empty FocusNode,
 effectively removing the focus from any active input field. 
 This is a common practice to dismiss the keyboard or unfocus text input fields when the user scrolls.
 */
@override
void initState() {
  super.initState();
  scrollController = ScrollController()
    ..addListener(() {
      FocusScope.of(context).requestFocus(FocusNode());
    });
}


Widget _buildList(Plan plan) {
  //make a function name buildList
  //and it return a ListView.builder
  //use scrollController,monitor the scroll position
  //itemBuilder is callBack function return a function name buildTaskTile, this method take two perametar
  return ListView.builder(
    controller: scrollController,
    itemCount: plan.tasks.length,
    itemBuilder: (context, index) =>
        _buildTaskTile(plan.tasks[index], index, context),
  );
}


 //make a instace of PlanProvider
 //ValueListenableBuilder is a Flutter widget that listens to changes in a ValueListenable
 // and rebuilds its UI when the value changes.
 //build callBack fucntion take three parametar and also have a variable currentPlan.
 //we check vai boolen operation plans first element equale Plan name than returan a colum.
 //this colum first expanded and show buildList method.
 //Also take safeArea,text have currentPlan variable with a getter completMessage.
 //add a buildAddTaskButton when user press add a task
  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(plan.name),
      backgroundColor: Colors.pink,),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          Plan currentPlan = plans.firstWhere((p) => p.name == plan.name);
          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(child: Text(currentPlan.completenessMessage)),
            ],
          );
        },
      ),
      floatingActionButton: _buildAddTaskButton(
        context,
      ),
    );
  }





Widget _buildAddTaskButton(BuildContext context) {
  //make a function name buildAddTaskButton
  //planNotifier is a instance of PlanProvider
  // buildAddTaskButton method return a button
  //when user press this button 
  ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
  return FloatingActionButton(
    child: const Icon(Icons.add),
    onPressed: () {
      Plan currentPlan = plan;
      int planIndex =
          planNotifier.value.indexWhere((p) => p.name == currentPlan.name);
      List<Task> updatedTasks = List<Task>.from(currentPlan.tasks)
        ..add(const Task());
      planNotifier.value = List<Plan>.from(planNotifier.value)
        ..[planIndex] = Plan(
          name: currentPlan.name,
          tasks: updatedTasks,
        );
     Plan(   //TODo
        name: currentPlan.name,
        tasks: updatedTasks,
      );
    },

    
  );
}


Widget _buildTaskTile(Task task, int index, BuildContext context) {
  //make a function name buildTaskTile and take three parametar
  //creat a instance of PlanProvider 
  //this function return a widget name listTile,ListTile widget is commonly used to create a material design list item
  //checkBox Material Design widget that represents a binary choice 
  //value check boolien operator via true or false
  //onChanged is callback Fucntion it take a parametar.
  //make a instance of getter plan
  //take a variable name planIndex this variable store we find out index one by one and check a boolean operator of this index equal.
  //make a getter call a list and cascade notetion for multiple operation.
  //call plan class and this class filed.
  //checkBox in..list title take a TextFormField  
  // initialValue take a class instace and call a filed description

  ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
  return ListTile(
    leading: Checkbox( //?
        value: task.complete,
        onChanged: (selected) {
          Plan currentPlan = plan;
          int planIndex =
              planNotifier.value.indexWhere((p) => p.name == currentPlan.name);
          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(
              name: currentPlan.name,
              tasks: List<Task>.from(currentPlan.tasks)
                ..[index] = Task(
                  description: task.description,
                  complete: selected ?? false,
                ),
            );
        }),
    title: TextFormField(
      initialValue: task.description,
      onChanged: (text) {
        Plan currentPlan = plan;
        int planIndex =
            planNotifier.value.indexWhere((p) => p.name == currentPlan.name);
        planNotifier.value = List<Plan>.from(planNotifier.value)
          ..[planIndex] = Plan(
            name: currentPlan.name,
            tasks: List<Task>.from(currentPlan.tasks)
              ..[index] = Task(
                description: text,
                complete: task.complete,
              ),
          );
      },
    ),
  );
}


}


