import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retinaguard/core/show_toast.dart';
import 'package:retinaguard/core/token_storage.dart';
import 'package:retinaguard/domain/use_cases/dependency_injection.dart';
import 'package:retinaguard/presentation/list_classifications/bloc/events/list_classifications_event.dart';
import 'package:retinaguard/presentation/list_classifications/bloc/list_classifications_bloc.dart';
import 'package:retinaguard/widgets/body.dart';
import 'package:retinaguard/widgets/error_message.dart';

import 'bloc/states/list_classifications_state.dart';

class ListClassificationsPage extends StatefulWidget {
  const ListClassificationsPage({super.key});

  @override
  State<ListClassificationsPage> createState() =>
      _ListClassificationsPageState();
}

class _ListClassificationsPageState extends State<ListClassificationsPage> {
  late final ListClassificationsBloc _listClassificationsBloc;
  late String? userId;
  @override
  void initState() {
    _listClassificationsBloc = getDependency<ListClassificationsBloc>();
    _getClassifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Body(
          showHeaderElements: true,
          onRefresh: () => _listClassificationsBloc.add(
            GetClassificationsEvent(
              patientId: userId!,
            ),
          ),
          constraints: constraints,
          content:
              BlocConsumer<ListClassificationsBloc, ListClassificationsState>(
            bloc: _listClassificationsBloc,
            listener: (context, state) {
              if (state is ListClassificationsError) {
                showToast(message: state.message, isError: true);
              }
            },
            builder: (context, state) {
              if (state is ListClassificationsLoading) {
                return const CircularProgressIndicator();
              }
              if (state is ListClassificationsSuccess) {
                return Visibility(
                  visible: state.classifications.isNotEmpty,
                  replacement: const Text("Lista vazia"),
                  child: ListView.builder(
                    itemCount: state.classifications.length,
                    itemBuilder: (context, index) {
                      var classification = state.classifications[index];
                      return ListTile(
                        leading: Icon(Icons.label),
                        title: Text(classification.prediction),
                        subtitle: Text(classification.performedDate),
                        trailing: Icon(Icons.arrow_forward),
                      );
                    },
                  ),
                );
              }
              if (state is ListClassificationsError) {
                return const ErrorMessage();
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }

  void _getClassifications() async {
    userId = await TokenStorage.getUserId();
    _listClassificationsBloc.add(
      GetClassificationsEvent(
        patientId: userId!,
      ),
    );
  }
}
