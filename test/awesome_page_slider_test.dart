import 'package:awesome_page_slider/awesome_page_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<PageModel> pageList = [
    PageModel(
      title: 'Page Title 1',
      category: 'Category 1',
      imageUrl: 'https://example.com/image1.jpg',
      spot: 'Page summary 1',
    ),
    PageModel(
      title: 'Page Title 2',
      category: 'Category 2',
      imageUrl: 'https://example.com/image2.jpg',
      spot: 'Page summary 2',
    ),
  ];

  final PageModel initialPage = pageList.first;

  testWidgets('PageDetailView displays initial page correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PageDetailView(
          initialPage: initialPage,
          pageList: pageList,
        ),
      ),
    );

    expect(find.text('Page Title 1'), findsOneWidget);
    expect(find.text('Page Title 2'), findsNothing);

    expect(find.text('Category 1'), findsOneWidget);
    expect(find.text('Category 2'), findsNothing);

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('PageDetailView can navigate to next page',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PageDetailView(
          initialPage: initialPage,
          pageList: pageList,
        ),
      ),
    );

    expect(find.text('Page Title 2'), findsNothing);

    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pumpAndSettle();

    expect(find.text('Page Title 2'), findsOneWidget);
  });

  testWidgets('PageDetailView page indicator updates on page change',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PageDetailView(
          initialPage: initialPage,
          pageList: pageList,
        ),
      ),
    );

    expect(find.text('1/2'), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(-400, 0));
    await tester.pumpAndSettle();

    expect(find.text('2/2'), findsOneWidget);
  });
}
