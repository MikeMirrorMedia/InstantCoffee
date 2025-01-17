import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readr_app/helpers/route_generator.dart';
import 'package:readr_app/models/record.dart';

class SearchListItem extends StatelessWidget {
  final Record record;
  const SearchListItem({
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double imageSize = 25 * (width - 32) / 100;

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    record.title,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                CachedNetworkImage(
                  height: imageSize,
                  width: imageSize,
                  imageUrl: record.photoUrl,
                  placeholder: (context, url) => Container(
                    height: imageSize,
                    width: imageSize,
                    color: Colors.grey,
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: imageSize,
                    width: imageSize,
                    color: Colors.grey,
                    child: const Icon(Icons.error),
                  ),
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
      onTap: () => RouteGenerator.navigateToStory(
        record.slug,
        isMemberCheck: record.isMemberCheck,
        url: record.url,
      ),
    );
  }
}
