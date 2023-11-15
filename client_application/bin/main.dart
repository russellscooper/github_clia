import 'dart:convert';

import 'package:dart_console/dart_console.dart';
import 'package:http/http.dart' as http;

const githubUrl = 'https://github.com/russellscooper';
const githubUser = 'russellscooper';

Future<bool> checkOnlineStatus() async {
  try {
    final response = await http.get(Uri.parse(githubUrl));
    return response.statusCode == 200;
  } catch (e) {
    // Handle the error (e.g., network error)
    return false;
  }
}

Future<Map<String, dynamic>> fetchUser(String username) async {
  final response =
      await http.get(Uri.parse('https://api.github.com/users/$username'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to fetch user information');
  }
}

void writeUserInfo(Map<String, dynamic> userInfo) {
  final console = Console();
  console.writeLine('\nUser Information:', TextAlignment.left);
  console.writeLine('Username: ${userInfo['login']}', TextAlignment.left);
  console.writeLine(
      'Name: ${userInfo['name'] ?? 'Not provided'}', TextAlignment.left);
  console.writeLine(
      'Bio: ${userInfo['bio'] ?? 'Not provided'}', TextAlignment.left);
  console.writeLine('Followers: ${userInfo['followers']}', TextAlignment.left);
  console.writeLine('Following: ${userInfo['following']}', TextAlignment.left);
}

void printMainMenu() {
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
}

void printOnlineStatus(bool isOnline) {
  final console = Console();
  console.writeLine(
      isOnline ? 'You are online.' : 'You are offline.', TextAlignment.center);
}

void printFooter() {
  final console = Console();
  console.writeLine('''
  Thank You for Using Our Tech!

      Copyright © S Cooper 2023
''', TextAlignment.left);
  console.resetColorAttributes();
}

void main() async {
  printMainMenu();

  // Check online status
  final isOnline = await checkOnlineStatus();
  printOnlineStatus(isOnline);

  // Fetch user information
  try {
    final userInfo = await fetchUser(githubUser);
    writeUserInfo(userInfo);
  } catch (e) {
    print('Failed to fetch user information. Error: $e');
  }

  printFooter();
}

/* 
Sources
Github API: https://docs.github.com/en/rest/guides/getting-started-with-the-rest-api?apiVersion=2022-11-28
Fetch data from the internet: https://docs.flutter.dev/cookbook/networking/fetch-data 
*/
