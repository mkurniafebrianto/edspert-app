import 'package:e_learning/src/data/firebase/firebase_service.dart';
import 'package:e_learning/src/data/repositories/auth_repository.dart';
import 'package:e_learning/src/data/repositories/banner_repository.dart';
import 'package:e_learning/src/data/repositories/excercise_repository.dart';
import 'package:e_learning/src/domain/usecases/get_banner_usecase.dart';
import 'package:e_learning/src/domain/usecases/get_courses_usecase.dart';
import 'package:e_learning/src/domain/usecases/get_excercises_usecase.dart';
import 'package:e_learning/src/domain/usecases/get_user_usecase.dart';
import 'package:e_learning/src/domain/usecases/registration_usecase.dart';
import 'package:e_learning/src/domain/usecases/sign_in_google_usecase.dart';
import 'package:e_learning/src/domain/usecases/sign_out_google_usecase.dart';
import 'package:e_learning/src/domain/usecases/upload_file_usecase.dart';
import 'package:e_learning/src/presentation/bloc/auth/auth_bloc.dart';
import 'package:e_learning/src/presentation/bloc/banner/banner_cubit.dart';
import 'package:e_learning/src/presentation/bloc/base/base_cubit.dart';
import 'package:e_learning/src/presentation/bloc/course/course_bloc.dart';
import 'package:e_learning/src/presentation/bloc/excercise/excercise_cubit.dart';
import 'package:e_learning/src/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/values/colors.dart';
import 'data/repositories/course_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CourseBloc(GetCoursesUseCase(CourseRepository())),
        ),
        BlocProvider(
          create: (context) =>
              BannerCubit(GetBannersUseCase(BannerRepository())),
        ),
        BlocProvider(
          create: (context) => BaseCubit(),
        ),
        BlocProvider(
          create: (context) =>
              ExcerciseCubit(GetExcercisesUseCase(ExcerciseRepository())),
        ),
        BlocProvider(create: (context) {
          AuthRepository repository =
              AuthRepository(firebaseService: FirebaseService());

          return AuthBloc(
            SignInGoogleUseCase(repository),
            RegistrationUseCase(repository),
            UploadFileUseCase(repository),
            SignOutGoogleUseCase(repository),
            GetUserUseCase(repository),
          );
        })
      ],
      child: GestureDetector(
        onTap: () {
          /// to manage keyboard visibility
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E Learning',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.background,
            navigationBarTheme: const NavigationBarThemeData(
              labelTextStyle: MaterialStatePropertyAll(
                TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
