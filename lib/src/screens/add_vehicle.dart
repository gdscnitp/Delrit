import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/src/widgets/place_search_text_field.dart';
import 'package:ride_sharing/view/add_vehicle_viewmodel.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  _AddVehicleState createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BaseView<AddVehicleViewModel>(
      onModelReady: (model) => model.init(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Vehicle',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 50),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 0.8 * width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        10.0,
                      ),
                    ),
                  ),
                  child: DropdownButton<String>(
                    hint: Text(
                      model.selectedVeh,
                      style: const TextStyle(color: Colors.black),
                    ),
                    dropdownColor: Colors.grey.shade300,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 40,
                    underline: const SizedBox(),
                    value: model.selectedVeh,
                    items: model.vehicles.map((e) {
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
                    onChanged: (value) => model.selectedVehicle(value!),
                  ),
                ),
                const SizedBox(height: 10),
                addVehicleStyle(
                  width: width,
                  hint: 'Vehicle Company',
                  controller: model.vehCompany,
                ),
                const SizedBox(height: 10),
                addVehicleStyle(
                  width: width,
                  hint: 'Vehicle Model',
                  controller: model.vehModel,
                ),
                const SizedBox(height: 10),
                addVehicleStyle(
                  width: width,
                  hint: 'Vehicle Number',
                  controller: model.vehNumber,
                ),
                const SizedBox(height: 10),
                addVehicleStyle(
                  width: width,
                  hint: 'Vehicle Number',
                  controller: model.licenseNumber,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 0.8 * width,
                  child: ElevatedButton(
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                    onPressed: () => model.saveDataToDb(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
