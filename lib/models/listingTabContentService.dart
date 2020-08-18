import 'package:readr_app/helpers/apiBaseHelper.dart';
import 'package:readr_app/models/recordList.dart';

class ListingTabContentService {
  ApiBaseHelper _helper = ApiBaseHelper();

  String nextPage = '';

  Future<RecordList> fetchRecordList(String url) async {
    final jsonResponse = await _helper.getByUrl(url);
    var jsonObject = jsonResponse['items'];
    nextPage = url + '&pageToken=' + jsonResponse['nextPageToken'];
    RecordList records = RecordList.fromListingJson(jsonObject);
    return records;
  }

  String getNext() {
    return this.nextPage;
  }
}
