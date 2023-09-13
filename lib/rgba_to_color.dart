import 'dart:ui';

listToColor(List<int> colorRGBA) {
  int a = colorRGBA[0]; 
  int r = colorRGBA[1]; 
  int g = colorRGBA[2];
  int b = colorRGBA[3];
  return Color.fromARGB(a, r, g, b);
}