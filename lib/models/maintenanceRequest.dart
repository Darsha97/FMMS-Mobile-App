class MaintenanceRequest {
  final Object id; // MongoDB ObjectId is typically represented as a string
  final String place;
  final String issueType;
  final String priority;
  final List<int>? image; // Represented as List<int> for binary data
  final String? contentType; // Content type of the image
  final String description;
  final String submittedBy; // Reference to the user who submitted the request
  final String status;
  final DateTime createdAt;

  MaintenanceRequest({
    required this.id,
    required this.place,
    required this.issueType,
    required this.priority,
    this.image,
    this.contentType,
    required this.description,
    required this.submittedBy,
    required this.status,
    required this.createdAt,
  });

  factory MaintenanceRequest.fromJson(Map<String, dynamic> json) {
    return MaintenanceRequest(
      id: json['_id'],
      place: json['place'],
      issueType: json['issueType'],
      priority: json['priority'],
      image: json['image'] != null ? List<int>.from(json['image']) : null,
      contentType: json['contentType'],
      description: json['description'],
      submittedBy: json['submittedBy'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'place': place,
      'issueType': issueType,
      'priority': priority,
      'image': image,
      'contentType': contentType,
      'description': description,
      'submittedBy': submittedBy,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
