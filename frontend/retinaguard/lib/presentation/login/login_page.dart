import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retinaguard/presentation/login/bloc/login_bloc.dart';
import 'package:retinaguard/presentation/login/bloc/states/login_state.dart';
import 'package:retinaguard/widgets/custom_elevated_button.dart';
import 'package:retinaguard/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: BlocConsumer<LoginBloc, LoginState>(listener:  (context,state){
        if(state is LoginSuccess){
          print("Login bem-sucedido!");
        }
      },builder: (context,state){
       return LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Column(
            children: [
                SizedBox(
                height: constraints.maxHeight * 0.1,
              ),
              Image.asset('assets/logo.png'),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              CustomTextField(
                height: constraints.maxHeight * 0.1,
                width: constraints.maxWidth * 0.9,
                hintText: "Digite seu email ",
              ),
              CustomTextField(
                height: constraints.maxHeight * 0.1,
                width: constraints.maxWidth * 0.9,
                hintText: "Digite sua senha ",
              ),
              CustomElevatedButton(
                height: constraints.maxHeight * 0.06,
                width: constraints.maxWidth * 0.9,
                hintText: "Login",
                onPressed: () => print("logado"),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  print("Ação de recuperação de senha executada!");
                },
                child: const Text(
                  "Esqueceu a senha?",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        );
      });
      })
    );
  }
}
