import 'package:flutter/material.dart';
import 'package:knebelknotes/custom_plugins/filter_list/src/choice_chip_widget.dart';
import 'package:knebelknotes/custom_plugins/filter_list/src/search_field_widget.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:toggle_switch/toggle_switch.dart';

//import 'package:knebelknotes/custom_plugins/filter_list/src/toggle_switch_widget.dart';

class FilterListWidget extends StatefulWidget {
  FilterListWidget({
    Key key,
    this.color,
    this.borderRadius,
    this.height,
    this.width,
    this.selectedExludeList,
    this.selectedTextList,
    this.allTextList,
    this.headlineText,
    this.searchFieldHintText,
    this.closeIconColor,
    this.headerTextColor,
    this.applyButonTextColor,
    this.applyButonTextBackgroundColor,
    this.allResetButonColor,
    this.selectedTextColor,
    this.backgroundColor,
    this.unselectedTextColor,
    this.searchFieldBackgroundColor,
    this.selectedTextBackgroundColor,
    this.unselectedTextbackGroundColor,
    this.hideHeader,
    this.hideheaderText,
    this.hideSearchField,
    this.hidecloseIcon,
    this.hideSelectedTextCount,
  }) : super(key: key);
  final Color color;
  final double height;
  final double width;
  final double borderRadius;
  final List<String> selectedExludeList;
  final List<String> selectedTextList;
  final List<String> allTextList;
  final Color closeIconColor;
  final Color headerTextColor;
  final Color backgroundColor;
  final Color applyButonTextColor;
  final Color applyButonTextBackgroundColor;
  final Color allResetButonColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Color searchFieldBackgroundColor;
  final Color selectedTextBackgroundColor;
  final Color unselectedTextbackGroundColor;

  final String headlineText;
  final String searchFieldHintText;
  final bool hideSelectedTextCount;
  final bool hideSearchField;
  final bool hidecloseIcon;
  final bool hideHeader;
  final bool hideheaderText;

  @override
  _FilterListWidgetState createState() => _FilterListWidgetState();
}

class _FilterListWidgetState extends State<FilterListWidget> {
  List<String> _selectedTextList = List();
  List<String> _selectedExcludeList = List();

  List<String> _allTextList;

  int switchIndex = 0;

  @override
  void initState() {
    _allTextList =
        widget.allTextList == null ? [] : List.from(widget.allTextList);
    _selectedTextList = widget.selectedTextList != null
        ? List.from(widget.selectedTextList)
        : [];
    _selectedExcludeList = widget.selectedExludeList != null
        ? List.from(widget.selectedExludeList)
        : [];
    super.initState();
  }

  bool showApplyButton = false;
 

  Widget _body() {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height - 100,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              widget.hideHeader ? SizedBox() : _header(),
              widget.hideSelectedTextCount
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        '${_selectedTextList.length} selected items',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: _buildChoiceList(_allTextList),
                  ),
                ),
              )),
            ],
          ),
          _controlButon()
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 15,
            color: Color(0x12000000),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 6,
                  child: Center(
                    child: widget.hideheaderText
                        ? Container()
                        : Text(
                            widget.headlineText.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .copyWith(
                                    fontSize: 18,
                                    color: widget.headerTextColor),
                          ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    onTap: () {
                      Navigator.pop(context, null);
                    },
                    child: widget.hidecloseIcon
                        ? SizedBox()
                        : Container(
                            height: 25,
                            width: 25,
                            child: Icon(
                              Icons.close,
                              color: widget.closeIconColor,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            widget.hideSearchField
                ? SizedBox()
                : SizedBox(
                    height: 10,
                  ),
            widget.hideSearchField
                ? SizedBox()
                : SearchFieldWidget(
                    searchFieldBackgroundColor:
                        widget.searchFieldBackgroundColor,
                    searchFieldHintText: widget.searchFieldHintText,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {}
                        _allTextList = widget.allTextList
                            .where(
                              (string) => string.toLowerCase().contains(
                                    value.toLowerCase(),
                                  ),
                            )
                            .toList();
                      });
                    },
                  ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChoiceList(List<String> list) {
    List<Widget> choices = List();
  
    list.forEach(
      (item) {
        var selectedText = _selectedTextList.contains(item);
        var selectedTextIndex = 0;
        if(_selectedTextList.contains(item)) selectedTextIndex = 1;
        else if(_selectedExcludeList.contains(item)) selectedTextIndex = 2;

        choices.add(
          ChoicechipWidget(
            onSelected: (value) {
              setState(
                () {
                  if(selectedTextIndex== 0){
                  _selectedTextList.add(item);
                  }
                  else if(selectedTextIndex ==1){
                    _selectedTextList.remove(item);
                    _selectedExcludeList.add(item);
                  }
                  else if(selectedTextIndex ==2){
                    _selectedExcludeList.remove(item);
                  }

                },
              );
            },
            icon: selectedTextIndex == 0 ? null : selectedTextIndex == 1 ? Icon(Icons.check) : Icon(Icons.clear),
            selected: selectedText,
            selectedTextColor: widget.selectedTextColor,
            selectedTextBackgroundColor: selectedTextIndex == 1 ? widget.color : Colors.red,
            unselectedTextBackgroundColor: selectedTextIndex == 0 ? widget.unselectedTextbackGroundColor : selectedTextIndex == 1 ? widget.color : Colors.red,
            unselectedTextColor: widget.unselectedTextColor,
            text: item,
          ),
        );
      },
    );
    choices.add(
      SizedBox(
        height: 70,
        width: MediaQuery.of(context).size.width,
      ),
    );
    return choices;
  }

  Widget _controlButon() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Expanded(child: SizedBox()),
            Container(
              width: MediaQuery.of(context).size.width * .5,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 15,
                    color: Color(0x12000000),
                  )
                ],
              ),
              child: Row(
                children: <Widget>[
                  PlatformButton(
                    androidFlat: (_) => MaterialFlatButtonData(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    cupertino: (_, __) => CupertinoButtonData(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    onPressed: () {
                      setState(() {
                        _selectedTextList.clear();
                        _selectedExcludeList.clear();
                      });
                    },
                    padding: EdgeInsets.only(bottom: 5),
                    child: Container(
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width / 4,
                      alignment: Alignment.center,
                      child: Text(
                        'Clear',
                        style: Theme.of(context).textTheme.headline.copyWith(
                            fontSize: 20, color: widget.allResetButonColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  PlatformButton(
                    androidFlat: (_) => MaterialFlatButtonData(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    cupertino: (_, __) => CupertinoButtonData(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    color: widget.applyButonTextBackgroundColor,
                    padding: EdgeInsets.only(bottom: 5),
                    onPressed: () {
                      Navigator.pop(context, [_selectedTextList, _selectedExcludeList]);
                    },
                    child: Container(
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width / 4,
                      alignment: Alignment.center,
                      child: Text(
                        'Apply',
                        style: Theme.of(context).textTheme.headline.copyWith(
                            fontSize: 20, color: widget.applyButonTextColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),

            /// add Bottom space in list
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        child: Container(
          height: widget.height,
          width: widget.width,
          color: widget.backgroundColor,
          child: Stack(
            children: <Widget>[
              _body(),
            ],
          ),
        ),
      ),
    );
  }
}
