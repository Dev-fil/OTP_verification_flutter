import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

final _auth=FirebaseAuth.instance;

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
                child: Image.asset('assets/home.png'),
              ),
              SizedBox(height:20),
              Container(child:Center(child: Text('WELCOME',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),),
              SizedBox(height:20),
               Container(child:Center(child: Text('Successfully logged IN !',style: TextStyle(fontSize: 16),)),),
               SizedBox(height:20),
               Image.asset('assets/correct.png',height: 80,),
               SizedBox(height:20),
              SizedBox(
                width: 300,
                height:50,
                child: RaisedButton(
                  child: Text(
                    'SIGNOUT',
                    style: TextStyle(color: Colors.white),
                  ),
                 onPressed: ()async{
          await _auth.signOut();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        },
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      
                      ),
                ),
              ),
               
             
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


