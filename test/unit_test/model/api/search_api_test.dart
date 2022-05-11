import 'package:flutter_test/flutter_test.dart';
import 'package:manga_time/models/search_model/search_api/search_api.dart';
import 'package:manga_time/models/search_model/search_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_api_test.mocks.dart';

@GenerateMocks([SearchApi])
void main() {
  SearchApi searchApi = MockSearchApi();
  test('get all komik returns data', () async {
    when(searchApi.getKomikList()).thenAnswer((_) async => <SearchModel>[
          SearchModel(
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
    var komik = await searchApi.getKomikList();
    expect(komik.isNotEmpty, true);
  });
}
