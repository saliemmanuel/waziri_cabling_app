import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class CustomWindowsButton extends StatefulWidget {
  const CustomWindowsButton({super.key});

  @override
  State<CustomWindowsButton> createState() => _CustomWindowsButtonState();
}

class _CustomWindowsButtonState extends State<CustomWindowsButton>
    with WindowListener {
  bool? isMaximised = true;
  listinerMaxiMinimizeButton() async {
    setState(() {
      isMaximised = !isMaximised!;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        WindowCaptionButton.minimize(onPressed: () => windowManager.minimize()),
        isMaximised!
            ? WindowCaptionButton.maximize(onPressed: () async {
                listinerMaxiMinimizeButton();
                windowManager.maximize();
              })
            : WindowCaptionButton.unmaximize(onPressed: () async {
                WindowOptions windowOptions = const WindowOptions(
                  minimumSize: Size(1200, 600),
                  center: true,
                  skipTaskbar: false,
                  titleBarStyle: TitleBarStyle.hidden,
                );
                await windowManager.waitUntilReadyToShow(windowOptions,
                    () async {
                  await windowManager.show();
                  await windowManager.focus();
                });
                listinerMaxiMinimizeButton();
              }),
        WindowCaptionButton.close(
          onPressed: () => windowManager.close(),
        ),
      ],
    );
  }
}
