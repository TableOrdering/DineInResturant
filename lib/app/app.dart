import 'package:dine_in/bloc/auth/authentication_bloc.dart';
import 'package:dine_in/bloc/category/category_bloc.dart';
import 'package:dine_in/bloc/sign_in/sign_in_bloc.dart';
import 'package:dine_in/bloc/sub_categories/sub_categories_bloc.dart';
import 'package:dine_in/core/routes/app_router.dart';
import 'package:dine_in/core/utils/constants.dart';
import 'package:dine_in/core/utils/k_color_scheme.dart';
import 'package:dine_in/data/repository/auth_repository.dart';
import 'package:dine_in/data/repository/catrgory_repo/category_repo.dart';
import 'package:dine_in/data/services/auth_service.dart';
import 'package:dine_in/data/services/category/category_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(
            authenticationBloc: context.read<AuthenticationBloc>(),
            repository: AuthRepositoryImpl(
              authService: AuthService(
                dio: Dio(),
              ),
            ),
          ),
        ),
        BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(
                  repository: CategoryRepoImp(
                      service: CategoryService(
                    dio: Dio(),
                  )),
                )..add(const GetAllCategories())),
        BlocProvider<SubCategoriesBloc>(
            create: (context) => SubCategoriesBloc(
                  repository: CategoryRepoImp(
                      service: CategoryService(
                    dio: Dio(),
                  )),
                )..add(const GetAllSubCategories())),
      ],
      child: const Middleware(),
    );
  }
}

class Middleware extends StatelessWidget {
  const Middleware({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter(
        authenticationBloc: context.read<AuthenticationBloc>(),
      ).router,
      title: kAppName,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        fontFamily: kFontFamily,
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          contentTextStyle: TextStyle(fontFamily: kFontFamily),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
            minimumSize: const Size(double.infinity, 48.0),
            backgroundColor: CustomColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        primaryColor: CustomColors.primary,
      ),
    );
  }
}
