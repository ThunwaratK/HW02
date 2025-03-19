class BoonModel {
  int? id;
  late String title;
  late String? desc;
  late String eventDate;
  late String startHour;
  late String startMinute;
  late String location;

  BoonModel({
    this.id,
    required this.title,
    this.desc,
    required this.eventDate,
    required this.startHour,
    required this.startMinute,
    required this.location,
  });

  BoonModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    desc = data['desc'];
    eventDate = data['eventDate'];
    startHour = data['startHour'];
    startMinute = data['startMinute'];
    location = data['location'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'eventDate': eventDate,
      'startHour': startHour,
      'startMinute': startMinute,
      'location': location,
    };
  }

  @override
  String toString() {
    return '[$id $title $desc $eventDate $startHour $startMinute $location]';
  }
}
