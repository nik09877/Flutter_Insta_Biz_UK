import 'package:flutter/material.dart';

class CustomCarouselSlider<T> extends StatefulWidget {
  final List<T> items;
  final Color activeColor;
  final Color inactiveColor;
  final double itemHeight;
  final double itemWidth;
  final TextStyle activeTextStyle;
  final TextStyle inactiveTextStyle;

  CustomCarouselSlider({
    required this.items,
    required this.activeColor,
    required this.inactiveColor,
    required this.itemHeight,
    required this.itemWidth,
    this.activeTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    this.inactiveTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  });

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState<T>();
}

class _CustomCarouselSliderState<T> extends State<CustomCarouselSlider<T>> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.itemHeight,
          child: PageView.builder(
            itemCount: widget.items.length,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              T currentItem = widget.items[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? widget.activeColor
                      : widget.inactiveColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: _buildItemWidget(currentItem),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.items.length,
            (index) => GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? widget.activeColor
                      : widget.inactiveColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemWidget(T item) {
    if (item is String) {
      return Text(
        item,
        style: _currentIndex == widget.items.indexOf(item)
            ? widget.activeTextStyle
            : widget.inactiveTextStyle,
      );
    } else if (item is Widget) {
      return item;
    } else {
      // Handle other item types as needed
      return Container();
    }
  }
}
