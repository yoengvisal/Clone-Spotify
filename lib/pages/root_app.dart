import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:music/pages/home_page.dart';
import 'package:music/theme/colors.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int activeTap = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getFooter() {
    List items = [
      Icons.home,
      Icons.book,
      Icons.search,
      Icons.settings,
    ];

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: black,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return IconButton(
                onPressed: () {
                  setState(() {
                    activeTap = index;
                  });
                },
                icon: Icon(
                  items[index],
                  color: activeTap == index ? primary : white,
                ));
          }),
        ),
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTap,
      children: [
        HomePage(),
        Center(
          child: Text(
            'Home',
            style: TextStyle(
              fontSize: 20,
              color: white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            'Book',
            style: TextStyle(
              fontSize: 20,
              color: white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            'Library',
            style: TextStyle(
              fontSize: 20,
              color: white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            'Setting',
            style: TextStyle(
              fontSize: 20,
              color: white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
