import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techtest/src/config/colors/app_colors.dart';
import 'package:techtest/src/config/text_style/app_text_style.dart';
import 'package:techtest/src/core/utils/toast_utils.dart';
import 'package:techtest/src/presentasion/widgets/frame_widget.dart';
import 'package:techtest/src/presentasion/widgets/input_text_widget.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _LoginBody(),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrameWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _LoginHeader(),
          Expanded(
            child: _LoginContent(),
          ),
        ],
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              CupertinoIcons.arrow_left,
              color: AppColors.defaultTextColor,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginContent extends StatefulWidget {
  const _LoginContent({Key? key}) : super(key: key);

  @override
  State<_LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<_LoginContent> {
  final _formKey = GlobalKey<FormState>();
  final _nikController = TextEditingController();
  final _pinController = TextEditingController();
  bool _isInputValid = false;

  void _checkInput() {
    if (_nikController.text.length == 16 && _pinController.text.length > 4) {
      if (!_isInputValid) {
        setState(() {
          _isInputValid = true;
        });
      }
    } else {
      if (_isInputValid) {
        setState(() {
          _isInputValid = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Login',
              style: AppTextStyle.headline1,
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Please enter your NIK and PIN',
              style: AppTextStyle.bodyText1,
            ),
            const SizedBox(
              height: 20,
            ),
            InputTextWidget(
              controller: _nikController,
              title: 'NIK',
              titleType: InputTextTitleType.top,
              hintText: 'Please enter your NIK',
              isBorder: true,
              isRequired: true,
              isFilled: true,
              keyboardType: TextInputType.number,
              textInputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChange: (_) {
                _checkInput();
              },
            ),
            const SizedBox(
              height: 16,
            ),
            InputTextWidget(
              controller: _pinController,
              title: 'PIN',
              titleType: InputTextTitleType.top,
              hintText: 'Please enter your PIN',
              isBorder: true,
              isRequired: true,
              isHidden: true,
              isFilled: true,
              keyboardType: TextInputType.number,
              textInputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChange: (_) {
                _checkInput();
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              color: AppColors.solidWhiteColor.withOpacity(0.9),
              child: GestureDetector(
                onTap: () {
                  Toast.show(
                    message: "Comming Soon!".toString(),
                    toastType: ToastType.info,
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor
                        .withOpacity(_isInputValid ? 1 : 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      'Login',
                      style: AppTextStyle.headline4.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.solidWhiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
