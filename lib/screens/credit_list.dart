import 'package:cbk_test/models/credit_item.dart';
import 'package:cbk_test/provider/credit_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class CreditList extends StatefulWidget {
  const CreditList({super.key});

  @override
  State<CreditList> createState() => _CreditListState();
}

class _CreditListState extends State<CreditList> {
  var myFuture;

  @override
  void initState() {
    myFuture = Provider.of<CreditProvider>(context, listen: false).loadData(8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myFuture,
      builder: (_, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Consumer<CreditProvider>(builder: (context, provider, _) {
          if (provider.requestSend) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Container(
              child: _buildPanel(provider.loadedCreditItems),
            ),
          );
        });
      },
    );
  }

  DataSource _getCalendarDataSource(
    String createDate,
    int paymentDay,
    int loanMonth,
    List<String> workdays,
    List<String> holidays,
  ) {
    List appointments = [];
    DateTime startTime = DateFormat("dd.MM.yyyy").parse(createDate);
    for (var i = 1; i < loanMonth + 1; i++) {
      var payDay = DateTime(
        startTime.year,
        startTime.month + i,
        paymentDay,
      );
      print(payDay.toString());
      if (payDay.weekday == 6 || workdays.contains(payDay.toString())) {
        payDay = payDay.add(const Duration(days: 2));
      } else if (payDay.weekday == 7 || workdays.contains(payDay.toString())) {
        payDay = payDay.add(const Duration(days: 1));
      }
      appointments.add(Appointment(
        startTime: payDay,
        endTime: payDay,
        isAllDay: true,
        subject: 'credit + $i',
        color: Colors.blue,
        startTimeZone: '',
        endTimeZone: '',
      ));
    }
    return DataSource(appointments);
  }

  Widget _buildPanel(items) {
    return ExpansionPanelList.radio(
      // initialOpenPanelValue: 1,
      children: items.map<ExpansionPanelRadio>((CreditItem item) {
        return ExpansionPanelRadio(
            canTapOnHeader: true,
            value: item.id,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.productName),
                subtitle: Text('${item.currency}: ${item.amount}'),
              );
            },
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Localizations.override(
                context: context,
                locale: const Locale('ru'),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.grey)),
                  child: SfCalendar(
                    firstDayOfWeek: 1,
                    dataSource: _getCalendarDataSource(
                      item.takeDate,
                      item.paymentDay,
                      item.loanMonths,
                      item.workDays,
                      item.holidays,
                    ),
                    view: CalendarView.month,
                  ),
                ),
              ),
            ));
      }).toList(),
    );
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List source) {
    appointments = source;
  }
}
