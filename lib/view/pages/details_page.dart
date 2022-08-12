import 'package:ecommerce_app/controller/view_model.dart';
import 'package:ecommerce_app/palette.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/model.dart';
import 'package:ecommerce_app/view/widgets/widgets.dart';
import 'package:ecommerce_app/apis/item_service.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<Item> _futureItem;

  @override
  void initState() {
    super.initState();
    _futureItem = ItemService().fetchData();
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

    return FutureBuilder<Item>(
      future: _futureItem,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final item = snapshot.data!;

          return ListView(
            children: <Widget>[
              CarouselViewWidget(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                item: item,
              ),
              const SizedBox(
                height: 20,
              ),
              ItemDetailsWidget(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
               item: item,
              ),
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
                  context
                      .read<NavigationManager>()
                      .setIsProductDetailsPage(false);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
            const Text('Product Details'),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Palette.orange,
              ),
              child: IconButton(
                onPressed: () {
                  context.read<NavigationManager>().setIsMyCartPage(true);
                },
                icon: const Icon(
                  CustomIcons.bag,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [],
    );
  }
}
