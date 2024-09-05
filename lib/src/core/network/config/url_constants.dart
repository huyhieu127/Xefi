class UrlConstants {
  //GET: /danh-sach/phim-moi-cap-nhat?page=1
  static const newest = '/danh-sach/phim-moi-cap-nhat';

  //GET: /phim/khi-anh-chay-ve-phia-em
  static const detail = '/phim/{slug_movie}';

  //GET: /v1/api/danh-sach/phim-le?page=2&limit=10
  static const movieGenre = '/v1/api/danh-sach/{movie_genre}';

  //GET: /v1/api/tim-kiem?keyword="Hello world"&limit=10
  static const search = '/v1/api/tim-kiem';
}
