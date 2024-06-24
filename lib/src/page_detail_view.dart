import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageDetailView extends StatefulWidget {
  const PageDetailView({
    required this.initialPage,
    required this.pageList,
    super.key,
  });

  final PageModel initialPage;
  final List<PageModel> pageList;

  @override
  _PageDetailViewState createState() => _PageDetailViewState();
}

class _PageDetailViewState extends State<PageDetailView> {
  late final PageController _pageController =
      PageController(initialPage: _currentIndex);
  late int _currentIndex = widget.pageList.indexOf(widget.initialPage);
  late final List<PageModel> _filteredPageList = widget.pageList;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {}

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialPage.title ?? 'Page Detail'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildPageIndicator(),
          Expanded(
            child: PageView.builder(
              itemCount: widget.pageList.length,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final page = _filteredPageList[index];

                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              page.category ?? '',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          page.title ?? 'No Title',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        if (page.imageUrl != null)
                          Image.network(
                            page.imageUrl!,
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                        const SizedBox(height: 30),
                        if (page.spot != null)
                          Text(
                            page.spot!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        const SizedBox(height: 16),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SmoothPageIndicator(
            controller: _pageController,
            count: _filteredPageList.length,
            effect: const ScrollingDotsEffect(
              activeStrokeWidth: 2.6,
              activeDotScale: 1.3,
              maxVisibleDots: 5,
              activeDotColor: Colors.red,
              radius: 8,
              spacing: 5,
              dotHeight: 10,
              dotWidth: 10,
            ),
            onDotClicked: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          const SizedBox(width: 8.0),
          Text(
            '${_currentIndex + 1}/${_filteredPageList.length}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}

class PageModel {
  final String? title;
  final String? category;
  final String? imageUrl;
  final String? spot;

  PageModel({
    this.title,
    this.category,
    this.imageUrl,
    this.spot,
  });
}
