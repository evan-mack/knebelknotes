import 'package:flutter/material.dart'
    show AlertDialog, BuildContext, Color, Colors, Container, MediaQuery;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:knebelknotes/custom_plugins/filter_list/src/filter_list_widget.dart';

/*
Original Source Code provided by
https://github.com/TheAlphamerc/flutter_plugin_filter_list
*/

class FilterList {
  static Future<List<String>> showFilterList(
    context, {
    Color color,
    double height,
    double width,
    double borderRadius = 20,
    List<String> selectedExcludeList,
    List<String> selectedTextList,
    List<String> allTextList,
    String headlineText = "Select here",
    String searchFieldHintText = "Search here",
    bool hideSelectedTextCount = false,
    bool hideSearchField = false,
    bool hidecloseIcon = false,
    bool hideheader = false,
    bool hideheaderText = false,
    Color closeIconColor = Colors.black,
    Color headerTextColor = Colors.black,
    Color applyButonTextColor = Colors.white,
    Color applyButonTextBackgroundColor = Colors.blue,
    Color allResetButonColor = Colors.blue,
    Color selectedTextColor = Colors.white,
    Color backgroundColor = Colors.white,
    Color unselectedTextColor = Colors.black,
    Color searchFieldBackgroundColor = const Color(0xfff5f5f5),
    Color selectedTextBackgroundColor = Colors.blue,
    Color unselectedTextbackGroundColor = const Color(0xfff8f8f8),
  }) async {
    if (height == null) {
      height = MediaQuery.of(context).size.height * .8;
    }
    if (width == null) {
      width = MediaQuery.of(context).size.width;
    }
    var list = await showPlatformDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Container(
            height: height,
            width: width,
            color: Colors.transparent,
            child: FilterListWidget(
              color: color,
              height: height,
              width: width,
              borderRadius: borderRadius,
              allTextList: allTextList,
              headlineText: headlineText,
              searchFieldHintText: searchFieldHintText,
              selectedExludeList: selectedExcludeList,
              selectedTextList: selectedTextList,
              allResetButonColor: allResetButonColor,
              applyButonTextBackgroundColor: applyButonTextBackgroundColor,
              applyButonTextColor: applyButonTextColor,
              backgroundColor: backgroundColor,
              closeIconColor: closeIconColor,
              headerTextColor: headerTextColor,
              searchFieldBackgroundColor: searchFieldBackgroundColor,
              selectedTextBackgroundColor: selectedTextBackgroundColor,
              selectedTextColor: selectedTextColor,
              hideSelectedTextCount: hideSelectedTextCount,
              unselectedTextbackGroundColor: unselectedTextbackGroundColor,
              unselectedTextColor: unselectedTextColor,
              hidecloseIcon: hidecloseIcon,
              hideHeader: hideheader,
              hideheaderText: hideheaderText,
              hideSearchField: hideSearchField,
            ),
          ),
        );
      },
    );
    return list ?? selectedTextList;
  }

  static Future<List<List<String>>> showFilterList2(
    context, {
    Color color,
    double height,
    double width,
    double borderRadius = 20,
    List<String> selectedExcludeList,
    List<String> selectedTextList,
    List<String> allTextList,
    String headlineText = "Select here",
    String searchFieldHintText = "Search here",
    bool hideSelectedTextCount = false,
    bool hideSearchField = false,
    bool hidecloseIcon = false,
    bool hideheader = false,
    bool hideheaderText = false,
    Color closeIconColor = Colors.black,
    Color headerTextColor = Colors.black,
    Color applyButonTextColor = Colors.white,
    Color applyButonTextBackgroundColor = Colors.blue,
    Color allResetButonColor = Colors.blue,
    Color selectedTextColor = Colors.white,
    Color backgroundColor = Colors.white,
    Color unselectedTextColor = Colors.black,
    Color searchFieldBackgroundColor = const Color(0xfff5f5f5),
    Color selectedTextBackgroundColor = Colors.blue,
    Color unselectedTextbackGroundColor = const Color(0xfff8f8f8),
  }) async {
    if (height == null) {
      height = MediaQuery.of(context).size.height * .8;
    }
    if (width == null) {
      width = MediaQuery.of(context).size.width;
    }
    var list = await showPlatformDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Container(
            height: height,
            width: width,
            color: Colors.transparent,
            child: FilterListWidget(
              color: color,
              height: height,
              width: width,
              borderRadius: borderRadius,
              allTextList: allTextList,
              headlineText: headlineText,
              searchFieldHintText: searchFieldHintText,
              selectedExludeList: selectedExcludeList,
              selectedTextList: selectedTextList,
              allResetButonColor: allResetButonColor,
              applyButonTextBackgroundColor: applyButonTextBackgroundColor,
              applyButonTextColor: applyButonTextColor,
              backgroundColor: backgroundColor,
              closeIconColor: closeIconColor,
              headerTextColor: headerTextColor,
              searchFieldBackgroundColor: searchFieldBackgroundColor,
              selectedTextBackgroundColor: selectedTextBackgroundColor,
              selectedTextColor: selectedTextColor,
              hideSelectedTextCount: hideSelectedTextCount,
              unselectedTextbackGroundColor: unselectedTextbackGroundColor,
              unselectedTextColor: unselectedTextColor,
              hidecloseIcon: hidecloseIcon,
              hideHeader: hideheader,
              hideheaderText: hideheaderText,
              hideSearchField: hideSearchField,
            ),
          ),
        );
      },
    );
    print('Selected :' + selectedTextList.toString());
    print('Excluded :' + selectedExcludeList.toString());
    return [list[0],list[1]];
  }
}
