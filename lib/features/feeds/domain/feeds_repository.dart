import 'package:find_cook/features/feeds/data/models/postresponse.dart';

import '../data/models/postmodels.dart';

abstract class FeedsRepository{
  Future<PostResponseModel>postfeeds(PostModel payload);
}