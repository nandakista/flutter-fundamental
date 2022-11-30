import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:submission_final/core/constant/request_state.dart';
import 'package:submission_final/domain/entities/restaurant.dart';
import 'package:submission_final/ui/views/home/restaurant_list_provider.dart';
import 'package:submission_final/ui/views/home/restaurant_list_view.dart';

import 'restaurant_list_view_test.mocks.dart';

@GenerateMocks([RestaurantListProvider])
void main() {
  late MockRestaurantListProvider mockProvider;

  setUp(() => mockProvider = MockRestaurantListProvider());

  final tRestaurantList = [
    const Restaurant(
      id: 'rqdv5juczeskfw1e867',
      name: 'Melting Pot',
      pictureId: '14',
      description: 'description',
      city: 'Medan',
      rating: 4.2,
    ),
  ];

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<RestaurantListProvider>.value(
      value: mockProvider,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('''Should display loading indicator when loading state''',
      (widgetTester) async {
    // Arrange
    when(mockProvider.state).thenReturn(RequestState.loading);
    // Act
    final progressBarFinder = find.byType(CircularProgressIndicator);
    await widgetTester
        .pumpWidget(makeTestableWidget(const RestaurantListView()));
    // Assert
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('''Should display Text with error message when error state''',
      (WidgetTester tester) async {
    // Arrange
    when(mockProvider.state).thenReturn(RequestState.error);
    when(mockProvider.message).thenReturn('Error message');
    // Act
    final textFinder = find.byKey(const Key('error_message'));
    await tester.pumpWidget(makeTestableWidget(const RestaurantListView()));
    // Assert
    expect(textFinder, findsOneWidget);
  });

  testWidgets('''Should display Text with empty message when empty state''',
      (WidgetTester tester) async {
    // Arrange
    when(mockProvider.state).thenReturn(RequestState.empty);
    when(mockProvider.data).thenReturn(<Restaurant>[]);
    when(mockProvider.message).thenReturn('Empty message');
    // Act
    final textFinder = find.byKey(const Key('empty_message'));
    await tester.pumpWidget(makeTestableWidget(const RestaurantListView()));
    // Assert
    expect(textFinder, findsOneWidget);
  });

  testWidgets('Should display ListView when state is success',
      (WidgetTester tester) async {
    // Arrange
    when(mockProvider.state).thenReturn(RequestState.success);
    when(mockProvider.data).thenReturn(tRestaurantList);
    // Act
    final listViewFinder = find.byType(ListView);
    await tester.pumpWidget(makeTestableWidget(const RestaurantListView()));
    // Assert
    expect(listViewFinder, findsOneWidget);
  });
}
