import 'package:attendance/componentes/custom_text/custom_text.dart';
import 'package:attendance/core/constant/appColors.dart';
import 'package:attendance/core/constant/string.dart';
import 'package:attendance/core/utils/logger.dart';
import 'package:attendance/di/locator.dart';
import 'package:attendance/features/home/presentation/provider/home_provider.dart';
import 'package:attendance/features/home/presentation/screens/home_screen.dart';
import 'package:attendance/features/login/presentation/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider = Provider.of<LoginProvider>(
      context,
      listen: false,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: loginBgColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Form(
                key: loginProvider.formKey,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SvgPicture.asset(loginIcon),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.6,
                      left: 22,
                      right: 22,
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.headingTwo(loginTitle, primaryBlue),
                            CustomText.captionOne(loginSubTitle1, black),
                            CustomText.captionOne(loginSubTitle2, black),
                            const SizedBox(height: 22),
                            CustomText.bodyBold(
                              loginTextFieldTitel,
                              primaryBlue,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: loginProvider.userIdController,
                                    maxLength: 4,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: loginTextFieldHint,
                                      filled: true,
                                      fillColor: white,
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color:
                                            context
                                                .watch<LoginProvider>()
                                                .hasError
                                            ? errorColor
                                            : primaryBlue,
                                      ),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: primaryBlue,
                                        ),
                                      ),
                                      errorBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: errorColor,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        context.read<LoginProvider>().showError(
                                          true,
                                        );
                                        return loginEmptyErrorText;
                                      }

                                      context.read<LoginProvider>().showError(
                                        false,
                                      );
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () async {
                                    Log.i(
                                      "-----------------Start Login---------------------",
                                    );

                                    if (loginProvider.formKey.currentState!
                                        .validate()) {
                                      final loginResponse = await loginProvider
                                          .execute(
                                            loginProvider.userIdController.text,
                                          );
                                      Log.i(
                                        "LoginScreen : onTap : loginResponse : $loginResponse",
                                      );

                                      if (!context.mounted) return;

                                      if (loginResponse) {
                                        Log.i(
                                          "LoginScreen : onTap : loginResponse True : ${loginProvider.loginReponse.toJson()}",
                                        );
                                        toastification.show(
                                          type: ToastificationType.success,
                                          alignment: Alignment.bottomCenter,
                                          context: context,
                                          // optional if you use ToastificationWrapper
                                          title: Text(loginSuccessText),
                                          autoCloseDuration: const Duration(
                                            seconds: 3,
                                          ),
                                        );

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                ChangeNotifierProvider<
                                                  HomeProvider
                                                >(
                                                  create: (_) =>
                                                      locator<HomeProvider>(),
                                                  child: const HomeScreen(),
                                                ),
                                          ),
                                        );

                                        // Navigate to the next screen or perform any other action
                                      } else {
                                        Log.i(
                                          "LoginScreen : onTap : loginResponse False : ${loginProvider.error}",
                                        );
                                        toastification.show(
                                          type: ToastificationType.info,
                                          alignment: Alignment.bottomCenter,
                                          context: context,
                                          // optional if you use ToastificationWrapper
                                          title: Text(loginIdErrorText),
                                          autoCloseDuration: const Duration(
                                            seconds: 3,
                                          ),
                                        );
                                        // Show an error message or perform any other action
                                      }
                                      Log.i(
                                        "-----------------End Login---------------------",
                                      );
                                    } else {
                                      toastification.show(
                                        type: ToastificationType.error,
                                        alignment: Alignment.bottomCenter,
                                        context: context,
                                        // optional if you use ToastificationWrapper
                                        title: Text(loginEmptyErrorText),
                                        autoCloseDuration: const Duration(
                                          seconds: 3,
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: primaryBlue,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            CustomText.captionOne(loginFooterText, greyText),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
