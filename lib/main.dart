import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

///image surce
///https://carlmary.jp/gallery/en/materials-300/?date=240430
///https://www.gameart2d.com/freebies.html
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with TapDetector {
  SpriteComponent girl = SpriteComponent();
  SpriteComponent boy = SpriteComponent();
  Dialog dialog = Dialog();
  SpriteComponent background = SpriteComponent();
  final int chacterSize = 150;
  final double textBoxHeight = 100.0;
  bool trunAwaya = false;
  Vector2 btnSize = Vector2(80, 80);
  int dialogLevel = 0;

  TextPaint dialogTextPoint =
      TextPaint(style: TextStyle(fontSize: 18, color: Colors.white));

  @override
  FutureOr<void> onLoad() async {
    try {
      final sprite = await loadSprite('girl.png');
      final sprites = await loadSprite('boy.png');
      final screenHeight = size[0];
      final screenWidth = size[1];

      add(background
        ..sprite = await loadSprite('bg.jpg')
        ..size = size);

      girl
        ..sprite = sprite
        ..size = Vector2(chacterSize.toDouble(), chacterSize.toDouble())
        ..anchor = Anchor.topCenter
        ..y = screenHeight - chacterSize - textBoxHeight;
      add(girl);

      // boy
      //   ..sprite = sprites
      //   ..size = Vector2(chacterSize.toDouble(), chacterSize.toDouble())
      //   ..y = screenHeight - chacterSize - textBoxHeight
      //   ..anchor = Anchor.topCenter
      //   ..flipHorizontally()
      //   ..x = screenWidth - chacterSize;
      // add(boy);

      dialog
        ..sprite = await loadSprite("rightArrow.png")
        ..size = btnSize
        ..position =
            Vector2(size[0] - btnSize[0] - 20, size[1] - btnSize[1] - 60);
      add(dialog);
      print("Sprite loaded successfully");
    } catch (e) {
      print("Error loading sprite: $e");
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (girl.x < size[0] / 10) {
      dialogLevel = 0;
      girl.x += .5;
    }  else  if (girl.x < size[0] / 2) {
      dialogLevel = 1;
      girl.x += .5;
    }else if (girl.x < size[0] / 1.2){
      dialogLevel = 2;
      girl.x += .5;
    }else if(girl.x < size[0]){
      dialogLevel = 3;
      girl.x += .5;
    } else if (trunAwaya == false) {
      boy.flipHorizontally();
      trunAwaya = true;
      if (dialogLevel == 2) {
        dialogLevel = 3;
        girl.x += .5;
      }
      girl.x += .5;
    }
  }

  @override
  void render(Canvas canvas) {
    print("====<> this render method");
    super.render(canvas);
    switch (dialogLevel) {
      case 0 : dialogTextPoint.render(canvas, "STARTING...", Vector2(10, size[1]-100));
      break;
      case 1:
        dialogTextPoint.render(
            canvas, "READY GAME FLUTTER FLAME...", Vector2(10, size[1] - 100));
        break;
      case 2:
        dialogTextPoint.render(
            canvas, "SAGOR AHAMED CREATE THIS GAME...", Vector2(10, size[1] - 100));
        break;
      case 3:
        dialogTextPoint.render(canvas, "FLUTTER FLAME GAME LOADING....", Vector2(10, size[1] - 100));
        add(dialog);
        break;
    }
    
    switch(dialog.scene2leval){
      case 1 : dialogTextPoint.render(canvas, "BUTTON WORK FINE...", Vector2(10, size[1] - 100));
      break;
    }
  }
}

class Dialog extends SpriteComponent with TapCallbacks {
  int scene2leval = 0;
  @override
  bool onTapDwon(TapDownInfo event) {
    try {
      print('========move work file');
      return true;
    } catch (error) {
      print('=======> $error');
      return false;
    }
  }
}
