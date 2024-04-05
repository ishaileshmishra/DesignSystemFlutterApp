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