import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:retinaguard/widgets/cusmtom_bottom_navigation_bar.dart';

class Body extends StatefulWidget {
  const Body(
      {required this.constraints,
      required this.content,
      this.onRefresh,
      this.showHeaderElements = true,
      super.key});
  final BoxConstraints constraints;
  final Widget content;
  final Function()? onRefresh;
  final bool showHeaderElements;

  @override
  State<Body> createState() => _BodyState();
}

RefreshController _refreshController = RefreshController(initialRefresh: false);

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(),
      appBar: AppBar(
        actions: [
          Visibility(
            visible: widget.showHeaderElements,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => print("about"),
                  icon: const Icon(Icons.help),
                  color: Colors.white,
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: () => print("help"),
                  icon: const Icon(Icons.exit_to_app),
                  color: Colors.white,
                  iconSize: 30,
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Visibility(
                visible: widget.showHeaderElements,
                child: Container(
                  height: constraints.maxHeight * 0.03,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [],
                  ),
                ),
              ),
              Container(
                height: constraints.maxHeight * 0.95,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SmartRefresher(
                  onRefresh: widget.onRefresh != null ? _onRefresh : () {},
                  controller: _refreshController,
                  child: widget.content,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onRefresh() async {
    widget.onRefresh;
    _refreshController.refreshCompleted();
  }
}
