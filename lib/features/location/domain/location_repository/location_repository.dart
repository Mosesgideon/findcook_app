
import '../../data/models/location_payload.dart';

abstract class LocationRepository {
  Future<void> storelocation(UpdateLocationPayload payload);
}