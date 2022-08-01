import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/model.dart';

class TapBarViewWidget extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final Item item;

  const TapBarViewWidget({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.item,
  }) : super(key: key);

  @override
  State<TapBarViewWidget> createState() => _TapBarViewWidgetState();
}

class _TapBarViewWidgetState extends State<TapBarViewWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.animateTo(2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static const List<Tab> _tabs = [
    Tab(child: Text('Shop')),
    Tab(child: Text('Details')),
    Tab(child: Text('Features')),
  ];

  static const List<Widget> _views = <Widget>[
    Center(child: Text('Content of Tab One')),
    Center(child: Text('Content of Tab Two')),
    Center(child: Text('Content of Tab Three')),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: widget.screenHeight / 2.2,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
            )),
        child: DefaultTabController(
          length: _tabs.length,
          child: Builder(builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context)!;
            tabController.addListener(
              () {
                if (!tabController.indexIsChanging) {
                  // Your code goes here.
                  // To get index of current tab use tabController.index
                }
              },
            );
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: widget.screenHeight / 9,
                      child: TabBar(
                        // labelColor: Colors.white,
                        // unselectedLabelColor: Colors.grey,
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        unselectedLabelStyle:
                            const TextStyle(fontStyle: FontStyle.italic),
                        overlayColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.blue;
                          }
                          if (states.contains(MaterialState.focused)) {
                            return Colors.orange;
                          } else if (states.contains(MaterialState.hovered)) {
                            return Colors.pinkAccent;
                          }

                          return Colors.transparent;
                        }),
                        indicatorWeight: 10,
                        indicatorColor: Colors.red,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding: const EdgeInsets.all(5),
                        indicator: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.pinkAccent,
                        ),
                        isScrollable: true,
                        physics: const BouncingScrollPhysics(),
                        onTap: (int index) {
                          debugPrint('Tab $index is tapped');
                        },
                        enableFeedback: true,
                        // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
                        // controller: _tabController,
                        tabs: _tabs,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: widget.screenHeight / 2.2,
                  child: const TabBarView(
                    physics: BouncingScrollPhysics(),
                    // Uncomment the line below and remove DefaultTabController if you want to use a custom TabController
                    // controller: _tabController,
                    children: _views,
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
