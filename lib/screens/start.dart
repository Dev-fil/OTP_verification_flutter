import 'package:OTP_verification/main.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
     
        
       Center(
        child: SingleChildScrollView(
                  child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                
                Image.asset('assets/main_top.png',height: 170,),
                
              ],),
              
              Padding(
                padding: const EdgeInsets.only(left: 20,right:20),
                child: Image.asset('assets/start.png'),
              ),
              SizedBox(height:20),
              Container(child:Center(child: Text('Firebase Authentication',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),),
              SizedBox(height:20),
              SizedBox(
                width: 300,
                height:50,
                child: RaisedButton(
                  child: Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InitializerWidget()),
                    );
                  },
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      
                      ),
                ),
              ),
               SizedBox(height:20),
              Container(child:Center(child: Text('Made By Dev Kumar')),),
                  SizedBox(height:60),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                Image.asset('assets/main_bottom.png',height: 150,),
                Image.asset('assets/login_bottom.png',height: 150,),
                
              ],),
              
            ],
            
          ),
        ),
        
      ),
    );
  }
}
