# MuslimMate (Converted)

README ini menjelaskan proyek aplikasi mobile "MuslimMate" yang dikembangkan menggunakan Flutter.

## Ringkasan
MuslimMate adalah aplikasi mobile yang membantu pengguna dalam aktivitas ibadah harian: waktu sholat, dzikir, membaca Al-Qur'an, habit tracking, dan profil pengguna. Proyek ini menggunakan GetX untuk state management, Hive untuk penyimpanan lokal, dan beberapa paket lain untuk audio dan notifikasi.

Versi repository: `prak-Mobile-uts` (branch: `main`)

## Fitur Utama
- Login sederhana (demo) dan persistence user (SharedPreferences)
- Halaman utama dengan Bottom Navigation: Home, Calendar, Stats, Profile
- Modul Dzikir dengan counter dan target
- Modul Quran (tampilan ayah/ayat dari data dummy)
- Modul Prayer (data sholat dummy dan tanda selesai)
- Audio controller stub (siap diintegrasikan dengan just_audio)
- Settings & Theme (ganti warna utama dan mode gelap)

## Struktur Kode Program

```
lib/
├── main.dart                    # Entry point, routing, dan theme setup
├── constants/
│   ├── colors.dart             # Definisi warna aplikasi
│   └── text_styles.dart        # Style teks yang digunakan
├── controllers/
│   ├── auth_controller.dart    # Manajemen login dan user state
│   ├── prayer_controller.dart  # Logic waktu sholat
│   ├── dzikir_controller.dart  # Counter dan state dzikir
│   ├── quran_controller.dart   # Manajemen data Al-Quran
│   ├── theme_controller.dart   # Pengaturan tema aplikasi
│   ├── habit_controller.dart   # Tracking kebiasaan ibadah
│   └── audio_controller.dart   # Kontrol audio (stub)
├── models/
│   ├── user_model.dart        # Model data user
│   ├── prayer_model.dart      # Model waktu sholat
│   ├── habit_model.dart       # Model tracking kebiasaan
│   ├── ayah_model.dart        # Model ayat Al-Quran
│   └── dua_model.dart         # Model doa-doa
├── screens/
│   ├── login_screen.dart      # Halaman login
│   ├── main_screen.dart       # Container untuk bottom navigation
│   ├── home_screen.dart       # Dashboard utama
│   ├── quran_screen.dart      # Tampilan Al-Quran
│   ├── dzikir_screen.dart     # Counter dzikir
│   ├── dua_screen.dart        # Kumpulan doa
│   ├── qibla_screen.dart      # Penunjuk kiblat
│   ├── profile_screen.dart    # Profil pengguna
│   ├── stats_screen.dart      # Statistik ibadah
│   └── calender_screen.dart   # Kalender ibadah
├── data/
│   ├── prayer_times_data.dart # Data dummy jadwal sholat
│   ├── quran_data.dart        # Data dummy Al-Quran
│   └── dua_data.dart          # Data dummy doa-doa
├── services/
│   └── notification_service.dart # Service notifikasi
├── utils/                     # Helper functions
└── widgets/
    ├── prayer_card.dart      # Widget card waktu sholat
    ├── habit_card.dart       # Widget tracking kebiasaan
    ├── stats_card.dart       # Widget statistik
    └── quick_action_card.dart # Widget aksi cepat

assets/
├── data/                     # File JSON statis
├── icons/                    # Icon assets
└── images/                   # Gambar aplikasi
```

### Penjelasan Komponen Utama:

