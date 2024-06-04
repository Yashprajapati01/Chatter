import 'package:chatter/services/auth_service.dart';
import 'package:chatter/components/MyTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatter/components/my_button.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  //tap var to go to register page
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});
  //login fxn at auth time
  void login(BuildContext context) async{
    final authService = AuthService();
    //try login
    try{
      await authService.signInWithEmailPass(_emailController.text, _passController.text);
    }
    catch(e){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text(e.toString()),),);
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
            Text("Welcome back, You've been missed!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16
            ),
            ),
            const SizedBox(height: 15),
            // email textfield
            MyTextField(hintText: 'Email',
              tf: false,
              controller: _emailController,
            ),
            const SizedBox(height: 15),
            MyTextField(hintText: 'Password',
              tf: true,
            controller: _passController,
            ),
            const SizedBox(height: 25),
            //login button
            MyButton(txt: "Login" , onTap: () => login(context)),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Register now",
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