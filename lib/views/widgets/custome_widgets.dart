import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconsax/flutter_iconsax.dart';

class CustomeNetworkImage extends StatelessWidget {
  const CustomeNetworkImage({
    super.key,
    required this.data,
    this.fill = false,
  });

  final String data;
  final bool fill;


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fill ? BoxFit.fill : BoxFit.cover,
      imageUrl: data,
      placeholder: (context, url) => Container(
        color: Colors.blueGrey,
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Iconsax.box_remove),
      ),
    );
  }
}
