import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Please inform your data";

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';

    setState(() {
      _infoText = "Please inform your data";
      _formKey = GlobalKey<FormState>();    // ADICIONE ESTA LINHA!
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double bmi = weight / (height * height);

      if(bmi < 18.6) {
        _infoText = "Your BMI is ${bmi.toStringAsPrecision(3)}: Underweight";
      } else if (bmi >= 18.6 && bmi < 24.9) {
        _infoText = "Your BMI is ${bmi.toStringAsPrecision(3)}: Ideal weight";
      } else if (bmi >= 24.9 && bmi < 29.9) {
        _infoText = "Your BMI is ${bmi.toStringAsPrecision(3)}: Slightly overweight";
      } else if (bmi >= 29.9 && bmi < 34.9) {
        _infoText = "Your BMI is ${bmi.toStringAsPrecision(3)}: Warning!!! Obesity I";
      } else if (bmi >= 34.9 && bmi < 39.9) {
        _infoText = "Your BMI is ${bmi.toStringAsPrecision(3)}: Warning!!! Obesity II";
      } else if (bmi > 40.0) {
        _infoText = "Your BMI is ${bmi.toStringAsPrecision(3)}: Warning!!! Obesity III";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView( 
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.green
              ),
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black, 
                    width: 5.0),
                  ),
                  labelText: "Weight (kg)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                // ignore: missing_return
                validator: (value) {
                  if(value.isEmpty) {
                    return "Please inform your weight!";
                  }
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black, 
                    width: 5.0),
                  ),
                  labelText: "Height (cm)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                // ignore: missing_return
                validator: (value) {
                  if(value.isEmpty) {
                    return "Please inform your height!";
                  }
                },
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                height: 70.0,
                child: RaisedButton(
                  child: Text(
                    "Show me!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      _calculate();
                    }
                  },
                  color: Colors.green,
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}