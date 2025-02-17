import 'package:flutter/material.dart';
import 'package:retinaguard/core/validations.dart';
import 'package:retinaguard/utils/utils.dart';
import 'package:retinaguard/widgets/custom_text_field.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(String) onDateSelected;

  const CustomDatePicker({Key? key, required this.onDateSelected})
      : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

final TextEditingController _controller = TextEditingController();

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onDoubleTap: () => _showDatePicker(context),
          onTap: () => _showDatePicker(context),
          child: CustomTextField(
            hintText: "Insira a data de nascimento",
            controller: _controller,
            validator: requiredFiled,
          ),
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Selecione sua data de nascimento".toUpperCase()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.86,
                height: MediaQuery.of(context).size.height * 0.4,
                child: SfDateRangePicker(
                  maxDate: DateTime.now(),
                  onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                    _controller.text = extractDate(
                        dateRangePickerSelectionChangedArgs.value.toString());
                    widget.onDateSelected(_controller.text);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
