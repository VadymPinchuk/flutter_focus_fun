import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/theme/background_reverse_gradient_theme.dart';
import 'package:flutter_focus_fun_tv_demo/theme/beige_theme.dart';

import 'background_gradient_theme.dart';

const MaterialColor blueGrey =
    MaterialColor(_blueGreyPrimaryValue, <int, Color>{
      50: Color(0xFFECEFF1),
      100: Color(0xFFCFD8DC),
      200: Color(0xFFB0BEC5),
      300: Color(0xFF90A4AE),
      400: Color(0xFF78909C),
      500: Color(_blueGreyPrimaryValue),
      600: Color(0xFF546E7A),
      700: Color(0xFF455A64),
      800: Color(0xFF37474F),
      900: Color(0xFF263238),
    });

const int _blueGreyPrimaryValue = 0xFF607D8B;

// --- Dark Blue Grey Theme Color Palette ---

/// A vibrant, cool teal for primary actions and highlights in the dark theme.
const Color primaryAmber = Color(0xFFFFC107);

// Inverse Color
const Color deepBlue = Color(0xFF003EF8);

/// A warm, bright amber for secondary elements and accents.
const Color secondaryLavender = Color(0xFFB39DDB);

/// A soft lavender for tertiary highlights, providing a subtle touch of color.
const Color tertiaryTeal = Color(0xFF4DD0E1);

/// The main background color, a deep and modern blue-grey.
const Color backgroundBlueGrey = Color(
  0xFF263238,
); // This is Colors.blueGrey.shade900

/// A light color for text to ensure high contrast and readability on dark surfaces.
const Color textLight = Color(0xFFF5F5F5);

/// A complete ThemeData object for a dark theme based on Blue Grey.
final ThemeData blueGreyTheme = ThemeData(
  primarySwatch: blueGrey,
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF263238),
  // This is blueGrey.shade900

  // Modern Material 3 ColorScheme
  colorScheme: ColorScheme.fromSeed(
    seedColor: blueGrey,
    brightness: Brightness.dark,
    primary: primaryAmber,
    tertiary: tertiaryTeal,
  ),
  // colorScheme: ColorScheme.dark(
  //   // Primary colors
  //   primary: primaryAmber,
  //   onPrimary: Colors.black,
  //
  //   // Secondary colors
  //   secondary: secondaryLavender,
  //   onSecondary: Colors.black,
  //
  //   tertiary: tertiaryTeal,
  //   onTertiary: Colors.black,
  //
  //   inversePrimary: deepBlue,
  //
  //   // Neutral colors
  //   background: const Color(0xFF263238),
  //   onBackground: textLight,
  //   surface: blueGrey.shade800,
  //   onSurface: textLight,
  //
  //   // Error colors
  //   error: Colors.redAccent.shade400,
  //   onError: Colors.black,
  // ),

  // --- Component Theming ---
  scaffoldBackgroundColor: const Color(0xFF263238),

  appBarTheme: AppBarTheme(
    backgroundColor: blueGrey.shade800,
    foregroundColor: Colors.white,
    elevation: 0.5,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: blueGrey.shade800.withValues(alpha: 0.75),
    selectedItemColor: primaryAmber,
    unselectedItemColor: secondaryLavender.withValues(alpha: 0.7),
  ),

  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.white),
    displayMedium: TextStyle(color: Colors.white),
    displaySmall: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white70),
    bodyMedium: TextStyle(color: Colors.white70),
    bodySmall: TextStyle(color: Colors.white70),
    labelLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(color: Colors.white70),
    labelSmall: TextStyle(color: Colors.white70),
  ),

  // --- Other Visual Properties ---
  cardTheme: CardTheme(
    color: blueGrey.shade800,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: blueGrey.shade700),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.tealAccent.shade400),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.tealAccent.shade400,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  extensions: <ThemeExtension<dynamic>>[
    BackgroundGradientTheme(
      colors: [blueGrey[900]!, blueGrey[900]!, blueGrey[500]!, blueGrey[900]!],
    ),
    BackgroundReverseGradientTheme(
      colors: [
        neutralBeige[400]!,
        neutralBeige[400]!,
        neutralBeige[100]!,
        neutralBeige[300]!,
      ],
    ),
  ],
);
