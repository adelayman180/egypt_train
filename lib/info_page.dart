import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './appBar&drawer.dart';

class InfoPage extends StatelessWidget {
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
              'images/3.png',
              fit: BoxFit.fitWidth,
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              height: 2,
              thickness: 3,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 35, 18, 100),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'الهدف من التطبيق:',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(width: 8),
                      Icon(CupertinoIcons.check_mark_circled,
                          color: Colors.pink),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    '- يهدف التطبيق إلي تسهيل بحث المسافرين عن مواعيد قيام ووصول '
                    'ووجهات وسرعة وأرقام قطارات الهيئة القومية لسكك حديد مصر '
                    'من جميع محطات الهيئة ودرجاتها مع إمكانية معرفة محطات الوقوف '
                    'بين محطة المغادرة والوصول لكل قطار باستخدام تاريخ اليوم المراد السفر فيه.\n'
                    '- التطبيق يعمل بدون الإتصال بالأنترنت.\n'
                    '- يرجي تنزيل التحديثات فور نزولها علي متجر التطبيقات للحصول علي المميزات '
                    'والخصائص الجديدة في التطبيق وأي تعديلات علي مواعيد القطارات أول بأول.',
                    textDirection: TextDirection.rtl,
                    style: textStyle,
                  ),
                  SizedBox(height: 66),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'عن التطبيق:',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(width: 8),
                      Icon(CupertinoIcons.info, color: Colors.pink),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'يتضمن التطبيق أكثر من 14000 رحلة وأكثر من 900 قطار يتم تسييرهم من 708 محطة '
                    'رئيسية وفرعية ومتوسطة وصغيرة في 60 خط تتوزع ما بين نوم سريعة وقطارات أولي وثانية '
                    'مكيفة فاخرة و VIP وقطارات مميزة ومطورة وقطارات ركاب ضواحي علي مدار 24 ساعة في اليوم '
                    'متضمنة أيام الأجازات الرسمية لكل قطار ومحطات وقوفه وتوقيتها كذلك درجة القطار وسرعته.',
                    textDirection: TextDirection.rtl,
                    style: textStyle,
                  ),
                  SizedBox(height: 66),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'عن سكك حديد مصر:',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.train, color: Colors.pink),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    '- الهيئة القومية لسكك حديد مصر تعرف اختصاراً باسم س.ح.م هي شركة قطاع عام تمتلكهاالحكومة المصرية '
                    'بالكامل ، وتشغّل خطوط السكك الحديدية المصرية ، والتي هي الثانية في العالم حيث تأسست بعد تأسيس '
                    'السكك الحديد البريطانية. تعد سكك حديد مصر هي أول خطوط سكك حديد يتم إنشاؤها في أفريقيا والشرق الأوسط '
                    '، والثانية علي مستوي العالم بعد المملكة المتحدة ، حيث بدأ إنشاؤها في 1834.\n'
                    '- نقل الركاب: 500 مليون راكب سنوياً (حوالي 1.4 مليون راكب يومياً).',
                    textDirection: TextDirection.rtl,
                    style: textStyle,
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
