import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retinaguard/core/redirect_pages.dart';
import 'package:retinaguard/core/show_toast.dart';
import 'package:retinaguard/core/validations.dart';
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

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCotroller = TextEditingController();
  final TextEditingController _passwordCotroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            showToast(message: "Login realizado com sucesso", isError: true);
            redirectToHomePage(context);
          }
          if (state is LoginError) {
            showToast(message: state.message, isError: true);
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
                  Image.asset(
                    'assets/logo.png',
                    width: constraints.maxWidth * 0.8,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          validator: validateEmail,
                          controller: _emailCotroller,
                          hintText: "Digite seu email ",
                        ),
                        CustomTextField(
                          validator: requiredFiled,
                          controller: _passwordCotroller,
                          isPassword: true,
                          hintText: "Digite sua senha ",
                        ),
                        CustomElevatedButton(
                          hintText: "Login",
                          onPressed: _onPressLogin,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () => redirectToCrateDoctorPage(context),
                    child: Text(
                      "Criar conta",
                      style: TextStyle(
                        color: Colors.blue[500],
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => redirectToCrateDoctorPage(context),
                    child: Text(
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
        },
      ),
    );
  }

  void _onPressLogin() {
    if (_formKey.currentState!.validate()) {
      _loginBloc.add(
        AuthEvent(
          email: _emailCotroller.text,
          password: _passwordCotroller.text,
        ),
      );
    }
  }
}
