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

### 8. Jelaskan perbedaan utama antara `Navigator.push()` dan `Navigator.pushReplacement()`!

Perbedaan utamanya terletak pada apa yang terjadi pada halaman *saat ini* (halaman asal).

-   **`Navigator.push()`**: **Menyimpan** halaman saat ini di tumpukan dan menambahkan halaman baru di atasnya. Pengguna bisa menekan tombol "kembali" (back) untuk kembali ke halaman asal.
    * **Kapan dipakai:** Saat membuka halaman detail atau form (misal: `MenuPage` → `ProductFormPage`).

-   **`Navigator.pushReplacement()`**: **Membuang** halaman saat ini dan menggantinya dengan halaman baru di tumpukan. Pengguna **tidak bisa** menekan tombol "kembali" untuk kembali ke halaman asal (karena sudah dibuang).
    * **Kapan dipakai:** Saat pindah dari halaman `LoginPage` ke `MenuPage`. Kita tidak ingin pengguna bisa kembali ke halaman login setelah mereka berhasil login.

---

### 9. Jelaskan kegunaan `GlobalKey<FormState>`!

`GlobalKey<FormState>` adalah kunci unik yang berfungsi sebagai "pegangan" atau referensi untuk sebuah widget `Form`.

Kegunaan utamanya adalah untuk berinteraksi dengan `Form` dari luar widget `Form` itu sendiri. Di proyek ini, kita menggunakannya di dalam tombol "Simpan" untuk:

1.  **Validasi (`_formKey.currentState!.validate()`)**: Memerintahkan `Form` untuk menjalankan fungsi `validator` pada semua `TextFormField` di dalamnya. Jika semua valid, ia mengembalikan `true`.
2.  **Menyimpan (`_formKey.currentState!.save()`)**: (Tidak digunakan di proyek ini) Jika `onSaved` diimplementasikan pada `TextFormField`, ini akan memicunya.
3.  **Reset (`_formKey.currentState!.reset()`)**: Mengosongkan semua field dalam form.

Tanpa `GlobalKey`, tombol "Simpan" tidak memiliki cara untuk "berbicara" dengan widget `Form` dan memicu validasi.

---

### 10. Jelaskan kegunaan `TextEditingController`!

`TextEditingController` adalah objek yang digunakan untuk **mengontrol teks** di dalam sebuah `TextField` atau `TextFormField`.

Kegunaan utamanya adalah:
1.  **Mendapatkan Nilai (`_nameController.text`)**: Membaca teks yang sedang diketik oleh pengguna di dalam field. Kita menggunakannya saat menekan tombol "Simpan" untuk mengambil data nama, harga, dan deskripsi.
2.  **Mengatur Nilai (`_nameController.text = "Nilai Baru"`)**: Mengubah teks di dalam field secara programatis (misalnya, untuk mengisi form dengan data *default*).
3.  **Mendengarkan Perubahan**: Controller bisa diberi *listener* untuk bereaksi setiap kali pengguna mengetik satu huruf.

Tanpa *controller*, kita tidak bisa dengan mudah mengambil data dari *field* saat tombol ditekan.