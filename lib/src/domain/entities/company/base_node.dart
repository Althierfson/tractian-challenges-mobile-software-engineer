class BaseNode {
  final String id;
  final String name;
  final String? parentId;

  BaseNode({
    required this.id,
    required this.name,
    this.parentId,
  });
}
