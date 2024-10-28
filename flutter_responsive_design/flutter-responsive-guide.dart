// 1. Media Query Usage
import 'package:flutter/material.dart';

class ResponsiveExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get device dimensions
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Responsive padding based on screen size
    final double horizontalPadding = screenWidth * 0.05; // 5% of screen width

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: [
            // Responsive text size
            Text(
              'Responsive Text',
              style: TextStyle(
                fontSize: screenWidth * 0.05, // 5% of screen width
              ),
            ),

            // Responsive container
            Container(
              width: screenWidth * 0.8, // 80% of screen width
              height: screenHeight * 0.3, // 30% of screen height
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

// 2. LayoutBuilder Usage
class ResponsiveLayoutBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          return WideLayout();
        } else if (constraints.maxWidth > 800) {
          return NormalLayout();
        } else {
          return NarrowLayout();
        }
      },
    );
  }
}

// 3. Flexible and Expanded Widgets
class FlexibleExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2, // Takes 2 parts of available space
          child: Container(color: Colors.red),
        ),
        Flexible(
          flex: 3, // Takes 3 parts of available space
          child: Container(color: Colors.blue),
        ),
        Expanded(
          // Takes all remaining space
          child: Container(color: Colors.green),
        ),
      ],
    );
  }
}

// 4. AspectRatio Widget
class AspectRatioExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.yellow,
      ),
    );
  }
}

// 5. FractionallySizedBox
class FractionExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8, // 80% of parent width
      heightFactor: 0.3, // 30% of parent height
      child: Container(
        color: Colors.purple,
      ),
    );
  }
}

// 6. OrientationBuilder
class OrientationExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          children: List.generate(6, (index) {
            return Card(
              child: Center(child: Text('Item $index')),
            );
          }),
        );
      },
    );
  }
}

// 7. Custom Responsive Widget
class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveWidget({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        } else if (constraints.maxWidth >= 650) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}

// Usage Example of ResponsiveWidget
class MyResponsivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        mobile: SingleChildScrollView(
          child: Column(
            children: [/* Mobile layout widgets */],
          ),
        ),
        tablet: Row(
          children: [/* Tablet layout widgets */],
        ),
        desktop: Row(
          children: [/* Desktop layout widgets */],
        ),
      ),
    );
  }
}
