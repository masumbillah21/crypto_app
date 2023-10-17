import 'package:crypto_app/screens/coin_screen.dart';
import 'package:flutter/material.dart';

class RecommendItem extends StatelessWidget {
  dynamic item;
  RecommendItem({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.02,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CoinScreen(
                selectedItem: item,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.02,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.03,
                child: Image.network(item.image),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                "${item.id}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                children: [
                  Text(
                    "\$${item.priceChange24H.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const Text("-"),
                  Text(
                    "${item.marketCapChangePercentage24H.toStringAsFixed(2)}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: item.marketCapChangePercentage24H >= 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
