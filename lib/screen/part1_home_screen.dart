import 'package:flutter/material.dart';
import 'package:skew_card/widget/app_size.dart';

////part 1 animation from top to bottom show when swipe
class Part1HomeScreen extends StatefulWidget {
  const Part1HomeScreen({super.key});

  @override
  State<Part1HomeScreen> createState() => _Part1HomeScreenState();
}

class _Part1HomeScreenState extends State<Part1HomeScreen> {
  List<String> images = [
    'assets/1.png',
    'assets/33.jpg',
    'assets/44.jpg',
    'assets/55.jpg',
    'assets/1.png',
  ];
  List<Map<String, dynamic>> imageDetails = [
    {
      'title': 'The Black Elegance',
      'description':
          'A bold and striking presence,exuding confidence in a sleek black dress and\n matching shades, embodying the essence of a modern femme fatale.',
      "isShow": true
    },
    {
      'title': 'Timeless Elegance',
      'description':
          'A portrait of beauty and grace captured in a single frame.',
      "isShow": true
    },
    {
      'title': 'Urban Serenity',
      'description':
          'Find peace amidst the bustling city with this hidden escape.',
      "isShow": true
    },
    {
      'title': 'Nature\'s Palette',
      'description':
          'A symphony of colors painted by the hands of nature itself.',
      "isShow": true
    },
    {
      'title': 'Reflections of Tranquility',
      'description': 'A serene moment by the water, perfect for introspection.',
      "isShow": true
    },
  ];
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool isnext = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              isnext = page > _currentPage;
              _currentPage = page;

              imageDetails[page]['isShow'] = true;
            });
          },
          itemCount: images.length,
          itemBuilder: (context, index) => Center(
            child: SizedBox(
              height: AppSizing.height(context) * 0.6,
              width: AppSizing.width(context),
              child: GestureDetector(
                onTap: () {
                  // if (index == _currentPage) {
                  //   setState(() {
                  //     imageDetails[index]['isShow'] =
                  //         !imageDetails[index]['isShow'];
                  //   });
                  // }
                },
                child: TweenAnimationBuilder(
                  key: ValueKey(
                      index == _currentPage && imageDetails[index]['isShow']),
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 1500),
                  tween: imageDetails[index]['isShow']
                      ? Tween<double>(begin: 1, end: 0)
                      : Tween<double>(begin: 0, end: 1),
                  builder: (context, value, child) {
                    return Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.02)
                        ..rotateX(-value * 0.2)
                        ..translate(
                            0.0, value * -AppSizing.height(context) * 1.2)
                        ..scale(1 - value, 1.0),
                      child: mainCard(index),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget mainCard(int index) {
    return Container(
      height: AppSizing.height(context) * 0.6,
      width: AppSizing.width(context),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.6),
            blurRadius: 40,
            spreadRadius: 1,
            offset: const Offset(0, 40),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              images[index],
              height: AppSizing.height(context) * 0.4,
              width: AppSizing.width(context),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 20),
            width: AppSizing.width(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  imageDetails[index]['title'],
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                FittedBox(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    imageDetails[index]['description'].toString(),
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
