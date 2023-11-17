//Needed to encode and decode data url:https://tinyurl.com/yc568h3f
import 'dart:convert';
//Build and manage terminal applications https://tinyurl.com/4eann3vm
import 'package:dart_console/dart_console.dart';
//Make http requests
import 'package:http/http.dart' as http;

//Establish API connection
const githubUrl = 'https://github.com/';
const githubApiUrl = 'https://api.github.com/users/';

//Return boolean object if github url is online or not.
Future<bool> checkOnlineStatus() async {
  try {
    //attempt to make a get request.
    final response = await http.get(Uri.parse(githubUrl));
    return response.statusCode == 200;
    // Handle the exception
  } catch (e) {
    return false;
  }
}

//Make a request to github api to get some user data.
Future<Map<String, dynamic>> fetchUser(String username) async {
  final response = await http.get(Uri.parse('$githubApiUrl$username'));
  //Uri info https://tinyurl.com/6ykctbve
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to fetch user information');
  }
}

//Function to write user info to the console.
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

//Print out the main menu
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

//show online status
void printOnlineStatus(bool isOnline) {
  final console = Console();
  console.writeLine(
      isOnline ? 'You are online.' : 'You are offline.', TextAlignment.center);
}

//show footer
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

  // Prompt the user for a GitHub username
  final console = Console();
  console.writeLine('\nEnter GitHub username:', TextAlignment.left);
  final input = console.readLine();

  // Fetch user information
  try {
    final userInfo = await fetchUser(input!);
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
