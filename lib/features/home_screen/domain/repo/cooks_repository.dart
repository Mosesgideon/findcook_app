
import '../../data/models/cook_models.dart';

abstract class AllCooksRepository{
  Future<List<AppCookModelResponse>> getCooks();
}