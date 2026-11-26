import 'package:easy_shop_list/core/theme/colors.dart';
import 'package:easy_shop_list/core/widgets/bottom_wave.dart';
import 'package:easy_shop_list/features/my_lists/my_lists_view.dart';
import 'package:easy_shop_list/features/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => ref.read(splashViewModelProvider.notifier).start());
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(splashViewModelProvider, (previous, next) {
      if (next) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MyListsView()),
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          const Positioned(left: 0, right: 0, bottom: 0, child: BottomWave()),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 180,
                  color: AppColors.primary,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Easy ',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Shop List',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Organize suas compras de forma simples!',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
