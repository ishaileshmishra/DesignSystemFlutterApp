extension ThemeDataExtended on ThemeData
{
  AppDimensionsTheme get appDimensions => extension<AppDimensionsTheme>()!;
  AppColorsTheme get appColors => extension<AppColorsTheme>()!;
  AppTextsTheme get appTexts => extension<AppTextsTheme>()!;
}

Text(
  "My text example",
  style: Theme.of(context).appTexts.labelDefaultEmphasis.copyWith(
    color: Theme.of(context).appColors.textDefault,
  ),
)