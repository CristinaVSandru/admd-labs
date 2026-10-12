 class BankAccount {
  late int accountNumber;
  final String holderName;
  final double balance;
  String? bankBranch;

  bool isNumberSet = false;
  
  BankAccount({required this.holderName, this.balance=0.0, this.bankBranch});

  void initializeAccount(String number) {
    accountNumber = int.parse(number);
    isNumberSet = true;
    }
  bool checkNumber(){
    return isNumberSet;
  }
}