import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db/transaction/transaction_db.dart';
import 'package:money_management_app/models/category/category_model.dart';
import 'package:money_management_app/models/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  double totalAmount = 0;

  double totalIncome = 0;
  double totalExpence = 0;
  double totalBalance = 0;
  ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB().refresh();
    CategoryDB().refreshUI();

    void total(List<TransactionModel> entireData) {
      totalAmount = 0;
      totalIncome = 0;
      totalExpence = 0;
      totalBalance = 0;
      for (TransactionModel data in entireData) {
        if (data.date.month == DateTime.now().month) {
          totalAmount = totalAmount + data.amount;
          if (data.category.type == CategoryType.income) {
            totalIncome = totalIncome + data.amount;
          } else {
            totalExpence = totalExpence + data.amount;
          }
          totalBalance = totalIncome - totalExpence;
        }
      }
      TransactionDB().refresh();
    }

    return ValueListenableBuilder(
        valueListenable: TransactionDB().transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          total(newList);
          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 120,
                    margin: const EdgeInsets.only(
                      top: 9,
                      left: 12,
                      right: 12,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(
                          15,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 15), 
                            child: Text(
                              "Balance",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            totalBalance.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    left: 25,
                    bottom: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 70,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.arrow_upward_sharp,
                            color: Colors.green,
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            const Text(
                              "Income",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              totalIncome.toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 25,
                    bottom: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 70,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.arrow_downward_sharp,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            const Text(
                              "Expense",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              totalExpence.toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (ctx, index) {
                    final _value = newList[index];

                    return Slidable(
                      key: Key(_value.id!),
                      startActionPane:
                          ActionPane(motion: ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: (ctx) {
                            TransactionDB().deleteTransaction(_value.id!);
                          },
                          icon: Icons.delete,
                          label: "Delete",
                        )
                      ]),
                      child: Card(
                        child: ListTile(
                          leading: Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Text(
                              "${_value.amount}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    _value.category.type == CategoryType.income
                                        ? Colors.blue
                                        : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.monetization_on_sharp,
                            color: _value.category.type == CategoryType.income
                                ? Colors.green
                                : Colors.red,
                            size: 30,
                          ),
                          title: Text(
                            _value.purpose,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                parseDate(_value.date),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                _value.category.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: newList.length,
                ),
              ),
            ],
          );
        });
  }

  String parseDate(DateTime date) {
    final _date = DateFormat('d-MMM-yy').format(date);
    return _date;
  }
}
