import 'package:flutter/material.dart';
import 'package:submission_final/core/constant/constant.dart';
import 'package:submission_final/core/theme/app_style.dart';
import 'package:submission_final/ui/views/detail/restaurant_detail_view.dart';
import 'package:submission_final/ui/widgets/sky_box.dart';
import 'package:submission_final/ui/widgets/sky_image.dart';

import '../../../../domain/entities/restaurant.dart';
import '../../../widgets/rating_builder.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({Key? key, required this.data}) : super(key: key);

  final Restaurant data;

  @override
  Widget build(BuildContext context) {
    return SkyBox(
      margin: const EdgeInsets.symmetric(vertical: 4),
      elevation: 1,
      onPressed: () {
        Navigator.pushNamed(
          context,
          RestaurantDetailView.route,
          arguments: data,
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkyImage(
            url: '${Constant.baseUrlImage}/${data.pictureId}',
            height: 100,
            width: 100,
            borderRadius: BorderRadius.circular(12),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        data.name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.subtitle4
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Row(
                      children: [
                        const SkyImage(
                          url: 'assets/images/ic_location.png',
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(data.city.toString()),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    RatingBuilder(ratingValue: data.rating),
                    const SizedBox(width: 8),
                    Text('(${data.rating} / 5)')
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
