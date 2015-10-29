import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sprites/flutter_sprites.dart';

AssetBundle _initBundle() {
  if (rootBundle != null)
    return rootBundle;
  return new NetworkAssetBundle(new Uri.directory(Uri.base.origin));
}

final AssetBundle _bundle = _initBundle();

ImageMap _images;

main() async {
  _images = new ImageMap(_bundle);

  List loads = [];
  loads.add(_images.load(<String>[
    'assets/background.png'
  ]));

  await Future.wait(loads);

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
    return new SpriteWidget(new FurryFeathersNode());
  }
}

class FurryFeathersNode extends NodeWithSize {
  FurryFeathersNode() : super(new Size(1024.0, 1024.0)) {
    Label lbl = new Label("Hello");
    lbl.position = new Point(512.0, 512.0);
    addChild(lbl);

    Sprite bg = new Sprite.fromImage(_images['assets/background.png']);
    bg.position = new Point(512.0, 512.0);
    addChild(bg);
  }
}
