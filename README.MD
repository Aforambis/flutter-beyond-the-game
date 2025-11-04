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
```dart
_showSnackBar(context, 'Kamu telah menekan tombol All Products');
