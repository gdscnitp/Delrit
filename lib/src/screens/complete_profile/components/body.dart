import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/src/screens/verification.dart';
import 'package:ride_sharing/src/widgets/place_search_text_field.dart';
import 'package:ride_sharing/view/complete_profile_viewmodel.dart';


class Body extends StatelessWidget {
  final CompleteProfileViewModel model;
  Body({Key? key, required this.model}) : super(key: key);
  final _formkey =GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: App(context).appWidth(10.0),
        vertical: App(context).appHeight(5),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Complete Your Profile',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: App(context).appWidth(6.0),
                        ),
                  ),
                  SizedBox(
                    height: App(context).appHeight(4),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration :InputDecoration(labelText: 'Name',
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))), controller: model.nameController,
                    validator: (text){
                     if(text!.isEmpty){
                        return 'please provide the name*';
                      }
                      else{
                        return null;
                      }
                    },
                    ),
                  SizedBox(
                    height: App(context).appHeight(3),
                  ),
                  TextFormField(
                    keyboardType:TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofillHints: const [AutofillHints.email],
                    decoration :InputDecoration(labelText: 'Email',
                    fillColor: Colors.grey[200],

                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))), controller: model.emailController,
                    validator: (email)=>
                      
                    email!=null && !EmailValidator.validate(email)?
                    
                    "enter a valid email*":
                    null,                    
                    ),
                  SizedBox(
                    height: App(context).appHeight(3),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration :InputDecoration(labelText: 'Phone',
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),controller: model.phoneController,
                    validator: (text){
                     if(text!.isEmpty || text.length<10 || text.length>10){
                        return 'please provide the phone no.*';
                      }
                      else{
                        return null;
                      }
                    },
                    ),
                  SizedBox(
                    height: App(context).appHeight(3),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    decoration :InputDecoration(labelText: 'Gender',
                    fillColor: Colors.grey[200],
                    helperText: "male/female/other",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),  controller: model.genderController,
                    validator: (text){
                     if(text!.isEmpty){
                        return 'fill your gender*';
                      }
                      else{
                        return null;
                      }
                    },
                    ),
                  SizedBox(
                    height: App(context).appHeight(3),
                  ),
                  TextFormField(
                     keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration :InputDecoration(labelText: 'Age',
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))), controller: model.ageController,
                    validator: (text){
                     if(text!.isEmpty){
                        return 'please mention your age*';
                      }
                      else{
                        return null;
                      }
                    },
                    ),
                  SizedBox(
                    height: App(context).appHeight(3),
                  ),
                  
                  ElevatedButton(
                    onPressed: (){
                      _formkey.currentState!.save();
                      if (_formkey.currentState!.validate()) {
                        return model.save(context);
                        
                        
                      } else {
                        return;
                      }
                      
                   
                    // model.save(context);
                
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: App(context).appWidth(20.0),
                        vertical: App(context).appHeight(1.5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:  const Text(
                      'Save & Continue',
                      style: TextStyle(
                      
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
