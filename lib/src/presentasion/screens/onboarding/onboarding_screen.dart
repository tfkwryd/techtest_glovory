import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:techtest/src/config/colors/app_colors.dart';
import 'package:techtest/src/config/text_style/app_text_style.dart';
import 'package:techtest/src/core/constants/assets_constants.dart';
import 'package:techtest/src/presentasion/providers/app_provider.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _OnboardingBody(),
    );
  }
}

class _OnboardingBody extends StatefulWidget {
  const _OnboardingBody({Key? key}) : super(key: key);

  @override
  State<_OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<_OnboardingBody> {
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {});
  }

  Widget _buildImage({
    required String pathImage,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: ClipRRect(
        child: Image.asset(
          pathImage,
          width: width,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  List<PageViewModel> _listPagesViewModel({
    required BuildContext context,
  }) =>
      [
        _buildPageView(
          pathImage: AssetsConstants.illustrationEasyAccess,
          subTitle: '',
          title: 'Buy Product easily via mobile & website inside office',
          context: context,
        ),
        _buildPageView(
          pathImage: AssetsConstants.illustrationEasyShopping,
          subTitle: '',
          title: 'Simple shopping that also works without internet',
          context: context,
        ),
        _buildPageView(
          pathImage: AssetsConstants.illustrationSimplePayment,
          subTitle: '',
          title: 'Simple payment by salary deduction each month',
          context: context,
        )
      ];

  PageViewModel _buildPageView({
    required String title,
    required String subTitle,
    required String pathImage,
    required BuildContext context,
  }) {
    return PageViewModel(
      titleWidget: const SizedBox(),
      bodyWidget: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildImage(
                    pathImage: pathImage,
                    width: double.infinity,
                  ),
                  Text(
                    title,
                    style: AppTextStyle.headline1.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      decoration: _pageDecoration,
    );
  }

  final PageDecoration _pageDecoration = const PageDecoration(
    titleTextStyle: AppTextStyle.headline1,
    bodyTextStyle: AppTextStyle.bodyText2,
    pageColor: AppColors.solidWhiteColor,
    imagePadding: EdgeInsets.zero,
    titlePadding: EdgeInsets.zero,
    bodyPadding: EdgeInsets.zero,
    footerPadding: EdgeInsets.zero,
    imageAlignment: Alignment.bottomCenter,
    bodyAlignment: Alignment.center,
  );
  // _scrollController.position

  Widget _buildDot({required int index}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: index == _activeIndex
            ? AppColors.primaryColor
            : AppColors.disableColor,
      ),
      child: const SizedBox(
        width: 32,
        height: 8,
      ),
    );
  }

  Widget _buildGlobalFooter({
    required BuildContext context,
  }) =>
      SizedBox(
        height: MediaQuery.of(context).size.height / 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 32,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildDot(index: 0),
                  _buildDot(index: 1),
                  _buildDot(index: 2),
                ],
              ),
              if (_activeIndex ==
                  _listPagesViewModel(context: context).length - 1)
                GestureDetector(
                  onTap: () => _doDone(context: context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Get Started",
                      style: AppTextStyle.button.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.solidWhiteColor,
                      ),
                    ),
                  ),
                ),
              if (_activeIndex !=
                  _listPagesViewModel(context: context).length - 1)
                GestureDetector(
                  onTap: () => _doDone(context: context),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Skip",
                      style: AppTextStyle.button.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );

  void _doDone({required BuildContext context}) {
    Provider.of<AppProvider>(context, listen: false).setIsFirstOpen(
      status: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: AppColors.solidWhiteColor,
      pages: _listPagesViewModel(context: context),
      onChange: (value) {
        setState(() {
          _activeIndex = value;
        });
      },
      showBackButton: false,
      showSkipButton: false,
      showNextButton: false,
      isTopSafeArea: true,
      isBottomSafeArea: true,
      isProgress: false,
      showDoneButton: false,
      dotsContainerDecorator: const BoxDecoration(
        color: AppColors.solidWhiteColor,
      ),
      dotsDecorator: const DotsDecorator(
        activeSize: Size(32.0, 6.0),
        activeColor: AppColors.primaryColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        size: Size(32.0, 6.0),
        color: AppColors.disableColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
      globalFooter: _buildGlobalFooter(context: context),
    );
  }
}
