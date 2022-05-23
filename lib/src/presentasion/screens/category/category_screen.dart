import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtest/src/config/colors/app_colors.dart';
import 'package:techtest/src/config/text_style/app_text_style.dart';
import 'package:techtest/src/presentasion/providers/product_provider.dart';
import 'package:techtest/src/presentasion/widgets/frame_widget.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category';
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _CategoryBody(),
    );
  }
}

class _CategoryBody extends StatelessWidget {
  const _CategoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrameWidget(
      child: Column(
        children: const [
          _CategoryHeader(),
          Expanded(
            child: _CategoryContent(),
          ),
        ],
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 5,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.defaultTextColor.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
        color: AppColors.solidWhiteColor,
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  CupertinoIcons.clear,
                  color: AppColors.defaultTextColor,
                  size: 24,
                ),
              ),
            ],
          ),
          const Positioned.fill(
            child: Center(
              child: Text(
                'Categories',
                style: AppTextStyle.headline2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryContent extends StatelessWidget {
  const _CategoryContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop('');
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(16),
              color: Provider.of<ProductProvider>(context, listen: true)
                          .activeKeyword ==
                      ''
                  ? AppColors.primaryColor.withOpacity(0.2)
                  : AppColors.solidWhiteColor,
              child: Text(
                'All Products',
                style: Provider.of<ProductProvider>(context, listen: true)
                            .activeKeyword ==
                        ''
                    ? AppTextStyle.headline4
                        .copyWith(color: AppColors.primaryColor)
                    : AppTextStyle.bodyText1,
              ),
            ),
          ),
          ...Provider.of<ProductProvider>(context, listen: true)
              .categorySource
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(e);
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(16),
                    color: Provider.of<ProductProvider>(context, listen: true)
                                .activeKeyword ==
                            e
                        ? AppColors.primaryColor.withOpacity(0.2)
                        : AppColors.solidWhiteColor,
                    child: Text(
                      e,
                      style: Provider.of<ProductProvider>(context, listen: true)
                                  .activeKeyword ==
                              e
                          ? AppTextStyle.headline4
                              .copyWith(color: AppColors.primaryColor)
                          : AppTextStyle.bodyText1,
                    ),
                  ),
                ),
              )
        ],
      ),
    );
  }
}
