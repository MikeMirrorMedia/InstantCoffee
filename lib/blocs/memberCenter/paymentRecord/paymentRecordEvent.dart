part of 'paymentRecordBloc.dart';

@immutable
abstract class PaymentRecordEvent {}

class FetchPaymentRecord extends PaymentRecordEvent {
  @override
  String toString() {
    return 'Fetch payment records';
  }
}
