import 'package:flutter/cupertino.dart';
import 'package:hanime/entity/search_entity.dart';

class GenreMenu extends StatelessWidget {
  GenreMenu({Key? key}) : super(key: key);

  SearchBrand genre = SearchBrand.fromJson({
    "label": "影片類型",
    "data": ["H動漫", "3D動畫", "同人作品", "Cosplay"]
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(genre.label),
    );
  }
}
