import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/controller/navigation_manager.dart';
import 'package:ecommerce_app/palette.dart';
import 'package:ecommerce_app/model/model.dart';
import 'package:ecommerce_app/apis/cart_service.dart';
import 'package:transparent_image/transparent_image.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  late Future<Cart> _futureCart;
  late Map<int?, int?> _itemQuantity;

  @override
  void initState() {
    super.initState();
    _futureCart = CartService().fetchData();
    _itemQuantity = <int, int>{};
  }

  void increment(int key) {
    setState(() {
      if (_itemQuantity[key] == null) {
        _itemQuantity[key] = 2;
      } else {
        _itemQuantity[key] = _itemQuantity[key]! + 1;
      }
    });
  }

  void decrement(int key) {
    setState(() {
      if (_itemQuantity[key] != null) {
        if (_itemQuantity[key]! > 1) {
          _itemQuantity[key] = _itemQuantity[key]! - 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(padding: const EdgeInsets.all(10), child: futureBuilder()),
    );
  }

  Widget futureBuilder() {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<Cart>(
      future: _futureCart,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final cart = snapshot.data!;

          return ListView(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              const Text('My Cart'),
              const SizedBox(
                height: 30,
              ),
              buildBasket(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                cart: cart,
                index: 0,
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  PreferredSizeWidget? buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Palette.darkBlue,
              ),
              child: IconButton(
                onPressed: () {
                  context.read<NavigationManager>().setIsMyCartPage(false);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              children: [
                const Text('Add address'),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Palette.orange,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBasket({
    required double screenHeight,
    required double screenWidth,
    required Cart cart,
    required int index,
  }) {
    return Container(
      height: screenWidth * 1.5,
      width: screenWidth / 1.1,
      decoration: const BoxDecoration(
          color: Palette.darkBlue,
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              height: 35,
            ),
            itemCount: cart.basket!.length,
            itemBuilder: (context, index) {
              return buildCard(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                cart: cart,
                index: index,
              );
            },
          ),
          const Divider(
            thickness: 2,
            color: Color.fromRGBO(255, 255, 255, 0.25),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Total',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Delivery',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${cart.total!.toPriceFormat()}us',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    cart.delivery!,
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(255, 255, 255, 0.2),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // <-- Radius
              ),
            ),
            onPressed: () {},
            child: SizedBox(
                width: screenWidth / 1.4,
                child: const Align(
                    alignment: Alignment.center, child: Text('Checkout'))),
          ),
        ],
      ),
    );
  }

  Widget buildCard({
    required double screenHeight,
    required double screenWidth,
    required Cart cart,
    required int index,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            SizedBox(
              height: screenWidth / 4.8,
              width: screenWidth / 4.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: cart.basket![index].images!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: screenWidth / 4.8,
              width: screenWidth / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cart.basket![index].title!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    '\$${cart.basket![index].price!.toPriceFormat()}',
                    style: const TextStyle(color: Palette.orange),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Color(0xFF282843),
              ),
              height: screenWidth / 4.8,
              width: screenWidth / 16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: IconButton(
                      onPressed: () {
                        decrement(index);
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    (_itemQuantity[index] ?? 1).toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: IconButton(
                      onPressed: () {
                        increment(index);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete_outline,
                color: Color(0xFF36364D),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

extension _FormatExtension on int {
  toPriceFormat() {
    final price = this;
    final result = NumberFormat("#########.00", "en_US").format(price);
    return result;
  }
}
