import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

enum ParagraphType {
  @JsonValue('header-one')
  headerOne,
  @JsonValue('header-two')
  headerTwo,
  @JsonValue('header-three')
  headerThree,
  @JsonValue('code-block')
  codeBlock,
  @JsonValue('unstyled')
  unStyled,
  @JsonValue('blockquote')
  blockQuote,
  @JsonValue('ordered-list-item')
  orderedListItem,
  @JsonValue('unordered-list-item')
  unorderedListItem,
  @JsonValue('image')
  image,
  @JsonValue('slideshow')
  slideShow,
  @JsonValue('slideshow-v2')
  slideShowV2,
  @JsonValue('youtube')
  youtube,
  @JsonValue('video')
  video,
  @JsonValue('audio')
  audio,
  @JsonValue('embeddedcode')
  embeddedCode,
  @JsonValue('infobox')
  infoBox,
  @JsonValue('annotation')
  annotation,
  @JsonValue('quoteBy')
  quoteBy,
  unKnow
}

