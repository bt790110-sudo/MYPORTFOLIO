class ProjectModel {
  final String id;
  final String title;
  final String description;
  final List<String> techStack;
  final String liveUrl;
  final String githubUrl;
  final String imageUrl;
  final bool isFeatured;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required List<String> techStack,
    required this.liveUrl,
    required this.githubUrl,
    this.imageUrl = '',
    this.isFeatured = false,
  }) : techStack = List.unmodifiable(techStack);
}