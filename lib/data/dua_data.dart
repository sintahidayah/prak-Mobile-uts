import '../models/dua_model.dart';

class DuaData {
  static List<Dua> getAllDuas() {
    return [
      Dua(
        id: '1',
        title: '🌅 Morning Du\'a',
        category: 'Morning',
        arabic: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ رَبِّ الْعَالَمِينَ',
        transliteration: 'Asbahna wa asbahal-mulku lillahi rabbil-alamin',
        translation:
            'We have reached the morning and at this very time all sovereignty belongs to Allah, Lord of all the worlds.',
      ),
      Dua(
        id: '2',
        title: '🌙 Evening Du\'a',
        category: 'Evening',
        arabic: 'أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ',
        transliteration: 'Amsayna wa amsal-mulku lillah',
        translation:
            'We have reached the evening and at this very time all sovereignty belongs to Allah.',
      ),
      Dua(
        id: '3',
        title: '🍽️ Before Eating',
        category: 'Food',
        arabic: 'بِسْمِ اللَّهِ',
        transliteration: 'Bismillah',
        translation: 'In the name of Allah.',
      ),
      Dua(
        id: '4',
        title: '✅ After Eating',
        category: 'Food',
        arabic:
            'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنَا وَسَقَانَا وَجَعَلَنَا مُسْلِمِينَ',
        transliteration:
            'Alhamdulillahil-ladhi at\'amana wa saqana wa ja\'alana muslimin',
        translation:
            'All praise is due to Allah who has given us food and drink and made us Muslims.',
      ),
      Dua(
        id: '5',
        title: '🛏️ Before Sleeping',
        category: 'Sleep',
        arabic: 'بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي وَبِكَ أَرْفَعُهُ',
        transliteration: 'Bismika Rabbi wada\'tu janbi wa bika arfa\'uh',
        translation:
            'In Your name, my Lord, I lie down and in Your name I rise.',
      ),
      Dua(
        id: '6',
        title: '🚗 Traveling Du\'a',
        category: 'Travel',
        arabic:
            'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَٰذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ',
        transliteration:
            'Subhanal-ladhi sakhkhara lana hadha wa ma kunna lahu muqrinin',
        translation:
            'Glory be to Him who has subjected this to us, and we could never have accomplished this by ourselves.',
      ),
      Dua(
        id: '7',
        title: '🏥 For Healing',
        category: 'Health',
        arabic: 'اللَّهُمَّ رَبَّ النَّاسِ أَذْهِبِ الْبَأْسَ',
        transliteration: 'Allahumma Rabban-nasi adhhibil-ba\'s',
        translation: 'O Allah, Lord of mankind, remove the harm.',
      ),
      Dua(
        id: '8',
        title: '😔 For Anxiety',
        category: 'Distress',
        arabic: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ',
        transliteration: 'Allahumma inni a\'udhu bika minal-hammi wal-hazan',
        translation: 'O Allah, I seek refuge in You from worry and grief.',
      ),
    ];
  }

  static List<String> getCategories() {
    return [
      'All',
      'Morning',
      'Evening',
      'Food',
      'Sleep',
      'Travel',
      'Health',
      'Distress'
    ];
  }
}
