import 'package:get/get.dart';

import '../modules/add_activity/bindings/add_activity_binding.dart';
import '../modules/add_activity/views/add_activity_view.dart';
import '../modules/add_activity/views/detail_activity_view.dart';
import '../modules/add_dietary_habit/bindings/add_dietary_habit_binding.dart';
import '../modules/add_dietary_habit/views/add_dietary_habit_view.dart';
import '../modules/add_dietary_habit/views/detail_dietary_view.dart';
import '../modules/add_mood/bindings/add_mood_binding.dart';
import '../modules/add_mood/bindings/detail_stress_binding.dart';
import '../modules/add_mood/controllers/detail_stress_controller.dart';
import '../modules/add_mood/views/add_mood_view.dart';
import '../modules/add_mood/views/detail_stress_view.dart';
import '../modules/add_sleep/bindings/add_sleep_binding.dart';
import '../modules/add_sleep/views/add_sleep_view.dart';
import '../modules/add_sleep/views/detail_sleep_view.dart';
import '../modules/enter_details/bindings/enter_details_binding.dart';
import '../modules/enter_details/views/enter_details_view.dart';
import '../modules/fooddetection/bindings/fooddetection_binding.dart';
import '../modules/fooddetection/views/fooddetection_view.dart';
import '../modules/healthy_living_tips/bindings/healthy_living_tips_binding.dart';
import '../modules/healthy_living_tips/views/healthy_living_tips_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/lupaPassword/bindings/lupa_password_binding.dart';
import '../modules/lupaPassword/controllers/password_baru_controller.dart';
import '../modules/lupaPassword/views/lupa_password_view.dart';
import '../modules/lupaPassword/views/password_baru_view.dart';
import '../modules/main_navigation/bindings/main_navigation_binding.dart';
import '../modules/main_navigation/views/main_navigation_view.dart';
import '../modules/menu/bindings/menu_binding.dart';
import '../modules/menu/views/menu_view.dart';
import '../modules/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/notifikasi/views/notifikasi_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/health_data_view.dart';
import '../modules/profile/views/my_account_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/progres/bindings/progres_binding.dart';
import '../modules/progres/views/progres_view.dart';
import '../modules/recommendation/bindings/recommendation_binding.dart';
import '../modules/recommendation/views/recommendation_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/controllers/signin_controller.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/target/bindings/target_binding.dart';
import '../modules/target/views/target_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: BindingsBuilder(() {
        Get.create<SigninController>(
          () => SigninController(),
        );
      }),
    ),
    GetPage(
      name: _Paths.ENTER_DETAILS,
      page: () => EnterDetailsView(),
      binding: EnterDetailsBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const MainNavigationView(),
      binding: MainNavigationBinding(),
    ),
    GetPage(
      name: _Paths.FOODDETECTION,
      page: () => const FoodDetectionView(),
      binding: FooddetectionBinding(),
    ),
    GetPage(
      name: _Paths.RECOMMENDATION,
      page: () => RecommendationView(),
      binding: RecommendationBinding(),
    ),
    GetPage(
      name: _Paths.MENU,
      page: () => const MenuView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.HEALTHY_LIVING_TIPS,
      page: () => const HealthyLivingTipsView(),
      binding: HealthyLivingTipsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: '/my-account',
      page: () => MyAccountView(),
    ),
    GetPage(
      name: '/health-data',
      page: () => HealthDataView(), // WAJIB ADA
    ),
    GetPage(
      name: _Paths.ADD_ACTIVITY,
      page: () => AddActivityView(),
      binding: AddActivityBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SLEEP,
      page: () => AddSleepView(),
      binding: AddSleepBinding(),
    ),
    GetPage(
      name: _Paths.ADD_MOOD,
      page: () => AddMoodView(),
      binding: AddMoodBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DIETARY_HABIT,
      page: () => AddDietaryHabitView(),
      binding: AddDietaryHabitBinding(),
    ),
    GetPage(
      name: '/detail-activity',
      page: () => DetailActivityView(),
    ),
    GetPage(
      name: '/detail-dietary',
      page: () => DetailDietaryView(),
    ),
    GetPage(
      name: '/detail-stress',
      page: () => DetailStressView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DetailStressController());
      }),
    ),
    GetPage(
      name: '/detail-sleep',
      page: () => DetailSleepView(),
    ),
    GetPage(
      name: _Paths.TARGET,
      page: () => TargetView(),
      binding: TargetBinding(),
    ),
    GetPage(
      name: _Paths.PROGRES,
      page: () => const ProgresView(),
      binding: ProgresBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_NAVIGATION,
      page: () => const MainNavigationView(),
      binding: MainNavigationBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () => const NotifikasiView(),
      binding: NotifikasiBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_PASSWORD,
      page: () => const LupaPasswordView(),
      binding: LupaPasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name:'/password-baru',
      page:(){
        Get.put(PasswordBaruController());
        return PasswordBaruView();
      }
    ),
  ];
}
