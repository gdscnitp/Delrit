import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/src/widgets/place_search_text_field.dart';
import 'package:ride_sharing/view/search_rider_viewmodel.dart';

class SearchRider extends StatefulWidget {
  const SearchRider({Key? key}) : super(key: key);

  @override
  _SearchRiderState createState() => _SearchRiderState();
}

class _SearchRiderState extends State<SearchRider> {
  final List<String> _vehicles = ['Choose vehicle', 'Car', 'Bike'];
  String _selectedVehicle = 'Choose vehicle';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BaseView<SearchRiderViewModel>(
      onModelReady: (model) => model.getCurrentLocation(),
      builder: (context, model, child) => Scaffold(
        key: model.scaffoldkey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: height * .33,
                    child: Image.asset(
                      'assets/images/bg_map.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 40,
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      readOnly: true,
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.blue.shade300,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18.0,
                          horizontal: 10.0,
                        ),
                        focusColor: Colors.white,
                        hintText: 'Search for Riders',
                        hintStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        prefixIcon: const Icon(
                          Icons.menu,
                          color: Colors.black,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      width: width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            riderSearchTextField(
                              context: context,
                              label: 'Search your starting point',
                              hint: 'Search your starting point',
                              suffIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.my_location),
                                onPressed: () {
                                  model.startAddressController.text =
                                      model.currentAddress;
                                  model.startAddress = model.currentAddress;
                                },
                              ),
                              controller: model.startAddressController,
                              focusNode: model.startAddressFocusNode,
                              width: width,
                              locationCallback: (String? value) {
                                setState(() {
                                  model.startAddress = value ?? "";
                                  model.startAddressController.text =
                                      value ?? "";
                                });
                                if (value != null) {
                                  model.getNewPosition(value);
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            riderSearchTextField(
                              context: context,
                              label: 'Search your destination',
                              hint: 'Search your destination',
                              suffIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              controller: model.destinationAddressController,
                              focusNode: model.desrinationAddressFocusNode,
                              width: width,
                              locationCallback: (String? value) {
                                setState(() {
                                  model.destinationAddress = value ?? "";
                                  model.destinationAddressController.text =
                                      value ?? "";
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: width * 0.8,
                              child: GestureDetector(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        10.0,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        model.getText(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Icon(Icons.calendar_today),
                                    ],
                                  ),
                                ),
                                onTap: () => model.selectDateTime(context),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: width * 0.8,
                              // child: TextField(
                              //   decoration: kTextFieldStyle(
                              //     suffixIcon: const Icon(Icons.car_rental),
                              //     label: 'Choose Vehicle',
                              //     hint: 'Choose Vehicle',
                              //     fillColor: Colors.grey[300],
                              //   ),
                              // ),
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      10.0,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DropdownButton(
                                      hint: Text(
                                        _selectedVehicle,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      dropdownColor: Colors.grey.shade300,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 40,
                                      underline: const SizedBox(),
                                      value: _selectedVehicle,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedVehicle = value.toString();
                                        });
                                      },
                                      items: _vehicles.map((e) {
                                        return DropdownMenuItem(
                                          child: Text(
                                            e,
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          value: e,
                                        );
                                      }).toList(),
                                    ),
                                    const Icon(Icons.drive_eta),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: width * 0.8,
                              child: ElevatedButton(
                                onPressed: () {
                                  print(model.startAddressController.text);
                                  print(
                                      model.destinationAddressController.text);
                                  Navigator.pushNamed(
                                    context,
                                    '/nearby-riders',
                                    arguments: {
                                      'startAddress':
                                          model.startAddressController.text,
                                      'destinationAddress': model
                                          .destinationAddressController.text,
                                    },
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Search Riders',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Search for drivers instead',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.my_location),
        //   onPressed: () {
        //     model.getCurrentLocation();
        //   },
        // ),
      ),
    );
  }
}
