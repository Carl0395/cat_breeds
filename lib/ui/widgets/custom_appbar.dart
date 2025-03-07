import 'dart:io';

import 'package:cat_breeds/ui/styles/scheme/scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double fontSizeTitle;
  final bool centerTitle;
  final Widget? leading;
  final IconData? leadingIcon;
  final String? leadingSvgPath;
  final String? leadingText;
  final void Function()? leadingTap;
  final IconData? actionIcon;
  final String? actionText;
  final void Function()? actionTap;
  final PreferredSizeWidget? bottom;
  final Color? actionColor;
  final List<Widget> actions;
  final double? radius;

  const CustomAppBar({
    super.key,
    this.title = '',
    this.centerTitle = true,
    this.fontSizeTitle = 24,
    this.leading,
    this.leadingIcon,
    this.leadingSvgPath,
    this.leadingText,
    this.leadingTap,
    this.actionIcon,
    this.actionText,
    this.actionTap,
    this.radius,
    this.bottom,
    this.actionColor,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Scheme.colorScheme(context);
    return AppBar(
      backgroundColor: scheme.primaryColor,
      title: Text(
        title,
        style: TextStyle(
          fontSize: fontSizeTitle,
          color: const Color(0xFFFFFFFF),
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      leading: leadingTap != null ? buildLeadingButton() : leading,
      leadingWidth: 50,
      actions: actionIcon != null || actionText != null
          ? [buildActionButton()]
          : actions,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(radius ?? 12),
        ),
      ),
      bottom: bottom,
      shadowColor: Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF000000)
          : const Color(0xFFFFFFFF),
      elevation: Theme.of(context).brightness == Brightness.light ? 5 : 0.3,
    );
  }

  Widget buildLeadingButton() {
    return GestureDetector(
      onTap: leadingTap != null ? () => leadingTap!() : null,
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: leadingIcon != null
            ? Icon(
                actionIcon,
                color: const Color(0xFFFECD1A),
                size: 23,
              )
            : leadingText != null
                ? Text(
                    actionText!,
                    style: const TextStyle(
                      color: Color(0xFFFECD1A),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  )
                : leadingSvgPath != null
                    ? SvgPicture.asset(
                        leadingSvgPath!,
                      )
                    : SvgPicture.asset(
                        'assets/chevron-left.svg',
                        height: 23,
                        width: 14,
                      ),
      ),
    );
  }

  Widget buildActionButton() {
    return GestureDetector(
      onTap: actionTap != null ? () => actionTap!() : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        color: Colors.transparent,
        child: actionIcon != null
            ? Icon(
                actionIcon,
                color: const Color(0xFFFECD1A),
                size: 25,
              )
            : Text(
                actionText!,
                style: TextStyle(
                  color: actionColor ?? const Color(0xFFFECD1A),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, Platform.isIOS ? 48 : 58);
}
