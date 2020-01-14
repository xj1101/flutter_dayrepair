library address_picker;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'address_manager.dart';
import 'address_model.dart';

import '../../services/ScreenAdaper.dart';

class Address {
  AddressProvince currentProvince;
  AddressCity currentCity;
  AddressDistrict currentDistrict;

  Address({this.currentProvince, this.currentCity, this.currentDistrict});
}

typedef AddressCallback = void Function(Address);

enum AddressPickerMode {
  province,
  provinceAndCity,
  provinceCityAndDistrict,
}

class AddressPicker extends StatefulWidget {

  /// 选中的地址发生改变回调
  final AddressCallback onSelectedAddressChanged;

  /// 选择模式
  /// province 一级: 省
  /// provinceAndCity 二级: 省市 
  /// provinceCityAndDistrict 三级: 省市区
  final AddressPickerMode mode;
  
  /// 省市区文字显示样式
  final TextStyle style;

  /// 确定地址发生改变回调
  final AddressCallback onDetermineAddressChanged;

  AddressPicker(
      {Key key,
      this.mode = AddressPickerMode.provinceCityAndDistrict,
      this.onSelectedAddressChanged,
      this.style = const TextStyle(color: Colors.black, fontSize: 17),
      this.onDetermineAddressChanged})
      : super(key: key);

  _AddressPickerState createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
  List<AddressProvince> _provinces;

  AddressProvince _selectedProvince;
  AddressCity _selectedCity;
  AddressDistrict _selectedDistrict;

  FixedExtentScrollController _cityScrollController =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController _districtScrollController =
      FixedExtentScrollController(initialItem: 0);

  @override
  void dispose() {
    _cityScrollController.dispose();
    _districtScrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getAddressData();
  }

  void _getAddressData() async {
    var addressData = await AddressManager.loadAddressData(context);
    setState(() {
      _provinces = addressData;
      _selectedProvince = _provinces.first;
      _selectedCity = _selectedProvince.cities.first;
      _selectedDistrict = _selectedCity.district.first;
    });
  }

  void _updateCurrent() {
    if (widget.onSelectedAddressChanged != null) {
      var address = Address(
          currentProvince: _selectedProvince,
          currentCity: _selectedCity,
          currentDistrict: _selectedDistrict);
      widget.onSelectedAddressChanged(address);
    }
  }

