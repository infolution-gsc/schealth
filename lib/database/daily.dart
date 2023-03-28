import 'package:hive/hive.dart';
part 'daily.g.dart';

@HiveType(typeId: 0)
class Daily {
  @HiveField(0)
  String name;
  @HiveField(1)
  int category;
  @HiveField(2)
  DateTime dateTime;
  @HiveField(3)
  int time;
  @HiveField(4)
  int reminder;
  @HiveField(5)
  String note;
  @HiveField(6)
  String location;

  Daily(this.name, this.category, this.dateTime, this.time, this.reminder,
      this.note, this.location);
}
