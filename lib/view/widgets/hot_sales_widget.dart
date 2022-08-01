import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/model.dart';
import 'package:transparent_image/transparent_image.dart';

class HotSalesWidget extends StatefulWidget {
  final List<HomeStore> homeStore;
  final double screenHeight;

  const HotSalesWidget({
    Key? key,
    required this.homeStore,
    required this.screenHeight,
  }) : super(key: key);

  @override
  State<HotSalesWidget> createState() => _HotSalesWidgetState();
}

class _HotSalesWidgetState extends State<HotSalesWidget> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Hot sales'),
            Text('see more'),
          ],
        ),
        Container(
          height: (widget.screenHeight / 4.5),
          // foregroundDecoration: BoxDecoration(
          //   border: Border.all(
          //       width: 10,
          //     color: Colors.white,
          //       ),
          //   borderRadius: BorderRadius.circular(12),
          // ),
          // decoration: BoxDecoration(
          //     border: Border.all(
          //         //width: 3,
          //         ),
          //     borderRadius: BorderRadius.circular(12),
          //     color: Colors.black),
          child: PageView.builder(
            pageSnapping: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            controller: controller,
            itemCount: widget.homeStore.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  const Center(child: CircularProgressIndicator()),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: widget.homeStore[index].picture!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (widget.homeStore[index].isNew!)
                            ? buildNew(opacity: 1.0)
                            : buildNew(opacity: 0.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.homeStore[index].title!,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(widget.homeStore[index].subtitle!,
                                style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        buildBuyNow(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildNew({required double opacity}) {
    return Opacity(
      opacity: opacity,
      child: const CircleAvatar(
        backgroundColor: Color.fromRGBO(255, 110, 78, 1.0),
        child: Center(
          child: Text('New'),
        ),
      ),
    );
  }

  Widget buildBuyNow() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Buy now!'),
    );
  }
}
