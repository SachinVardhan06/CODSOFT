import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
                Container(
                  height: MediaQuery.of(context).size.height/2.79,
                  child: resultwidget(),
                  color: Colors.white,
                ),
              Expanded(child: buttonWidget()),
            ],
          ),
        ));
  }
  String userInput = "";
  String result = "0";

  // Keys

  List<String> buttonList =[
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "C",
    "0",
    ".",
    "=",
  ];


  @override
  Widget resultwidget() {
    return Container(
      color: Colors.white10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(userInput, style: TextStyle(
              fontSize: 60,
            ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            child: Text(
              result, style: TextStyle(
              color: Colors.blue,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonWidget(){
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white30,
      child: GridView.builder(
        itemCount: buttonList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ), itemBuilder: (context,index){
        return button(buttonList[index]);
      }),
    );
  }


  getColor(String text){
    if(text == '/' || text == '*' || text == '+' || text == '-' || text == 'C' || text == '(' || text == ')'){
      return Colors.redAccent;
    }
    if(text == '=' || text == 'AC'){
      return Colors.white;

    }
    return Colors.indigo;

  }

  getBgColor(String text){
    if(text == "AC"){
      return Colors.red;
    }
    if(text == "="){
      return Colors.blue;
    }

    return Colors.white;
  }
  Widget button(String text){
    return InkWell(
      onTap: (){
        setState(() {
          handleButtonPress(text);

        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(80),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 1,
              spreadRadius: 1,
            )
          ]
        ),
        child: Center(
          child: Text(text, style: TextStyle(
            color: getColor(text),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),

      ),
    );
  }
  handleButtonPress(String text){
    if(text == "AC"){
      userInput = "";
      result = "0";
      return;
    }
    if(text == "C"){
      if(userInput.length > 0){
        userInput = userInput.substring(0,userInput.length - 1);
        return;
      }
      else{
        return null;
      }
    }
    if(text == "="){
      result = calculate();
      userInput = result;
      if(userInput.endsWith(".0")){
        userInput = userInput.replaceAll(".0", "");
      }
      if(result.endsWith(".0")){
        result = result.replaceAll(".0", "");
      }
      return;
    }
    userInput = userInput+text;
  }

  String calculate(){
    try{
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL,ContextModel());
      return evaluation.toString();
    }
    catch(e){
      return "Error";
    }
  }
}


