import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sprites/flutter_sprites.dart';

AssetBundle _initBundle() {
  if (rootBundle != null)
    return rootBundle;
  return new NetworkAssetBundle(new Uri.directory(Uri.base.origin));
}

final AssetBundle _bundle = _initBundle();

ImageMap _images;
SpriteSheet _sprites;

main() async {
  _images = new ImageMap(_bundle);

  List loads = [];
  loads.add(_images.load(<String>[
    'assets/background.png',
    'assets/sprites.png'
  ]));

  await Future.wait(loads);

  String json = await _bundle.loadString('assets/sprites.json');
  _sprites = new SpriteSheet(_images['assets/sprites.png'], json);

  runApp(
    new MaterialApp(
      title: "Flutter Demo",
      routes: {
        '/': (RouteArguments args) => new FurryFeathers()
      }
    )
  );
}

class FurryFeathers extends StatelessComponent {
  Widget build(BuildContext context)  {
    return new ScrollableViewport(
      scrollDirection: ScrollDirection.horizontal,
      child: new Container(
        width: 4096.0,
        height: 1280.0,
        child: new SpriteWidget(new FurryFeathersNode(), SpriteBoxTransformMode.fixedHeight)
      )
    );
  }
}

class FurryFeathersNode extends NodeWithSize {
  FurryFeathersNode() : super(new Size(4096.0, 1280.0)) {
    Sprite bg = new Sprite.fromImage(_images['assets/background.png']);
    bg.pivot = Point.origin;
    bg.position = Point.origin;
    addChild(bg);

    userInteractionEnabled = true;
  }

  bool handleEvent(SpriteBoxEvent event) {
    if (event.type == "pointerdown") {
      print("Pointer down");
      return true;
    }
    return false;
  }
}
