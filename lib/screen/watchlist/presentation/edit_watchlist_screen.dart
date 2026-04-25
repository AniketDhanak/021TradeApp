import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../../../utils/app_colors.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';
import '../data/model/stock.dart';
import '../data/model/watch_list.dart';

class EditWatchlistScreen extends StatefulWidget {
  final Watchlist watchlist;
  final int index;

  const EditWatchlistScreen({
    super.key,
    required this.watchlist,
    required this.index,
  });

  @override
  State<EditWatchlistScreen> createState() =>
      _EditWatchlistScreenState();
}

class _EditWatchlistScreenState extends State<EditWatchlistScreen> {
  late List<Stock> stocks;
  late TextEditingController nameController;

  double w(double value) => Utils.screenWidth * (value / 375);
  double h(double value) => Utils.screenHeight * (value / 812);

  @override
  void initState() {
    super.initState();
    stocks = List.from(widget.watchlist.stocks);
    nameController =
        TextEditingController(text: widget.watchlist.name);
  }

  @override
  Widget build(BuildContext context) {
    Utils.defineScreenDimensions(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          "Edit Watchlist",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: w(16),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildNameField(),
          Expanded(child: _buildReorderableList()),
          _buildSaveButton(),
        ],
      ),
    );
  }

  // 🔹 Watchlist Name Field
  Widget _buildNameField() {
    return Padding(
      padding: EdgeInsets.all(w(12)),
      child: TextField(
        controller: nameController,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: w(13),
        ),
        decoration: InputDecoration(
          labelText: "Watchlist Name",
          labelStyle: TextStyle(
            color: AppColors.textSecondary,
            fontSize: w(12),
          ),
          filled: true,
          fillColor: AppColors.card,
          contentPadding: EdgeInsets.symmetric(
            horizontal: w(12),
            vertical: h(12),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(w(10)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // 🔹 Reorder List
  Widget _buildReorderableList() {
    return ReorderableListView.builder(
      padding: EdgeInsets.symmetric(horizontal: w(12)),
      itemCount: stocks.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          final item = stocks.removeAt(oldIndex);
          stocks.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, item);
        });

        context.read<WatchlistBloc>().add(
          ReorderStocksEvent(
            watchlistIndex: widget.index,
            oldIndex: oldIndex,
            newIndex: newIndex,
          ),
        );
      },
      itemBuilder: (context, index) {
        final stock = stocks[index];

        return Container(
          key: ValueKey(stock.name),
          margin: EdgeInsets.symmetric(vertical: h(6)),
          padding: EdgeInsets.all(w(10)),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(w(8)),
          ),
          child: Row(
            children: [
              ReorderableDragStartListener(
                index: index,
                child: Icon(
                  Icons.drag_handle,
                  size: w(18),
                  color: AppColors.textSecondary,
                ),
              ),

              SizedBox(width: w(8)),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stock.name,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: w(13),
                      ),
                    ),
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

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹${stock.price}",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: w(12),
                    ),
                  ),
                  Text(
                    "${stock.change > 0 ? "+" : ""}${stock.change}%",
                    style: TextStyle(
                      color: stock.change >= 0
                          ? AppColors.profitGreen
                          : AppColors.lossRed,
                      fontSize: w(11),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // 🔹 Save Button
  Widget _buildSaveButton() {
    return Padding(
      padding: EdgeInsets.all(w(12)),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryGold,
            padding: EdgeInsets.symmetric(vertical: h(14)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(w(8)),
            ),
          ),
          onPressed: _onSave,
          child: Text(
            "Save",
            style: TextStyle(
              fontSize: w(13),
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // 🔥 Save Logic → BLoC
  void _onSave() {
    final updated = widget.watchlist.copyWith(
      name: nameController.text.trim(),
      stocks: stocks,
    );

    context.read<WatchlistBloc>().add(
      UpdateWatchlist(
        index: widget.index,
        updatedWatchlist: updated,
      ),
    );

    Navigator.pop(context);
  }
}