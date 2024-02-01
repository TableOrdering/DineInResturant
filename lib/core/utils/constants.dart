import 'package:dine_in/core/env/environment.dart';
import 'package:flutter/material.dart';

/// core constants
const kAppName = 'Dine-In';
const kUser = 'kUser';

/// theme constants
const kFontFamily = 'Poppins';

/// [kPrimaryColor] is the primary color of the app.
/// black: [#000000]
const kPrimaryColor = Color(0xFF000000);

/// server address
const apiPath = '/api';
const apiVersion = '/v1';
const resturantPath = '/resturant';

/// [url] is final variable.
const kURL = '$kHTTPScheme://$kBaseURL$kAPIPath$kAPIVersion$resturantPath';
const operatorPath = '/';

/// login
const loginPath = '/loginResturant';
const categoryPath = '/getAllCategory';
const updateCategoryStatusPath = '/updateAvailability';
const updateSubCatStatusPath = '/updateSubAvailability';
const getAllSubCategoryPath = "/getAllSubCategory";
