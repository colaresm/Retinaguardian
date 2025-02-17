import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

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
        backgroundColor: Colors.blue[500],
      ),
      backgroundColor: Colors.blue[500],
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Visibility(
              visible: widget.showHeaderElements,
              child: Container(
                height: constraints.maxHeight * 0.1,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  color: Colors.blue[500],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 28.0),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Bem vindo,\n",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "Marcelo",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: widget.showHeaderElements
                  ? constraints.maxHeight * 0.88
                  : constraints.maxHeight * 0.97,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SmartRefresher(
                  onRefresh: widget.onRefresh != null ? _onRefresh : () {},
                  controller: _refreshController,
                  child: widget.content),
            ),
          ],
        );
      }),
    );
  }

  void _onRefresh() async {
    widget.onRefresh;
    _refreshController.refreshCompleted();
  }
}
