import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './appBar&drawer.dart';
import './database_helper.dart';

class PhoneNumberPage extends StatelessWidget {
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
          children: <Widget>[
            Image.asset(
              'images/1.png',
              fit: BoxFit.fitWidth,
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              height: 2,
              thickness: 3,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 35, 15, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      TitleItem('رقم التليفون', Icons.phone_iphone, 2),
                      TitleItem('اسم المحطة', Icons.location_on, 3),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(1),
                    padding: EdgeInsets.all(8),
                    color: Color(0xffeeeeee),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('أضغط علي الرقم للإتصال'),
                        Text(
                          '   :ملاحظة',
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: DatabaseHelper().getNameOfPhone(),
                    builder: (_, AsyncSnapshot snapshot) => snapshot.hasData
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, i) => IntrinsicHeight(
                              child: Row(children: <Widget>[
                                PhoneItem(snapshot.data[i]['name']),
                                NameItem(snapshot.data[i]['name']),
                              ]),
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneItem extends StatelessWidget {
  final String name;
  PhoneItem(this.name);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseHelper().getPhone(name),
      builder: (_, AsyncSnapshot asyncSnapshot) => asyncSnapshot.hasData
          ? Expanded(
              flex: 2,
              child: Container(
                color: Color(0xffeeeeee),
                alignment: Alignment.center,
                margin: EdgeInsets.all(1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int x = 0; x < asyncSnapshot.data.length; x++)
                      InkWell(
                        onTap: () =>
                            launch('tel:' + asyncSnapshot.data[x]['phone']),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            asyncSnapshot.data[x]['phone'],
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}

class NameItem extends StatelessWidget {
  final String text;
  NameItem(this.text);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        color: Color(0xffeeeeee),
        alignment: Alignment.center,
        margin: EdgeInsets.all(1),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class TitleItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final int flex;
  TitleItem(this.text, this.icon, this.flex);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: EdgeInsets.all(1),
        padding: EdgeInsets.symmetric(vertical: 20),
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
            Icon(
              icon,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
