import 'package:ecommerce_app/apis/base_service.dart';
import 'package:ecommerce_app/palette.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/model.dart';
import 'package:ecommerce_app/view/widgets/widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<BaseRepository> _futureBaseRepository;
  late int tappedIndex;

  @override
  void initState() {
    super.initState();
    tappedIndex = 0;
    _futureBaseRepository = BaseService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: buildAppBar(),
      body: Padding(padding: const EdgeInsets.all(10), child: futureBuilder()),
      bottomNavigationBar: buildBottomAppBar(),
    );
  }

  Widget futureBuilder() {
    final double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<BaseRepository>(
      future: _futureBaseRepository,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final homeStore = snapshot.data!.homeStore!;
          final bestSeller = snapshot.data!.bestSeller!;

          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Select Category'),
                  Text('view all'),
                ],
              ),
              buildCategories(screenHeight),
              buildSearchBar(screenHeight),
              HotSalesWidget(
                homeStore: homeStore,
                screenHeight: screenHeight,
              ),
              BestSellerWidget(
                bestSeller: bestSeller,
                screenHeight: screenHeight,
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
    final double screenHeight = MediaQuery.of(context).size.height;
    return AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.location_on_outlined),
          Text('Zihuatanejo, Gro'),
          Icon(Icons.keyboard_arrow_down_outlined),
        ],
      ),
      actions: [
        buildFiltering(screenHeight),
      ],
    );
  }

  Widget buildCategories(double screenHeight) {
    List<IconData> icons = [
      CustomIcons.phones,
      CustomIcons.computer,
      CustomIcons.health,
      CustomIcons.books,
      Icons.tablet_android_outlined,
    ];

    List<String> categories = [
      'Phones',
      'Computer',
      'Health',
      'Books',
      'Tablets',
    ];

    return SizedBox(
      height: screenHeight / 9,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          primary: true,
          separatorBuilder: (BuildContext context, int index) => SizedBox(
                width: screenHeight / 46.3,
              ),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Column(
              children: [
                CircleAvatar(
                  radius: screenHeight / 26,
                  backgroundColor: (tappedIndex == index)
                      ? const Color.fromRGBO(255, 110, 78, 1.0)
                      : Colors.white,
                  child: Transform.scale(
                    scale: screenHeight / 620,
                    child: IconButton(
                      splashRadius: 1.0,
                      onPressed: () {
                        setState(() {
                          tappedIndex = index;
                        });
                      },
                      icon: Icon(
                        icons[index],
                        color:
                            (tappedIndex == index) ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  categories[index],
                  style: TextStyle(
                    fontSize: screenHeight / 77.2,
                    color: (tappedIndex == index)
                        ? const Color.fromRGBO(255, 110, 78, 1.0)
                        : null,
                  ),
                )
              ],
            );
          }),
    );
  }

  Widget buildSearchBar(double screenHeight) {
    return SizedBox(
      width: screenHeight / 2.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: SizedBox(
              height: screenHeight / 27,
              width: screenHeight / 3.1,
              child: Row(
                children: [
                  SizedBox(
                    width: screenHeight / 38,
                  ),
                  Icon(
                    Icons.search_outlined,
                    color: const Color.fromRGBO(255, 110, 78, 1.0),
                    size: screenHeight / 45,
                  ),
                  SizedBox(
                    width: screenHeight / 70,
                  ),
                  Text(
                    'Search',
                    style: TextStyle(
                      fontSize: screenHeight / 77.2,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: screenHeight / 85,
          ),
          CircleAvatar(
            radius: screenHeight / 54,
            backgroundColor: const Color.fromRGBO(255, 110, 78, 1.0),
            child: Icon(
              CustomIcons.categories,
              // Icons.category_outlined,
              color: Colors.white,
              size: screenHeight / 48,
            ),
          )
        ],
      ),
    );
  }

  Widget buildFiltering(double screenHeight) {
    return IconButton(
      icon: const Icon(Icons.filter_alt_outlined),
      onPressed: () {
        showModalBottomSheet<void>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          // backgroundColor: Colors.white,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: screenHeight / 2.5,
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close_outlined)),
                      const Text('Filter options'),
                      ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Done')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Text('Brand'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildBrandFilter(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Text('Price'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildPriceFilter(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      Text('Size'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildSizeFilter(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildBrandFilter() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.blueGrey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        items: const [
          DropdownMenuItem(
            value: 'Samsung',
            child: Text('Samsung'),
          ),
          DropdownMenuItem(
            value: 'Motorola',
            child: Text('Motorola'),
          ),
        ],
        onChanged: (value) {},
      ),
    );
  }

  Widget buildPriceFilter() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.blueGrey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        items: const [
          DropdownMenuItem(
            value: '\$0 - \$300',
            child: Text('\$0 - \$300'),
          ),
          DropdownMenuItem(
            value: '\$300 - \$500',
            child: Text('\$300 - \$500'),
          ),
          DropdownMenuItem(
            value: '\$500 - \$10000',
            child: Text('\$500 - \$10000'),
          ),
        ],
        onChanged: (value) {},
      ),
    );
  }

  Widget buildSizeFilter() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        items: const [
          DropdownMenuItem(
            value: '4.5 to 5.5 inches',
            child: Text('4.5 to 5.5 inches'),
          ),
          DropdownMenuItem(
            value: '5.5 to 6.5 inches',
            child: Text('5.5 to 6.5 inches'),
          ),
        ],
        onChanged: (value) {},
      ),
    );
  }

  Widget buildBottomAppBar() {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight / 11.6,
      decoration: const BoxDecoration(
        color: Palette.darkBlue,
        borderRadius: BorderRadius.all(Radius.circular(35)),
        boxShadow: [
          //  BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          Row(
            children: const [
              Icon(
                Icons.circle_rounded,
                color: Colors.white,
                size: 10,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Explorer',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Icon(
            CustomIcons.bag,
            color: Colors.white,
          ),
          const Icon(
            CustomIcons.favorite,
            color: Colors.white,
          ),
          const Icon(
            CustomIcons.person,
            color: Colors.white,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      // delete
      // child: ClipRRect(
      //   borderRadius: const BorderRadius.all(Radius.circular(70)),
      //
      //   child: BottomNavigationBar(
      //     items: const <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.favorite), label: 'Favourite'),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.favorite), label: 'Favourite')
      //     ],
      //   ),
      // )
    );
  }
}
