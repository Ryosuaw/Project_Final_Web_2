import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uas_flutter/main.dart';

class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return MockHttpClient();
  }
}

class MockHttpClient implements HttpClient {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #getUrl) {
      return Future.value(MockHttpClientRequest());
    }
    return null;
  }
}

class MockHttpClientRequest implements HttpClientRequest {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #close) {
      return Future.value(MockHttpClientResponse());
    }
    return null;
  }
}

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
]);

class MockHttpClientResponse implements HttpClientResponse {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #statusCode) {
      return 200;
    }
    if (invocation.memberName == #contentLength) {
      return kTransparentImage.length;
    }
    if (invocation.memberName == #compressionState) {
      return HttpClientResponseCompressionState.notCompressed;
    }
    if (invocation.memberName == #listen) {
      final Function onData = invocation.positionalArguments[0] as Function;
      onData(kTransparentImage);
      
      final Function? onDone = invocation.namedArguments[#onDone] as Function?;
      if (onDone != null) {
        onDone();
      }
      return MockStreamSubscription();
    }
    return null;
  }
}

class MockStreamSubscription implements StreamSubscription<List<int>> {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

void main() {
  setUpAll(() {
    HttpOverrides.global = MockHttpOverrides();
  });

  testWidgets('Register page loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Daftar Akun Baru'), findsOneWidget);
    expect(find.text('Nama Lengkap'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Kata Sandi'), findsOneWidget);
    expect(find.text('Konfirmasi Kata Sandi'), findsOneWidget);
    expect(find.text('Daftar Sekarang'), findsOneWidget);
  });

  testWidgets('Dashboard page loads correctly after registering', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Navigate to Dashboard via register button
    final registerButton = find.text('Daftar Sekarang');
    await tester.ensureVisible(registerButton);
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    // Verify new dashboard elements are loaded
    expect(find.text('NOERA'), findsWidgets);       // in header & sidebar
    expect(find.text('KAKAK CICA!', skipOffstage: false), findsOneWidget); // hero offstage sentinel
    expect(find.text('Amanda Putri'), findsOneWidget); // first partner card
  });

  testWidgets('Explore page loads correctly after navigating from dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Navigate to Dashboard
    final registerButton = find.text('Daftar Sekarang');
    await tester.ensureVisible(registerButton);
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    // Tap 'Cari Partner' button on Dashboard
    final cariPartnerButton = find.text('Cari Partner').first;
    await tester.tap(cariPartnerButton);
    await tester.pumpAndSettle();

    // Verify Explore Page elements are loaded
    expect(find.text('Explore Students Match'), findsOneWidget);
    expect(find.text('Sarah Azhari'), findsOneWidget);
    expect(find.text('Budi Raharjo'), findsOneWidget);

    // Tap 'Ajak Chat' button for the first candidate (goes to Chat Page)
    final ajakChatButton = find.text('Ajak Chat').first;
    await tester.tap(ajakChatButton);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 800));

    // Verify Chat Page is loaded
    expect(find.text('Sarah Mitchell'), findsOneWidget);
    expect(find.text("Hi there! I saw your request for the UI Design skill exchange. I'd love to help you with Figma components!"), findsOneWidget);

    // Tap back button on Chat Page to go to Messages Page
    final backButton = find.byIcon(Icons.arrow_back);
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // Verify Messages page is loaded
    expect(find.text('Pesan Masuk'), findsOneWidget);
    expect(find.text('Awesome! I look forward to it. See you tomorrow at 2 PM!'), findsOneWidget);
  });

  testWidgets('Login page loads and navigates correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Scroll to and tap "Masuk" text link to navigate to LoginPage
    final masukTextLink = find.text('Masuk');
    await tester.ensureVisible(masukTextLink);
    await tester.tap(masukTextLink);
    await tester.pumpAndSettle();

    // Verify LoginPage is loaded
    expect(find.text('Masuk ke Noera'), findsOneWidget);
    expect(find.text('kakakcica@mail.ugm.ac.id'), findsOneWidget);

    // Scroll to and tap "Masuk" button to go to Dashboard
    final masukButton = find.widgetWithText(ElevatedButton, 'Masuk');
    await tester.ensureVisible(masukButton);
    await tester.tap(masukButton);
    await tester.pumpAndSettle();

    // Verify Dashboard page is loaded with new design
    expect(find.text('NOERA'), findsWidgets);
    expect(find.text('KAKAK CICA!', skipOffstage: false), findsOneWidget);
  });
}
