
RegExp phonePattern = RegExp(r'^(?:[+0]9)?[0-9]{9}$');
RegExp otpPattern = RegExp(r'^(?:[+0]9)?[0-9]{6}$');
RegExp phonePattern2 = RegExp(r'^(\+)?\d{9, 10}$');
RegExp emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}');

/// Minimum eight characters, at least one letter and one number:
RegExp passwordPattern = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');



