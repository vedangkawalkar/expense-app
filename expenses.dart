import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expenseapp/widgets/expenseslist/expenses_list.dart';
import 'package:expenseapp/widgets/chart/chart.dart';
class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<Expense> _registereexpenses = [
    Expense(title: 'flutter', amount: 300, date:DateTime.now(), category: Category.work)
  ];

  void _openaddexpenseoverlay() {
    showModalBottomSheet(
      useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => Newexpense(onaddexpense: _addexpense));
  }

  void _addexpense(Expense expense) {
    setState(() {
      _registereexpenses.add(expense);
    });
  }

  void _removeexpense(Expense expense) {
    final expenseindex = _registereexpenses.indexOf(expense);
    setState(() {
      _registereexpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        duration:const Duration(seconds: 3),
        content: const Text("expense deleted"),
        action: SnackBarAction(
          label:'Undo' 
        , onPressed: (){
          setState(() {
            _registereexpenses.insert(expenseindex,expense);
          });
        },
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
      final width =MediaQuery.of(context).size.width;


    Widget maincontent = const Center(
      child: Text('No expenses found,try adding some!'),
    );

    if (_registereexpenses.isNotEmpty) {
      maincontent=Expenseslist(
            expenses: _registereexpenses,
            onremoveexpense: _removeexpense,
          );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Expense tracker'), actions: [
        IconButton(
          onPressed: _openaddexpenseoverlay,
          icon: const Icon(Icons.add),
        )
      ]),
      body:width<600? Column(
        children: [
          Chart(expenses: _registereexpenses),
          Expanded(
              child: maincontent,
          )
        ],
      ):Row( children: [
          Expanded(
            child:
              Chart(expenses: _registereexpenses),),
              Expanded(
                  child: maincontent,
              )
        ],),
    );
  }
}
