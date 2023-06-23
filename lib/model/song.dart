class Song {
  late String id;
  late String title;
  String? artist;
  String? album;

  Song({required this.id, required this.title, this.artist, this.album});
}