1. **Controllers/**
   - Menggunakan GetX untuk state management
   - Setiap controller menangani domain spesifik (auth, prayer, dzikir)
   - Reactive state dengan `.obs` dan `Obx`

2. **Models/**
   - Plain Dart classes dengan fromJson/toJson
   - Immutable objects dengan constructors final
   - Metode helper untuk transformasi data

3. **Screens/**
   - Stateless widgets dengan GetX controllers
   - Responsive layouts menggunakan MediaQuery
   - Custom painters untuk UI elements khusus

4. **Widgets/**
   - Reusable components untuk konsistensi UI
   - Menerima callbacks untuk interaksi
   - Menggunakan theme untuk styling konsisten

5. **Services/**
   - Background tasks dan platform services
   - Notification handling
   - Local storage operations

## Demo akun (credentials)
- Email: `demo@example.com`
- Password: `password123`

> Catatan: Login ini hanya demo. Untuk integrasi sebenarnya, tambahkan backend atau Firebase Auth.

## Cara Menjalankan (PowerShell di Windows)
Pastikan Anda sudah menginstall Flutter SDK dan dependency (lihat `pubspec.yaml`).

1. Install dependencies:

```powershell
flutter pub get
```

2. Jalankan analyzer (opsional):

```powershell
flutter analyze
```

3. Jalankan aplikasi pada device/emulator:

```powershell
flutter run -d <device-id>
```

Contoh untuk emulator Android: jika Anda menggunakan `flutter emulators --launch <name>` dulu, lalu jalankan `flutter run`.

## Dependensi Utama
Diambil dari `pubspec.yaml`:
- get
- hive, hive_flutter
- shared_preferences
- flutter_svg
- google_fonts
- intl
- geolocator
- permission_handler
- just_audio
- audio_service
- flutter_local_notifications
- timezone
- path_provider
- file_picker
- share_plus
- fl_chart


## Implementasi Teknis (ringkasan)
- State management menggunakan GetX (`GetxController`, `Obx`, `Get.put`, `Get.find`).
- Routing menggunakan `GetMaterialApp` dan `GetPage`.
- Persistent storage: Hive (untuk data aplikasi) dan SharedPreferences (untuk user login demo).
- UI: Widgets Flutter standar (Container, Row, Column, ListView, CustomPaint, Slider, dll.).

### Contoh cuplikan kode penting
Navigasi dan inisialisasi auth di `main.dart`:

```dart
Get.put(AuthController(), permanent: true);

GetMaterialApp(
	initialRoute: authController.isAuthenticated ? '/home' : '/login',
	getPages: [
		GetPage(name: '/login', page: () => LoginScreen()),
		GetPage(name: '/home', page: () => MainScreen(), middlewares: [AuthMiddleware()]),
	],
)
```

Controller contoh (DzikirController):

```dart
class DzikirController extends GetxController {
	var count = 0.obs;
	var target = 33.obs;

	var currentDzikir = {'name': 'SubhanAllah', 'arabic': 'سُبْحَانَ اللّٰهِ', 'target': 33}.obs;

	void increment() {
		if (count.value < target.value) {
			count.value++;
			HapticFeedback.lightImpact();
			if (count.value == target.value) HapticFeedback.heavyImpact();
		}
	}
}
```

## UI Design
Desain mengikuti tema hijau/putih dengan aksen hijau utama (AppColors). Layout dibuat responsif menggunakan Column/Row dan container bertingkat. Gambar desain awal (Figma) dapat ditempatkan di folder `assets/design/` dan direferensikan di laporan.

## Hasil dan Pembahasan (singkat)
- Aplikasi berfungsi pada level demo: login demo, navigasi, tampilan data dummy.
- Integrasi penuh (audio streaming, sync dengan backend, jadwal sholat akurat) belum diimplementasikan.
- Beberapa controller sudah disiapkan untuk integrasi lebih lanjut (audio_controller, prayer_controller).

## Known Issues / Notes
- Pesan GetX "improper use of a GetX has been detected" dapat muncul jika `Obx` atau `GetX` membungkus widget yang tidak memiliki observable di dalam scope; perbaikan telah dilakukan untuk beberapa layar tetapi masih perlu diperhatikan saat menambahkan observables baru.
- Penyimpanan user di SharedPreferences saat ini menggunakan format sederhana (string) untuk demo. Untuk produksi gunakan JSON encode/decode (`jsonEncode` / `jsonDecode`) atau serialisasi yang aman.

## Testing
- Unit testing belum banyak ditambahkan. Anda bisa menjalankan `flutter test` setelah menambahkan test di folder `test/`.

## Kontak
Untuk pertanyaan lebih lanjut atau instruksi, hubungi pengembang: [Sinta Nur Hidayah] — [sintahidayahsnh@gmail.com]

---

