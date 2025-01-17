import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readr_app/models/record.dart';

class PremiumListItem extends StatelessWidget {
  final Record record;
  final GestureTapCallback? onTap;
  const PremiumListItem({
    required this.record,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double imageWidth = width / 2 - 4;
    double imageHeight = imageWidth / 1.6;

    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            width: imageWidth,
            height: imageHeight,
            imageUrl: record.photoUrl,
            placeholder: (context, url) => Container(
              width: imageWidth,
              height: imageHeight,
              color: Colors.grey,
            ),
            errorWidget: (context, url, error) => Container(
              width: imageWidth,
              height: imageHeight,
              color: Colors.grey,
              child: const Icon(Icons.error),
            ),
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              record.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
