import 'package:flutter/material.dart';
import 'package:flutter_chap7/models/plan.dart';
import 'package:flutter_chap7/plan_provider.dart';
import 'package:flutter_chap7/views/plan_screen.dart';

class PlanCreatorScreen extends StatefulWidget {
  const PlanCreatorScreen({super.key});

  @override
  State<PlanCreatorScreen> createState() => _PlanCreatorScreenState();
}

class _PlanCreatorScreenState extends State<PlanCreatorScreen> {
  final textController = TextEditingController();
  //TextEditingController use multiple action like reading current text value (textController.text),
  //setting a new text value (textController.text = 'New Text')..etc.

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  //dispos method is a part of statefull widget.
  //when ever textController work finish dispos method close textControler

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Master Plans'),
        backgroundColor: Colors.pink,
      ),
      body: Column(children: [
        _buildListCreator(),
        Expanded(child: _buildMasterPlans())
      ]),
    );
  }

  Widget _buildListCreator() {
    //make method name buildListCreator it return a padding widget.
    // Material or Material Design use for text filed, 
    //call global color
    // Material Design TextFiled use TextController(line:15,line:16).
    // use InputDecoration for Material Textfiled desing boder or label or text etc.
    //and lastly add a method name addPlan what and how we add this textfiled add a text.
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          color: Theme.of(context).cardColor,
          elevation: 10,
          child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                  labelText: 'Add a plan', contentPadding: EdgeInsets.all(20)),
              onEditingComplete: addPlan),
        ));
  }


  void addPlan() {
    //make a method name addPlan 
    //textcontroller stored a variable name text
    //we  check text variable if it empty return nothig.
    //we call Plan and make a instance name plan,it take two filed
    //planNotifier is a type of ValueNotifier, planNotifer is a instance of PlanProvider
    //  planNotifier.value is a setter set a value.
    //List.from is a constructor.This constructor creates a growable list when [planNotifier.value] is true.
    //use cascadeNotetion add a plan one by one
    //use clear method also clear  textfild text.
    //This line removes the focus from the current input field. It requests the focus for an
    //empty FocusNode, effectively dismissing the keyboard and removing focus from any text input filed.

    final text = textController.text;
    if (text.isEmpty) {
      return;
    }
    final plan = Plan(name: text, tasks: []);
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);//why not take two requried parameter?
    planNotifier.value = List<Plan>.from(planNotifier.value)..add(plan);
    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }




  Widget _buildMasterPlans() {
    //make a method name buildMasterlPlan
    //planNotifier is a instance of PlanProvider
    //make a lsit name plans 
    //we check plans list if is empty than return a colum
    //add a icon and add a text
    
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    List<Plan> plans = planNotifier.value;
    if (plans.isEmpty) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.note, size: 100, color: Colors.grey),
            Text('You do not have any plans yet.',
                style: Theme.of(context).textTheme.headlineSmall)
          ]);
    }
    // buildMasterPlan return ListView.builder.
    //itemCount >plans list length
    //itemBuilder> is callback fucntion it has two parametar also have a variable plan it stored plans list index.
    //call back function return a widget ListTile.
    //onTap> when user tap than user go PlanScren
    return ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return ListTile(
              title: Text(plan.name),
              subtitle: Text(plan.completenessMessage),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => PlanScreen(
                          plan: plan,
                        )));
              });
        });
  }
}
