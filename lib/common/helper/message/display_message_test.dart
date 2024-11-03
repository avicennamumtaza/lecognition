
// // display_message_test.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:lecognition/common/helper/message/display_message.dart';

// void main() {
// 	testWidgets('Display error message in snackbar', (WidgetTester tester) async {
// 		final testKey = GlobalKey<ScaffoldState>();

// 		await tester.pumpWidget(
// 			MaterialApp(
// 				home: Scaffold(
// 					key: testKey,
// 					body: Builder(
// 						builder: (context) => ElevatedButton(
// 							onPressed: () => DisplayMessage.errorMessage(context, 'Error occurred'),
// 							child: Text('Show Error'),
// 						),
// 					),
// 				),
// 			),
// 		);

// 		await tester.tap(find.text('Show Error'));
// 		await tester.pump();

// 		expect(find.text('Error occurred'), findsOneWidget);
// 	});
// }