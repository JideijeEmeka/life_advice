Uri randomAdviceUrl = Uri.parse('https://api.adviceslip.com/advice');
Uri adviceDetailsUrl({required String id}) {
  return Uri.parse('https://api.adviceslip.com/advice/$id');
}