//This is a skeleton for console apps.
//As with any good skeletons, it can be cloned to other projects and the internals attatched.

import 'package:dart_console/dart_console.dart';

int main() {
  final console = Console();

  console.setBackgroundColor(ConsoleColor.blue);
  console.setForegroundColor(ConsoleColor.white);
  console.clearScreen();
  console.resetCursorPosition();
  console.writeLine(
    '''
 #######################################################################################
 #      WELCOME TO YOUR NEW CLI APP! Change and modify this file to add content!       #
 #######################################################################################
  ''',
    TextAlignment.left,
  );
  //Create a body
  console.writeLine(
    'Console size is ${console.windowWidth} cols and ${console.windowHeight} rows.',
    TextAlignment.center,
  );
  //Create a footer
  console.writeLine(
    '''
  Thank You for Using Our Tech! 
                        
                        Copyright \u00A9 [Your Name] 2023
    ''',
    TextAlignment.left,
  );
  console.resetColorAttributes();
  return 0;
}
