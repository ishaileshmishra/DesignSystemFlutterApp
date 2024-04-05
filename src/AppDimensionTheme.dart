class AppDimensionsTheme extends ThemeExtension<AppDimensionsTheme>
{
  ...
    
  factory AppDimensionsTheme.main(FlutterView flutterView) => AppDimensionsTheme._internal(
    radiusHelpIndication: flutterView.isSmallSmartphone ? 8 : 16, // <- responsive here!
    paddingHelpIndication: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );

  ...
}