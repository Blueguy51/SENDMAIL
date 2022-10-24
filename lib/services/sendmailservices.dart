part of 'services.dart';

class SendMailServices {
  static Future<http.Response> sendEmail(String mail) {
    return http.post(
      Uri.https("dtales.my.id", "/cirestapi/index.php/api/mahasiswa"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'email': mail,
        },
      ),
    );
  }
}
