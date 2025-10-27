import '../models/ayah_model.dart';

class QuranData {
  static List<Map<String, dynamic>> getAllSurahs() {
    return [
      {
        'number': 1,
        'name': 'Al-Fatihah',
        'translation': 'The Opening',
        'type': 'Makiyah',
        'ayahs': 7
      },
      {
        'number': 2,
        'name': 'Al-Baqarah',
        'translation': 'The Cow',
        'type': 'Madaniyah',
        'ayahs': 286
      },
      {
        'number': 36,
        'name': 'Ya-Sin',
        'translation': 'Ya-Sin',
        'type': 'Makiyah',
        'ayahs': 83
      },
      {
        'number': 67,
        'name': 'Al-Mulk',
        'translation': 'The Sovereignty',
        'type': 'Makiyah',
        'ayahs': 30
      },
      {
        'number': 55,
        'name': 'Ar-Rahman',
        'translation': 'The Most Gracious',
        'type': 'Madaniyah',
        'ayahs': 78
      },
      {
        'number': 18,
        'name': 'Al-Kahf',
        'translation': 'The Cave',
        'type': 'Makiyah',
        'ayahs': 110
      },
      {
        'number': 112,
        'name': 'Al-Ikhlas',
        'translation': 'The Sincerity',
        'type': 'Makiyah',
        'ayahs': 4
      },
      {
        'number': 113,
        'name': 'Al-Falaq',
        'translation': 'The Daybreak',
        'type': 'Makiyah',
        'ayahs': 5
      },
      {
        'number': 114,
        'name': 'An-Nas',
        'translation': 'Mankind',
        'type': 'Makiyah',
        'ayahs': 6
      },
    ];
  }

  static List<Ayah> getAlFatihah() {
    return [
      Ayah(
          number: 1,
          arabic: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
          translation:
              'In the name of Allah, the Most Gracious, the Most Merciful.',
          transliteration: 'Bismillahir Rahmanir Rahim'),
      Ayah(
          number: 2,
          arabic: 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
          translation: 'All praise is due to Allah, Lord of all the worlds.',
          transliteration: 'Alhamdu lillahi rabbil aalamin'),
      Ayah(
          number: 3,
          arabic: 'الرَّحْمَٰنِ الرَّحِيمِ',
          translation: 'The Most Gracious, the Most Merciful.',
          transliteration: 'Ar-Rahmanir-Rahim'),
      Ayah(
          number: 4,
          arabic: 'مَالِكِ يَوْمِ الدِّينِ',
          translation: 'Master of the Day of Judgment.',
          transliteration: 'Maliki yawmid-din'),
      Ayah(
          number: 5,
          arabic: 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
          translation: 'You alone we worship, and You alone we ask for help.',
          transliteration: 'Iyyaka nabudu wa iyyaka nastaeen'),
      Ayah(
          number: 6,
          arabic: 'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
          translation: 'Guide us on the Straight Path.',
          transliteration: 'Ihdinas-siratal-mustaqim'),
      Ayah(
          number: 7,
          arabic:
              'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
          translation:
              'The Path of those You have blessed—not those You are displeased with, or those who are astray.',
          transliteration:
              'Siratal-ladhina an amta alayhim ghayril-maghdubi alayhim walad-dallin'),
    ];
  }

  static List<Ayah> getAlIkhlas() {
    return [
      Ayah(
          number: 1,
          arabic: 'قُلْ هُوَ اللَّهُ أَحَدٌ',
          translation: 'Say, "He is Allah, [who is] One,',
          transliteration: 'Qul huwa Allahu ahad'),
      Ayah(
          number: 2,
          arabic: 'اللَّهُ الصَّمَدُ',
          translation: 'Allah, the Eternal Refuge.',
          transliteration: 'Allahu assamad'),
      Ayah(
          number: 3,
          arabic: 'لَمْ يَلِدْ وَلَمْ يُولَدْ',
          translation: 'He neither begets nor is born,',
          transliteration: 'Lam yalid wa lam yulad'),
      Ayah(
          number: 4,
          arabic: 'وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ',
          translation: 'Nor is there to Him any equivalent."',
          transliteration: 'Wa lam yakul-lahu kufuwan ahad'),
    ];
  }

  static List<Ayah> getAlFalaq() {
    return [
      Ayah(
          number: 1,
          arabic: 'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ',
          translation: 'Say, "I seek refuge in the Lord of daybreak',
          transliteration: 'Qul aAAoothu birabbi alfalaq'),
      Ayah(
          number: 2,
          arabic: 'مِن شَرِّ مَا خَلَقَ',
          translation: 'From the evil of that which He created',
          transliteration: 'Min sharri ma khalaq'),
      Ayah(
          number: 3,
          arabic: 'وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ',
          translation: 'And from the evil of darkness when it settles',
          transliteration: 'Wamin sharri ghasiqin itha waqab'),
      Ayah(
          number: 4,
          arabic: 'وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ',
          translation: 'And from the evil of the blowers in knots',
          transliteration: 'Wamin sharri annaffathati fee alAAuqad'),
      Ayah(
          number: 5,
          arabic: 'وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ',
          translation: 'And from the evil of an envier when he envies."',
          transliteration: 'Wamin sharri hasidin itha hasad'),
    ];
  }

  static List<Ayah> getAnNas() {
    return [
      Ayah(
          number: 1,
          arabic: 'قُلْ أَعُوذُ بِرَبِّ النَّاسِ',
          translation: 'Say, "I seek refuge in the Lord of mankind,',
          transliteration: 'Qul aAAoothu birabbi annas'),
      Ayah(
          number: 2,
          arabic: 'مَلِكِ النَّاسِ',
          translation: 'The Sovereign of mankind,',
          transliteration: 'Maliki annas'),
      Ayah(
          number: 3,
          arabic: 'إِلَٰهِ النَّاسِ',
          translation: 'The God of mankind,',
          transliteration: 'Ilahi annas'),
      Ayah(
          number: 4,
          arabic: 'مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ',
          translation: 'From the evil of the retreating whisperer -',
          transliteration: 'Min sharri alwaswasi alkhannas'),
      Ayah(
          number: 5,
          arabic: 'الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ',
          translation: 'Who whispers [evil] into the breasts of mankind -',
          transliteration: 'Allathee yuwaswisu fee sudoori annas'),
      Ayah(
          number: 6,
          arabic: 'مِنَ الْجِنَّةِ وَالنَّاسِ',
          translation: 'From among the jinn and mankind."',
          transliteration: 'Mina aljinnati wannas'),
    ];
  }

  static List<Ayah> getSurahByNumber(int surahNumber) {
    switch (surahNumber) {
      case 1:
        return getAlFatihah();
      case 112:
        return getAlIkhlas();
      case 113:
        return getAlFalaq();
      case 114:
        return getAnNas();
      default:
        return getAlFatihah();
    }
  }
}
