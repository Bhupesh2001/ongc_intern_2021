import 'package:telephony/telephony.dart';

class SMS {
  final Telephony telephony = Telephony.instance;
  static List<SmsMessage> inboxMessages = [];
  void readMessages() async {
    final bool result = await telephony.requestPhoneAndSmsPermissions;
    if (!(result != null && result)) {
      print("Request Denied");
      return;
    }

    inboxMessages = await telephony.getInboxSms(
        columns: [SmsColumn.DATE, SmsColumn.ADDRESS, SmsColumn.BODY],
        filter: SmsFilter.where(SmsColumn.ADDRESS)
            .equals("7906573815")
            .and(SmsColumn.BODY)
            .like("ONGC"),
        sortOrder: [OrderBy(SmsColumn.DATE, sort: Sort.DESC)]);
  }
}
