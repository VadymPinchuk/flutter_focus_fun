import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/theme/background_reverse_gradient_theme.dart';
import 'package:flutter_focus_fun_tv_demo/theme/blue_grey_theme.dart';

import 'background_gradient_theme.dart';

// --- Main Color Palette Definition ---

/// A custom MaterialColor swatch for a light, warm beige.
/// The primary swatch color (shade 500) is #EDE8D0.
const MaterialColor neutralBeige = MaterialColor(
  0xFFEDE8D0, // The primary value for the swatch.
  <int, Color>{
    50: Color(0xFFFEFEFC), // Lightest
    100: Color(0xFFFCFAF7),
    200: Color(0xFFF8F6EF),
    300: Color(0xFFF5F2E5),
    400: Color(0xFFF1EDDA),
    500: Color(0xFFEDE8D0), // The primary color
    600: Color(0xFFE0D9C1),
    700: Color(0xFFD2CAAD),
    800: Color(0xFFC5BC99),
    900: Color(0xFFB7AE84), // Darkest
  },
);

// --- Accent & Contrast Colors ---

/// A rich, deep purple for primary actions and high-contrast elements.
const Color primaryPurple = Colors.deepPurple;

const Color limeGreen = Color(0xFF98C548);

/// A muted, earthy sage green for secondary elements.
const Color secondarySage = Color(0xFF8FBC8F);

/// A soft, warm amber for tertiary accents and highlights.
const Color tertiaryAmber = Colors.amber;

/// Black for text and important icons to ensure high readability.
const Color textBlack = Colors.black;

/// The main background color, a very light, almost off-white beige.
const Color backgroundLight = Color(0xFFFEFEFC);

// --- ThemeData Definition ---

/// A complete ThemeData object using the light beige palette with a high-contrast primary color.
final ThemeData beigeTheme = ThemeData(
  primarySwatch: neutralBeige,
  brightness: Brightness.light,

  // Modern Material 3 ColorScheme
  colorScheme: ColorScheme.fromSeed(
    seedColor: neutralBeige,
    brightness: Brightness.light,
    primary: primaryPurple,
    tertiary: tertiaryAmber,
  ),
  //colorScheme: const ColorScheme(
  //   brightness: Brightness.light,
  //
  //   // Primary colors
  //   primary: primaryPurple,
  //   onPrimary: Colors.white,
  //   // Text/icons on top of the primary color
  //
  //   // Secondary colors
  //   secondary: secondarySage,
  //   onSecondary: Colors.white,
  //
  //   // Tertiary colors
  //   tertiary: tertiaryAmber,
  //   onTertiary: textBlack,
  //
  //   inversePrimary: limeGreen,
  //
  //   // Neutral colors
  //   background: backgroundLight,
  //   onBackground: textBlack,
  //   surface: backgroundLight,
  //   // Use beige for cards, dialogs, etc.
  //   onSurface: textBlack,
  //
  //   // Error colors
  //   error: Color(0xFFB00020),
  //   onError: Colors.white,
  // )

  // --- Component Theming ---
  scaffoldBackgroundColor: backgroundLight,

  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundLight,
    foregroundColor: textBlack,
    elevation: 0.5,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: neutralBeige.shade800.withValues(alpha: 0.75),
    selectedItemColor: primaryPurple,
    unselectedItemColor: secondarySage.withValues(alpha: 0.7),
  ),

  textTheme: const TextTheme(
    displayLarge: TextStyle(color: textBlack),
    displayMedium: TextStyle(color: textBlack),
    displaySmall: TextStyle(color: textBlack),
    headlineLarge: TextStyle(color: textBlack),
    headlineMedium: TextStyle(color: textBlack),
    headlineSmall: TextStyle(color: textBlack),
    titleLarge: TextStyle(color: textBlack, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: textBlack),
    titleSmall: TextStyle(color: textBlack),
    bodyLarge: TextStyle(color: textBlack),
    bodyMedium: TextStyle(color: textBlack),
    bodySmall: TextStyle(color: textBlack),
    labelLarge: TextStyle(color: textBlack, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(color: textBlack),
    labelSmall: TextStyle(color: textBlack),
  ),

  // --- Other Visual Properties ---
  cardTheme: CardTheme(
    elevation: 1,
    color: neutralBeige.shade600,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: neutralBeige.shade600),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: primaryPurple),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryPurple,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  extensions: <ThemeExtension<dynamic>>[
    BackgroundGradientTheme(
      colors: [
        neutralBeige[500]!,
        neutralBeige[500]!,
        neutralBeige[100]!,
        neutralBeige[400]!,
      ],
    ),
    BackgroundReverseGradientTheme(
      colors: [blueGrey[900]!, blueGrey[900]!, blueGrey[700]!, blueGrey[900]!],
    ),
  ],
);
