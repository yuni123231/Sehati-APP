import 'package:get/get.dart';

class GuideItem {
  final String title;
  final String description;
  RxBool isDone;

  GuideItem({
    required this.title,
    required this.description,
    bool isDone = false,
  }) : isDone = isDone.obs;
}