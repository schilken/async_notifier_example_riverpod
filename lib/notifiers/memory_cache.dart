import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemoryCache {
  String _cachedValue = '';

  bool get hasCachedData => _cachedValue.isNotEmpty;

  void saveCacheData(String data) {
    print('saveCacheData: $data');
    _cachedValue = data;
  }

  String get cachedData => _cachedValue;

  void clear() {
    _cachedValue = '';
  }
}

final cacheProvider = Provider((ref) => MemoryCache());
