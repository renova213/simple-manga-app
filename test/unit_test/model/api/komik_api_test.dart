import 'package:flutter_test/flutter_test.dart';
import 'package:manga_time/models/komik_model/komik_api/komik_api.dart';
import 'package:manga_time/models/komik_model/komik_list_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'komik_api_test.mocks.dart';

@GenerateMocks([GetList])
void main() {
  group('KomikAPI', () {
    GetList komikApi = MockKomikApi();
    test('get all komik returns data', () async {
      when(komikApi.getKomikList()).thenAnswer((_) async => <KomikListModel>[
            KomikListModel(
                chapters: [
                  ['gambar1'],
                  ['gambar2']
                ],
                jumlahPembaca: 1,
                caraBaca: 'caraBaca',
                gambar: 'gambar',
                genre: 'genre',
                jenisKomik: 'jenisKomik',
                judul: 'judul',
                judulIndonesia: 'judulIndonesia',
                sinopsis: 'sinopsis',
                status: 'status',
                umurPembaca: 'umurPembaca')
          ]);
      var komik = await komikApi.getKomikList();
      expect(komik.isNotEmpty, true);
    });

    test('get all banner returns data', () async {
      when(komikApi.getBannersList()).thenAnswer((_) async => <KomikListModel>[
            KomikListModel(
                chapters: [
                  ['gambar1'],
                  ['gambar2']
                ],
                jumlahPembaca: 1,
                caraBaca: 'caraBaca',
                gambar: 'gambar',
                genre: 'genre',
                jenisKomik: 'jenisKomik',
                judul: 'judul',
                judulIndonesia: 'judulIndonesia',
                sinopsis: 'sinopsis',
                status: 'status',
                umurPembaca: 'umurPembaca')
          ]);
      var komik = await komikApi.getBannersList();
      expect(komik.isNotEmpty, true);
    });
  });
}
