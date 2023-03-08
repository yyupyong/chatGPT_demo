import 'package:chat_app/constansts/constants.dart';
import 'package:chat_app/providers/models_provider.dart';
import 'package:chat_app/widgets/text_Widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModelDropdownWidget extends StatefulWidget {
  const ModelDropdownWidget({Key? key}) : super(key: key);

  @override
  State<ModelDropdownWidget> createState() => _ModelDropdownWidgetState();
}

class _ModelDropdownWidgetState extends State<ModelDropdownWidget> {
  String? currentModel;

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModel = modelsProvider.getCurrentModel;
    return FutureBuilder(
        future: modelsProvider.getAllModels(),
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return Center(
                child: TextWidget(label: snapShot.hasError.toString()));
          }
          return snapShot.data == null || snapShot.data!.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                    dropdownColor: scaffoldBackgroundColor,
                    items: List<DropdownMenuItem<Object?>>.generate(
                      snapShot.data!.length,
                      (index) => DropdownMenuItem(
                        value: snapShot.data![index].id,
                        child: TextWidget(
                          label: snapShot.data![index].id,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    value: currentModel,
                    onChanged: (newValue) {
                      setState(() {
                        currentModel = newValue.toString();
                      });
                      modelsProvider.setCurrentModel(newValue.toString());
                    },
                  ),
                );
        });
  }
}
