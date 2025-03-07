class ApiConstants {
  static String baseUrl = 'https://mediaregistration.alkafeel.net/api/';
  static String baseUrlImage = 'https://taher13.com/api/motrash_2/storage/';
  // Auth User
  static const String login = '/login';
  static const String register = '/register';
  static const String updateProfile = '/customer/update';
  static const String customer = '/customer';
  static const String section =
      'https://pic-api.alkafeel.net/v1/api/v1/photos/sections/ar';
  static const String gallery =
      'https://pic-api.alkafeel.net/v1/api/v1/photos/photos/ar?page=1';
//
  //  var url =
  //       'https://pic-api.alkafeel.net/v1/api/v1/photos/photos/ar?page=$page';
  //   if (sectionId != null) {
  //     url =
  //         'https://pic-api.alkafeel.net/v1/api/v1/photos/section/$sectionId/ar?page=$page';
  //   }
  //   if (query != null) {
  //     url =
  //         'https://pic-api.alkafeel.net/v1/api/v1/photos/photos_search/$query/ar?page=$page';
  //   }

  static String galleryBySection(int sectionId) =>
      'https://pic-api.alkafeel.net/v1/api/v1/photos/section/$sectionId/ar?page=1';
  static String videoCast = 'videscats?page=1';
  static String videos(int page, {int? idCast, String? search}) {
    String url = 'videos?page=$page';
    if (idCast != null) url += '&cat_id=$idCast';
    if (search != null) url += '&search=$search';
    return url;
  }

  // static String videosByVideoCast(int page, int videoCastId) =>
  //     'videos/page=1&cat_id=$videoCastId';
}
