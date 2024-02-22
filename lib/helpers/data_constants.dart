

const homePageTag = 'Home Page';
const latestPageTag = 'Latest News';

const appTitle = "鏡週刊";
const searchPageTitle = '搜尋';
const personalPageTitle = '個人專屬頁面';
const settingPageTitle = '設定';
const settingPageDescription = '通知設定 - 啟用推播通知，搶先收到重要新聞以及你感興趣的內容更新';
const moreContentHtml =
    '<p>更多內容，歡迎訂閱<a href="https://docs.google.com/forms/d/e/1FAIpQLSeqbPjhSZx63bDWFO298acE--otet1s4-BGOmTKyjG1E4t4yQ/viewform">鏡週刊紙本雜誌</a>、<a href="https://www.mirrormedia.mg/story/webauthorize/">了解內容授權資訊</a>。</p>';

const Map<String, int> sectionColorMaps = {
  'news': 0xff30BAC8,
  'entertainment': 0xffBF3284,
  'businessmoney': 0xff009045,
  'people': 0xffEFA256,
  'videohub': 0xff969696,
  'international': 0xff911F27,
  'foodtravel': 0xffEAC151,
  'mafalda': 0xff662D8E,
  'culture': 0xff009245,
  'carandwatch': 0xff003153,
  'external': 0xffFB9D18,
};

/// assets
const String splashIconPng = 'assets/image/splash.png';
const String premiumIconPng = 'assets/image/premiumIcon.png';
const String premiumTextPng = 'assets/image/premiumText.png';
const String magazineDownloadIconPng =
    'assets/image/magazine/magazineDownloadIcon.png';
const String hamiPng = 'assets/image/magazine/hami.png';
const String konoPng = 'assets/image/magazine/kono.png';
const String myBookPng = 'assets/image/magazine/my_book.png';
const String pubuPng = 'assets/image/magazine/pubu.png';
const String readmooPng = 'assets/image/magazine/readmoo.png';
const String subscriptionIconPng = 'assets/image/member/subscription_icon.png';
const String subscribeBannerJpg = 'assets/image/member/subscribe_banner_mobile.jpg';
const String lineIconPng = 'assets/image/line_icon.png';
const String igIconPng = 'assets/image/ig_icon.png';
const String ytIconPng = 'assets/image/yt_icon.png';
const String bookIconSvg = 'assets/image/magazine/book_icon.svg';

// online magazine URL
const String hamiMagazineURL =
    'https://bookstore.emome.net/Searchs/finish/keyword:%E9%8F%A1%E9%80%B1%E5%88%8A';
const String myBookMagazineURL =
    'https://mybook.taiwanmobile.com/search?publisher=%E9%8F%A1%E9%80%B1%E5%88%8A';
const String pubuMagazineURL =
    'https://www.pubu.com.tw/magazine-list/%E9%8F%A1%E9%80%B1%E5%88%8A-773';
const String readmooMagazineURL =
    'https://readmoo.com/mag/248?header_v2_subject_category';
const String konoMagazineAURL =
    'https://www.thekono.com/magazines/mirrormedia_a';
const String konoMagazineBURL =
    'https://www.thekono.com/magazines/mirrormedia_b';

const bool isTabContentAdsActivated = true;
const bool isListeningTabContentAdsActivated = true;
// AT index in tab content(carousel)
const int carouselAT1AdIndex = 0;
const int carouselAT2AdIndex = 4;
const int carouselAT3AdIndex = 9;
// AT index in tab content(no carousel)
const int noCarouselAT1AdIndex = 1;
const int noCarouselAT2AdIndex = 5;
const int noCarouselAT3AdIndex = 10;

const bool isStoryWidgetAdsActivated = true;
const bool isListeningWidgetAdsActivated = true;
// AT index in story
const int storyAT1AdIndex = 1;
const int storyAT2AdIndex = 5;

const String mirrorMediaServiceEmail = 'MM-onlineservice@mirrormedia.mg';
const mirrormediaGroupDomain = [
  'mnews.com.tw',
  'mnews.tw',
  'mirrormedia.mg',
  'mirrorfiction.com'
];

//election
const kmtLogoSvg = 'assets/image/election/kmt.svg';
const dppLogoSvg = 'assets/image/election/dpp.svg';
const tppLogoSvg = 'assets/image/election/tpp.svg';
const noPartySvg = 'assets/image/election/noParty.svg';
const electedSvg = 'assets/image/election/elected.svg';

const Map<String, String> partyLogoMap = {
  '國民黨': kmtLogoSvg,
  '中國國民黨': kmtLogoSvg,
  '民進黨': dppLogoSvg,
  '民主進步黨': dppLogoSvg,
  '民眾黨': tppLogoSvg,
  '台灣民眾黨': tppLogoSvg,
  '無黨籍': noPartySvg,
  '無': noPartySvg,
};

// misc
const String articleDateTimePostfix = '臺北時間';

// use same login as browser,
// ref: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/email#basic_validation
const String validEmailPattern =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
