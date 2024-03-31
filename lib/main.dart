import 'package:discount_calculator/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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

class Receipt {
  final String codClient;
  final double totalValue;

  final double percentage;
  final double discount;
  final double finalValue;

  const Receipt(this.codClient, this.totalValue, this.percentage, this.discount, this.finalValue);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override 
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  final codClientController = TextEditingController();
  final totalValueController = TextEditingController();

  void _calculate(){
    setState(() {
      String codClient = codClientController.text;
      double totalValue = double.parse(totalValueController.text);

      double percentage;
      double finalValue;
      double discount;

      if(codClient.length == 4){
        percentage = 0.05;

        discount = totalValue * percentage;
        finalValue = totalValue - (discount);
      }

      else if(codClient.length == 5){
        percentage = 0.10;

        discount = totalValue * percentage;
        finalValue = totalValue - (discount);
      }

      else if(codClient.length == 6){
        percentage = 1;

        discount = totalValue * percentage;
        finalValue = totalValue - (discount);
      }

      else {
        // Mostra o Alerta
        showDialog(
          barrierDismissible: true,
          context: context, 
          builder: (context){
            // Configura o AlertDialog
            return AlertDialog(
              title: const Text("Código inválido!"),
              content: const Text("O código Informado não existe."),
              actions: [
                // Configura o botão de fechar
                ElevatedButton(
                  child: const Text("Ok"),
                  onPressed: (){
                    // Fecha o AlertDialog
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }

        );
        // Interrompe a execução da função
        return;
      }

      if(kDebugMode){
        print("Código do Cliente: $codClient");
        print("Valor Total: $totalValue");
        print("Porcentagem: $percentage");
        print("Desconto: $discount");
        print("Valor Final: $finalValue");
      }

      final receipt = Receipt(codClient, totalValue, percentage, discount, finalValue);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyReceipt(receipt: receipt)
        )
      );

    });
  } 

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
                      if(_formKey.currentState!.validate()){
                        _calculate();
                      }
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

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key, required this.receipt});

  final Receipt receipt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recibo"),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Código do Cliente: ${receipt.codClient}", 
              style: const TextStyle(fontSize: 20.0, color: AppColor.textColor)
            ),
            Text(
              "Total da compra: ${receipt.totalValue}", 
              style: const TextStyle(fontSize: 20.0, color: AppColor.textColor)
            ),
            Text(
              "Porcentagem de desconto: ${receipt.percentage}", 
              style: const TextStyle(fontSize: 20.0, color: AppColor.textColor)
            ),
            Text(
              "Valor desconto: ${receipt.discount}", 
              style: const TextStyle(fontSize: 20.0, color: AppColor.textColor)
            ),
            Text(
              "Valor Final: ${receipt.finalValue}", 
              style: const TextStyle(fontSize: 20.0, color: AppColor.textColor)
            ),
          ],

        )
      )
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

