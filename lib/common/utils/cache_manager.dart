import 'package:file/local.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static const key = 'customCacheKey';

  static CacheManager instance = CacheManager(
    Config(
      key,
      // 缩短缓存时间，避免占用过多文件描述符
      stalePeriod: const Duration(hours: 3),
      // 严格限制缓存数量，防止文件描述符泄漏
      maxNrOfCacheObjects: 30,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileSystem: IOFileSystem(key),
      fileService: HttpFileService(),
    ),
  );

  static Future<double> cacheSize() async {
    var baseDir = await getTemporaryDirectory();
    var path = p.join(baseDir.path, key);

    var fs = const LocalFileSystem();
    var directory = fs.directory((path));
    return (await directory.stat()).size / 8 / 1000;
  }

  static Future<void> clearCache() async {
    var baseDir = await getTemporaryDirectory();
    var path = p.join(baseDir.path, key);

    var fs = const LocalFileSystem();
    var directory = fs.directory((path));
    await directory.delete(recursive: true);
  }
}
