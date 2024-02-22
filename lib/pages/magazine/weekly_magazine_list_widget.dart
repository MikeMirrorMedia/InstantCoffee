import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readr_app/core/values/colors.dart';
import 'package:readr_app/helpers/data_constants.dart';
import 'package:readr_app/helpers/route_generator.dart';
import 'package:readr_app/models/magazine.dart';
import 'package:readr_app/models/magazine_list.dart';
import 'package:readr_app/pages/magazine/magazine_item_widget.dart';
import 'package:readr_app/pages/magazine/magazine_list_label.dart';
import 'package:readr_app/widgets/custom_cached_network_image.dart';

import '../../core/values/string.dart';

class WeeklyMagazineListWidget extends StatefulWidget {
  final MagazineList magazineList;

  const WeeklyMagazineListWidget({
    required this.magazineList,
  });

  @override
  _WeeklyMagazineListWidgetState createState() =>
      _WeeklyMagazineListWidgetState();
}

class _WeeklyMagazineListWidgetState extends State<WeeklyMagazineListWidget> {
  late List<Magazine> _currentMagazineList;
  late List<Magazine> _remainMagazineList;

  @override
  void initState() {
    _currentMagazineList = getCurrentMagazineList(widget.magazineList);
    _remainMagazineList = getRemainMagazineList(widget.magazineList);
    super.initState();
  }

  List<Magazine> getCurrentMagazineList(MagazineList magazineList) {
    if (magazineList.length < 2) {
      return magazineList;
    }
    return magazineList.sublist(0, 2);
  }

  List<Magazine> getRemainMagazineList(MagazineList magazineList) {
    if (magazineList.length < 3) {
      return [];
    }
    return magazineList.sublist(2, magazineList.length);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        if (_currentMagazineList.isNotEmpty)
          const MagazineListLabel(label: '當期雜誌'),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) => Container(
                  height: 4,
                  color: const Color.fromRGBO(248, 248, 249, 1),
                ),
            itemCount: _currentMagazineList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 24.0, right: 24, top: 20, bottom: 16),
                child: _buildTheFirstMagazine(
                    context, width, 24, _currentMagazineList[index]),
              );
            }),
        if (_remainMagazineList.isNotEmpty)
          const MagazineListLabel(
            label: '近期雜誌',
          ),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) => Container(
                  height: 4,
                  color: const Color.fromRGBO(248, 248, 249, 1),
                ),
            itemCount: _remainMagazineList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24,
                ),
                child: MagazineItemWidget(
                  magazine: _remainMagazineList[index],
                ),
              );
            }),
      ],
    );
  }

  Widget _displayMagazineImage(
      double imageWidth, double imageHeight, Magazine magazine) {
    return CustomCachedNetworkImage(
        height: imageHeight,
        width: imageWidth,
        imageUrl: magazine.photoUrl ?? StringDefault.valueNullDefault);
  }

  Widget _buildTheFirstMagazine(
      BuildContext context, double width, double padding, Magazine magazine) {
    double imageWidth = (width - padding * 2) / 2.5;
    double imageHeight = imageWidth / 0.75;

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
        height: imageHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _displayMagazineImage(imageWidth, imageHeight, magazine),
            SizedBox(
              width: MediaQuery.of(context).size.width - 48 - imageWidth - 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    magazine.issue ?? StringDefault.valueNullDefault,
                    style: const TextStyle(
                      fontSize: 15,
                      color: appColor,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(height: 8.0),
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                      text: magazine.title,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(top: 12, bottom: 16),
        child: Divider(
          height: 1,
          thickness: 1,
          color: Colors.black12,
        ),
      ),
      TextButton.icon(
          icon: SvgPicture.asset(
            bookIconSvg,
            color: appColor,
            width: 16,
            height: 14,
          ),
          label: const Text(
            '線上閱讀',
            style: TextStyle(
              fontSize: 15,
              color: appColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          onPressed: () => RouteGenerator.navigateToMagazineBrowser(magazine)),
    ]);
  }
}
