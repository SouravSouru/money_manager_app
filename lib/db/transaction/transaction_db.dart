import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = "transaction-database";


abstract class TransactionDBFuctions{
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getTansactions();
  Future<void> deleteTransaction(String id);
  Future<void> deleteAllTransaction();
  

}

class TransactionDB implements TransactionDBFuctions{

  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB(){
    return instance;
  }


  ValueNotifier<List<TransactionModel>> transactionListNotifier = ValueNotifier([]);



  @override
  Future<void> addTransaction(TransactionModel obj) async{
    final _transactionDB = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDB.put(obj.id, obj);
  }

  Future<void> refresh()async{
    final _list = await getTansactions();
    _list.sort((first,second)=>second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();

  }

  @override
  Future<List<TransactionModel>> getTansactions() async{
    final _transactionDB = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactionDB.values.toList();

  }

  @override
  Future<void> deleteTransaction(String id) async{
    final _transactionDB = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDB.delete(id);
    refresh();
    
  }

  @override
  Future<void> deleteAllTransaction() async {
    final _transactionDB = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDB.deleteFromDisk();
    refresh();
  }

 

  
  
}