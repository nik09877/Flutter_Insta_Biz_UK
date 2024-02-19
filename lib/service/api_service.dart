import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myproject/models/account_model.dart';
import 'package:myproject/models/payer_model.dart';

class ApiService {
  static const String baseUrl = 'http://10.101.151.42:3000';
  // static const String baseUrl = 'http://10.101.151.42:3000';
  // static const String baseUrl = 'http://10.101.151.42:3000';

  Future<List<Account>> getAllAccounts(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/accounts'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        final ans = data
            .map((account) => Account.fromJson(account))
            .where((account) => account.userId == userId)
            .toList();
        return ans;
      } else {
        throw Exception('Failed to fetch accounts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch accounts: ${e.toString()}');
    }
  }

  Future<List<Payer>> getAllPayers(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/payers'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        final ans = data
            .map((payer) => Payer.fromJson(payer))
            .where((payer) => payer.userId == userId)
            .toList();
        return ans;
      } else {
        throw Exception('Failed to fetch payers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch payers: ${e.toString()}');
    }
  }
}
