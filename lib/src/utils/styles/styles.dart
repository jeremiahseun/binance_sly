library styles;

import 'package:binance_sly/core/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

export 'package:flutter/material.dart' show Color, TextStyle, FontStyle, FontWeight, TextOverflow;

part 'colors.dart';
part 'typography.dart';

///? SCREENUTIL CONFIG IMPLEMENTATIONS
/// [.r] is `radius` of a circle, and `EdgeInsets`.
/// FOR EXAMPLE: 
/// ```
/// EdgeInsets.only(left:8,right:8).r 
/// OR 
/// EdgeInsets.only(left:8.r,right:8.r).
/// ```
/// [.h] is `height`. 
/// [.w] is `width`. 
/// [.sp] is `text font sizes`. 
/// [.sw] is `screen width`. 
/// [.sh] is `screen height`. 
/// I THINK THAT IS ALL WHAT WE NEED FOR THIS PROJECT.
