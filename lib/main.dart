import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PDF',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String pdfUrl = "http://www.pdf995.com/samples/pdf.pdf";
  String pdfAsset = "assets/sample.pdf";
  PDFDocument _doc;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  _getFileFromAsset() async {
    setState(() {
      _isLoading = true;
    });
    final doc = await PDFDocument.fromAsset(pdfAsset);
    setState(() {
      _doc = doc;
      _isLoading = false;
    });
    log("From Asset Method");
  }

  _getFileFromUrl() async {
    setState(() {
      _isLoading = true;
    });
    final doc = await PDFDocument.fromURL(pdfUrl);
    setState(() {
      _doc = doc;
      _isLoading = false;
    });
    log("From URL Method");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Flutter PDF Demo"),),
      //body: _isLoading ? Center(child: CircularProgressIndicator(),) : PDFViewer(document: _doc, showPicker: false, ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 8,
              child: _isLoading ? CircularProgressIndicator() : PDFViewer(document: _doc, showPicker: false, ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                  padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: _getFileFromUrl,
                      child: Text(
                          'Using URL'
                      ),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                    RaisedButton(
                      onPressed: _getFileFromAsset,
                      child: Text(
                          'Using Storage'
                      ),
                      color: Colors.blue,
                      textColor: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
