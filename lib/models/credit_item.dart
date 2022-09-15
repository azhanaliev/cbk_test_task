class CreditItem {
  CreditItem(
      {required this.id,
        required this.productName,
        required this.takeDate,
        required this.amount,
        required this.percent,
        required this.loanMonths,
        required this.currency,
        required this.paymentDay,
        required this.holidays,
        required this.workDays
      });

  int id;
  String productName;
  String takeDate;
  int amount;
  int percent;
  int loanMonths;
  String currency;
  int paymentDay;
  List<String> holidays;
  List<String> workDays;
}