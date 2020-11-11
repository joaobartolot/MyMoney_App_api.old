class Account {
  final int id;
  final String name;
  final int balance;
  final String cardImage;

  Account({this.id, this.name, this.balance, this.cardImage});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      name: json['name'],
      balance: json['balance'],
      cardImage: json['cardImg'],
    );
  }
}

class Accounts {
  final List<Account> accounts;

  Accounts({this.accounts});
  factory Accounts.fromJson(List<dynamic> json) {
    List<Account> list = [];
    for (int i = 0; i < json.length - 1; i++) {
      list.add(Account.fromJson(json[i]));
    }
    return Accounts(
      accounts: list,
    );
  }
}
