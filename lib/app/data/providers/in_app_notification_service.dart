import 'package:get_storage/get_storage.dart';

class InAppNotificationService {
  static final box = GetStorage();

  static void add(String title, String body) {
    final List list =
        List.from(box.read('notifications') ?? []);

    list.insert(0, {
      "title": title,
      "body": body,
      "time": DateTime.now().toString(),
    });

    box.write('notifications', list);

    print("NOTIFIKASI DISIMPAN");
    print(list);
  }

  static List getAll() {
    return List.from(
      box.read('notifications') ?? [],
    );
  }

  static void clear() {
    box.remove('notifications');
  }
}