class Account {
  final int id;
  final String name;
  final String balance;
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
