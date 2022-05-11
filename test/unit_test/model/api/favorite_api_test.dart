import 'package:flutter_test/flutter_test.dart';
import 'package:manga_time/models/favorite_model/favorite_api/favorite_api.dart';
import 'package:manga_time/models/favorite_model/favorite_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorite_api_test.mocks.dart';

@GenerateMocks([FavoriteApi])
void main() {
  group('Favorite API', () {
    var postFavorite = FavoriteApi();
    FavoriteApi favoriteApi = MockFavoriteApi();
    test('get all favorite komik returns data', () async {
      when(favoriteApi.getFavorite()).thenAnswer((_) async => <FavoriteModel>[
            FavoriteModel(
                chapters: [
                  ['gambar1'],
                  ['gambar2']
                ],
                jumlahPembaca: 'jumlahPembaca',
                caraBaca: 'caraBaca',
                gambar: 'gambar',
                genre: 'genre',
                jenisKomik: 'jenisKomik',
                judul: 'judul',
                judulIndonesia: 'judulIndonesia',
                sinopsis: 'sinopsis',
                status: 'status',
                umurPembaca: 'umurPembaca',
                key: 'key')
          ]);

      var favorite = await favoriteApi.getFavorite();
      expect(favorite.isNotEmpty, true);
    });

    test('Post Favorite Komik statusCode == 200', () async {
      var post = await postFavorite.postFavoriteKomik(
          postfavorite: FavoriteModel(
        chapters: [
          ['gambar1'],
          ['gambar2']
        ],
        jumlahPembaca: 'jumlahPembaca',
        caraBaca: 'caraBaca',
        gambar: 'gambar',
        genre: 'genre',
        jenisKomik: 'jenisKomik',
        judul: 'judul',
        judulIndonesia: 'judulIndonesia',
        sinopsis: 'sinopsis',
        status: 'status',
        umurPembaca: 'umurPembaca',
      ));
      expect(post.statusCode == 200, true);
    });
  });
}
