import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readr_app/blocs/externalStory/cubit.dart';
import 'package:readr_app/helpers/data_constants.dart';
import 'package:readr_app/helpers/environment.dart';
import 'package:readr_app/pages/storyPage/external/external_story_widget.dart';
import 'package:readr_app/services/external_story_service.dart';
import 'package:share_plus/share_plus.dart';

class ExternalStoryPage extends StatelessWidget {
  final String slug;
  final bool isPremiumMode;
  const ExternalStoryPage(
      {Key? key, required this.slug, required this.isPremiumMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'share',
            onPressed: () {
              Share.share(
                  '${Environment().config.mirrorMediaDomain}/external/$slug');
            },
          )
        ],
      ),
      body: BlocProvider(
        create: (BuildContext context) =>
            ExternalStoryCubit(externalStoryRepos: ExternalStoryService()),
        child: ExternalStoryWidget(slug: slug, isPremiumMode: isPremiumMode),
      ),
    );
  }
}
