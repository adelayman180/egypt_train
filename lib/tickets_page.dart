import 'package:flutter/material.dart';
import './appBar&drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketsPage extends StatelessWidget {
  final String bookURL = 'https://enr.gov.eg/ticketing/webscreen.pdf';
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
              'images/2.png',
              fit: BoxFit.fitWidth,
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              height: 2,
              thickness: 3,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(18, 35, 18, 100),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'حجز مقاعد عن طريق الانترنت:',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.credit_card, color: Colors.pink),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    '- عملية حجز التذاكر عن طريق الإنترنت تقتصر بشكل حصري من موقع سكك حديد مصر ويشترط '
                    'أن يكون لديك فيزا كارت أو ماستر كارت وطابعة لطباعة التذكرة.',
                    textDirection: TextDirection.rtl,
                    style: textStyle,
                  ),
                  SizedBox(height: 30),
                  Text(
                    '- لقراءة الشرح مصور لكيفية التسجيل بالموقع وشراء وحجز التذاكر من خلال '
                    'موقع سكك حديد مصر الرسمي ، برجاء تحميل كتيب الPDF هذا:',
                    textDirection: TextDirection.rtl,
                    style: textStyle,
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    child: Text(
                      bookURL,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 16),
                    ),
                    onTap: () => launch(bookURL),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
