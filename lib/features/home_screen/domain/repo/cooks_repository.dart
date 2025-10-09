
import 'package:find_cook/features/cook_onboarding/data/models/cookpayload.dart';

import '../../data/models/cook_models.dart';

abstract class AllCooksRepository{
  Future<List<AppCookModelResponse>> getCooks();
  Future<void> createCooks(AppCookPayload payload);
}