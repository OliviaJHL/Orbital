import 'package:flutter/material.dart';

class ForgetpasswordPage extends StatelessWidget {
  const ForgetpasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: const <Widget>[
                    Text(
                      "Forget Password",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/forgetpassword.png"),
                        fit: BoxFit.fitHeight
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      inputFile(
                        label: "Please enter your email address.",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {},
                      color: Colors.orange,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),

                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                      ),
                      ),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

}


// we will be creating a widget for text field
Widget inputFile({label, obscureText = false})
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color:Colors.black87
        ),

      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: const InputDecoration(
            hintText: "Email",
            contentPadding: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 10
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey,
              ),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
        ),
      ),
      const SizedBox(height: 10,)
    ],
  );
}