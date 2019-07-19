import 'dart:core';

import 'package:mpesa_ledger_flutter/sms_filter/check_sms_type.dart';

class SMSFilter {
  CheckSMSType smsFilters;

  List<Map<String, dynamic>> bodies = [
    {
      "body":
          "NFM0RAI80W Confirmed.Your M-PESA balance was  Ksh0.00  on 22/6/19 at 10:35 AM. Transaction cost, Ksh0.00.[OTHER]",
      "timestamp": "1563442495"
    },
    {
      "body":
          "NFM6RAIRZO Confirmed.Ksh200.00 transferred from M-Shwari account on 22/6/19 at 10:35 AM. M-Shwari balance is Ksh4,340.43 .M-PESA balance is Ksh200.00 .Transaction cost Ksh.0.00.[OTHER]",
      "timestamp": "1563442495"
    },
    {
      "body": "NFM2RAJZYM confirmed.You bought Ksh5.00 of airtime on 22/6/19 at 10:37 AM.New M-PESA balance is Ksh195.00. Transaction cost, Ksh0.00. To reverse, forward this message to 456.[AIRTIME]",
      "timestamp": "1563442495"
    },
    {
      "body":
          "NFM2RJGKT6 Confirmed. Ksh10.00 transfered to KCB M-PESA account on 22/6/19 at 3:50 PM. New M-PESA balance is Ksh165.00, new KCB M-PESA Saving account balance is Ksh10.00.",
      "timestamp": "1563442495"
    },
    {
      "body":
          "NFM8RJZ8A4 Confirmed. Ksh10.00 sent to M-Changa  for account BIOFUEL on 22/6/19 at 4:07 PM New M-PESA balance is Ksh155.00. Transaction cost, Ksh0.00.",
      "timestamp": "1563442495"
    },
    {
      "body":
          "NFR5VCBFR9 Confirmed. On 27/6/19 at 5:21 PM Give Ksh100.00 cash to Camara (ss) Interco shariifs shoes shop six street eastleigh New M-PESA balance is Ksh293.00. Dial *234*1# to manage your bills.",
      "timestamp": "1563442495"
    },
    {
      "body":
          "NFQ1UTXF7R Confirmed.You have received Ksh10.00 from SAMSON OYANGO OPONDO 0702470000 on 26/6/19 at 9:16 PM  New M-PESA balance is Ksh193.00. To reverse, forward this message to 456.",
      "timestamp": "1563442495"
    },
    {
      "body":
          "NFN5SBJW0P Confirmed . Your M-Shwari Deposit Account balance is Ksh4,350.43 .Transaction cost Ksh 0.00.",
      "timestamp": "1563442495"
    },
  ];

  Future<List<Map<String, dynamic>>> test() async {
    try {
      List<Map<String, dynamic>> listResult = [];
      for (var i = 0; i < bodies.length; i++) {
        Map<String, dynamic> result = {};
        var obj = await getSMSObject(bodies[i]["body"], bodies[i]["timestamp"]);
        if (obj.isNotEmpty) {
          result.addAll(obj);
          listResult.add(result);
        }
      }
      print(listResult);
      return listResult;
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> getSMSObject(
      String body, String timestamp) async {
    Map<String, dynamic> smsObject = {};
    smsFilters = CheckSMSType(body, timestamp);
    var coreValuesObject = await smsFilters.getCoreValues();
    if (!coreValuesObject.containsKey("error")) {
      smsObject.addAll(coreValuesObject);
      await smsObject["data"].addAll(smsFilters.checkTypeOfSMS());
    }
    return Future.value(smsObject);
  }
}
