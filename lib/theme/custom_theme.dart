import 'package:flutter/material.dart'; 
class Palette { 
  static const MaterialColor myTheme = MaterialColor( 
    0xff578bfa, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    <int, Color>{ 
      50: Color(0xff578bfa),//10% 
      100:Color(0xff578bfa),//20% 
      200:Color(0xff578bfa),//30% 
      300:Color(0xff578bfa),//40% 
      400:Color(0xff578bfa),//50% 
      500:Color(0xff578bfa),//60% 
      600:Color(0xff578bfa),//70% 
      700:Color(0xff578bfa),//80% 
      800:Color(0xff578bfa),//90% 
      900:Color(0xff578bfa),//100% 
    }, 
  ); 
} // y