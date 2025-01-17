import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/presentation/pages/banner/banner_detail_page.dart';

class BannerWidget extends StatelessWidget {
  final List<Map<String, String>> banners;

  const BannerWidget({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: banners.map((banner) {
        return GestureDetector(
          onTap: () {
            Get.to(() => BannerDetailPage(
              title: banner['title']!,
              imageUrl: banner['image']!,
            ));
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  banner['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Text(
                  banner['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        height: 200,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 16 / 9,
        initialPage: 0,
      ),
    );
  }
}
