import 'package:mymoney_app/src/api/api_base_helper.dart';
import 'package:mymoney_app/src/model/account_model.dart';

class AccountList {
  final String _endpoint = 'account-list';

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Accounts> fetchAccounts() async {
    final response = await _helper.get(_endpoint);
    return Accounts.fromJson(response);
  }
}
