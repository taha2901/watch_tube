import 'package:flutter/material.dart';
import 'package:watch_it/widgets/control_btn.dart';
import 'package:watch_it/models/vedio_items_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerScreen extends StatefulWidget {
  final VideoItem video;
  const PlayerScreen({super.key, required this.video});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late YoutubePlayerController _controller;
  bool _isMuted = false;
  double _playbackSpeed = 1.0;
  final List<double> _speeds = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

  final List<VideoItem> _playlist = List.from(kVideos);
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = _playlist.indexWhere(
      (v) => v.videoId == widget.video.videoId,
    );
    if (_currentIndex < 0) _currentIndex = 0;
    _initController(_playlist[_currentIndex].videoId);
  }

  void _initController(String videoId) {
    _controller = YoutubePlayerController(
      initialVideoId: videoId, 
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        enableCaption: false,
      ),
    );
  }

  void _loadVideo(int index) {
    setState(() => _currentIndex = index);
    // ✅ بنبعت videoId للـ controller مش id الخام
    _controller.load(_playlist[index].videoId);
  }

  void _toggleMute() {
    setState(() => _isMuted = !_isMuted);
    _isMuted ? _controller.mute() : _controller.unMute();
  }

  void _changeSpeed(double speed) {
    setState(() => _playbackSpeed = speed);
    _controller.setPlaybackRate(speed);
    Navigator.pop(context);
  }

  VideoItem get _currentVideo => _playlist[_currentIndex];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: const Color(0xFFFF3B3B),
        progressColors: const ProgressBarColors(
          playedColor: Color(0xFFFF3B3B),
          handleColor: Color(0xFFFF6B35),
          bufferedColor: Colors.white24,
          backgroundColor: Colors.white12,
        ),
        bottomActions: [
          const CurrentPosition(),
          const ProgressBar(isExpanded: true),
          const RemainingDuration(),
          FullScreenButton(),
        ],
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0F),
          body: Column(
            children: [
              player,
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title & Channel
                      Text(
                        _currentVideo.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _currentVideo.channel,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white38,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ControlBtn(
                            icon: _isMuted
                                ? Icons.volume_off_rounded
                                : Icons.volume_up_rounded,
                            label: _isMuted ? 'رفع الصوت' : 'كتم الصوت',
                            isActive: _isMuted,
                            onTap: _toggleMute,
                          ),
                          ControlBtn(
                            icon: Icons.speed_rounded,
                            label: '${_playbackSpeed}x',
                            onTap: () => _showSpeedSheet(context),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // Playlist Header
                      Row(
                        children: [
                          const Text(
                            'قائمة التشغيل',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${_currentIndex + 1} / ${_playlist.length}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white38,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Playlist Items
                      ...List.generate(_playlist.length, (i) {
                        final v = _playlist[i];
                        final isPlaying = i == _currentIndex;

                        return GestureDetector(
                          onTap: () => _loadVideo(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isPlaying
                                  ? const Color(0xFFFF3B3B).withOpacity(0.15)
                                  : const Color(0xFF141420),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isPlaying
                                    ? const Color(0xFFFF3B3B).withOpacity(0.5)
                                    : Colors.white.withOpacity(0.05),
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 28,
                                  child: isPlaying
                                      ? const Icon(
                                          Icons.equalizer_rounded,
                                          color: Color(0xFFFF3B3B),
                                          size: 18,
                                        )
                                      : Text(
                                          '${i + 1}',
                                          style: const TextStyle(
                                            color: Colors.white38,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                                // ✅ thumbnail بتستخدم videoId تلقائياً
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    v.thumbnail,
                                    width: 72,
                                    height: 46,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 72,
                                      height: 46,
                                      color: const Color(0xFF1E1E2E),
                                      child: const Icon(
                                        Icons.play_circle_outline,
                                        color: Colors.white24,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        v.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: isPlaying
                                              ? const Color(0xFFFF3B3B)
                                              : Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        v.channel,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.white38,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  v.duration,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white38,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSpeedSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF141420),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'سرعة التشغيل',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
          ..._speeds.map(
            (s) => ListTile(
              onTap: () => _changeSpeed(s),
              title: Text(
                s == 1.0 ? 'عادي (1x)' : '${s}x',
                style: TextStyle(
                  color: s == _playbackSpeed
                      ? const Color(0xFFFF3B3B)
                      : Colors.white,
                  fontWeight: s == _playbackSpeed
                      ? FontWeight.w700
                      : FontWeight.w400,
                ),
              ),
              trailing: s == _playbackSpeed
                  ? const Icon(Icons.check_rounded, color: Color(0xFFFF3B3B))
                  : null,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}