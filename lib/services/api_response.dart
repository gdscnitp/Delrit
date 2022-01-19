/*---------------------File to mould all http responses in a class--------*/

class ApiResponse {
  final data;
  final bool error;
  final String errorMessage;

  ApiResponse({this.data, this.error: false, this.errorMessage: ''});
}
