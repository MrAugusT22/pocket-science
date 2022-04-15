import 'dart:convert';
import 'package:fin_calc/utilities/calculations.dart';
import 'package:fin_calc/utilities/constants.dart';
import 'package:fin_calc/utilities/investment_card_text.dart';
import 'package:fin_calc/utilities/user_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Map cryptos = {
  'BTC': 'Bitcoin',
  'ETH': 'Etherium',
  'LTC': 'Litecoin',
  'USD': 'US Dollar',
  'GBP': 'UK Pound',
  'JPY': 'Japanese Yen',
  'EUR': 'Euro',
  'SOL': 'Solana',
  'ADA': 'Cardano',
};
late Map coinValues;

class Currency extends StatefulWidget {
  const Currency({Key? key}) : super(key: key);
  static const String id = 'curr';

  @override
  _CurrencyState createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  String api = 'F6934F8F-FDAF-4365-8E7B-1C30D460DE8C';
  List<String> cryptoList = [
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'BTC',
    'ETH',
    'LTC',
    'SOL',
    'ADA'
  ];

  String coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
  bool isWaiting = true;

  List xCurrency = [];

  Future getCoinData() async {
    Map<String, String> cryptoPrices = {};
    String rate = '';
    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/$crypto/INR?apikey=$api';
      http.Response response = await http.get(Uri.parse(requestURL));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        rate = format(price, 2);
      } else {
        print(response.statusCode);
        setState(() {
          isWaiting = false;
        });
        throw 'Problem with the get request';
      }
      cryptoPrices[crypto] = rate;
      // print(cryptoPrices);
    }
    return cryptoPrices;
  }

  void getData() async {
    isWaiting = true;
    try {
      var data = await getCoinData();
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: isWaiting
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Provider.of<UserData>(context).getMyColor,
                    ),
                    SizedBox(height: 10),
                    InvestmentCardText(
                        text: 'Mining...', fontStyle: FontStyle.italic),
                  ],
                ),
              )
            : ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return CryptoCard(coin: cryptoList[index]);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: cryptoList.length,
              ),
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  final coin;
  CryptoCard({@required this.coin});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(builder: (context, myThemeData, child) {
      bool _isDarkMode = myThemeData.getDarkMode;

      return Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _isDarkMode ? kMyDarkBGColor : kMyLightBGColor),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InvestmentCardText(text: cryptos[coin]),
                    SizedBox(height: 10),
                    InvestmentCardText(text: coin),
                  ],
                ),
                InvestmentCardText(text: '₹ ${coinValues[coin]}'),
              ],
            ),
          ),
        ),
      );
    });
  }
}
