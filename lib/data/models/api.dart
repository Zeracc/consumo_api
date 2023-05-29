class ApiModel {
  final String name;
  final String color;
  final String style;

  ApiModel({
    required this.name, 
    required this.color,
    required this.style, 
    });

  factory ApiModel.fromMap(Map<String, dynamic> map){
    return ApiModel(
      name: map['name'], 
      color: map['color'],
      style: map['style']) 
      ;
  }

}