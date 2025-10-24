import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pure_live/common/utils/cache_manager.dart';
import 'dart:developer' as developer;

class CacheNetWorkUtils {
  static Widget getCacheImage(String imageUrl,
      {double radius = 0.0, required Widget errorWidget, bool full = false}) {
    return imageUrl.isNotEmpty
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            cacheManager: CustomCacheManager.instance,
            placeholder: (context, url) => const CircularProgressIndicator(
                  color: Colors.white,
                ),
            errorWidget: (context, error, stackTrace) {
              // 记录图片加载错误，帮助排查问题
              developer.log(
                '❌ 图片加载失败\n'
                '🔗 URL: $imageUrl\n'
                '⚠️ 错误: $error',
                name: 'CacheNetwork',
                error: error,
              );
              return errorWidget;
            },
            imageBuilder: (context, image) => full == false
                ? CircleAvatar(
                    foregroundImage: image,
                    radius: radius,
                    backgroundColor: Theme.of(context).disabledColor,
                  )
                : Image(image: image),
            // 添加重试机制，图片加载失败后自动重试
            maxHeightDiskCache: 300,
            maxWidthDiskCache: 300,
          )
        : errorWidget;
  }
}
