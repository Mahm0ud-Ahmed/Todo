import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/presention/widget/components.dart';
import 'package:todo_task/presention/widget/custom_text_field.dart';

class BuildingFields extends StatelessWidget {
  const BuildingFields({
    this.formKey,
    this.titleController,
    this.descriptionController,
    this.timeController,
    this.dateController,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController titleController;

  final TextEditingController descriptionController;

  final TextEditingController timeController;

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            label: 'Title',
            controller: titleController,
            textType: TextInputType.text,
            prefixIcon: const Icon(Icons.title),
            validator: (String value) {
              if (value.isEmpty) {
                return 'This field should not be empty!';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 14,
          ),
          CustomTextField(
            label: 'Description',
            controller: descriptionController,
            textType: TextInputType.text,
            prefixIcon: const Icon(Icons.description),
            lines: 3,
          ),
          const SizedBox(
            height: 14,
          ),
          CustomTextField(
            label: 'Time',
            controller: timeController,
            textType: TextInputType.datetime,
            prefixIcon: const Icon(Icons.more_time),
            onTab: () async {
              final time = await timePicker(context);
              timeController.text = time.format(context);
            },
            validator: (String value) {
              if (value.isEmpty) {
                return 'This field should not be empty!';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 14,
          ),
          CustomTextField(
            label: 'Date',
            controller: dateController,
            textType: TextInputType.datetime,
            prefixIcon: const Icon(Icons.date_range),
            onTab: () async {
              final date = await datePicker(context);
              dateController.text = DateFormat('y-MM-dd').format(date);
            },
            validator: (String value) {
              if (value.isEmpty) {
                return 'This field should not be empty!';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
