import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

const TextStyle textStyle = TextStyle(
  fontSize: 17,
  height: 1.7,
  color: Color(0xff777777),
);

class CustomAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(45);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: AppBar(
        title: Text('EgypTrains - قطارات مصر'),
        titleSpacing: 0,
      ),
      preferredSize: preferredSize,
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            DrawerItem('الرئيسية', Icons.home, () {
              if (Navigator.canPop(context)) Navigator.pop(context);
            }),
            DrawerItem('أرقام الاستعلامات', Icons.phone, () {
              Navigator.canPop(context)
                  ? Navigator.pushReplacementNamed(context, '/phone')
                  : Navigator.pushNamed(context, '/phone');
            }),
            DrawerItem('حجز تذاكر', Icons.card_travel, () {
              Navigator.canPop(context)
                  ? Navigator.pushReplacementNamed(context, '/tickets')
                  : Navigator.pushNamed(context, '/tickets');
            }),
            DrawerItem(
                'عرف اصحابك',
                Icons.share,
                () async => await Share.share(
                    'أعرف مواعيد قطارات سكك حديد مصر، وجه بحري وقبلي، جميع الدرجات: '
                    'مكيفة ومطورة ومميزة وعاده.\n'
                    'كمان تقدر من التطبيق ده تعرف القطار اللي هتركبه بيقف في محطات أيه وامتي.\n'
                    'https://www.facebook.com/EgypTrains')),
            DrawerItem(
              'فيه مشكلة؟ ابعتلنا',
              Icons.perm_device_information,
              () async => await launch(
                  'mailto:adelayman180@gmail.com?subject=EgypTrains'),
            ),
            DrawerItem('عن التطبيق', Icons.public, () {
              Navigator.canPop(context)
                  ? Navigator.pushReplacementNamed(context, '/info')
                  : Navigator.pushNamed(context, '/info');
            }),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: IconButton(
                iconSize: 60,
                icon: CircleAvatar(
                  radius: 33,
                  backgroundColor: Color(0xff3b5998),
                  child: Text(
                    'f',
                    style: TextStyle(fontSize: 75, color: Colors.white),
                  ),
                ),
                onPressed: () async =>
                    await launch('https://www.facebook.com/EgypTrains'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function function;

  DrawerItem(this.text, this.icon, this.function);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            text,
            style: TextStyle(fontSize: 18),
          ),
          leading: Icon(
            icon,
            color: Colors.pink,
            size: 30,
          ),
          onTap: () {
            Navigator.pop(context);
            function();
          },
        ),
        Divider(height: 0)
      ],
    );
  }
}
