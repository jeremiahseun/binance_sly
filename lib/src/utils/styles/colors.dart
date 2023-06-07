part of styles;

class AppColors {
  static Color primaryColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).isDarkMode
        ? Colors.white
        : const Color(0xffF0A0A0);
  }

  static Color secondaryColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).isDarkMode
        ? Colors.white
        : const Color(0xff737A91);
  }

  static Color blackWhiteColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).isDarkMode
        ? Colors.white
        : const Color(0xff0E0E0E);
  }

  static Color greenColor(BuildContext context) {
    return const Color(0xff00C076);
  }

  static Color lightRedColor(BuildContext context) {
    return const Color(0xffFF6838);
  }

  static Color alertColor(BuildContext context) {
    return const Color(0xffFF554A);
  }

  static Color successColor(BuildContext context) {
    return const Color(0xff25C26E);
  }

  static Color whiteColor(BuildContext context) {
    return const Color(0xFFFFFFFF);
  }
  static Color whiteBlackColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).isDarkMode
        ? const Color(0xff17181B)
        : const Color(0xFFFFFFFF);
  }

  static Color borderWhiteColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).isDarkMode
        ? Colors.white
        : const Color(0xffCFD9E4);
  }

  static Color lighterGreyColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).isDarkMode
        ? const Color(0xff262932)
        : const Color(0xffF8f8f9);
  }

  static Color lightGreyColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).isDarkMode
        ? const Color(0xff262932)
        : const Color(0xffF1F1F1);
  }

  static Color darkGreyColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).isDarkMode
        ? const Color(0xff555C63)
        : const Color(0xffCFD3D8);
  }

  static Color redColor(BuildContext context) {
    return const Color(0xffDC2B04);
  }

  static Color blueColor(BuildContext context) {
    return const Color(0xff2764FF);
  }
}
