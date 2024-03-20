import 'package:chess/utils/themes.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Function() onClick;
  final String text;
  final bool isLoading;
  final bool isActive;
  final Color? color;
  final Color? textColor;
  final Widget? extraRight;
  final Color? border;
  final bool filled;

  const MainButton(this.text, this.onClick,
      {this.isLoading = false,
      this.isActive = true,
      this.color,
      this.textColor,
      this.border,
      this.extraRight,
      this.filled = false,
      super.key});


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: (color ?? MainTheme.accentColor)
            .withOpacity(isActive ? 1.0 : 0.5),
        child: InkWell(
          highlightColor: Colors.white.withAlpha(30),
          onTap: isActive && !isLoading
              ? () {
                  onClick();
                }
              : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (filled) ...{
                  const Expanded(
                      child: SizedBox(
                    height: 0,
                  ))
                },
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: isLoading ? 0 : 1,
                      child: Text(
                        text,
                        maxLines: 2),
                      ),
                    ]),
                    if (isLoading) ...{
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: textColor??MainTheme.secondaryColor,
                        ),
                      )
                    },
                if (extraRight != null) ...{
                  const SizedBox(
                    width: 10,
                  ),
                  extraRight!
                },
                if (filled) ...{
                  const Expanded(
                      child: SizedBox(
                    height: 0,
                  ))
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
