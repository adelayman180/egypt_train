import 'package:egypt_train/database_helper.dart';
import 'package:flutter/material.dart';
import './appBar&drawer.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();

  final List<String> showMenuItems = [
    'عرض جميع الدرجات...',
    'VIP',
    'مكيف',
    'نوم',
    'إكسبريس بعربيات مطورة (ركاب)',
    'إكسبريس بعربيات مميزة',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bg.png'),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter),
        ),
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            TextFieldAutoComp(1, 'محطة المغادرة...', controller1),
            TextFieldAutoComp(2, 'محطة الوصول...', controller2),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: controller3,
                onTap: () => showMenu(context),
                textAlign: TextAlign.right,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  hintText: '...عرض جميع الدرجات',
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.grey[600])),
                  border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                  prefixIcon: Icon(
                    Icons.menu,
                    size: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                if (controller1.text.isEmpty || controller2.text.isEmpty)
                  showError(context, 'اكتب محطة المغادرة والوصول!');
                else if (controller1.text == controller2.text)
                  showError(
                      context, 'لا يمكن أن تكون محطة المغادرة هي محطة الوصول!');
                else if (!_TextFieldAutoCompState.suggestions
                        .contains(controller1.text) ||
                    !_TextFieldAutoCompState.suggestions
                        .contains(controller2.text))
                  showError(
                      context, 'اختر محطة المغادرة والوصول من المقترحات!');
                else
                  Navigator.pushNamed(context, '/result', arguments: [
                    controller1.text,
                    controller2.text,
                    controller3.text
                  ]);
              },
              color: Theme.of(context).primaryColor,
              child: Text(
                'عرض القطارات',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  void showError(BuildContext ctx, String txt) {
    showDialog(
        context: ctx,
        builder: (context) => AlertDialog(
              content: Text(
                txt,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  textColor: Theme.of(context).primaryColor,
                  child: Text('حسناً'),
                ),
              ],
            ));
  }

  void showMenu(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (context) => Dialog(
              child: Container(
                height: 300,
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (_, i) => InkWell(
                          onTap: () {
                            controller3.clear();
                            if (i != 0) controller3.text = showMenuItems[i];
                            Navigator.pop(context);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              if (i != 0)
                                Divider(height: 0, color: Colors.white38),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                alignment: i == 1
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                color: i == 0
                                    ? Colors.lightBlue[700]
                                    : Colors.grey[850],
                                height: 50,
                                child: Text(showMenuItems[i],
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )),
              ),
            ));
  }
}

class TextFieldAutoComp extends StatefulWidget {
  final int keyNum;
  final String text;
  final TextEditingController _controller;
  TextFieldAutoComp(this.keyNum, this.text, this._controller);
  @override
  _TextFieldAutoCompState createState() => _TextFieldAutoCompState();
}

class _TextFieldAutoCompState extends State<TextFieldAutoComp> {
  final key1 = GlobalKey<AutoCompleteTextFieldState<String>>();
  final key2 = GlobalKey<AutoCompleteTextFieldState<String>>();
  bool focusNode = false;
  static List<String> suggestions = [];
  AutoCompleteTextField<String> autoCompleteTextField;
  @override
  void initState() {
    super.initState();
    DatabaseHelper().getAllCities().then((value) {
      List list = value.map((e) => e['trainFrom']).toList();
      suggestions = list.cast();
      autoCompleteTextField.updateSuggestions(suggestions);
    });
  }

  @override
  Widget build(BuildContext context) {
    autoCompleteTextField = AutoCompleteTextField<String>(
      itemSubmitted: (item) => widget._controller.text = item,
      clearOnSubmit: false,
      key: widget.keyNum == 1 ? key1 : key2,
      suggestions: suggestions,
      suggestionsAmount: 4,
      itemBuilder: (context, item) => Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(item),
      ),
      itemSorter: (a, b) => a.compareTo(b),
      itemFilter: (item, query) => item.contains(query),
      onFocusChanged: (value) {
        setState(() {
          focusNode = value;
        });
      },
      controller: widget._controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
        hintText: widget.text,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
    return Container(
      decoration: BoxDecoration(
          boxShadow: focusNode
              ? [
                  BoxShadow(
                      color: Color(0xff777777), spreadRadius: 3, blurRadius: 5),
                ]
              : []),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: AutoDirection(
        text: widget.text,
        child: autoCompleteTextField,
      ),
    );
  }
}
