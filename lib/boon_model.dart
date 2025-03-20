class BoonModel {
  int? id;
  String title;
  String? desc;
  String eventDate;
  String startHour;
  String startMinute;
  String location;

  BoonModel({
    this.id,
    required this.title,
    this.desc,
    required this.eventDate,
    required this.startHour,
    required this.startMinute,
    required this.location,
  });


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

  BoonModel.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        desc = data['desc'],
        eventDate = data['eventDate'],
        startHour = data['startHour'],
        startMinute = data['startMinute'],
        location = data['location'];

  @override
  String toString() {
    return '[$id $title $desc $eventDate $startHour $startMinute $location]';
  }
}
