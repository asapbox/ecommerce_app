import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/model.dart';
import 'package:transparent_image/transparent_image.dart';

class CarouselViewWidget extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final Item item;

  const CarouselViewWidget({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.item,
  }) : super(key: key);

  @override
  State<CarouselViewWidget> createState() => _CarouselViewWidgetState();
}

class _CarouselViewWidgetState extends State<CarouselViewWidget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.item.images!.length,
      options: CarouselOptions(
        viewportFraction: 0.7,
        height: widget.screenHeight / 2.7,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        autoPlay: false,
      ),
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: widget.item.images![itemIndex],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
