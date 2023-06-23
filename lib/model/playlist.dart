import 'song.dart';

class Playlist {
  final List<Song> _playlist = [
    Song(
      title: "Anew",
      artist: "Hollow Coves",
      id: "1dI7xOMNT29Zu6LkzoAljstZysGUTJ-E9",
      album: "anew.jpg",
    ),
    Song(
      title: "Coastline",
      artist: "Hollow Coves",
      id: "1uAeqdaYwcC51hSf3WN_aKSWUHrmOOLLW",
      album: "wanderlust.jpg",
    ),
    Song(
      title: "Home",
      artist: "Hollow Coves",
      id: "1x_ltKT7m-0QEXeas4PZNMmKA80TDrXkT",
      album: "wanderlust.jpg",
    ),
    Song(
      title: "The Woods",
      artist: "Hollow Coves",
      id: "16E97TbHsyoUzm0QWpnPFNgeChDBcZ7aO",
      album: "wanderlust.jpg",
    ),
    Song(
      title: "Evermore",
      artist: "Hollow Coves",
      id: "1RGYhzKHjiiemy7k4OYgxxkjaQTA4E64j",
      album: "evermore.jpg",
    ),
    Song(
      title: "The Pool",
      artist: "Stephen Sanchez",
      id: "1oZr_-0oG3EtJ3gOXRYonE4hHkTnfY9Od",
      album: "thepool.jpg",
    ),
    Song(
      title: "Space Song",
      artist: "Beach House",
      id: "1x5-0H5Rd5pWYBNDw7Z4q0Nlts_Gj9eGN",
      album: "depressioncherry.jpg",
    ),
    Song(
      title: "Sunflower",
      artist: "Post Malone",
      id: "1ghQxdmKjvCrzvLTDAbMR5OvOR1DKXb6u",
      album: "spiderverse.jpg",
    ),
    Song(
      title: "Paradise",
      artist: "Coldplay",
      id: "14sdJrXOdc-J3M6b0cGC71qXqoKzoG454",
      album: "paradise.jpg",
    ),
    Song(
      title: "Yellow",
      artist: "Coldplay",
      id: "1gkFVxN9qSL4voyT7ZmFjJnP_ZE8Mv2hX",
      album: "parachutes.jpg",
    ),
    Song(
      title: "The Scientist",
      artist: "Coldplay",
      id: "1oBWLV5OYCFk7yIe05OUEDl1AYIa6zq86",
      album: "thescientist.jpg",
    ),
    Song(
      title: "Gunjo",
      artist: "YOASOBI",
      id: "1t-pxGaZXKn6k0YLBsD7YarsiiVMnrgYV",
      album: "thebook.jpg",
    )
  ];

  int getPlaylistLength() {
    return _playlist.length;
  }

  String getTitle(songIndex) {
    return _playlist[songIndex].title;
  }

  String getId(songIndex) {
    return _playlist[songIndex].id;
  }

  String? getArtist(songIndex) {
    return _playlist[songIndex].artist;
  }

  String? getAlbum(songIndex) {
    return _playlist[songIndex].album;
  }
}
