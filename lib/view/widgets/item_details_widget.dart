import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:ecommerce_app/palette.dart';
import 'custom_icons.dart';

class ItemDetailsWidget extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final Item item;

  const ItemDetailsWidget({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.item,
  }) : super(key: key);

  static const List<Tab> _tabs = <Tab>[
    Tab(child: Text('Shop')),
    Tab(child: Text('Details')),
    Tab(child: Text('Features')),
  ];

  static final List<Widget> _views = <Widget>[
    const Center(child: Text('Content in column of Tab One')),
    const Center(child: Text('please, add content')),
    const Center(child: Text('please, add content')),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
// The Builder widget is used to have a different BuildContext to access
// closest DefaultTabController.
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
// Your code goes here.
// To get index of current tab use tabController.index
            }
          });
          return Container(
            alignment: AlignmentDirectional.center,
            height: screenHeight / 2.2,
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                )),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: screenWidth / 1.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.title!),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Palette.darkBlue,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CustomIcons.favorite,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildRatingBar(initialRating: item.rating!, size: screenWidth / 17.1),
                  ],
                ),
                SizedBox(
                  width: screenWidth / 1.3,
                  height: screenHeight / 17,
                  child: const TabBar(
                    tabs: _tabs,
                  ),
                ),
                SizedBox(
                  width: screenWidth / 1.3,
                  height: screenHeight / 4,
                  child: TabBarView(children: _views
// tabs.map((Tab tab) {
//   return Center(
//     child: Text(
//       '${tab.text!} Tab',
//       style: Theme.of(context).textTheme.headline5,
//     ),
//   );
// }).toList(),
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildRatingBar({
    required double initialRating,
    required double size,
  }) {
    return RatingBar.builder(
      itemSize: size,
      initialRating: initialRating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        debugPrint(rating.toString());
      },
    );
  }
}
