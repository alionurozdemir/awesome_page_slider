# Awesome Page Slider

A Flutter package to display detailed views of pages with smooth sliding effects.

## Features

- Display a detailed view of pages
- Smooth sliding effects
- Page indicators


<img src="https://github.com/alionurozdemir/awesome_page_slider/main/lib/screenshot/awesome_page_slider.gif" width="320px" />


## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  awesome_page_slider: ^<latest-version>
  ```

## Getting Started

Add `awesome_page_slider` to your `pubspec.yaml`:

# Example

```dart
import 'package:flutter/material.dart';
import 'package:awesome_page_slider/awesome_page_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Page App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final initialPage = pageList.first; // Initial page

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pages'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageDetailView(
                  initialPage: initialPage,
                  pageList: pageList,
                ),
              ),
            );
          },
          child: const Text('Go to Page Detail'),
        ),
      ),
    );
  }
}

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
  // Add more pages...
];

```