  void _determineCurrent() {
    if (widget.onDetermineAddressChanged != null) {
      var address = Address(
          currentProvince: _selectedProvince,
          currentCity: _selectedCity,
          currentDistrict: _selectedDistrict);
      widget.onDetermineAddressChanged(address);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    String addressStr = _selectedProvince==null?"":_selectedProvince.province + "-" + _selectedCity.city + "-" + _selectedDistrict.area;
    if (_provinces == null || _provinces.isEmpty) {
      return Container();
    }
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: 45,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.black12
                )
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  child: Container(
                    width: 60,
                    height: double.infinity,
                    child: Center(child: Text("取消")),
                  ),
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  width: ScreenAdaper.getScreenWidth()-120,
                  height: double.infinity,
                  child: Center(
                    child: Text(addressStr),
                  ),
                ),
                InkWell(
                  child: Container(
                    width: 60,
                    height: double.infinity,
                    child: Center(child: Text("确定")),
                  ),
                  onTap: (){
                    Navigator.of(context).pop();
                    _determineCurrent();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: CupertinoPicker.builder(
                      backgroundColor: Colors.white,
                      childCount: _provinces?.length ?? 0,
                      itemBuilder: (context, index) {
                        var item = _provinces[index];
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            item.province,
                            style: widget.style,
                          ),
                        );
                      },
                      itemExtent: 44,
                      onSelectedItemChanged: (item) {
                      setState(() {
                          _selectedProvince = _provinces[item];
                          _selectedCity = _selectedProvince.cities.first;
                          _selectedDistrict = _selectedCity.district.first;
                          _cityScrollController.animateToItem(0,
                              curve: Curves.easeInOut,
                              duration: Duration(milliseconds: 250));
                          _districtScrollController.animateToItem(0,
                              curve: Curves.easeInOut,
                              duration: Duration(milliseconds: 250));
                        });
                        _updateCurrent();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CupertinoPicker.builder(
                      scrollController: _cityScrollController,
                      backgroundColor: Colors.white,
                      childCount: _selectedProvince?.cities?.length ?? 0,
                      itemBuilder: (context, index) {
                        var item = _selectedProvince.cities[index];
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            item.city,
                            style: widget.style,
                          ),
                        );
                      },
                      itemExtent: 44,
                      onSelectedItemChanged: (item) {
                        setState(() {
                          _selectedCity = _selectedProvince.cities[item];
                          _selectedDistrict = _selectedCity.district.first;
                          _districtScrollController.animateToItem(0,
                              curve: Curves.easeInOut,
                              duration: Duration(milliseconds: 250));
                        });
                        _updateCurrent();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CupertinoPicker.builder(
                      scrollController: _districtScrollController,
                      backgroundColor: Colors.white,
                      childCount: _selectedCity?.district?.length ?? 0,
                      itemBuilder: (context, index) {
                        var item = _selectedCity.district[index];
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            item.area,
                            style: widget.style,
                          ),
                        );
                      },
                      itemExtent: 44,
                      onSelectedItemChanged: (item) {
                      var district = _selectedCity.district[item];
                        _selectedDistrict = district;
                        setState(() {
                          
                        });
                        _updateCurrent();
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      // child: Row(
      //   children: <Widget>[
      //     Expanded(
      //       flex: 1,
      //       child: CupertinoPicker.builder(
      //         backgroundColor: Colors.white,
      //         childCount: _provinces?.length ?? 0,
      //         itemBuilder: (context, index) {
      //           var item = _provinces[index];
      //           return Container(
      //             alignment: Alignment.center,
      //             child: Text(
      //               item.province,
      //               style: widget.style,
      //             ),
      //           );
      //         },
      //         itemExtent: 44,
      //         onSelectedItemChanged: (item) {
      //           setState(() {
      //             _selectedProvince = _provinces[item];
      //             _selectedCity = _selectedProvince.cities.first;
      //             _selectedDistrict = _selectedCity.district.first;
      //             _cityScrollController.animateToItem(0,
      //                 curve: Curves.easeInOut,
      //                 duration: Duration(milliseconds: 250));
      //             _districtScrollController.animateToItem(0,
      //                 curve: Curves.easeInOut,
      //                 duration: Duration(milliseconds: 250));
      //           });
      //           _updateCurrent();
      //         },
      //       ),
      //     ),
      //     widget.mode == AddressPickerMode.province
      //         ? Container()
      //         : Expanded(
      //             flex: 1,
      //             child: CupertinoPicker.builder(
      //               scrollController: _cityScrollController,
      //               backgroundColor: Colors.white,
      //               childCount: _selectedProvince?.cities?.length ?? 0,
      //               itemBuilder: (context, index) {
      //                 var item = _selectedProvince.cities[index];
      //                 return Container(
      //                   alignment: Alignment.center,
      //                   child: Text(
      //                     item.city,
      //                     style: widget.style,
      //                   ),
      //                 );
      //               },
      //               itemExtent: 44,
      //               onSelectedItemChanged: (item) {
      //                 setState(() {
      //                   _selectedCity = _selectedProvince.cities[item];
      //                   _selectedDistrict = _selectedCity.district.first;
      //                   _districtScrollController.animateToItem(0,
      //                       curve: Curves.easeInOut,
      //                       duration: Duration(milliseconds: 250));
      //                 });
      //                 _updateCurrent();
      //               },
      //             )),
      //     widget.mode != AddressPickerMode.provinceCityAndDistrict
      //         ? Container()
      //         : Expanded(
      //             flex: 1,
      //             child: CupertinoPicker.builder(
      //               scrollController: _districtScrollController,
      //               backgroundColor: Colors.white,
      //               childCount: _selectedCity?.district?.length ?? 0,
      //               itemBuilder: (context, index) {
      //                 var item = _selectedCity.district[index];
      //                 return Container(
      //                   alignment: Alignment.center,
      //                   child: Text(
      //                     item.area,
      //                     style: widget.style,
      //                   ),
      //                 );
      //               },
      //               itemExtent: 44,
      //               onSelectedItemChanged: (item) {
      //                 var district = _selectedCity.district[item];
      //                 _selectedDistrict = district;
      //                 _updateCurrent();
      //               },
      //             ),
      //           ),
      //   ],
      // ),
    );
  }
}
