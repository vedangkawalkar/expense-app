import 'package:expenseapp/models/expense.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class Newexpense extends StatefulWidget {
  const Newexpense({super.key, required this.onaddexpense});
  final Function(Expense expense) onaddexpense;

  @override
  State<Newexpense> createState() {
    return _Newexpense();
  }
}

class _Newexpense extends State<Newexpense> {
// var _enteredtitle='';

//   void _savetitleinp(String inpval){
//       _enteredtitle= inpval;
//   }

  final _titlecontoller = TextEditingController();
  final _amountcontoller = TextEditingController();
  DateTime? _selecteddate;
  Category _selectedcategory = Category.leisure;

  void _presentdatepick() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickeddate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
      initialDate: now,
    );
    setState(() {
      _selecteddate = pickeddate;
    });
  }

  void _submitExpense() {
    final eneteredamount = double.tryParse(_amountcontoller.text);
    final amountinvalid = eneteredamount == null || eneteredamount <= 0;
    if (_titlecontoller.text.trim().isEmpty ||
        amountinvalid ||
        _selecteddate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('pls mk sure crrct amount and date was entered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        ),
      );
      return;
    }
    widget.onaddexpense(Expense(
        title: _titlecontoller.text,
        amount: eneteredamount,
        date: _selecteddate!,
        category: _selectedcategory),
        );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titlecontoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final keyboaredspace=MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx,constraints){
      // print(constraints.minWidth);
      // print(constraints.maxWidth);
      // print(constraints.minHeight);
      // print(constraints.maxHeight);
//final width=constraints.maxWidth;


       return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.fromLTRB(10,48,10,keyboaredspace+10),
          child: Column(
            children: [
              // if(width>=600)
              // Row(children: [
              //    TextField(
              //   //onChanged: _savetitleinp,
              //   controller: _titlecontoller,
              //   maxLength: 50,
              //   decoration: const InputDecoration(label: Text('Title')),
              // ),
              // const SizedBox(width: 24,),
              // Expanded(
              //       child: TextField(
              //         //onChanged: _savetitleinp,
              //         controller: _amountcontoller,
              //         keyboardType: TextInputType.number,
              //         decoration: const InputDecoration(
              //             prefixText: '\$ ', label: Text('Amount')),
              //       ),
              //     ),
              // ],)
              // else
              TextField(
                //onChanged: _savetitleinp,
                controller: _titlecontoller,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Title')),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      //onChanged: _savetitleinp,
                      controller: _amountcontoller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          prefixText: '\$ ', label: Text('Amount')),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selecteddate == null
                          ? 'no date selected'
                          : formatter.format(_selecteddate!)),
                      IconButton(
                          onPressed: _presentdatepick,
                          icon: const Icon(Icons.calendar_month))
                    ],
                  ))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedcategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedcategory = value;
                        });
                        //print(value);
                      }),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('cancel')),
                  ElevatedButton(
                      onPressed: _submitExpense // () {
                      // print(_enteredtitle);
                      // print(_titlecontoller.text);
                      // print(_amountcontoller.text);
                      //},
                      ,
                      child: const Text('save expense')),
                ],
              )
            ],
          ),
        ),
      ),
    );
    });
  }
}