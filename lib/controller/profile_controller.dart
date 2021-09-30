import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:satorio/binding/select_avatar_binding.dart';
import 'package:satorio/controller/mixin/non_working_feature_mixin.dart';
import 'package:satorio/controller/select_avatar_controller.dart';
import 'package:satorio/domain/entities/profile.dart';
import 'package:satorio/domain/entities/select_avatar_type.dart';
import 'package:satorio/domain/repositories/sator_repository.dart';
import 'package:satorio/ui/dialog_widget/default_dialog.dart';
import 'package:satorio/ui/dialog_widget/send_invite_dialog.dart';
import 'package:satorio/ui/page_widget/select_avatar_page.dart';

class ProfileController extends GetxController with NonWorkingFeatureMixin {
  final SatorioRepository _satorioRepository = Get.find();

  final Rx<Profile?> profileRx = Rx(null);

  late final ValueListenable<Box<Profile>> profileListenable;

  final Rx<Uri?> referralLinkRx = Rx(null);

  ProfileController() {
    this.profileListenable =
        _satorioRepository.profileListenable() as ValueListenable<Box<Profile>>;
  }

  @override
  void onInit() {
    super.onInit();

    _profileListener();
    profileListenable.addListener(_profileListener);
  }

  @override
  void onClose() {
    profileListenable.removeListener(_profileListener);
    super.onClose();
  }

  Future<void> getReferralCode() async {
    _satorioRepository.getReferralCode().then((value) {
      _createDynamicLink(value.referralCode);
      print(value.referralCode);
    });
  }

  Future<void> _createDynamicLink(String referralCode) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://satorio.page.link',
      link: Uri.parse('https://satorio.page.link/referal?code=$referralCode'),
      androidParameters: AndroidParameters(
        packageName: 'com.satorio.app',
        minimumVersion: 0,
      ),
      // iosParameters: IosParameters(
      //   bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
      //   minimumVersion: '0',
      // ),
    );

    parameters.buildShortLink().then((value) {
      referralLinkRx.update((val) {
        referralLinkRx.value = value.shortUrl;
        print(referralLinkRx.value);

        Get.dialog(
          SendInviteDialog(referralLinkRx.value.toString()),
        );
      });
    });
  }

  void toSelectAvatar() {
    Get.to(() => SelectAvatarPage(),
        binding: SelectAvatarBinding(),
        arguments: SelectAvatarArgument(SelectAvatarType.settings));
  }

  void toLogoutDialog() {
    Get.dialog(
      DefaultDialog(
        'txt_log_out'.tr,
        'txt_log_out_message'.tr,
        'txt_yes'.tr,
        icon: Icons.logout,
        onButtonPressed: () {
          _satorioRepository.logout();
        },
        secondaryButtonText: 'txt_no'.tr,
      ),
    );
  }

  void _profileListener() {
    if (profileListenable.value.length > 0)
      profileRx.value = profileListenable.value.getAt(0);
  }
}
