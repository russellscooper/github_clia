import 'package:dart_console/dart_console.dart';
import 'package:http/http.dart' as http;

Future<bool> checkOnlineStatus() async {
  final response =
      await http.get(Uri.parse('https://github.com/russellscooper'));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

void main() async {
  final console = Console();

  console.setBackgroundColor(ConsoleColor.black);
  console.setForegroundColor(ConsoleColor.brightGreen);
  console.clearScreen();
  console.resetCursorPosition();
  console.writeLine('''
##################################################
#      GITHUB CLIENT APPLICATION MAIN MENU      #
##################################################
''', TextAlignment.left);

  // Create a body
  final isOnline = await checkOnlineStatus();
  console.writeLine(
      isOnline ? 'You are online.' : 'You are offline.', TextAlignment.center);

  // Create a footer
  console.writeLine('''
  Thank You for Using Our Tech!

      Copyright © [Your Name] 2023
''', TextAlignment.left);

  console.resetColorAttributes();
}
