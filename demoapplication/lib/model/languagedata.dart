class LanguageData {
  final String englishText;
  final String englishAudio;
  final String hindiText;
  final String hindiAudio;

  LanguageData({
    required this.englishText,
    required this.englishAudio,
    required this.hindiText,
    required this.hindiAudio,
  });

  factory LanguageData.fromJson(Map<String, dynamic> json) {
    return LanguageData(
      englishText: json['english_text'],
      englishAudio: json['english_audio'],
      hindiText: json['hindi_text'],
      hindiAudio: json['hindi_audio'],
    );
  }
}

List<LanguageData> languageDataList = [
  {
    "english_text": "Hello",
    "english_audio": "https://example.com/hello_en.mp3",
    "hindi_text": "नमस्ते",
    "hindi_audio": "https://example.com/hello_hi.mp3",
  },
  {
    "english_text": "Good morning",
    "english_audio": "https://example.com/good_morning_en.mp3",
    "hindi_text": "सुप्रभात",
    "hindi_audio": "https://example.com/good_morning_hi.mp3",
  },
  {
    "english_text": "Thank you",
    "english_audio": "https://example.com/thank_you_en.mp3",
    "hindi_text": "धन्यवाद",
    "hindi_audio": "https://example.com/thank_you_hi.mp3",
  },
  {
    "english_text": "How are you?",
    "english_audio": "https://example.com/how_are_you_en.mp3",
    "hindi_text": "कैसे हो आप?",
    "hindi_audio": "https://example.com/how_are_you_hi.mp3",
  },
  {
    "english_text": "I'm fine, thank you.",
    "english_audio": "https://example.com/im_fine_en.mp3",
    "hindi_text": "मैं ठीक हूँ, धन्यवाद।",
    "hindi_audio": "https://example.com/im_fine_hi.mp3",
  },
  {
    "english_text": "What is your name?",
    "english_audio": "https://example.com/whats_your_name_en.mp3",
    "hindi_text": "तुम्हारा नाम क्या है?",
    "hindi_audio": "https://example.com/whats_your_name_hi.mp3",
  },
  {
    "english_text": "My name is John.",
    "english_audio": "https://example.com/my_name_is_john_en.mp3",
    "hindi_text": "मेरा नाम जॉन है।",
    "hindi_audio": "https://example.com/my_name_is_john_hi.mp3",
  },
  {
    "english_text": "Where are you from?",
    "english_audio": "https://example.com/where_are_you_from_en.mp3",
    "hindi_text": "तुम कहाँ से हो?",
    "hindi_audio": "https://example.com/where_are_you_from_hi.mp3",
  },
  {
    "english_text": "I am from India.",
    "english_audio": "https://example.com/im_from_india_en.mp3",
    "hindi_text": "मैं भारत से हूँ।",
    "hindi_audio": "https://example.com/im_from_india_hi.mp3",
  },
  {
    "english_text": "Goodbye",
    "english_audio": "https://example.com/goodbye_en.mp3",
    "hindi_text": "अलविदा",
    "hindi_audio": "https://example.com/goodbye_hi.mp3",
  },
].map((json) => LanguageData.fromJson(json)).toList();
