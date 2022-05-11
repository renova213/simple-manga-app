import 'package:flutter_test/flutter_test.dart';
import 'package:manga_time/models/category_model/category_api/category_api.dart';
import 'package:manga_time/models/category_model/category_model.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'category_api_test.mocks.dart';

@GenerateMocks([CategoryApi])
void main() {
  group('Category API', () {
    CategoryApi categoryApi = MockCategoryApi();
    test('get category komik returns data', () async {
      when(categoryApi.getCategoryList())
          .thenAnswer((_) async => <CategoryModel>[
                CategoryModel(
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

      final categories = await categoryApi.getCategoryList();
      expect(categories.isNotEmpty, true);
    });
  });
}
