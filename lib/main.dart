// ignore_for_file: camel_case_types, non_constant_identifier_names
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      home: musicplayer(),
    );
  }
}

class musicplayer extends StatefulWidget {
  const musicplayer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _musicplayerstate createState() => _musicplayerstate();
}

class _musicplayerstate extends State<musicplayer> {
  // Button Variable for changing
  bool music_playing = false;
  IconData music_playbtn = Icons.play_arrow;

  // Music Player Functionality

  late AudioPlayer a_player;
  late AudioCache a_cache;

  Duration position = const Duration();
  Duration lengthofmusic = const Duration();

  // Slider for the Application

  Widget slider() {
    return Slider.adaptive(
        activeColor: Colors.black,
        inactiveColor: Colors.grey.shade400,
        value: position.inSeconds.toDouble(),
        max: lengthofmusic.inSeconds.toDouble(),
        onChanged: ((value) {
          seeking(value.toInt());
        }));
  }

  // Function that create a certain position of music
  void seeking(int sec) {
    Duration position_new = Duration(seconds: sec);
    a_player.seek(position_new);
  }

  @override
  void initState() {
    super.initState();
    a_player = AudioPlayer();
    a_cache = AudioCache(fixedPlayer: a_player);

    a_player.onDurationChanged.listen((duration) {
      setState(() {
        lengthofmusic = duration;
      });
    });

    a_player.onAudioPositionChanged.listen((position) {
      setState(() {
        this.position = position;
      });
    });

    a_cache.load("t.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.white10,
              Colors.blue.shade200,
            ])),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 48.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  "Code-Clause Music Player",
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Unleash Your Music Experience",
                  style: TextStyle(
                    color: Colors.red.shade600,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Center(
                child: Container(
                  width: 280.0,
                  height: 280.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      image: const DecorationImage(
                        image: AssetImage("assets/unnamed.png"),
                      )),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              const Center(
                child: Text(
                  "Jack Sparrow Theme",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 1000.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              ("${position.inMinutes}: ${position.inSeconds.remainder(60)}")),
                          slider(),
                          Text(
                              ("${lengthofmusic.inMinutes}: ${lengthofmusic.inSeconds.remainder(60)}")),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 45.0,
                          color: Colors.black,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_previous,
                          ),
                        ),
                        IconButton(
                          iconSize: 62.0,
                          color: Colors.black,
                          onPressed: () {
                            if (!music_playing) {
                              a_cache.play("t.mp3");
                              setState(() {
                                music_playbtn = Icons.pause;
                                music_playing = true;
                              });
                            } else {
                              setState(() {
                                a_player.pause();
                                music_playbtn = Icons.play_arrow;
                                music_playing = false;
                              });
                            }
                          },
                          icon: Icon(
                            music_playbtn,
                          ),
                        ),
                        IconButton(
                          iconSize: 45.0,
                          color: Colors.black,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_next,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}


// video stopped at 7.52
