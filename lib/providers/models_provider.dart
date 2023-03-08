import 'package:chat_app/services/api_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/models_model.dart';

class ModelsProvider with ChangeNotifier {
  String currentModel = "text-davinci-003";

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelList = [];

  List<ModelsModel> get getModelList {
    return modelList;
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelList = await ApiService.getModels();
    return modelList;
  }
}
