import 'package:hive/hive.dart';
part 'LocalAccount.g.dart';

@HiveType(typeId: 1)
class Account {
  Account(
      {required this.UsernName, required this.Password, required this.Status});

  @HiveField(0)
  String UsernName;

  @HiveField(1)
  String Password;

  @HiveField(2)
  bool Status;
}
