import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_clone/main.dart';

void main() {
  testWidgets('Instagram Clone smoke test', (WidgetTester tester) async {
    // 1. Construir la app y lanzar el primer frame.
    await tester.pumpWidget(const InstagramCloneApp());

    // 2. Verificar que NO estamos en la app de contador (no debe haber '0').
    expect(find.text('0'), findsNothing);

    // 3. Verificar que la estructura principal de Instagram cargó.
    // Buscamos la barra de navegación inferior (BottomNavigationBar).
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // 4. Verificar que el icono de "Home" está presente.
    expect(find.byIcon(Icons.home_filled), findsOneWidget);
    
    // 5. Verificar que el icono de "Perfil" está presente.
    expect(find.byIcon(Icons.person), findsOneWidget);
  });
}