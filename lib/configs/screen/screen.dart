import 'package:flutter/material.dart';

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenArea(BuildContext context) =>
    MediaQuery.of(context).size.width * MediaQuery.of(context).size.height;
