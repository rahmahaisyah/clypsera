import 'package:get/get.dart';
import '../../../data/models/notification_item.dart';

class NotificationController extends GetxController {
  final notifications = <NotificationItem>[
    NotificationItem(title: 'Data pasien x telah dikonfirmasi!'),
    NotificationItem(title: 'Data pasien x telah dikonfirmasi!'),
    NotificationItem(title: 'Data pasien x telah dikonfirmasi!'),
    NotificationItem(title: 'Data pasien x telah dikonfirmasi!'),
  ].obs;
}
