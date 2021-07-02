import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/domain/entities/transaction.dart';

class TransactionModel extends Transaction implements ToJsonInterface {
  const TransactionModel(String txHash, double amount, DateTime? createdAt)
      : super(txHash, amount, createdAt);

  factory TransactionModel.fromJson(Map json) {
    double amount;
    if (json['amount'] == null)
      amount = 0.0;
    else if (json['amount'] is int)
      amount = (json['amount'] as int).toDouble();
    else
      amount = json['amount'];

    DateTime? createdAt;
    if (json['created_at'] != null)
      createdAt = DateTime.tryParse(json['created_at']);

    return TransactionModel(
      json['tx_hash'] == null ? '' : json['tx_hash'],
      amount,
      createdAt,
    );
  }

  @override
  Map toJson() => {
        'tx_hash': txHash,
        'amount': amount,
        'created_at': createdAt?.toIso8601String() ?? '',
      };
}