import 'package:retinaguard/data/models/create_user_model.dart';

class CreateDoctor {
  final String name;
  final String crm;
  final String birthday;
  final CreateUserModel user;

  CreateDoctor({
    required this.name,
    required this.crm,
    required this.birthday,
    required this.user,
  });
}
