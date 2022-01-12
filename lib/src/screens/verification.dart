import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/enum/view_state.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/view/login_viewmodel.dart';

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: model.currentState ==
                MobileVerificationState.SHOW_MOBILE_FORM_STATE
            ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 70, left: 15, right: 15, bottom: 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back)),
                          const Text(
                            'Enter your phone number\nfor verification',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'This number will be used for all ride-sharing\n realated communication.You shall recieve an SMS\n with OTP for verification. ',
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 2,
                              child: CountryCodePicker(
                                initialSelection: 'IN',
                                favorite: const ['+91', 'IN'],
                                alignLeft: true,
                                showDropDownButton: true,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 0,
                                ),
                                showCountryOnly: false,
                                dialogSize: const Size(300, 400),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Your Number',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                ),
                                controller: model.phoneController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: ElevatedButton(
                            onPressed: () {
                              model.signInWithPhone(context);
                            },
                            child: const FractionallySizedBox(
                              heightFactor: 0.1,
                              widthFactor: 1.2,
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            : model.getOtpFormWidget(context),
      ),
    );
  }
}
