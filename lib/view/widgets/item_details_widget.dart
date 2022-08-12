import 'package:ecommerce_app/controller/view_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ecommerce_app/palette.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'custom_icons.dart';

class ItemDetailsWidget extends StatefulWidget {
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

  @override
  State<ItemDetailsWidget> createState() => _ItemDetailsWidgetState();
}

class _ItemDetailsWidgetState extends State<ItemDetailsWidget> {
  late int? _value;
  late int? _tappedIndex;
  late List<String> _sd;

  @override
  void initState() {
    _value = 1;
    _tappedIndex = 0;
    _sd = <String>['128 GB', widget.item.sd!];
    super.initState();
  }

  //  final List<Widget> _views = <Widget>[
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: ItemDetailsWidget._tabs.length,
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
            height: widget.screenHeight / 2.2,
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: const BorderRadius.all(
                Radius.circular(40),
                )),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: widget.screenWidth / 1.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.item.title!),
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
                    buildRatingBar(
                        initialRating: widget.item.rating!,
                        size: widget.screenWidth / 17.1),
                  ],
                ),
                SizedBox(
                  width: widget.screenWidth / 1.3,
                  height: widget.screenHeight / 17,
                  child: const TabBar(
                    tabs: ItemDetailsWidget._tabs,
                  ),
                ),
                SizedBox(
                  width: widget.screenWidth / 1.3,
                  height: widget.screenHeight / 4,
                  child: TabBarView(
                    children: <Widget>[
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Column(
                                children: <Widget>[
                                  const Icon(CustomIcons.exynos),
                                  Text(widget.item.cPU!),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  const Icon(CustomIcons.mp),
                                  Text(widget.item.camera!),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  const Icon(Icons.memory_outlined),
                                  Text(widget.item.camera!),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  const Icon(Icons.sd_card_outlined),
                                  Text(widget.item.sd!),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Text('Select color and capacity'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: widget.screenWidth / 9,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    primary: true,
                                    shrinkWrap: true,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(
                                              width: widget.screenHeight / 80,
                                            ),
                                    itemCount: widget.item.colors!.length,
                                    itemBuilder: (context, index) {
                                      return CircleAvatar(
                                        radius: widget.screenWidth / 22,
                                        backgroundColor: widget
                                            .item.colors![index]
                                            .toColor(),
                                        // delete
                                        // (_tappedIndex == index)
                                        //     ? const Color.fromRGBO(255, 110, 78, 1.0)
                                        //     : Colors.white,
                                        child: Transform.scale(
                                          scale: widget.screenWidth / 620,
                                          child: IconButton(
                                            splashRadius: 1.0,
                                            onPressed: () {
                                              setState(() {
                                                _tappedIndex = index;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.check,
                                              color: (_tappedIndex == index)
                                                  ? Colors.white
                                                  : Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),

                              SizedBox(
                                height: widget.screenWidth / 9,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  primary: true,
                                  shrinkWrap: true,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          SizedBox(
                                    width: widget.screenHeight / 80,
                                  ),
                                  itemCount: _sd.length,
                                  itemBuilder: (context, index) {
                                    return ChoiceChip(
                                      backgroundColor: Colors.transparent,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      )),
                                      selectedColor: (_value == index)
                                          ? Palette.orange
                                          : Colors.transparent,
                                      label: Text(_sd[index]),
                                      selected: _value == index,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _value = selected ? index : null;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),

                              // delete
                              // ChoiceChip(
                              //   backgroundColor:
                              //       widget.item.colors![0].toColor(),
                              //   selectedColor: widget.item.colors![0].toColor(),
                              //   label: (_value == 1)
                              //       ? const Icon(
                              //           Icons.check,
                              //           color: Colors.white,
                              //         )
                              //       : const Icon(
                              //           Icons.check,
                              //           color: Colors.transparent,
                              //         ),
                              //   selected: _value == 1,
                              //   onSelected: (bool selected) {
                              //     setState(() {
                              //       _value = selected ? 1 : null;
                              //     });
                              //   },
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: widget.screenWidth / 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: widget.screenWidth / 1.4,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<NavigationManager>().setIsMyCartPage(true);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8), // <-- Radius
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text('Add to Cart')),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0),
                                          child: Text(
                                              '\$${widget.item.price!.toPriceFormat()}'))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: const <Widget>[Text("add content")],
                      ),
                      Column(
                        children: const <Widget>[Text("add content")],
                      ),
                    ],

                    // _views

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

extension ColorExtension on String {
  toColor() {
    final hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension _FormatExtension on int {
  toPriceFormat() {
    final price = this;
    final result = NumberFormat("###,###,###.00", "en_US").format(price);
    return result;
  }
}
