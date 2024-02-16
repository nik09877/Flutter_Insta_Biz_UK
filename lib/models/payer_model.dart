class Payer {
  String payerName;
  String currency;
  String accountNumber;
  int userId;
  String payerType;

  Payer({
    required this.payerName,
    required this.currency,
    required this.accountNumber,
    required this.userId,
    required this.payerType,
  });

  // Factory method to create a Payer instance from a map
  factory Payer.fromJson(Map<String, dynamic> json) {
    return Payer(
      payerName: json['payerName'] ?? '',
      currency: json['currency'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      userId: json['userId'] ?? 0,
      payerType: json['payerType'] ?? '',
    );
  }

// Payer <-> Map<String,dynamic> <-> json

  // Convert the Payer instance to a map
  Map<String, dynamic> toJson() {
    return {
      'payerName': payerName,
      'currency': currency,
      'accountNumber': accountNumber,
      'userId': userId,
      'payerType': payerType,
    };
  }
}
