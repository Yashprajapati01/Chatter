import 'package:chatter/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatter/components/MyTextField.dart';
import 'package:chatter/components/my_button.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmpassController = TextEditingController();
  //tap var to go to login page
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});
  void Register(BuildContext context){
    //get auth service
    final _auth = AuthService();
    if(_passController.text == _confirmpassController.text){
      try{
        _auth.signUpWIthEmailPassword(_emailController.text, _passController.text);
      } catch(e){
        showDialog(context: context, builder: (context) => AlertDialog(title: Text(e.toString()),),);
      }
    }
    else{
      showDialog(context: context, builder: (context) => const AlertDialog(title: Text("Password doesn't match"),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Image.asset(
                'images/icon.png',
                height: 60.0,
            ),
            SizedBox(height: 20),
            //welcome text
            Text("Let's create an account for you",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16
              ),
            ),
            const SizedBox(height: 15),
            // email textfield
            MyTextField(hintText: 'Email',
              tf: false,
              controller: _emailController, focusNode: null,
            ),
            const SizedBox(height: 15),
            MyTextField(hintText: 'Password',
              tf: true,
              controller: _passController, focusNode: null,
            ),
            const SizedBox(height: 25),
            MyTextField(hintText: 'Confirm Password',
              tf: true,
              controller: _confirmpassController, focusNode: null,
            ),
            const SizedBox(height: 25),
            //login button
            MyButton(txt: "Register" , onTap: () => Register(context)),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already a member? ",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
