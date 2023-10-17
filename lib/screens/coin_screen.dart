import 'dart:convert';

import 'package:crypto_app/model/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinScreen extends StatefulWidget {
  final dynamic selectedItem;
  const CoinScreen({this.selectedItem, super.key});

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  List<ChartModel>? itemChart;
  late TrackballBehavior _trackballBehavior;
  final List<String> _list = ['D', 'W', 'M', '3M', '6M', 'Y'];
  List<bool> _listBool = [false, false, false, false, false, false];
  bool isRefresh = true;

  Future<void> getChart() async {
    String url =
        "https://api.coingecko.com/api/v3/coins/${widget.selectedItem.id}/ohlc?vs_currency=usd&days=$days";

    setState(() {
      isRefresh = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    setState(() {
      isRefresh = false;
    });
    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      List<ChartModel> modelList =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = modelList;
      });
    } else {
      throw response.statusCode;
    }
  }

  int days = 30;
  void setDays(String day) {
    if (day == 'D') {
      setState(() {
        days = 1;
      });
    } else if (day == 'W') {
      setState(() {
        days = 7;
      });
    } else if (day == 'M') {
      setState(() {
        days = 30;
      });
    } else if (day == '3M') {
      setState(() {
        days = 90;
      });
    } else if (day == '6M') {
      setState(() {
        days = 180;
      });
    } else if (day == 'Y') {
      setState(() {
        days = 365;
      });
    }
  }

  @override
  void initState() {
    getChart();
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.selectedItem.id),
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: height * 0.08,
                          child: Image.network(
                            widget.selectedItem.image,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.selectedItem.id,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              widget.selectedItem.symbol,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${widget.selectedItem.currentPrice}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          "${widget.selectedItem.marketCapChangePercentage24H}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: widget.selectedItem
                                        .marketCapChangePercentage24H >=
                                    0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Low",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                "\$${widget.selectedItem.low24H}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "High",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                "\$${widget.selectedItem.high24H}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Vol",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                "\$${widget.selectedItem.totalVolume}M",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    SizedBox(
                      height: height * 0.26,
                      width: width,
                      child: isRefresh
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0XFFFBC700),
                              ),
                            )
                          : itemChart == null
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
                              : SfCartesianChart(
                                  trackballBehavior: _trackballBehavior,
                                  zoomPanBehavior: ZoomPanBehavior(
                                    enablePinching: true,
                                    zoomMode: ZoomMode.x,
                                  ),
                                  series: <CandleSeries>[
                                    CandleSeries<ChartModel, int>(
                                      enableSolidCandles: true,
                                      enableTooltip: true,
                                      bullColor: Colors.green,
                                      bearColor: Colors.red,
                                      dataSource: itemChart!,
                                      xValueMapper: (ChartModel sales, _) =>
                                          sales.time,
                                      lowValueMapper: (ChartModel sales, _) =>
                                          sales.low,
                                      highValueMapper: (ChartModel sales, _) =>
                                          sales.high,
                                      openValueMapper: (ChartModel sales, _) =>
                                          sales.open,
                                      closeValueMapper: (ChartModel sales, _) =>
                                          sales.close,
                                      animationDuration: 55,
                                    ),
                                  ],
                                ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Center(
                      child: SizedBox(
                        height: height * 0.03,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _list.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _listBool = [
                                    false,
                                    false,
                                    false,
                                    false,
                                    false,
                                    false
                                  ];
                                  _listBool[index] = !_listBool[index];
                                });
                                setDays(_list[index]);
                                getChart();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03,
                                  vertical: height * 0.005,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: _listBool[index]
                                      ? const Color(0XFFFBC700).withOpacity(0.3)
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  _list[index],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.06,
                            ),
                            child: const Text(
                              'News',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.06,
                              vertical: height * 0.01,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                SizedBox(
                                  width: width * 0.25,
                                  child: CircleAvatar(
                                    backgroundImage: const AssetImage(
                                        'assets/images/11.PNG'),
                                    radius: height * 0.06,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.1,
                width: width,
                child: Column(
                  children: [
                    const Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.015,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0XFFFBC700),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: height * 0.02,
                                ),
                                const Text(
                                  'Add to portfolio',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.013,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            child: Image.asset(
                              'assets/icons/3.1.png',
                              height: height * 0.03,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
