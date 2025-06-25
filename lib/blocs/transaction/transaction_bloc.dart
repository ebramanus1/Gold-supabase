import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_workshop_manager/models/transaction.dart';
import 'package:gold_workshop_manager/repositories/transaction_repository.dart';

// Events
abstract class TransactionEvent {}

class LoadTransactions extends TransactionEvent {}

class AddEntryTransaction extends TransactionEvent {
  final Transaction transaction;

  AddEntryTransaction(this.transaction);
}

class AddOutputTransaction extends TransactionEvent {
  final Transaction transaction;

  AddOutputTransaction(this.transaction);
}

// States
abstract class TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;

  TransactionLoaded(this.transactions);
}

class TransactionError extends TransactionState {
  final String message;

  TransactionError(this.message);
}

// BLoC
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _transactionRepository = TransactionRepository();

  TransactionBloc() : super(TransactionLoading()) {
    on<LoadTransactions>((event, emit) async {
      await emit.forEach(_transactionRepository.getTransactions(),
          onData: (transactions) {
        return TransactionLoaded(transactions);
      }, onError: (error, stackTrace) {
        return TransactionError(error.toString());
      });
    });

    on<AddEntryTransaction>((event, emit) async {
      try {
        await _transactionRepository.addEntry(event.transaction);
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });

    on<AddOutputTransaction>((event, emit) async {
      try {
        await _transactionRepository.addOutput(event.transaction);
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    });
  }
}

