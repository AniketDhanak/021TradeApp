import 'package:diamond_hands_task/utils/app_colors.dart';
import 'package:diamond_hands_task/widgets/stock_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_theme.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_event.dart';
import '../bloc/watchlist_state.dart';
import '../data/model/stock.dart';
import 'edit_watchlist_screen.dart';


class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        return DefaultTabController(
          length: state.watchlists.length,
          initialIndex: state.selectedIndex,
          child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.background,
              elevation: 0,
              titleSpacing: w(12),
              title: Text(
                "Watchlist",
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: w(18),
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: w(12)),
                  child: GestureDetector(
                    onTap: () {
                      final state = context.read<WatchlistBloc>().state;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditWatchlistScreen(
                            watchlist: state.watchlists[state.selectedIndex],
                            index: state.selectedIndex,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: w(12), vertical: h(6)),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(w(6)),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          color: AppColors.primaryGold,
                          fontWeight: FontWeight.w600,
                          fontSize: w(12),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: BlocBuilder<WatchlistBloc, WatchlistState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    _buildIndexSection(),
                    _buildSearchBar(),
                    _buildTabs(state),
                    Expanded(
                      child: TabBarView(
                        children: state.watchlists.map((watchlist) {
                          return _buildStockList(watchlist.stocks);
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }
    );
  }

  Widget _buildIndexSection() {
    return Padding(
      padding: EdgeInsets.all(w(12)),
      child: Row(
        children: [
          Expanded(child: _indexCard("NIFTY 50", "22,450", "+120 (0.54%)")),
          SizedBox(width: w(10)),
          Expanded(child: _indexCard("BANK NIFTY", "48,320", "-80 (0.16%)")),
        ],
      ),
    );
  }

  Widget _indexCard(String title, String value, String change) {
    final isPositive = change.contains("+");

    return Container(
      padding: EdgeInsets.all(w(10)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(w(10)),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: w(11),
                  )),
              SizedBox(height: h(2)),
              Text(value,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: w(14),
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
          Text(
            change,
            style: TextStyle(
              color: isPositive
                  ? AppColors.profitGreen
                  : AppColors.lossRed,
              fontSize: w(12),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(12)),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search & add",
          hintStyle: TextStyle(
            color: AppColors.textSecondary,
            fontSize: w(12),
          ),
          prefixIcon: Icon(Icons.search, size: w(18), color: AppColors.textSecondary),
          filled: true,
          fillColor: AppColors.card,
          contentPadding: EdgeInsets.symmetric(vertical: h(10)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(w(10)),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: w(13),
        ),
      ),
    );
  }

  Widget _buildTabs(WatchlistState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(12), vertical: h(8)),
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        onTap: (index) {
          context.read<WatchlistBloc>().add(
            SelectWatchlist(index),
          );
        },
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: w(12),
        ),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.primaryGold,
            width: w(2),
          ),
          insets: EdgeInsets.symmetric(horizontal: w(20)),
        ),
        labelColor: AppColors.textPrimary,
        unselectedLabelColor: AppColors.textSecondary,
        dividerColor: AppColors.border,
        tabs: state.watchlists
            .map((w) => Tab(text: w.name))
            .toList(),
      ),
    );
  }

  Widget _buildStockList(List<Stock> stocks) {
    return ListView.separated(
      padding: EdgeInsets.all(w(12)),
      itemCount: stocks.length,
      separatorBuilder: (_, __) => Divider(
        color: AppColors.border,
        thickness: 0.6,
        height: h(16),
      ),
      itemBuilder: (context, index) {
        final stock = stocks[index];
        return StockCard(stock: stock);
      },
    );
  }


}