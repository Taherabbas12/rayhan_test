class ApiConstants {
  static String baseUrl = 'https://aaa.aa.net/api/';
  static String baseUrlImage = 'https://aa.com/api/a/storage/';
  // Auth User
  static const String login = '/login';
  static const String register = '/register';
  static const String updateProfile = '/customer/update';
  static const String customer = '/customer';

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
      'https://pic-api.aaa.net/v1/api/v1/photos/section/$sectionId/ar?page=1';
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
