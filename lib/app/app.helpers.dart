

/// input validator with regex pattern
dynamic validator(String value, RegExp regex, [String? error]) {
  var v = value.toString().trim();
  if (v.isEmpty) {
    return 'Le champ est obligatoire';
  } else if (!regex.hasMatch(v)) {
    if (error != null) {
      return error;
    }
    return 'Veillez entrer une valeur valide';
  }
  return null;
}