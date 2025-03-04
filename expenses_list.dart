//import 'dart:js_interop_unsafe';

import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/widgets/expenseslist/expenseitem.dart';
import 'package:flutter/material.dart';

class Expenseslist extends StatelessWidget{
const Expenseslist({super.key,required this.expenses,required this.onremoveexpense});

final List<Expense> expenses;
final void Function(Expense expense) onremoveexpense;

@override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.25),
        margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        // Colors.red,),
        key:ValueKey(expenses[index]),
        onDismissed:(direction){
          onremoveexpense(expenses[index]);
        } ,
        child: Expenseitem(expenses[index]),
      ),
      );
  }
}
