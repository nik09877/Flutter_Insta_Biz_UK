class Account {
  String name;
  int userId;
  int accountNumber;
  String currency;
  int balance;
  DateTime openingDate;
  String branch;
  int customerId;
  String accountType;

  Account({
    required this.name,
    required this.userId,
    required this.accountNumber,
    required this.currency,
    required this.balance,
    required this.openingDate,
    required this.branch,
    required this.customerId,
    required this.accountType,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      name: json['name'] ?? '',
      userId: json['userId'],
      accountNumber: json['accountNumber'] ?? 0,
      currency: json['currency'] ?? '',
      balance: json['balance'],
      openingDate: DateTime.parse(json['openingDate'] ?? ''),
      branch: json['branch'] ?? '',
      customerId: json['customerId'] ?? 0,
      accountType: json['accountType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userId': userId,
      'accountNumber': accountNumber,
      'currency': currency,
      'balance': balance,
      'openingDate': openingDate.toIso8601String(),
      'branch': branch,
      'customerId': customerId,
      'accountType': accountType,
    };
  }
}
