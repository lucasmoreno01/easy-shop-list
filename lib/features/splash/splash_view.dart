import 'package:easy_shop_list/core/widgets/bottom_wave.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 180,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Easy ',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      children: [
                        TextSpan(
                          text: 'Shop List',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge?.copyWith(),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Organize suas compras de modo simples!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                ],
              ),
            ),
          ),
          const BottomWave(),
        ],
      ),
    );
  }
}
