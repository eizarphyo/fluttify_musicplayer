import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttify/model/playlist.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:image/image.dart' as img;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Fluttify(),
    );
  }
}

class Fluttify extends StatefulWidget {
  const Fluttify({super.key});

  @override
  State<Fluttify> createState() => _FluttifyState();
}

class _FluttifyState extends State<Fluttify> {
  // String sunflower = "https://hiphopmood.com/music/stream/842";

  Playlist playlist = Playlist();

  int nowPlayingIndex = 0;

  String prefix = "https://docs.google.com/uc?export=download&id=";
  String? title;
  String? artist;
  String? id;
  String? album;

  bool repeatOn = false;
  bool shuffleOn = false;

  AudioPlayer player = AudioPlayer();

  double sliderValue = 0;
  PlayerState? playerState;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

// Format Duration in 00:00
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours != 0) {
      // 00:00:00
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    } else {
      // 00:00
      return "${twoDigits(duration.inMinutes)}:$twoDigitSeconds";
    }
  }

  @override
  void initState() {
    super.initState();
    player.setSourceUrl("$prefix${playlist.getId(nowPlayingIndex)}");

    player.onDurationChanged.listen((Duration d) {
      // debugPrint('Max duration>>>>>>> $d');
      setState(() => duration = d);
    });

    player.onPlayerStateChanged.listen((PlayerState s) {
      // debugPrint('Current player state: $s');
      setState(() => playerState = s);
    });

    player.onPositionChanged.listen((Duration p) {
      // debugPrint('Current position: $p');
      setState(() => position = p);
    });

    player.onPlayerComplete.listen((_) {
      if (repeatOn) {
        playSongFromPlaylist(nowPlayingIndex);
      } else if (nowPlayingIndex < playlist.getPlaylistLength()) {
        nowPlayingIndex++;
        nowPlayingIndex = nowPlayingIndex;
        playSongFromPlaylist(nowPlayingIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //--ALBUM--
            GlassContainer.clearGlass(
              height: 320,
              width: 320,
              borderColor: Colors.white30,
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: AssetImage(
                    "assets/images/${playlist.getAlbum(nowPlayingIndex)}"),
              ),
            ),
            // TITLE & ARTIST
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Column(
                children: [
                  Text(
                    playlist.getTitle(nowPlayingIndex),
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    playlist.getArtist(nowPlayingIndex)!,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            //--SLIDER--
            Slider(
              value:
                  position.inSeconds.toDouble() <= duration.inSeconds.toDouble()
                      ? position.inSeconds.toDouble()
                      : 0,
              min: 0,
              max: duration.inSeconds.toDouble(),
              onChanged: (newVal) {
                position = Duration(seconds: newVal.toInt());
                player.seek(position);
                setState(() {});
              },
              inactiveColor: Colors.white54,
              activeColor: Colors.grey.shade300,
            ),
            // MIN & MAX DURATION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  formatDuration(position),
                  style: const TextStyle(color: Colors.white60),
                ),
                Text(
                  formatDuration(duration),
                  style: const TextStyle(color: Colors.white60),
                ),
              ],
            ),
            //--PLAY/SKIP BUTTONS--
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --SHUFFLE--
                  IconButton(
                    onPressed: () {
                      setState(() {
                        shuffleOn = !shuffleOn;
                      });
                    },
                    icon: !shuffleOn
                        ? const Icon(
                            Icons.shuffle,
                            size: 23,
                            color: Colors.white70,
                          )
                        : Icon(
                            Icons.shuffle,
                            size: 23,
                            color: Colors.pink.shade300,
                          ),
                  ),
                  //--PREV--
                  IconButton(
                    onPressed: () {
                      // prevSong();
                      int i = nowPlayingIndex - 1;
                      if (position.inSeconds != 0) {
                        player.seek(duration - duration);
                      } else if (-1 < i) {
                        nowPlayingIndex = i;
                        // playSongFromPlaylist(i);
                        // debugPrint("Prev Song: $nowPlayingIndex");
                      }
                    },
                    icon: Icon(
                      Icons.skip_previous,
                      size: 35,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  //--PLAY--
                  GlassContainer.clearGlass(
                    height: 50,
                    width: 50,
                    borderColor: Colors.white30,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    child: playerState != PlayerState.playing
                        ? IconButton(
                            onPressed: () {
                              // player.play(AssetSource("audios/sunflower.mp3"));

                              player.play(UrlSource(
                                  "$prefix${playlist.getId(nowPlayingIndex)}"));

                              // setState(() {
                              //   playPause = !playPause;
                              // });
                            },
                            alignment: Alignment.center,
                            icon: const Icon(
                              Icons.play_arrow,
                              // color: Colors.white,
                              size: 30,
                            ),
                          )
                        //---PAUSE/RESUME---
                        : IconButton(
                            onPressed: () async {
                              if (playerState == PlayerState.playing) {
                                debugPrint("player state1 >>>>>> $playerState");

                                await player.pause();
                                debugPrint("player state2 >>>>>> $playerState");
                              } else {
                                player.resume();
                              }
                              // setState(() {
                              //   playPause = !playPause;
                              // });
                            },
                            icon: const Icon(
                              Icons.pause,
                              size: 30,
                            ),
                          ),
                  ),
                  //--NEXT--
                  IconButton(
                    onPressed: () {
                      // nextSong();
                      int i = nowPlayingIndex + 1;
                      if (i < playlist.getPlaylistLength()) {
                        nowPlayingIndex = i;
                        playSongFromPlaylist(i);
                        debugPrint("Next Song: $nowPlayingIndex");
                      }
                    },
                    icon: Icon(
                      Icons.skip_next,
                      size: 35,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  // REPEAT
                  IconButton(
                    onPressed: () {
                      repeatOn = !repeatOn;
                      setState(() {});
                    },
                    icon: !repeatOn
                        ? const Icon(
                            Icons.repeat,
                            size: 23,
                            color: Colors.white70,
                          )
                        : Icon(
                            Icons.repeat_one,
                            size: 23,
                            color: Colors.pink.shade300,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
