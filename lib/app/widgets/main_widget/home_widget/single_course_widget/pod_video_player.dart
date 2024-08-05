import 'package:pod_player/pod_player.dart';
import 'package:flutter/material.dart';
import 'package:webinar/common/common.dart';

// ignore: must_be_immutable
class VimeoVideoPlayer extends StatefulWidget {
  String type;
  String url;
  VimeoVideoPlayer(this.url,this.type,{Key? key}) : super(key: key);

  @override
  State<VimeoVideoPlayer> createState() => _VimeoVideoPlayerState();
}

class _VimeoVideoPlayerState extends State<VimeoVideoPlayer> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: widget.type == 'vimeo'
        ? PlayVideoFrom.vimeo(
            widget.url.split('/').last,
          )
        : widget.type == 'youtube'
            ? PlayVideoFrom.youtube(
                widget.url,
              )
            : PlayVideoFrom.network(
                widget.url,
              ),

    )..initialise().then((value){
      setState(() {
        
      });
    });
    
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ClipRRect(
        borderRadius: borderRadius(),
        child: SizedBox(
          width: getSize().width,
          child: PodVideoPlayer(controller: controller),
        ),
      ),
    );
  }
}