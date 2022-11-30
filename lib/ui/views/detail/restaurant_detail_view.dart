import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_final/core/constant/constant.dart';
import 'package:submission_final/core/constant/request_state.dart';
import 'package:submission_final/core/theme/app_style.dart';
import 'package:submission_final/domain/entities/restaurant.dart';
import 'package:submission_final/ui/views/detail/restaurant_detail_provider.dart';
import 'package:submission_final/ui/widgets/content_wrapper.dart';
import 'package:submission_final/ui/widgets/sky_box.dart';
import 'package:submission_final/ui/widgets/sky_image.dart';

class RestaurantDetailView extends StatefulWidget {
  static const route = '/detail';

  const RestaurantDetailView({Key? key, required this.restaurant})
      : super(key: key);

  final Restaurant restaurant;

  @override
  State<RestaurantDetailView> createState() => _RestaurantDetailViewState();
}

class _RestaurantDetailViewState extends State<RestaurantDetailView> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<RestaurantDetailProvider>(context, listen: false)
          .loadData(widget.restaurant.id.toString());
      Provider.of<RestaurantDetailProvider>(context, listen: false)
          .loadFavoriteExistStatus(widget.restaurant.id.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.restaurant.name.toString())),
      bottomNavigationBar: SafeArea(
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, provider, child) {
            if (provider.detailState == RequestState.success) {
              provider.hasAddedToFavorite;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (provider.hasAddedToFavorite == false) {
                      await provider.addFavorite(provider.detailData);
                    } else {
                      await provider.removeFromFavorite(provider.detailData);
                    }
                    if (mounted) {
                      _buildAlertSnackBar(context, provider.favoriteMessage);
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        provider.hasAddedToFavorite ? Icons.check : Icons.add,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Favorite',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Consumer<RestaurantDetailProvider>(
              builder: (context, provider, child) {
                switch (provider.detailState) {
                  case RequestState.initial:
                    return const CircularProgressIndicator();
                  case RequestState.empty:
                    return Text(
                      key: const Key('empty_message'),
                      provider.message,
                    );
                  case RequestState.loading:
                    return const CircularProgressIndicator();
                  case RequestState.success:
                    final data = provider.detailData;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkyImage(
                          url: '${Constant.baseUrlImage}/${data.pictureId}',
                          height: 300,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ContentWrapper(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${data.name}',
                                    style: AppStyle.subtitle2,
                                  ),
                                  Row(
                                    children: [
                                      const SkyImage(
                                        url: 'assets/images/ic_star.svg',
                                        height: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${data.rating}',
                                        style: AppStyle.headline4,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const SkyImage(
                                    url: 'assets/images/ic_location.png',
                                    height: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${data.city}',
                                    style: AppStyle.body1
                                        .copyWith(fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      const SkyImage(
                                        url: 'assets/images/ic_food.png',
                                        height: 36,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${data.menus?.drinks?.length} Foods',
                                        style: AppStyle.body1.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Row(
                                    children: [
                                      const SkyImage(
                                        url: 'assets/images/ic_drink.png',
                                        height: 36,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${data.menus?.drinks?.length} Drinks',
                                        style: AppStyle.body1.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '${data.description}',
                                textAlign: TextAlign.justify,
                                style: AppStyle.body1.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ContentWrapper(
                          child: Text(
                            'Menu',
                            textAlign: TextAlign.justify,
                            style: AppStyle.subtitle3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ContentWrapper(
                          child: Text(
                            'Drinks',
                            textAlign: TextAlign.justify,
                            style: AppStyle.subtitle4.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 4,
                          ),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              data.menus?.drinks?.length ?? 0,
                              (index) {
                                final item = data.menus?.drinks?[index];
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: SkyBox(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 16,
                                    ),
                                    borderRadius: 8,
                                    child: Center(child: Text('${item?.name}')),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ContentWrapper(
                          child: Text(
                            'Foods',
                            textAlign: TextAlign.justify,
                            style: AppStyle.subtitle4.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 4,
                          ),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              data.menus?.drinks?.length ?? 0,
                              (index) {
                                final item = data.menus?.drinks?[index];
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: SkyBox(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 16,
                                    ),
                                    borderRadius: 8,
                                    child: Center(child: Text('${item?.name}')),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  case RequestState.error:
                    return Text(
                      key: const Key('error_message'),
                      provider.message,
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildAlertSnackBar(BuildContext context, String message) {
    if (message == 'Added to Favorite' ||
        message == 'Removed from Favorite') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
          );
        },
      );
    }
  }
}
