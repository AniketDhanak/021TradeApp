import 'package:flutter/material.dart';

import '../screen/watchlist/data/model/stock.dart';
import '../utils/app_colors.dart';
import '../utils/app_theme.dart';

class StockCard extends StatelessWidget {
  final Stock stock;

  const StockCard({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final isPositive = stock.change >= 0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: h(10)),
      child: Row(
        children: [
          /// LEFT SIDE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stock.name,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: w(14),
                  ),
                ),
                SizedBox(height: h(2)),
                Text(
                  stock.symbol,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: w(11),
                  ),
                ),
              ],
            ),
          ),

          /// RIGHT SIDE
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "₹${stock.price.toStringAsFixed(2)}",
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: w(13),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: h(2)),
              Text(
                "${stock.change > 0 ? "+" : ""}${stock.change}%",
                style: TextStyle(
                  color: isPositive
                      ? AppColors.profitGreen
                      : AppColors.lossRed,
                  fontSize: w(11),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}