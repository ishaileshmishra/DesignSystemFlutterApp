# DesignSystemFlutterApp

## Understanding the Importance of Design Systems in Clean Code

When discussing the importance of writing clean code, our initial focus often lies on implementing optimal design and architectural patterns for our application's features. Undoubtedly, this is a commendable practice, and I strongly advocate for its adoption.

However, we should also consider the frontend code. How do we effectively integrate a design system into our application? And what exactly is a design system? What purpose does it serve, and what value does it offer?

This article draws partial inspiration from the work of Aloïs Deniel, which you can explore further [here](link to Aloïs Deniel's work).

## Understanding Design Systems

In essence, a design system comprises reusable components, style guides encompassing fonts, colors, dimensions, and other standards. These elements are systematically organized to foster consistency and efficiency in digital product design. Acting as a centralized resource, a design system aids designers and developers in maintaining coherence in visual appearance, behavior, and user experience across diverse platforms and applications.

For a mobile application, a design system typically consists of three primary categories (and I will maintain this focus throughout the remainder of this article):

1. **The atomic level:** This tier encompasses fundamental aspects of the design system, including colors, fonts, shadows, standard spacings, card radii (if applicable), icons, and more.
2. **The molecular level:** Here, you'll encounter basic and commonly used widgets such as buttons, checkboxes, radio boxes, dividers, input fields, and similar elements.
3. **The cellular level:** This tier hosts more intricate widgets like app bars, complex cards, or even custom widgets (utilizing tools like CustomPainter), which can be shared across the application or confined to specific pages.

## Material Design or Cupertino Design?

One might assume that opting for Material Design or Cupertino Design suffices.

While that may seem plausible, it's not entirely accurate.

Certainly, Flutter SDK provides default theming options. However, relying solely on these defaults may lead to limitations, resulting in an application that resembles a rudimentary project crafted by a novice.

For instance, while you can customize headline styles within the text theme of the default theme, you're constrained to just three levels: large, medium, and small, which could prove overly restrictive.

## Getting Started with Design Systems

Now, where should one commence this journey?

Creating a dedicated package for your design system serves as an excellent starting point. While not mandatory, I strongly recommend this approach for two key reasons:

1. Facilitates effortless sharing of your implemented design system across multiple applications.
2. Ensures that none of your widgets are intertwined with your application's logic.

Moreover, establishing a naming convention, especially when collaborating with designers, proves immensely beneficial. This becomes particularly relevant when translating different screens of your application. Familiarity with the names of each component on every screen eliminates the need for constant back-and-forth referencing between your design system document and your IDE.

## Bringing the Design System to Life

Now, it's time to bring the design system to life!

Theme extensions emerge as invaluable tools for crafting custom theming. Primarily used for colors, theme extensions can also accommodate custom text theming and shared dimensions across multiple widgets.

Let's initiate the process by creating a new class named `AppColorsTheme`.

```dart
class AppColorsTheme extends ThemeExtension<AppColorsTheme>
{
  // reference colors:
  static const _grey = Color(0xFFB0B0B0);
  static const _green = Color(0xFF00C060);
  static const _red = Color(0xFFED4E52);

  // actual colors used throughout the app:
  final Color backgroundDefault;
  final Color backgroundInput;
  final Color snackbarValidation;  
  final Color snackbarError;
  final Color textDefault;

  // private constructor (use factories below instead):
  const AppColorsTheme._internal({
    required this.backgroundDefault,
    required this.backgroundInput,
    required this.snackbarValidation,
    required this.snackbarError,
    required this.textDefault,
  });

  // factory for light mode:
  factory AppColorsTheme.light() {
    return AppColorsTheme._internal(
      backgroundDefault: _grey,
      backgroundInput: _grey,
      snackbarValidation: _green,
      snackbarError: _red,
      textDefault: _grey
    );  
  }

  // factory for dark mode:
  factory AppColorsTheme.dark() {
    return AppColorsTheme._internal(...);  
  }
  
  @override
  ThemeExtension<AppColorsTheme> copyWith({bool? lightMode})
  {
    if (lightMode == null || lightMode == true) {
      return AppColorsTheme.light();
    }
    return AppColorsTheme.dark();
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(
    covariant ThemeExtension<AppColorsTheme>? other,
    double t) => this;
}
```


## Key Points to Note

Here are some important points to consider:

- **Separation of Base Colors:** I intentionally segregate the base colors from those utilized within my application. This approach allows for flexibility as different widgets may share the same color in one mode but require distinct colors in another mode. Although this scenario is relatively uncommon, it's worth considering.
  
- **Utilization of Factories:** Employing factories simplifies the creation of different modes, enabling effortless selection of colors for each mode. Adding a new mode can be achieved within minutes! Moreover, you're not confined to just dark and light modes; you can incorporate any color mode you desire.
  
- **Customization of lerp() Method:** I override the `lerp()` method by simply returning `this`. However, if you wish to achieve a smooth transition between different color modes, you can utilize `Color.lerp()` as demonstrated here. While this feature may not be particularly essential, it provides added flexibility.

Now, let’s proceed with font customization by creating a new class named `AppTextsTheme`.


```dart
class AppTextsTheme extends ThemeExtension<AppTextsTheme>
{
  static const _baseFamily = "Base";

  final TextStyle labelBigEmphasis;
  final TextStyle labelBigDefault;
  final TextStyle labelDefaultEmphasis;
  final TextStyle labelDefaultDefault;

  const AppTextsTheme._internal({
    required this.labelBigEmphasis,
    required this.labelBigDefault,
    required this.labelDefaultEmphasis,
    required this.labelDefaultDefault,
  });
  
  factory AppTextsTheme.main() => AppTextsTheme._internal(
    labelBigEmphasis: TextStyle(
      fontFamily: _baseFamily,
      fontWeight: FontWeight.w400,
      fontSize: 18,
      height: 1.4,
    ),
    labelBigDefault: TextStyle(
      fontFamily: _baseFamily,
      fontWeight: FontWeight.w300,
      fontSize: 18,
      height: 1.4,
    ),
    labelDefaultEmphasis: TextStyle(
      fontFamily: _baseFamily,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.4,
    ),
    labelDefaultDefault: TextStyle(
      fontFamily: _baseFamily,
      fontWeight: FontWeight.w300,
      fontSize: 16,
      height: 1.4,
    ),
  );
  
  @override
  ThemeExtension<AppTextsTheme> copyWith()
  {
    return AppTextsTheme._internal(
      labelBigEmphasis: labelBigEmphasis,
      labelBigDefault: labelBigDefault,
      labelDefaultEmphasis: labelDefaultEmphasis,
      labelDefaultDefault: labelDefaultDefault,
    );
  }

  @override
  ThemeExtension<AppTextsTheme> lerp(
    covariant ThemeExtension<AppTextsTheme>? other,
    double t) => this;
}
```

## Key Points to Consider

Here are some important points to keep in mind:

- **Font Usage:** Strive to utilize as few fonts as possible. It's crucial to establish a naming convention with the design team regarding the fonts used in the application. Consistency in font usage can significantly streamline the development process. Having clarity on the appropriate font to use directly from the mock-up can save considerable time and effort.

- **Customization of lerp() Method:** In this use case, the `lerp()` method serves no practical purpose, so I opt to return `this` instead.

- **Hardcoded Font Sizes:** To maintain simplicity, font sizes are hardcoded here. However, we'll explore methods to introduce responsiveness later on. This will enable font sizes to adjust dynamically based on the screen size.

With these considerations in mind, let's proceed to create a new class for managing dimensions, named `AppDimensionsTheme`.

```dart
class AppDimensionsTheme extends ThemeExtension<AppDimensionsTheme>
    {
    final double radiusHelpIndication;
    final EdgeInsets paddingHelpIndication;

    const AppDimensionsTheme._internal({
        required this.radiusHelpIndication,
        required this.paddingHelpIndication,
    });
    
    factory AppDimensionsTheme.main() => AppDimensionsTheme._internal(
        radiusHelpIndication: 8,
        paddingHelpIndication: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );

    @override
    ThemeExtension<AppDimensionsTheme> copyWith()
    {
        return AppDimensionsTheme._internal(
        radiusHelpIndication: radiusHelpIndication,
        paddingHelpIndication: paddingHelpIndication,
        );
    }

    @override
    ThemeExtension<AppDimensionsTheme> lerp(
        covariant ThemeExtension<AppDimensionsTheme>? other,
        double t) => this;
    }
```


## Key Considerations

Here are several important points to take note of:

**Usage of Dimension Class:** It's not advisable to use a single class for every dimension in your app. If a dimension is only needed in one place or within the same widget, it's best to keep it localized within that widget (for example, as a constant). Unlike font and color themes, it's recommended to utilize a dimension class only when sharing dimensions across multiple widgets in your app.

**Customization of lerp() Method:** In this particular use case, the `lerp()` method serves no practical purpose, so it's simply returned as `this`.

**Hardcoded Font Sizes:** For simplicity, font sizes are hardcoded. However, later on, we'll explore methods to introduce responsiveness, allowing font sizes to adjust dynamically based on screen size.

Now, let's delve into the implementation steps:

## Main File

Navigate to your `main.dart` file and locate the `MaterialApp()` widget. Within the `theme` attribute of type `ThemeData?`, add your extensions as follows:

```dart
MaterialApp(
  ...
  theme: Theme.of(context).copyWith(
    extensions: [
      AppDimensionsTheme.main(),
      AppColorsTheme.light(),
      AppTextsTheme.main(),
    ],
  ),
  ...
),

```

## ThemeData Extension

Though not mandatory, creating a `ThemeData` extension can streamline the process of accessing extensions and simplify code syntax. Define the extension as follows:

```dart
extension ThemeDataExtended on ThemeData {
  AppDimensionsTheme get appDimensions => extension<AppDimensionsTheme>()!;
  AppColorsTheme get appColors => extension<AppColorsTheme>()!;
  AppTextsTheme get appTexts => extension<AppTextsTheme>()!;
}
```

## Implementation Example

Now, you can utilize your theme as demonstrated in the following example:

```dart
Text(
  "My text example",
  style: Theme.of(context).appTexts.labelDefaultEmphasis.copyWith(
    color: Theme.of(context).appColors.textDefault,
  ),
)
```

## Responsiveness Implementation

For implementing responsiveness, let's create a `FlutterView` extension:

```dart
extension FlutterViewExtended on FlutterView {
  // Define responsiveness thresholds
  static const double responsive360 = 360;
  static const double responsive480 = 480;
  static const double responsive600 = 600;
  static const double responsive800 = 800;
  static const double responsive900 = 900;
  static const double responsive1200 = 1200;

  // Methods to calculate logical dimensions and device types
  double get logicalWidth => physicalSize.width / devicePixelRatio;
  double get logicalHeight => physicalSize.height / devicePixelRatio;
  double get logicalWidthSA => (physicalSize.width - padding.left - padding.right) / devicePixelRatio;
  double get logicalHeightSA => (physicalSize.height - padding.top - padding.bottom) / devicePixelRatio;

  // Determine device type based on logical dimensions
  bool get isSmallSmartphone {
    // Implementation details
  }
  bool get isRegularSmartphoneOrLess {
    // Implementation details
  }
  bool get isSmallTabletOrLess {
    // Implementation details
  }
  bool get isRegularTabletOrLess {
    // Implementation details
  }
}
```

## Updating AppDimensionsTheme

Modify the `AppDimensionsTheme` class to accommodate responsiveness:

```dart
class AppDimensionsTheme extends ThemeExtension<AppDimensionsTheme> {
  ...
    
  factory AppDimensionsTheme.main(FlutterView flutterView) => AppDimensionsTheme._internal(
    radiusHelpIndication: flutterView.isSmallSmartphone ? 8 : 16, // Responsive sizing
    paddingHelpIndication: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );

  ...
}
```

Ensure to pass an instance of `FlutterView` as an argument to `AppDimensionsTheme.main`. Import the extension created earlier.

## Updating main.dart

Update the `main.dart` file with the modified theme:

```dart
MaterialApp(
  ...
  theme: Theme.of(context).copyWith(
    extensions: [
      AppDimensionsTheme.main(View.of(context)),
      ...
    ],
  ),
  ...
),
```

Now, your app's dimensions will automatically adjust based on the device type, providing a more responsive user experience.

### Reference

    https://www.youtube.com/watch?v=lTy8odHcS5s
