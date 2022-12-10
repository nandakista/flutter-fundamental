import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_final/core/constant/request_state.dart';
import 'package:submission_final/core/utils/route_observer.dart';
import 'package:submission_final/core/theme/app_style.dart';
import 'package:submission_final/ui/views/favorite/favorite_provider.dart';
import 'package:submission_final/ui/views/home/widgets/restaurant_item.dart';
import 'package:submission_final/ui/widgets/content_wrapper.dart';
import 'package:submission_final/ui/widgets/sky_image.dart';

class FavoriteView extends StatefulWidget {
  static const route = '/favorite';

  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> with RouteAware {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<FavoriteProvider>(context, listen: false).loadData();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<FavoriteProvider>(context, listen: false).loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Restaurant')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<FavoriteProvider>(
            builder: (context, provider, child) {
              switch (provider.state) {
                case RequestState.initial:
                  return Container();
                case RequestState.empty:
                  return ContentWrapper(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      key: const Key('empty_message'),
                      children: [
                        const SkyImage(url: 'assets/images/img_error.png'),
                        const SizedBox(height: 24),
                        Text(
                          'Oops..',
                          textAlign: TextAlign.center,
                          style:
                              AppStyle.headline2.copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Empty Favorite',
                            textAlign: TextAlign.center,
                            style: AppStyle.subtitle4
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
