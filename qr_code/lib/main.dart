import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutterjson/generate_qrcode_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final title = "MY QR Code By KS2Mo";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatelessWidget {
  String title;

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            child: Image.asset(
              'assets/banner.jpg',
              fit: BoxFit.cover,
            ),
            padding: EdgeInsets.all(30),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  _buildScan(context: context),
                  SizedBox(
                    width: 30,
                  ),
                  _buildGenerator(context: context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildScan({BuildContext context}) => Expanded(
    flex: 1,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          "assets/ic_scan_qrcode.png",
          width: 110,
          height: 110,
        ),
        SizedBox(
          height: 15,
        ),
        RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          child: Text("SCAN"),
          onPressed: (){
            scanQRCode(context: context);
          } ,
        )
      ],
    ),
  );

  _buildGenerator({BuildContext context}) {
    final text = "GENERATOR";
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "assets/ic_generate_qrcode.png",
            width: 110,
            height: 110,
          ),
          SizedBox(
            height: 15,
          ),
          RaisedButton(
            color: Colors.tealAccent[700],
            textColor: Colors.white,
            child: Text(text),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GenerateQRCodePage(
                      title: text,
                    )),
              );
            },
          )
        ],
      ),
    );
  }

  Future scanQRCode({BuildContext context}) async {
    try {
      String barcode = await BarcodeScanner.scan();
      showAlertDialog(result: barcode, context: context);
    } on PlatformException catch (exception) {
      if (exception.code == BarcodeScanner.CameraAccessDenied) {
        showAlertDialog(
            result: 'not grant permission to open the camera',
            context: context);
      } else {
        print('Unknown error: $exception');
      }
    } catch (exception) {
      print('Unknown error: $exception');
    }
  }

  showAlertDialog({BuildContext context, String result}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Result"),
          content: Text(result),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            )
          ],
        );
      },
    );
  }
}
