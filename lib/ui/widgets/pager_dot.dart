import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PagerDot extends StatefulWidget {
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final double height;
  final bool activeBlur;
  final bool showExpandButton;
  final PageController? pageController;
  final void Function(int index)? onExpand;
  const PagerDot({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.pageController,
    this.height = 200,
    this.showExpandButton = false,
    this.activeBlur = false,
    this.onExpand,
  });

  @override
  State<PagerDot> createState() => _PagerDotState();
}

class _PagerDotState extends State<PagerDot> {
  late PageController pageController;
  int currentPage = 1;
  @override
  void initState() {
    super.initState();
    pageController = widget.pageController ?? PageController();
    pageController.addListener(() {
      if (pageController.page == null) return;
      int page = pageController.page!.round() + 1;
      if (page != currentPage) {
        if (mounted) {
          setState(() {
            currentPage = page;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.itemCount,
            itemBuilder: widget.itemBuilder,
          ),
        ),
        if (widget.itemCount > 1)
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0x66000000),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: widget.itemCount,
                  effect: const ScrollingDotsEffect(
                    maxVisibleDots: 5,
                    activeDotColor: Color(0xFF006EFF),
                    dotColor: Colors.white,
                    dotHeight: 5,
                    dotWidth: 5,
                    spacing: 4,
                  ),
                ),
              ),
            ),
          ),
        if (widget.itemCount > 1)
          Positioned(
            left: 16,
            bottom: 10,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
              decoration: BoxDecoration(
                color: const Color(0xE6212121),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                '$currentPage/${widget.itemCount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        if (widget.showExpandButton)
          Positioned(
            right: 12,
            top: 12,
            child: GestureDetector(
              onTap: () =>
                  widget.onExpand?.call(pageController.page?.round() ?? 0),
              child: Container(
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                  color: const Color(0xE6212121),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Icon(
                  CupertinoIcons.plus_app,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ),
        if (widget.activeBlur)
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 3,
              sigmaY: 3,
            ),
            child: Container(),
          )
      ],
    );
  }
}
