import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satorio/controller/wallet_send_controller.dart';
import 'package:satorio/ui/theme/light_theme.dart';
import 'package:satorio/ui/theme/sator_color.dart';
import 'package:satorio/ui/theme/sator_icons.dart';
import 'package:satorio/ui/theme/text_theme.dart';
import 'package:satorio/ui/widget/elevated_gradient_button.dart';
import 'package:satorio/ui/widget/input_text_field.dart';

class WalletSendPage extends GetView<WalletSendController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'txt_send'.tr,
          style: textTheme.bodyText1!.copyWith(
            color: SatorioColor.darkAccent,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: InkWell(
            onTap: () => controller.back(),
            child: Icon(
              Icons.chevron_left_rounded,
              size: 32,
              color: SatorioColor.darkAccent,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline_rounded,
              color: SatorioColor.darkAccent,
            ),
            onPressed: () {
              controller.showTransactingTips();
            },
          )
        ],
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'images/bg/gradient.svg',
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Container(
            width: Get.width,
            height: Get.mediaQuery.size.height -
                (Get.mediaQuery.padding.top + kToolbarHeight),
            margin: EdgeInsets.only(
                top: Get.mediaQuery.padding.top + kToolbarHeight),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 28, bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputTextField(
                        controller: controller.amountController,
                        inputTitle: 'txt_amount'.tr,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        hintText: '0.00',
                        icon: ClipOval(
                          child: Container(
                            width: 24,
                            height: 24,
                            color: SatorioColor.mauve,
                            child: Icon(
                              SatorIcons.logo,
                              size: 20,
                              color: SatorioColor.brand,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 28 * coefficient,
                      ),
                      Text(
                        'txt_send_to'.tr,
                        style: textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: SatorioColor.textBlack),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _sendTo(
                            'accounts',
                            'txt_accounts'.tr,
                            () {
                              controller.selectDestinationFromOwnWallets();
                            },
                          ),
                          _sendTo(
                            'contacts',
                            'txt_contacts'.tr,
                            () {
                              controller.selectDestinationFromContacts();
                            },
                          ),
                          _sendTo(
                            'address',
                            'txt_address'.tr,
                            () {
                              controller.enterDestinationAddress();
                            },
                          ),
                          _sendTo(
                            'scan_qr',
                            'txt_scan_qr'.tr,
                            () {
                              controller.scanDestinationQr();
                            },
                          ),
                        ],
                      ),
                      Obx(
                        () => SizedBox(
                          height: controller.toAddressVisibility.value ? 28 : 0,
                        ),
                      ),
                      Obx(
                        () => controller.toAddressVisibility.value
                            ? InputTextField(
                                controller: controller.toAddressController,
                                inputTitle: 'txt_send_to'.tr,
                                icon: Icon(
                                  Icons.close_rounded,
                                  color:
                                      SatorioColor.textBlack.withOpacity(0.5),
                                ),
                                onPressedIcon: () {
                                  controller.clearDestinationAddress();
                                },
                              )
                            : SizedBox(
                                height: 0,
                              ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      InputTextField(
                        controller: controller.noteController,
                        inputTitle: 'txt_note'.tr,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => ElevatedGradientButton(
                          text: 'txt_preview'.tr,
                          isEnabled:
                              controller.fromWalletDetailRx.value != null &&
                                  controller.toAddressRx.value.isNotEmpty &&
                                  controller.amountRx.value > 0,
                          onPressed: () {
                            controller.createTransfer();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _sendTo(String assetName, String title, VoidCallback? onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 75,
        height: 75,
        decoration: BoxDecoration(
          color: SatorioColor.alice_blue,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'images/$assetName.svg',
                width: 24,
                height: 24,
                color: SatorioColor.interactive,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: textTheme.bodyText2!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: SatorioColor.textBlack),
              ),
            ],
          ),
        ),
      ),
    );
  }
}