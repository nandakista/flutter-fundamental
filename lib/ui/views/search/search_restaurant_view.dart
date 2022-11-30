import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_final/core/constant/request_state.dart';
import 'package:submission_final/core/theme/app_style.dart';
import 'package:submission_final/ui/views/home/widgets/restaurant_item.dart';
import 'package:submission_final/ui/views/search/search_restataurant_provider.dart';
import 'package:submission_final/ui/widgets/content_wrapper.dart';
import 'package:submission_final/ui/widgets/sky_form_field.dart';
import 'package:submission_final/ui/widgets/sky_image.dart';

class SearchRestaurantView extends StatelessWidget {
  static const route = '/search';
  const SearchRestaurantView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<SearchRestaurantProvider>(context, listen: false)
          ..toInitial();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkyFormField(
              icon: Icons.search,
              hint: 'Search title',
              onFieldSubmitted: (query) {
                provider.onSearchRestaurant(query);
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: AppStyle.subtitle3,
            ),
            Consumer<SearchRestaurantProvider>(
              builder: (context, provider, child) {
                switch (provider.state) {
                  case RequestState.initial:
                    return const Expanded(
                      child: Center(
                        child: Text("Let's find the Restaurant"),
                      ),
                    );
                  case RequestState.empty:
                    return Expanded(
                      child: ContentWrapper(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          key: const Key('empty_message'),
                          children: [
                            const SkyImage(
                                url: 'assets/images/img_not_found.png'),
                            const SizedBox(height: 24),
                            Text(
                              'Oops..',
                              textAlign: TextAlign.center,
                              style: AppStyle.headline2,
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Restaurant Not Found',
                                textAlign: TextAlign.center,
                                style: AppStyle.subtitle4
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  case RequestState.loading:
                    return const Center(
                      child: CircularProgressIndicator(
                        key: Key('loading_indicator_state'),
                      ),
                    );
                  case RequestState.success:
                    return Expanded(
                      child: ListView.builder(
                        itemCount: provider.data.length,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          return RestaurantItem(
                            data: provider.data[index],
                          );
                        },
                      ),
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
          ],
        ),
      ),
    );
  }
}
