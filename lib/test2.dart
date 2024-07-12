main() {
  String message =
      "01020784498 hello world 2005 2007 ahemd@zozo.com hi everybody i lost all my money  eslam@gmail.com ahmed@yahoo.com";
  message = message
      .replaceAll(RegExp(r'[0-9]'), '*')
      .replaceAll(RegExp(r'([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)'), '***@admin.com');
  print(message);
  // var result = message.split('').forEach((element) {
  // });
}
