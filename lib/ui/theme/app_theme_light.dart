import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeLight {
  final ThemeData theme = ThemeData(
    useMaterial3: true,
    // visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      // splashColor: Colors.red,
      // highlightElevation: 0,
      // hoverColor: Colors.lightBlue,
    ),
    // hoverColor: Colors.black38,
    primaryColor: const Color(0xff039be5),
    //tab_bar
    // tabBarTheme: TabBarTheme(
    //   labelColor: const Color(0xFF5C2FDA),
    //   unselectedLabelColor: const Color(0xFF8288A3),
    //   labelPadding: const EdgeInsets.only(
    //     left: 5,
    //     right: 5,
    //   ),
    //   labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
    //   unselectedLabelStyle:
    //   GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
    //   // indicator: BoxDecoration(
    //   //     borderRadius: BorderRadius.circular(50), // Creates border
    //   //     color: Color(0xFF5C2FDA)),
    //   // indicatorSize: TabBarIndicatorSize.label,
    // ),

    scaffoldBackgroundColor: const Color(0xffffffff),
    // cardColor: const Color(0xFFe8f5e9),
    dividerColor: const Color(0xffC0C3D1),
    // focusColor: const Color(0x1a311F06),
    // canvasColor: const Color(0xffe1f5fe),
    // cardTheme: CardTheme(
    //   color: const Color(0xFFe8f5e9),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(8.0),
    //   ),
    // ),
    // bottomSheetTheme:
    // const BottomSheetThemeData(backgroundColor: Colors.transparent),
    // dialogTheme: DialogTheme(
    //   titleTextStyle: GoogleFonts.inter(
    //       fontSize: 18, color: Color(0xff212121), letterSpacing: 0.5),
    //   contentTextStyle: GoogleFonts.inter(
    //       fontSize: 12, color: Color(0xff212121), letterSpacing: 0.5),
    //   backgroundColor: const Color(0xffffffff),
    // ),
    // iconTheme: const IconThemeData(
    //     color: Colors.black,
    //     opacity: .7
    // ),
    textTheme: TextTheme(
      titleMedium:
      GoogleFonts.roboto(color: const Color(0xFF241257), fontSize: 10),
      headlineSmall:
      GoogleFonts.roboto(color: const Color(0xFF8288A3), fontSize: 12),
      bodyLarge: GoogleFonts.inter(
        fontSize: 12,
        color: const Color(
          0xFF596084,
        ),
      ),
      displayLarge: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w900,
        color: const Color(
          0xFF571CFF,
        ),
      ),
      labelMedium: GoogleFonts.inter(
          fontSize: 18, color: Color(0xff212121), letterSpacing: 0.5),
      titleSmall: GoogleFonts.inter(
          fontSize: 14, color: Color(0xff333333), letterSpacing: 0.5),
      bodySmall: GoogleFonts.inter(
          fontSize: 16, color: Colors.black45, letterSpacing: 0.5),
      bodyMedium: GoogleFonts.inter(
          fontSize: 24,
          color: const Color(0xFF212121),
          fontWeight: FontWeight.w600),
      titleLarge: GoogleFonts.inter(
          fontSize: 20,
          color: const Color(0xFF131628),
          fontWeight: FontWeight.w600),
      headlineMedium: GoogleFonts.inter(
          fontSize: 16,
          color: const Color(0xFF007AFC),
          fontWeight: FontWeight.w600),
    ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     foregroundColor: const Color(0xFF131628), backgroundColor: Colors.blue,
    //   ),
    // ),

    // listTileTheme: const ListTileThemeData(iconColor: Color(0xFFEAE9EF)),
    // secondaryHeaderColor: const Color(0xFF64C0AB),
    // unselectedWidgetColor: Color(0xFFFDD000),
    // dividerTheme: const DividerThemeData(
    //     endIndent: 20, indent: 20, color: Color(0xffcfd8dc)),

    // hintColor: const Color(0xFFACAFC1),
    // checkboxTheme: CheckboxThemeData(
    //   fillColor: MaterialStateProperty.all(const Color(0xFF212121)),
    //   overlayColor: MaterialStateProperty.all(const Color(0x33212121)),
    //   side: MaterialStateBorderSide.resolveWith(
    //         (states) {
    //       return const BorderSide(width: 1.0, color: Color(0xFF212121));
    //     },
    //   ),
    // ),
    // disabledColor: const Color(0xff616161),
    // buttonTheme: const ButtonThemeData(buttonColor: Color(0xFFF5F5F5)),
    // highlightColor: Colors.grey.shade200,
    //
    // inputDecorationTheme: const InputDecorationTheme(
    // )
    // appBarTheme: AppBarTheme(
    //   backgroundColor: const Color(0xffFFFFFF),
    //   iconTheme: const IconThemeData(
    //     color: Color(0xff000000),
    //
    //   ),
    //   titleTextStyle: GoogleFonts.inter(
    //       fontSize: 18,
    //       fontWeight: FontWeight.bold,
    //       color: const Color(0xff000000),
    //       letterSpacing: 0.5),
    // ), bottomAppBarTheme: BottomAppBarTheme(color: const Color(0xffe1f5fe)),
  );
}
