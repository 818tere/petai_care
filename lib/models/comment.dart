class Comment {
  final String? id;
  final String? contents;
  final DateTime? writeCommentDate;
  final String? postId;
  final String? userId;

  Comment(
      {this.id,
      this.contents,
      this.writeCommentDate,
      this.postId,
      this.userId});
}
