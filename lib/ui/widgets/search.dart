import 'package:cat_breeds/ui/styles/scheme/scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Search extends StatefulWidget {
  final String hintText;
  final Function(String text)? onChange;
  final void Function()? onFocus;
  final Widget? suffixIcon;
  final bool autoFocus;
  final double height;
  final TextEditingController? controller;
  final BoxDecoration? decoration;
  final Color? colorInputText;

  const Search({
    super.key,
    this.hintText = '',
    this.onChange,
    this.suffixIcon,
    this.autoFocus = false,
    this.height = 36,
    this.onFocus,
    this.controller,
    this.decoration,
    this.colorInputText,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool showSuffixIcon = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.addListener(_onTextController);
    }
  }

  void _onTextController() {
    if (mounted) {
      setState(() {
        showSuffixIcon = widget.controller!.text.isNotEmpty;
      });
    }
  }

  _onChange(String text) {
    widget.onChange?.call(text);
    setState(() {
      showSuffixIcon = text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: widget.height,
        color: widget.decoration == null ? Colors.grey[300] : null,
        alignment: Alignment.centerRight,
        decoration: widget.decoration,
        child: TextField(
          controller: widget.controller,
          textCapitalization: TextCapitalization.words,
          autofocus: widget.autoFocus,
          onTap: widget.onFocus,
          onChanged: (value) {
            _onChange(value);
          },
          style: TextStyle(
              color: widget.colorInputText ??
                  Scheme.colorScheme(context).inputTextColor),
          decoration: inputDecoration(context),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(BuildContext context) {
    return InputDecoration(
      hintText: widget.hintText,
      hintStyle: const TextStyle(color: Color(0xFF878D90)),
      // filled: true,
      border: InputBorder.none,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 0,
      ),
      prefixIconConstraints: const BoxConstraints.expand(
        width: 24,
        height: 14,
      ),
      prefixIcon: Container(
        padding: const EdgeInsets.only(left: 4),
        child: const Icon(
          CupertinoIcons.search,
          size: 16,
          color: Color(0xFF878D90),
        ),
      ),
      // suffixIcon: suffixIcon,
      suffixIcon: widget.suffixIcon ??
          (showSuffixIcon
              ? GestureDetector(
                  onTap: () {
                    _onChange('');
                    widget.controller?.clear();
                  },
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/circle-times.svg',
                      height: 14,
                      width: 14,
                    ),
                  ),
                )
              : const SizedBox()),
      suffixIconConstraints: const BoxConstraints.expand(
        width: 30,
        height: 24,
      ),
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onTextController);
    super.dispose();
  }
}
