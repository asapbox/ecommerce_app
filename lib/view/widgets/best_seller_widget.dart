import 'package:ecommerce_app/controller/view_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/model.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class BestSellerWidget extends StatefulWidget {
  final List<BestSeller> bestSeller;
  final double screenHeight;

  const BestSellerWidget({
    Key? key,
    required this.bestSeller,
    required this.screenHeight,
  }) : super(key: key);

  @override
  State<BestSellerWidget> createState() => _BestSellerWidgetState();
}

class _BestSellerWidgetState extends State<BestSellerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Best Seller'),
            Text('see more'),
          ],
        ),
        Container(
          height: (widget.screenHeight / 1.85),
          // color: Colors.greenAccent,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.83,
            ),
            primary: false, // lock scrolling
            itemCount: widget.bestSeller.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  context.read<NavigationManager>().setIsProductDetailsPage(true);
                },
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Stack(
                    // fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: widget.bestSeller[index].picture!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            (widget.bestSeller[index].isFavorites!)
                                ? buildIsFavorite(true)
                                : buildIsFavorite(false),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(widget
                                        .bestSeller[index].priceWithoutDiscount!
                                        .toString()),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(widget.bestSeller[index].discountPrice!
                                        .toString()),
                                  ],
                                ),
                                Text(widget.bestSeller[index].title!.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget buildIsFavorite(bool isFavorite) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: Center(
        child: (isFavorite)
            ? const Icon(
                Icons.favorite_outlined,
                color: Color.fromRGBO(255, 110, 78, 1.0),
              )
            : const Icon(
                Icons.favorite_outline,
                color: Color.fromRGBO(255, 110, 78, 1.0),
              ),
      ),
    );
  }
}
