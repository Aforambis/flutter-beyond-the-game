# Flutter Project — Football Shop  
**Rusydan Mujtaba Ibnu Ramadhan**  
**NPM:** 2406421081  
**Kelas:** PBP F  

---

### 1. Apa itu _Widget Tree_ pada Flutter dan bagaimana hubungan _parent-child_ bekerja antar widget?

_Widget tree_ (pohon widget) adalah **struktur hierarki dari semua widget** yang membentuk antarmuka pengguna (_UI_) di Flutter.  
Kita bisa membayangkannya seperti pohon keluarga, di mana ada satu widget paling atas (root) yang memiliki anak-anak (_child_), dan masing-masing anak juga bisa punya anak sendiri, dan seterusnya.

**Hubungan Parent–Child:**
- **Parent Widget (Induk)** → widget yang membungkus widget lain.  
  Contoh: `Column` adalah parent dari daftar `Text` dan `_ShopButton`.
- **Child Widget (Anak)** → widget yang berada di dalam parent.  
  Contoh: `Text`, `SizedBox`, dan `_ShopButton` di dalam `Column`.

**Contoh hubungan antar-widget di proyek ini:**
- `Center` (parent) memberi tahu `Column` (child) untuk berada di tengah layar.  
- `Padding` (parent) memberi jarak di sekitar `Center` (child).  
- `Column` (parent) menata anak-anaknya (`Text`, `SizedBox`, `_ShopButton`) secara vertikal.

---

### 2. Sebutkan semua widget yang digunakan dalam proyek dan jelaskan fungsinya

Berikut daftar widget yang digunakan pada proyek **Football Shop**:

#### 🧩 **Widget Struktural & Layout**
| Widget | Fungsi |
|--------|--------|
| `MyApp` | Widget root kustom (extends `StatelessWidget`) yang menginisialisasi aplikasi. |
| `MaterialApp` | Membungkus seluruh aplikasi; menyediakan tema, navigasi, dan judul. |
| `MyHomePage` | Widget kustom yang menjadi halaman utama aplikasi. |
| `Scaffold` | Menyediakan struktur dasar halaman seperti `appBar` dan `body`. |
| `AppBar` | Bilah atas layar, berisi judul “Beyond The Game”. |
| `Center` | Memposisikan child di tengah layar. |
| `Column` | Menyusun widget secara vertikal (atas ke bawah). |
| `Padding` | Memberi jarak di sekitar widget child. |
| `SizedBox` | Memberi ruang kosong antar widget. |

#### 🎨 **Widget Tampilan & Interaksi**
| Widget | Fungsi |
|--------|--------|
| `Text` | Menampilkan teks di layar. |
| `Icon` | Menampilkan ikon (misalnya `Icons.shopping_bag_outlined`). |
| `ElevatedButton.icon` | Tombol dengan efek terangkat + ikon. |
| `_ShopButton` | Widget kustom untuk menampilkan tombol dengan gaya seragam. |
| `ScaffoldMessenger` | Mengelola dan menampilkan `SnackBar`. |
| `SnackBar` | Pesan pop-up sementara di bagian bawah layar. |

#### ⚙️ **Widget Styling**
| Widget | Fungsi |
|--------|--------|
| `ThemeData` | Menyimpan konfigurasi visual global (warna, font, dsb). |
| `AppBarTheme` | Menyimpan gaya khusus untuk `AppBar`. |

---

### 3. Apa fungsi dari widget `MaterialApp` dan mengapa digunakan sebagai root?

`MaterialApp` adalah **widget inti Flutter** yang membungkus seluruh aplikasi dan menyediakan konfigurasi serta layanan dasar berbasis _Material Design_.

**Fungsinya meliputi:**
- 🎨 **Tema global:** menyediakan `ThemeData` agar gaya visual konsisten di seluruh aplikasi.  
- 🧭 **Navigasi:** mengatur perpindahan halaman menggunakan `Navigator` dan `routes`.  
- 🏷️ **Konfigurasi dasar:** seperti `title`, `locale`, dan banner debug.

**Mengapa digunakan sebagai root?**
Karena widget seperti `Scaffold`, `Navigator`, dan `Theme.of(context)` **bergantung** pada keberadaan `MaterialApp` di atasnya dalam widget tree.  
Tanpa `MaterialApp`, aplikasi tidak dapat menampilkan tema atau struktur standar Flutter dengan benar.

