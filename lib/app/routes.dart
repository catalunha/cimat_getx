import 'package:cimat/app/view/controllers/caution/delivery/caution_delivery_dependencies.dart';
import 'package:cimat/app/view/controllers/caution/giveback/caution_giveback_dependencies.dart';
import 'package:cimat/app/view/controllers/caution/receiver/caution_receiver_dependencies.dart';
import 'package:cimat/app/view/controllers/caution/search/caution_search_dependencies.dart';
import 'package:cimat/app/view/controllers/home/home_dependencies.dart';
import 'package:cimat/app/view/controllers/image/image_search_addedit_dependencies.dart';
import 'package:cimat/app/view/controllers/item/addedit/item_addedit_dependencies.dart';
import 'package:cimat/app/view/controllers/item/search/item_search_dependencies.dart';
import 'package:cimat/app/view/controllers/splash/splash_dependencies.dart';
import 'package:cimat/app/view/controllers/user/login/login_dependencies.dart';
import 'package:cimat/app/view/controllers/user/register/email/user_register_email_dependencies.dart';
import 'package:cimat/app/view/controllers/user_profile/access/user_profile_access_dependencies.dart';
import 'package:cimat/app/view/controllers/user_profile/edit/user_profile_edit_dependencies.dart';
import 'package:cimat/app/view/controllers/user_profile/search/user_profile_search_dependencies.dart';
import 'package:cimat/app/view/pages/caution/delivery/caution_delivery_confirm_page.dart';
import 'package:cimat/app/view/pages/caution/delivery/caution_delivery_consult_page.dart';
import 'package:cimat/app/view/pages/caution/giveback/caution_giveback_page.dart';
import 'package:cimat/app/view/pages/caution/receiver/caution_receiver_page.dart';
import 'package:cimat/app/view/pages/caution/receiver/caution_receiver_permanent_page.dart';
import 'package:cimat/app/view/pages/caution/search/caution_search_list_page.dart';
import 'package:cimat/app/view/pages/caution/search/caution_search_page.dart';
import 'package:cimat/app/view/pages/home/home_page.dart';
import 'package:cimat/app/view/pages/image/image_addedit_page.dart';
import 'package:cimat/app/view/pages/image/image_search_page.dart';
import 'package:cimat/app/view/pages/item/addedit/item_addedit_page.dart';
import 'package:cimat/app/view/pages/item/search/item_search_list_page.dart';
import 'package:cimat/app/view/pages/item/search/item_search_page.dart';
import 'package:cimat/app/view/pages/item/view/item_view_page.dart';
import 'package:cimat/app/view/pages/splash/splash_page.dart';
import 'package:cimat/app/view/pages/user/login/auth_login_page.dart';
import 'package:cimat/app/view/pages/user/register/email/user_register_email.page.dart';
import 'package:cimat/app/view/pages/user_profile/access/user_profile_access_page.dart';
import 'package:cimat/app/view/pages/user_profile/edit/user_profile_edit_page.dart';
import 'package:cimat/app/view/pages/user_profile/search/user_profile_search_list_page.dart';
import 'package:cimat/app/view/pages/user_profile/search/user_profile_search_page.dart';
import 'package:cimat/app/view/pages/user_profile/view/user_profile_view_page.dart';
import 'package:get/get.dart';

class Routes {
  static const splash = '/';
  static const userLogin = '/user/login';
  static const userRegisterEmail = '/user/register/email';
  static const home = '/home';

  static const userProfileEdit = '/user/profile/edit';
  static const userProfileSearch = '/user/profile/search';
  static const userProfileSearchList = '/user/profile/search/list';
  static const userProfileAccess = '/user/profile/access';
  static const userProfileView = '/user/profile/view';

  static const itemAddEdit = '/item/addedit';
  static const itemSearch = '/item/search';
  static const itemSearchList = '/item/search/list';
  static const itemView = '/item/view';

  static const cautionDeliveryConsult = '/caution/delivery/search';
  static const cautionDeliveryConfirm = '/caution/delivery/confirm';

  static const cautionReceiver = '/caution/receiver';
  static const cautionReceiverPermanent = '/caution/receiver/permanent';

  static const cautionGiveback = '/caution/giveback';

  static const cautionSearch = '/caution/search';
  static const cautionSearchList = '/caution/search/List';

  static const imageSearch = '/image/search';
  static const imageAddEdit = '/image/addedit';

  static final pageList = [
    GetPage(
      name: Routes.splash,
      binding: SplashDependencies(),
      page: () => const SplashPage(),
    ),
    GetPage(
      name: Routes.userLogin,
      binding: AuthLoginDependencies(),
      page: () => AuthLoginPage(),
    ),
    GetPage(
      name: Routes.userRegisterEmail,
      binding: UserRegisterEmailDependencies(),
      page: () => AuthRegisterEmailPage(),
    ),
    GetPage(
      name: Routes.home,
      binding: HomeDependencies(),
      page: () => HomePage(),
      children: const [],
    ),
    GetPage(
      name: Routes.userProfileEdit,
      binding: UserProfileEditDependencies(),
      page: () => UserProfileEditPage(),
    ),
    GetPage(
      name: Routes.userProfileSearch,
      binding: UserProfileSearchDependencies(),
      page: () => UserProfileSearchPage(),
    ),
    GetPage(
      name: Routes.userProfileSearchList,
      page: () => UserProfileSearchListPage(),
    ),
    GetPage(
      name: Routes.userProfileAccess,
      binding: UserProfileAccessDependencies(),
      page: () => UserProfileAccessPage(),
    ),
    GetPage(
      name: Routes.userProfileView,
      page: () => UserProfileViewPage(),
    ),
    GetPage(
      name: Routes.itemAddEdit,
      binding: ItemAddEditDependencies(),
      page: () => ItemAddEditPage(),
    ),
    GetPage(
      name: Routes.itemSearch,
      binding: ItemSearchDependencies(),
      page: () => ItemSearchPage(),
    ),
    GetPage(
      name: Routes.itemSearchList,
      page: () => ItemSearchListPage(),
    ),
    GetPage(
      name: Routes.itemView,
      page: () => ItemViewPage(),
    ),
    GetPage(
      name: Routes.cautionDeliveryConsult,
      binding: CautionDeliveryDependencies(),
      page: () => CautionDeliveryConsultPage(),
    ),
    GetPage(
      name: Routes.cautionDeliveryConfirm,
      page: () => CautionDeliveryConfirmPage(),
    ),
    GetPage(
      name: Routes.cautionReceiver,
      binding: CautionReceiverDependencies(),
      page: () => CautionReceiverPage(),
    ),
    GetPage(
      name: Routes.cautionReceiverPermanent,
      binding: CautionReceiverDependencies(),
      page: () => CautionReceiverPermanentPage(),
    ),
    GetPage(
      name: Routes.cautionGiveback,
      binding: CautionGivebackDependencies(),
      page: () => CautionGivebackPage(),
    ),
    GetPage(
      name: Routes.cautionSearch,
      binding: CautionSearchDependencies(),
      page: () => CautionSearchPage(),
    ),
    GetPage(
      name: Routes.cautionSearchList,
      page: () => CautionSearchListPage(),
    ),
    GetPage(
      name: Routes.imageSearch,
      binding: ImageSearchAddEditDependencies(),
      page: () => ImageSearchPage(),
    ),
    GetPage(
      name: Routes.imageAddEdit,
      page: () => ImageAddEditPage(),
    ),
  ];
}
