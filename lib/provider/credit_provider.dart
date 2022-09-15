import 'package:cbk_test/models/credit_item.dart';
import '../helper/get_loans.dart';
import 'base_provider.dart';

class CreditProvider extends BaseProvider {
  final List<CreditItem> _loadedCreditItems =
      List<CreditItem>.empty(growable: true);

  List<CreditItem> get loadedCreditItems => _loadedCreditItems;

  Future<void> loadData(int numberOfItems) async {
    _loadedCreditItems.clear();
    await generateItems(numberOfItems);
  }

  generateItems(int numberOfItems) async {
    var data = await NetworkHelper().getData();
    _loadedCreditItems.addAll(
      List<CreditItem>.generate(
        numberOfItems,
        (int index) {
          return CreditItem(
            id: index,
            productName: data['product_name'],
            takeDate: data['take_date'],
            amount: data['amount'],
            percent: data['percent'],
            loanMonths: data['loanMonths'],
            currency: data['currency'],
            paymentDay: data['paymentDay'],
            holidays: List<String>.from(data['holidays']),
            workDays: List<String>.from(data['workDays']),
          );
        },
      ),
    );
  }
}