---

### 4. Perbedaan antara `StatelessWidget` dan `StatefulWidget`

| Aspek | `StatelessWidget` | `StatefulWidget` |
|-------|--------------------|------------------|
| **Sifat** | Tidak dapat berubah (_immutable_) setelah dibuat. | Dapat berubah karena memiliki objek `State`. |
| **Lifecycle** | Dibangun sekali, tidak diperbarui ulang. | Bisa di-_rebuild_ setiap kali `setState()` dipanggil. |
| **Contoh penggunaan** | `Text`, `Icon`, tombol statis, dan semua widget di proyek ini. | Counter, form input, toggle, animasi dinamis. |

**Kapan digunakan?**
- Gunakan **`StatelessWidget`** untuk UI statis (tidak berubah selama runtime).  
- Gunakan **`StatefulWidget`** jika widget perlu menyimpan dan memperbarui _state_ internal (misal nilai counter atau status login).

---

### 5. Apa itu `BuildContext` dan mengapa penting di Flutter?

`BuildContext` adalah **“alamat” atau lokasi sebuah widget di dalam widget tree**.  
Ia bukan widget, tapi _reference_ yang memungkinkan widget:
- Mengetahui **posisinya** relatif terhadap widget lain.
- **Mengakses data leluhur**, seperti tema (`Theme.of(context)`) atau navigasi (`Navigator.of(context)`).

**Contoh penggunaan di proyek:**
"```dart"
"_showSnackBar(context, 'Kamu telah menekan tombol All Products')";

---

### 6. Jelaskan konsep `Hot Reload` pada Flutter dan apa bedanya dengan `Hot Restart`?

`Hot Reload` dan `Hot Restart` adalah fitur di Flutter untuk mempercepat proses _development_, namun keduanya bekerja dengan cara yang berbeda:
`Hot Reload`
- **Apa yang dilakukannya:** Menyuntikkan file _source code_ yang telah diperbarui ke dalam Dart Virtual Machine (VM) yang sedang berjalan. Setelah itu, Flutter secara otomatis membangun ulang widget tree, memungkinkan kita melihat perubahan UI secara instan.
- **Kecepatan:** Sangat cepat (biasanya kurang dari 1-2 detik).
- **State Aplikasi:** State (keadaan) aplikasi tetap terjaga. Misalnya, jika kita sedang mengisi form atau berada di halaman kedua, kita akan tetap di sana setelah hot reload. Ini ideal untuk tweaking UI atau logika tampilan.

`Hot Restart`
- **Apa yang dilakukannya:** Me-reset seluruh Dart VM dan memulai ulang aplikasi dari awal.
- **Kecepatan:** Lebih lambat dari hot reload tetapi jauh lebih cepat daripada menghentikan dan menjalankan ulang aplikasi sepenuhnya (cold boot).
- **State Aplikasi:** State aplikasi hilang dan kembali ke nilai awalnya. Ini berguna jika kita membuat perubahan besar pada state atau struktur data aplikasi dan perlu menguji alur aplikasi dari awal.

---

### 7. Jelaskan perbedaan antara `Navigator.push()` dan `Navigator.pop()`!

`Navigator.push()` dan `Navigator.pop()` adalah dua metode inti untuk mengelola tumpukan (stack) halaman dalam navigasi Flutter.

-   **`Navigator.push(context, ...)`**: Berfungsi untuk **menambahkan** halaman baru ke atas tumpukan. Ini seperti menumpuk piring baru di atas tumpukan piring yang sudah ada. Pengguna akan melihat halaman baru tersebut. Halaman yang lama masih ada di bawahnya, menunggu untuk ditampilkan kembali.
    * **Contoh:** Digunakan saat pindah dari `MenuPage` ke `ProductFormPage`.

-   **`Navigator.pop(context)`**: Berfungsi untuk **menghapus** halaman paling atas dari tumpukan. Ini seperti mengambil piring teratas dari tumpukan, sehingga piring di bawahnya (halaman sebelumnya) sekarang terlihat.
    * **Contoh:** Digunakan setelah menekan tombol "Simpan" di `ProductFormPage` untuk kembali ke halaman sebelumnya.

---

