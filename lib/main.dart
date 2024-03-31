import 'package:discount_calculator/constants/colors.dart';
import 'package:flutter/material.dart';



void main() async{
  runApp(MaterialApp(
    home: const MyApp(),
    theme: ThemeData(
      hintColor: AppColor.secondaryColor,
      primaryColor: AppColor.primaryColor,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.primaryColor)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.textColor)),
        hintStyle: TextStyle(color: AppColor.secondaryColor),
      ),
      scaffoldBackgroundColor: AppColor.backgroundColor,
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override 
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  final codClientController = TextEditingController();
  final totalValueController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey <FormState>();

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar( 
        title: const Text("Discount Calculator"),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Icon(Icons.shopping_cart_outlined,
                size: 120,
                color: AppColor.secondaryColor,
                ),
                buildTextField("Insira o código", codClientController),
                const Divider(),
                buildTextField("Insira o valor da compra", totalValueController),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: ElevatedButton(                    
                    onPressed: (){

                    },
                    child: const Text(
                      'Enviar',
                      style: TextStyle(color: AppColor.backgroundColor, fontSize: 15.0),
                    ),
                  ),
                )
              ],
              
            )
        ) 
      ),
    );
  } 
}

Widget buildTextField(String label, TextEditingController c){
  return TextFormField(
    keyboardType: TextInputType.number,
    style: const TextStyle(color: AppColor.textColor),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColor.primaryColor), 
    ),
    controller: c,
    validator: (value){
      if(value!.isEmpty){
        return 'Preencha o campo!';
      }
      return null;
    },
  );
}

