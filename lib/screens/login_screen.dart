import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './home_screen.dart';


enum MobileVerificationState{
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

MobileVerificationState currentState =MobileVerificationState.SHOW_MOBILE_FORM_STATE;

final phoneController=TextEditingController();
final otpController=TextEditingController();

FirebaseAuth _auth=FirebaseAuth.instance;

String verificationId;

bool showLoading =false;

void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
  setState(() {
    showLoading=true;
  }); 
  try{
    final authCredential = await _auth.signInWithCredential(phoneAuthCredential);
    setState(() {
      showLoading =false;
    });
     
     if(authCredential?.user != null){
       Navigator.push(context,MaterialPageRoute(builder: (context)=> HomeScreen()));
     }

}on FirebaseAuthException catch (e){
  setState(() {
    showLoading = false;
  });

  _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text('Incorrect OTP Entered')));
}
}

getMobileFormWidget(context){
return Column(children: [
  SizedBox(
                width: 300,
                height: 50,
                child: new TextField(
                  controller: phoneController,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(40.0),
                          
                        ),
                        
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      hintText: "Mobile Number",
                      focusColor: Colors.deepPurple,
                      fillColor: Colors.white70),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                height: 50,
                child: RaisedButton(
                  child: Text(
                    'SEND OTP',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
     
     setState(() {
       showLoading=true;
     });

     await  _auth.verifyPhoneNumber(
      phoneNumber: phoneController.text, 
      verificationCompleted: (phoneAuthCredential) async{
          setState(() {
       showLoading=false;
     });
      },
      verificationFailed: (verificationFailed) async{
           setState(() {
       showLoading=false;
     });
            _scaffoldKey.currentState.showSnackBar(SnackBar(content :Text("Incorrect number entered or add +91 in starting")));
      },

      codeSent:(verificationId, resendingToken) async {
       setState(() {
         showLoading=false;
         currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
         this.verificationId =verificationId;
       });
      },
      codeAutoRetrievalTimeout: (verificationId){

      }
      );
    },
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
],);
}
getOtpFormWidget(context){
return Column(children: [
   SizedBox(
                width: 300,
                height: 50,
                child: new TextField(
                   controller: otpController,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(40.0),
                          
                        ),
                        
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      hintText: "Enter OTP received",
                      focusColor: Colors.deepPurple,
                      fillColor: Colors.white70),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                height: 50,
                child: RaisedButton(
                  child: Text(
                    'VERIFY OTP',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
      PhoneAuthCredential phoneAuthCredential =PhoneAuthProvider.credential(verificationId: verificationId, smsCode:otpController.text);
    
      signInWithPhoneAuthCredential(phoneAuthCredential);
          },
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
      ],);
      }
      
      final GlobalKey<ScaffoldState>_scaffoldKey =GlobalKey();
        @override
        Widget build(BuildContext context) {
          return Scaffold(
            key:_scaffoldKey,
            body:   
             Center(
        child: SingleChildScrollView(
                  child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/main_top.png',
                    height: 170,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Image.asset('assets/phone.png'),
              ),
              SizedBox(height: 40),
              Container(
                child: Center(
                    child: Text(
                  'Firbase Authentication',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
              ),
              SizedBox(height: 40),
               Container(
            child: showLoading ? Center(child: CircularProgressIndicator(),) :
             currentState ==MobileVerificationState.SHOW_MOBILE_FORM_STATE ?
            getMobileFormWidget(context):
            getOtpFormWidget(context),
           
      
            
          ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/main_bottom.png',
                    height: 150,
                    alignment: Alignment.bottomLeft,
                  ),
                  Image.asset(
                    'assets/login_bottom.png',
                    height: 150,
                    alignment: Alignment.bottomCenter,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
            );
        }
      }
      
     