### 8. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten?
Hierarki widget ini adalah kunci untuk membuat aplikasi terasa konsisten dan profesional:
- **`Scaffold`**: Digunakan sebagai widget "pembungkus" level atas untuk setiap halaman (LoginPage, MenuPage, ProductFormPage, ProductListPage). Ini menyediakan kerangka dasar yang konsisten untuk meletakkan AppBar, body, dan Drawer.
- **`AppBar`**: Ditempatkan di dalam Scaffold di setiap halaman. Konsistensi visualnya dijamin oleh ThemeData di main.dart, yang mengatur appBarTheme (warna latar 0xFF1F1F1F dan gaya teks) secara global untuk seluruh aplikasi.
- **`Drawer`**: Dibuat sebagai satu widget terpisah (LeftDrawer di widgets/left_drawer.dart). Widget ini kemudian diimpor dan dipanggil di dalam Scaffold pada setiap halaman yang membutuhkannya (MenuPage, ProductFormPage, ProductListPage). Dengan cara ini, jika ada perubahan pada menu navigasi, saya hanya perlu mengedit satu file (left_drawer.dart) dan perubahannya akan langsung terlihat di semua halaman.

Kombinasi ketiganya memastikan bahwa setiap halaman memiliki header yang sama, background yang sama, dan (jika perlu) menu navigasi samping yang identik.

---

### 9. Apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form?
Layout widget ini sangat penting untuk membuat form yang rapi dan fungsional:
- **`Padding`**: Kelebihannya adalah memberi "ruang napas" visual. Tanpa Padding, elemen form akan menempel langsung di pinggir layar, membuatnya terlihat sempit dan sulit dibaca.
  **Contoh Penggunaan:** Di product_form_page.dart, saya tidak menggunakan Padding secara langsung, tetapi menggunakan properti padding di dalam SingleChildScrollView (padding: const EdgeInsets.all(24.0)) yang memiliki fungsi yang sama persis, yaitu memberi jarak 24 piksel di sekeliling Column yang berisi form.
- **`SingleChildScrollView`**: Kelebihannya adalah mencegah error "Bottom Overflow" (konten terpotong di bagian bawah). Ini krusial pada halaman form.
  **Contoh Penggunaan:** Di product_form_page.dart, Form dibungkus dengan SingleChildScrollView. Saat pengguna mengetuk TextFormField dan keyboard virtual muncul, SingleChildScrollView memungkinkan pengguna untuk scroll ke bawah untuk melihat dan mengisi field yang mungkin terhalang oleh keyboard.
- **`ListView`**: Kelebihannya adalah menampilkan daftar data yang dinamis dan bisa di-scroll (mirip seperti SingleChildScrollView tapi khusus untuk daftar).
  **Contoh Penggunaan:** Walaupun tidak dipakai untuk membangun form-nya (saya pakai Column di dalam SingleChildScrollView untuk itu), ListView dipakai di product_list_page.dart untuk menampilkan hasil dari form. ListView.builder secara efisien merender setiap Product yang tersimpan di ProductStorage.products sebagai Card yang bisa di-scroll.

---

### 10. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten?
Identitas visual yang konsisten diatur secara terpusat di file `lib/main.dart` di dalam `MaterialApp`, menggunakan properti theme: `ThemeData(...)`.
Dengan mendefinisikan tema di satu tempat, semua widget di seluruh aplikasi akan mengikutinya secara otomatis. Penyesuaian yang saya lakukan:
- **`Tema Gelap`**: Mengatur brightness: Brightness.dark sebagai dasar tema.
- **`Warna Latar`**: Mengatur scaffoldBackgroundColor: const Color(0xFF121212) untuk memberi warna abu-abu gelap yang konsisten di body setiap Scaffold.
- **`Warna Aksen/Utama`**: Mengatur primaryColor: Colors.blueAccent sebagai warna "brand" utama. Ini otomatis dipakai oleh ElevatedButton dan _ShopButton di menu_page.dart.
- **`Font Kustom`**: Mengatur fontFamily: GoogleFonts.poppins().fontFamily untuk memastikan semua Text di aplikasi menggunakan font Poppins, memberikan tampilan yang unik dan seragam.
- **`Tema AppBar`**: Mengatur appBarTheme secara spesifik (backgroundColor: const Color(0xFF1F1F1F)) agar semua AppBar memiliki warna yang sedikit berbeda dari body, lengkap dengan gaya teks yang seragam (titleTextStyle).