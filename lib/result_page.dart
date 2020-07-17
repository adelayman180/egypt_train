import './model.dart';
import 'package:flutter/material.dart';
import './appBar&drawer.dart';
import 'package:flutter/services.dart';
import './database_helper.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<String> arr;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    arr = ModalRoute.of(context).settings.arguments;
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
        child: FutureBuilder(
            future: DatabaseHelper().getTrains(arr[0], arr[1], arr[2]),
            builder: (context, snapshot) => snapshot.hasData
                ? ListView(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 70),
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                        child: CustomPaint(
                          painter: Draw(),
                          child: Text(
                            'من ${arr[0]} إلي ${arr[1]} يوجد ${snapshot.data.length} قطار',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            TitleItem('قطار', Icons.train),
                            TitleItem('قيام', Icons.access_time),
                            TitleItem('وصول', Icons.av_timer),
                            TitleItem('المدة', Icons.filter_list),
                            TitleItem('السرعة', Icons.flash_on),
                            TitleItem('الدرجة', Icons.local_offer, 3),
                            TitleItem('يقف في', Icons.receipt),
                          ],
                        ),
                      ),
                      Container(
                        color: Color(0xffeeeeee),
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 1),
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              Icon(
                                Icons.info,
                                color: Theme.of(context).primaryColor,
                                size: 16,
                              ),
                              Text(
                                'ملاحظة: ',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              Text(
                                'يمكن معرفة محطات الوقوف التي ستمر عليها في القطار عن طريق اللمس علي',
                                textDirection: TextDirection.rtl,
                              ),
                              Icon(
                                Icons.receipt,
                                color: Theme.of(context).primaryColor,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      snapshot.data.length == 0
                          ? Container(
                              alignment: Alignment.center,
                              color: Color(0xffeeeeee),
                              margin: EdgeInsets.all(1),
                              padding: EdgeInsets.all(8),
                              child: Text(
                                  'لا توجد قطارات بين ${arr[0]} و ${arr[1]}'),
                            )
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, i) {
                                final train = Train.fromDB(snapshot.data[i]);
                                return CompleteRow(train, i);
                              },
                            ),
                    ],
                  )
                : Center(child: CircularProgressIndicator())),
      ),
    );
  }
}

class CompleteRow extends StatefulWidget {
  final Train train;
  final int i;
  CompleteRow(this.train, this.i);
  @override
  _CompleteRowState createState() => _CompleteRowState();
}

class _CompleteRowState extends State<CompleteRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IntrinsicHeight(
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              RowItem(widget.train.id),
              RowItem(widget.train.go + (widget.i % 2 == 0 ? 'ص' : 'م')),
              RowItem(widget.train.arrive + (widget.i % 2 == 0 ? 'ص' : 'م')),
              RowItem(widget.train.time),
              RowItem(widget.train.speed + 'كم/س'),
              RowItem(widget.train.level, null, 3),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.train.visible = !widget.train.visible;
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      RowItem(
                        widget.train.stopin,
                        Icon(Icons.receipt,
                            size: 15, color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.train.visible,
          child: IntrinsicHeight(
              child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Expanded(
                flex: 10,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(1),
                  color: Color(0xffeeeeee),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset('images/train.png'),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(1),
                  color: Color(0xffeeeeee),
                  child: Column(
                    children: <Widget>[
                      for (int i = 1; i <= int.parse(widget.train.stopin); i++)
                        Padding(
                          padding: EdgeInsets.all(4),
                          child: Text("محطة($i)"),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(1),
                  color: Color(0xffeeeeee),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 1; i <= int.parse(widget.train.stopin); i++)
                        Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(
                            '$i:00' + (widget.i % 2 == 0 ? 'ص' : 'م'),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        )
      ],
    );
  }
}

class RowItem extends StatelessWidget {
  final String text;
  final Widget icon;
  final int flex;
  RowItem(this.text, [this.icon, this.flex]);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex ?? 2,
        child: Container(
          margin: EdgeInsets.all(1),
          padding: EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          color: Color(0xffeeeeee),
          child: icon == null
              ? FittedBox(
                  child:
                      Text(text, maxLines: 1, textDirection: TextDirection.rtl))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(text + ' '),
                    icon,
                  ],
                ),
        ));
  }
}

class TitleItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final int flex;
  TitleItem(this.text, this.icon, [this.flex]);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 2,
      child: Container(
        margin: EdgeInsets.all(1),
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(color: Colors.white),
                textDirection: TextDirection.rtl,
              ),
              Icon(
                icon,
                color: Colors.white,
                size: 18,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Draw extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xffD8443C);
    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width * 0.04, size.height * 0.5);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - size.width * 0.04, size.height * 0.5);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);

    var rect = Rect.fromLTRB(size.width * 0.06, size.height - 2,
        size.width - size.width * 0.06, size.height + size.height * 0.1);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
