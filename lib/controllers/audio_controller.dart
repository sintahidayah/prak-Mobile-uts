import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';

class AudioController extends GetxController {
  var isPlaying = false.obs;
  var currentAyah = 0.obs;
  var currentTime = Duration.zero.obs;
  var totalDuration = Duration(minutes: 3, seconds: 45).obs;
  var playbackSpeed = 1.0.obs;

  void playPause() {
    isPlaying.value = !isPlaying.value;
    // Di sini nanti integrate dengan just_audio package
  }

  void playAyah(int ayahNumber) {
    currentAyah.value = ayahNumber;
    isPlaying.value = true;
    // Play audio untuk ayah tertentu
  }

  void nextAyah() {
    currentAyah.value++;
    playAyah(currentAyah.value);
  }

  void previousAyah() {
    if (currentAyah.value > 0) {
      currentAyah.value--;
      playAyah(currentAyah.value);
    }
  }

  void seek(Duration position) {
    currentTime.value = position;
    // Seek audio to position
  }

  void changeSpeed(double speed) {
    playbackSpeed.value = speed;
    // Change audio playback speed
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

// Widget Audio Player
Widget buildAudioPlayer(AudioController audioController) {
  return Obx(() => Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Reciter',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Mishary Rashid', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  iconSize: 40,
                  onPressed: () => audioController.previousAyah(),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () => audioController.playPause(),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [AppColors.green, Color(0xFF00856F)]),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      audioController.isPlaying.value
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  iconSize: 40,
                  onPressed: () => audioController.nextAyah(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                    audioController
                        .formatDuration(audioController.currentTime.value),
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                Expanded(
                  child: Slider(
                    value:
                        audioController.currentTime.value.inSeconds.toDouble(),
                    max: audioController.totalDuration.value.inSeconds
                        .toDouble(),
                    activeColor: AppColors.green,
                    inactiveColor: Colors.grey[800],
                    onChanged: (value) =>
                        audioController.seek(Duration(seconds: value.toInt())),
                  ),
                ),
                Text(
                    audioController
                        .formatDuration(audioController.totalDuration.value),
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.speed, size: 20, color: Colors.grey),
                    SizedBox(width: 5),
                    DropdownButton<double>(
                      value: audioController.playbackSpeed.value,
                      dropdownColor: AppColors.cardBackground,
                      underline: SizedBox(),
                      items: [0.5, 0.75, 1.0, 1.25, 1.5, 2.0]
                          .map((speed) => DropdownMenuItem(
                              value: speed, child: Text('${speed}x')))
                          .toList(),
                      onChanged: (value) => audioController.changeSpeed(value!),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.repeat, size: 20), onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.shuffle, size: 20), onPressed: () {}),
                  ],
                ),
              ],
            ),
          ],
        ),
      ));
}
