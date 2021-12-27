
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() => runApp(const MaterialApp(
      home: PhoneScreen(),
    ));

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale('en','US'),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            
            child: Stack(
            children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70,left:15,right: 15,bottom: 0),
                  
                  child: Column(
                    children: [
                      const Text(
                        'Enter your phone number\nfor verification',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
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
                        
                        padding: const EdgeInsets.only(right: 10,),
                        child: Row(
                          
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          
                          children: [
                        
                            Expanded(
                              flex:4,
                              child: CountryCodePicker(
                                initialSelection: 'IN',
                                showCountryOnly: true,
                                favorite: const ['+91','IN'],
                                alignLeft:false,
                                padding: const EdgeInsets.all(15),
                                
                                
                                
                            
                              ),
                            ),
                           
                            const Expanded(
                                flex: 8,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: 'Your Number',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.blue))),
                                ),
                              ),
                            
                          ],
                        ),
                      ),
                      
                      const SizedBox(height:330),
                      
                      Positioned(
                        bottom: 10,
                        child: Container(
                          //padding: EdgeInsets.only(bottom: 30),
                          
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: ElevatedButton(
                            onPressed: (){},
                            child: const FractionallySizedBox(
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
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                      ),
                    ],
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
