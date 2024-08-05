import 'package:intl/intl.dart';
import 'package:webinar/app/models/currency_model.dart';
import 'package:webinar/app/services/guest_service/guest_service.dart';
import 'package:webinar/common/data/api_public_data.dart';
import 'package:webinar/common/data/app_data.dart';

class CurrencyUtils{

  static late String userCurrency;
  
  CurrencyUtils(){
    AppData.getCurrency().then((value) {
      userCurrency = value;
      GuestService.getCurrencyList();
    });
  }
  

  static String getSymbol(String currency){
    var format = NumberFormat.simpleCurrency(name: currency);

    return format.currencySymbol;
  }
  

  static String calculator(var price,{int fractionDigits=0}) {
    String symbol = getSymbol(userCurrency);
    
    if(PublicData.currencyListData.indexWhere((element) => element.currency == userCurrency) == -1){
      return '$symbol$price';
    }

    CurrencyModel currency =  PublicData.currencyListData[PublicData.currencyListData.indexWhere((element) => element.currency == userCurrency)];
    double newPrice = (price ?? 0.0) * (currency.exchangeRate ?? 1.0);
    // print(newPrice);

    return '$symbol${newPrice.toStringAsFixed(fractionDigits)}';
  }
}