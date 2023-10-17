import 'package:crypto_app/components/item.dart';
import 'package:crypto_app/components/recommend_item.dart';
import 'package:crypto_app/model/coin_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isRefreshing = true;

  List? coinMarket = [];

  Future<List<CoinModel>?> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    setState(() {
      _isRefreshing = true;
    });
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    setState(() {
      _isRefreshing = false;
    });
    if (response.statusCode == 200) {
      var x = response.body;
      setState(() {
        coinMarket = coinModelFromJson(x);
      });
    } else {
      throw response.statusCode;
    }
    return null;
  }

  @override
  void initState() {
    getCoinMarket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 253, 225, 112),
            Color(0XFFFBC700),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.03,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                    vertical: height * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: const Text(
                    "Main Portfolio",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const Text(
                  "Top 10 Coins",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const Text(
                  "Experimental",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "\$ 7,466.20",
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(width * 0.02),
                  height: height * 0.05,
                  width: width * 0.1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Image.asset(
                    "assets/icons/5.1.png",
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            child: const Row(
              children: [
                Text(
                  "+162% all time",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            height: height * 0.7,
            width: width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey.shade200,
                  spreadRadius: 3,
                  offset: const Offset(0, 3),
                )
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Assets",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Icon(Icons.add)
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.37,
                  child: _isRefreshing
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0XFFFBC700),
                          ),
                        )
                      : coinMarket == null
                          ? Padding(
                              padding: EdgeInsets.all(height * 0.06),
                              child: const Center(
                                child: Text(
                                  "Attention the api is free, so you can't send multiple request per second, please wait and try again later.",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index) =>
                                  Item(item: coinMarket![index]),
                            ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: const Row(
                    children: [
                      Text(
                        "Recommend to Buy",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.03),
                    child: _isRefreshing
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0XFFFBC700),
                            ),
                          )
                        : coinMarket == null
                            ? Padding(
                                padding: EdgeInsets.all(height * 0.06),
                                child: const Center(
                                  child: Text(
                                    "Attention the api is free, so you can't send multiple request per second, please wait and try again later.",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: coinMarket!.length,
                                itemBuilder: (context, index) => RecommendItem(
                                  item: coinMarket![index],
                                ),
                              ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
