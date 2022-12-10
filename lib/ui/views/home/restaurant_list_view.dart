import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_final/core/constant/request_state.dart';
import 'package:submission_final/core/utils/notification_helper.dart';
import 'package:submission_final/core/theme/app_style.dart';
import 'package:submission_final/ui/views/detail/restaurant_detail_view.dart';
import 'package:submission_final/ui/views/favorite/favorite_view.dart';
import 'package:submission_final/ui/views/home/restaurant_list_provider.dart';
import 'package:submission_final/ui/views/home/widgets/restaurant_item.dart';
import 'package:submission_final/ui/views/search/search_restaurant_view.dart';
import 'package:submission_final/ui/views/settings/settings_view.dart';
import 'package:submission_final/ui/widgets/colored_status_bar.dart';
import 'package:submission_final/ui/widgets/content_wrapper.dart';
import 'package:submission_final/ui/widgets/keyboard_dismisser.dart';
import 'package:submission_final/ui/widgets/sky_form_field.dart';

class RestaurantListView extends StatefulWidget {
  static const route = '/home';

  const RestaurantListView({Key? key}) : super(key: key);

  @override
  State<RestaurantListView> createState() => _RestaurantListViewState();
}

class _RestaurantListViewState extends State<RestaurantListView> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailView.route);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      child: KeyboardDismisser(
        child: Scaffold(
          body: ContentWrapper(
            top: true,
            bottom: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Restaurant',
                      style: AppStyle.subtitle2,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, FavoriteView.route);
                      },
                      child: const Icon(CupertinoIcons.square_favorites),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SettingsView.route);
                      },
                      child: const Icon(CupertinoIcons.settings),
                    ),
                  ],
                ),
                Text(
                  'Lets find your favorite food...',
                  style: AppStyle.body1,
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    SearchRestaurantView.route,
                  ),
                  child: const SkyFormField(
                    icon: Icons.search,
                    hint: 'Search Restaurant',
                    enabled: false,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Consumer<RestaurantListProvider>(
                    builder: (context, provider, child) {
                      switch (provider.state) {
                        case RequestState.initial:
                          return Container();
                        case RequestState.empty:
                          return Center(
                            child: Text(
                              key: const Key('empty_message'),
                              provider.message,
                            ),
                          );
                        case RequestState.loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case RequestState.success:
                          return ListView.builder(
                            itemCount: provider.data.length,
                            itemBuilder: (context, index) {
                              return RestaurantItem(data: provider.data[index]);
                            },
                          );
                        case RequestState.error:
                          return Center(
                            child: Text(
                              key: const Key('error_message'),
                              provider.message,
                            ),
                          );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
