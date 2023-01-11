Uri randomAdviceUrl = Uri.parse('https://api.adviceslip.com/advice');
Uri adviceDetailsUrl({required String id}) {
  return Uri.parse('https://api.adviceslip.com/advice/$id');
}
Uri searchAdviceUrl({required String query}) {
  return Uri.parse('https://api.adviceslip.com/advice/search/$query');
}