

// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music/theme/colors.dart';


class MusicDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final Color color;
  final String img;
  final String songUrl;

  const MusicDetailPage(
      {Key key,
       this.title,
       this.description,
       this.color,
       this.img,
       this.songUrl})
      : super(key: key);

  @override
  _MusicDetailPageState createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  double _currentSliderValue = 20;

 AudioPlayer advancedPlayer;
 AudioCache audioCache;
  bool isPlayer = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }

  initPlayer(){
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
    playSound(widget.songUrl);
  }
  playSound(localPath) async{
    await audioCache.play(localPath);
  }
  stopSound(localPath) async{
    File audioFile = (await audioCache.load(localPath)) as File;
    await advancedPlayer.setUrl(audioFile.path);
    advancedPlayer.stop();
  }
  seekSound() async {
    File audioFile = (await audioCache.load(widget.songUrl)) as File;
    await advancedPlayer.setUrl(audioFile.path);
    advancedPlayer.seek(Duration(milliseconds: 2000),);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stopSound(widget.songUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: white,
            ),
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 20,
                ),
                child: Container(
                  width: size.width - 100,
                  height: size.width - 100,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: widget.color,
                        blurRadius: 50,
                        spreadRadius: 5,
                        offset: Offset(-10, 40),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 20,
                ),
                child: Container(
                  width: size.width - 60,
                  height: size.width - 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.img),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Container(
              width: size.width - 80,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.drive_folder_upload,
                    color: white,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 18,
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 150,
                        child: Text(
                          widget.description,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.more_vert,
                    color: white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Slider(
            activeColor: primary,
            value: _currentSliderValue,
            min: 0,
            max: 200,
            onChanged: (value) {
              setState(() {
                _currentSliderValue = value;
              });
              seekSound();
            },
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1:50',
                  style: TextStyle(
                    color: white.withOpacity(0.5),
                  ),
                ),
                Text(
                  '4:60',
                  style: TextStyle(
                    color: white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shuffle,
                    color: white.withOpacity(0.8),
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_previous,
                    color: white.withOpacity(0.8),
                    size: 30,
                  ),
                ),
                IconButton(
                  iconSize: 50,
                  onPressed: () {
                    if(isPlayer){
                      stopSound(widget.songUrl);
                      setState(() {
                        isPlayer = false;
                      });
                    }else{
                       playSound(widget.songUrl);
                      setState(() {
                        isPlayer = true;
                      });
                    }
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                      isPlayer ? Icons.stop : Icons.play_arrow,
                        color: white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_next,
                    color: white.withOpacity(0.8),
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.repeat,
                    color: white.withOpacity(0.8),
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.tv,
                color: primary,
                size: 20,
              ),
              SizedBox(width: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  'Chromecast is ready',
                  style: TextStyle(
                    color: primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
