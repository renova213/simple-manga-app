import 'package:flutter_test/flutter_test.dart';
import 'package:manga_time/models/komik_model/komik_api/komik_api.dart';
import 'package:manga_time/models/komik_model/komik_list_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'komik_api_test.mocks.dart';

@GenerateMocks([KomikApi])
void main() {
  group('KomikAPI', () {
    KomikApi komikApi = MockKomikApi();
    test('get all komik returns data', () async {
      when(komikApi.getKomikList()).thenAnswer((_) async => <KomikListModel>[
            KomikListModel(
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
                umurPembaca: 'umurPembaca')
          ]);
      var komik = await komikApi.getKomikList();
      expect(komik.isNotEmpty, true);
    });
  });
}
