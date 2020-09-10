import 'dart:ui';
import 'package:country_pickers/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Pickers Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => DemoPage(),
      },
    );
  }
}

class DemoPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<DemoPage> {

  Country _selectedCupertinoCountry =
  CountryPickerUtils.getCountryByIsoCode('AR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Country Pickers Demo'),),
      body: Column(children: <Widget>[
        //Card(child: CountryPickerDropdown()),
        Card(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_selectedCupertinoCountry.name),
            ListTile(
              title: _buildCupertinoSelectedItem(_selectedCupertinoCountry),
              onTap: _openCupertinoCountryPicker,
            ),],),),],),
    );
  }
  void _openCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: context, builder: (BuildContext context) {
    return CountryPickerCupertino(
      backgroundColor: Colors.white,
      itemBuilder: _buildCupertinoItem,
      pickerSheetHeight: 300.0,
      pickerItemHeight: 55,
      initialCountry: _selectedCupertinoCountry,
      onValuePicked: (Country country) =>
          setState(() => _selectedCupertinoCountry = country),
      itemFilter: (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
    );});
  Widget _buildCupertinoSelectedItem(Country country) {
    return Row(children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      SizedBox(width: 8.0),
      Flexible(child: Text(country.isoCode))
    ],);
  }
  Widget _buildCupertinoItem(Country country) {
    return DefaultTextStyle(
      style:  TextStyle(color: CupertinoColors.white, fontSize: 16.0,),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 8.0),
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name, style: TextStyle(color: Colors.black),))
        ],),);
  }
}