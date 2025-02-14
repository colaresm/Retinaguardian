import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:retinaguard/core/redirect_pages.dart';
import 'package:retinaguard/domain/use_cases/dependency_injection.dart';
import 'package:retinaguard/presentation/login/bloc/events/login_event.dart';
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
  late final LoginBloc _loginBloc;
  @override
  void initState() {
    _loginBloc = getDependency<LoginBloc>();
    _loginBloc.add(AuthInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[500],
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Fluttertoast.showToast(
                  msg: "Login realizado com sucesso",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 18.0,
                );
                redirectToHomePage(context);
              }
              if (state is LoginError) {
                Fluttertoast.showToast(
                  msg: state.message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0,
                );
              }
            },
            bloc: _loginBloc,
            builder: (context, state) {
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
                          onPressed: () {
                            _loginBloc.add(AuthEvent(
                                email: "colaresmarcelo2018@gmail.com",
                                password: "qwe123"));
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Ação de recuperação de senha executada!");
                        },
                        child:  Text(
                          "Esqueceu a senha?",
                          style: TextStyle(
                            color: Colors.blue[500],
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
            }));
  }

  void showCustomToast() {
    Fluttertoast.showToast(
      msg: "Isso é um Toast em Flutter!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
