import 'package:complete_advanced_flutter/data/network/error_handler.dart';
import 'package:complete_advanced_flutter/data/responses/home/home.dart';

const cachedHomeKey = "CACHED_HOME_KEY";
const cachedHomeInterval = 60 * 1000; // 1 minute interval

abstract class LocalDataSource {
  HomeResponse getHome();

  Future<void> saveHomeToCached(HomeResponse homeResponse);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {

  Map<String, CachedItem> cachedMap = {};

  @override
  HomeResponse getHome() {
    CachedItem? homeData = cachedMap[cachedHomeKey];
    if(homeData != null){
      return homeData.data;
    }else{
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveHomeToCached(HomeResponse homeResponse) async {
    cachedMap[cachedHomeKey] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
   cachedMap.clear();
  }

  @override
  void removeFromCache(String key) {
     cachedMap.remove(key);
  }
}

class CachedItem {
  dynamic data;
  int cachedTime = DateTime
      .now()
      .microsecondsSinceEpoch;

  CachedItem(this.data);


}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    // 60 secs
    int currentTimeStamp = DateTime.now().microsecondsSinceEpoch;
    bool isCachedValid = currentTimeStamp - expirationTime < cachedTime;
    return isCachedValid;
  }
}
