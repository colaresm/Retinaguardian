import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retinaguard/core/redirect_pages.dart';
import 'package:retinaguard/core/show_toast.dart';
import 'package:retinaguard/core/validations.dart';
import 'package:retinaguard/data/models/create_doctor_model.dart';
import 'package:retinaguard/data/models/create_user_model.dart';
import 'package:retinaguard/domain/use_cases/dependency_injection.dart';
import 'package:retinaguard/presentation/create_doctor/bloc/create_doctor_bloc.dart';
import 'package:retinaguard/presentation/create_doctor/bloc/events/create_doctor_event.dart';
import 'package:retinaguard/presentation/create_doctor/bloc/states/create_doctor_state.dart';
import 'package:retinaguard/utils/utils.dart';
import 'package:retinaguard/widgets/body.dart';
import 'package:retinaguard/widgets/custom_datepicker.dart';
import 'package:retinaguard/widgets/custom_elevated_button.dart';
import 'package:retinaguard/widgets/custom_header.dart';
import 'package:retinaguard/widgets/custom_text_field.dart';

class CreateDoctorPage extends StatefulWidget {
  const CreateDoctorPage({super.key});

  @override
  State<CreateDoctorPage> createState() => _CreateDoctorPageState();
}

class _CreateDoctorPageState extends State<CreateDoctorPage> {
  late final CreateDoctorBloc _createDoctorBloc;
  @override
  void initState() {
    _createDoctorBloc = getDependency<CreateDoctorBloc>();
    _createDoctorBloc.add(DoctorInitialEvent());
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _crmController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Body(
        showHeaderElements: false,
        constraints: constraints,
        content: BlocConsumer<CreateDoctorBloc, DoctorState>(
            bloc: _createDoctorBloc,
            listener: (context, state) {
              if (state is DoctorSuccessState) {
                _onCreationDoctor(message: "Médico cadastrado com sucesso");
              }
              if (state is DoctorErrorState) {
                _onCreationDoctor(message: state.message, isError: true);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  const CustomHeader(
                    title: "Cadastrar médico",
                    subtitle:
                        "Insira suas informações para finalizar o cadastro",
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.03,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            validator: requiredFiled,
                            hintText: "Nome",
                            controller: _nameController,
                          ),
                          CustomTextField(
                            validator: requiredFiled,
                            hintText: "CRM",
                            controller: _crmController,
                          ),
                          CustomTextField(
                            validator: validateEmail,
                            hintText: "Email",
                            controller: _emailController,
                          ),
                          CustomDatePicker(
                            onDateSelected: (selectedDate) =>
                                _birthDayController.text = selectedDate,
                          ),
                          CustomTextField(
                            validator: requiredFiled,
                            hintText: "Senha",
                            controller: _passwordController,
                            isPassword: true,
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.03,
                          ),
                          CustomElevatedButton(
                            hintText: "Cadastrar médico",
                            onPressed: _onPressCreate,
                          )
                        ],
                      )),
                ],
              );
            }),
      );
    });
  }

  void _onPressCreate() {
    if (_formKey.currentState!.validate()) {
      _createDoctorBloc.add(
        CreateDoctorEvent(
          createDoctorModel: CreateDoctorModel(
            name: _nameController.text,
            crm: _crmController.text,
            birthday: convertDateToISO(_birthDayController.text),
            user: CreateUserModel(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          ),
        ),
      );
    }
  }

  void _onCreationDoctor({required String message, bool isError = false}) {
    showToast(message: message, isError: isError);
    redirectToLoginPage(context);
  }
}
