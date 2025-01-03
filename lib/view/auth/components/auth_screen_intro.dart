import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants.dart';

Widget authScreenIntro(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: defPadding),
    child: Column(
      children: [
        const SafeArea(child: Center()),

        // JOIN SIGNAL PROMO
        Row(
          children: [

            // SIGNAL SVG ICON
            SvgPicture.asset(
              'assets/svg/signal_icon.svg',
              height: height * 0.1,
              width: height * 0.1,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(
              width: defPadding,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Join FireChatX',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: height * 0.04,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
              
                  const SizedBox(
                    height: defPadding,
                  ),
              
                  // SIGN IN TITLE
                  Text(
                    'Connect, Chat, and Create Memories. Stay Connected, Anytime, Anywhere.',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: height * 0.018,
                        height: 1.2,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
