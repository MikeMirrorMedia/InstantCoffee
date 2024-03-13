import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readr_app/core/extensions/duration_extension.dart';
import 'package:readr_app/core/values/string.dart';
import 'package:readr_app/data/enum/playback_status.dart';
import 'package:readr_app/data/enum/podcast_panel_status.dart';
import 'package:readr_app/models/podcast_info/podcast_info.dart';
import 'package:readr_app/pages/tabContent/podcast_tab_content/widgets/podcast_sticky_panel/podcast_sticky_panel_controller.dart';

class PodcastStickyPanel extends GetView<PodcastStickyPanelController> {
  const PodcastStickyPanel(
      {Key? key, required this.height, this.podcastInfo, required this.width})
      : super(key: key);
  final double height;
  final double width;
  final PodcastInfo? podcastInfo;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<PodcastStickyPanelController>()) {
      Get.put(PodcastStickyPanelController());
    }
    return Container(
      width: width,
      height: height,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              podcastInfo?.title ?? StringDefault.valueNullDefault,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Noto Sans TC',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.white),
              overflow: TextOverflow.ellipsis, // 超出部分顯示省略號
              maxLines: 1, // 只顯示一行
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 52,
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: controller.playButtonClick,
                  child: Obx(() {
                    final status = controller.rxPodcastPanelStatus.value;
                    return Image.asset(
                      status == PodcastPanelStatus.play
                          ? 'assets/image/podcast/podcast_panel_stop_icon.png'
                          : 'assets/image/podcast/podcast_panel_play_icon.png',
                      width: 22,
                      height: 22,
                    );
                  }),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 16,
                  width: 98,
                  child: Obx(() {
                    final position = controller.rxPosition.value;
                    final duration = controller.rxDuration.value;
                    return Text(
                        '${position.toFormattedString()} / ${duration.toFormattedString()}',
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Colors.white));
                  }),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(() {
                    final duration = controller.rxDuration.value;
                    final pos = controller.rxPosition.value;
                    return SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          trackHeight: 4,
                          trackShape: const CustomSliderTrackShape(),
                          thumbColor: Colors.transparent,
                          thumbShape: SliderComponentShape.noThumb),
                      child: Slider(
                        value: pos.inSeconds.toDouble(),
                        activeColor: Get.theme.primaryColor,
                        inactiveColor: Colors.white,
                        onChanged: controller.slideBarValueChangeEvent,
                        max: duration.inSeconds.toDouble(),
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: controller.volumeButtonClick,
                  child: Obx(() {
                    final isMute = controller.rxIsMute.value;
                    return Image.asset(
                      isMute
                          ? 'assets/image/podcast/volume_mute.png'
                          : 'assets/image/podcast/volume.png',
                      width: 22,
                      height: 22,
                    );
                  }),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: controller.playbackRateButtonClick,
                  child: Obx(() {
                    final status = controller.rxPlaybackRate.value;
                    return SizedBox(
                      width: 30,
                      child: Text(
                        status.displayValue,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  const CustomSliderTrackShape();

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
