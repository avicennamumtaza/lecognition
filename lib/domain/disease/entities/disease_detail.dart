class DiseaseDetail {
  final int id;
  final String name;
  final String desc;
  final List<String> treatment;
  final List<String> prevention;
  final String severity;
  final List<String> symptoms;

  DiseaseDetail({
    required this.id,
    required this.name,
    required this.desc,
    required this.treatment,
    required this.prevention,
    required this.severity,
    required this.symptoms,
  });
}

List<DiseaseDetail> diseaseDetails = [
  DiseaseDetail(
    id: 3,
    name: 'Antraknosa',
    desc:
        'Penyakit jamur yang menyerang daun dan buah mangga, menyebabkan bintik-bintik hitam dan pembusukan buah.',
    treatment: [
      'Gunakan fungisida untuk mengendalikan infeksi jamur.',
      'Pangkas area tanaman yang terinfeksi untuk mencegah penyebaran.',
      'Buang buah dan daun yang sudah terinfeksi dari sekitar tanaman.',
    ],
    prevention: [
      'Hindari kelembapan berlebih pada tanaman.',
      'Jaga jarak antar tanaman untuk memastikan sirkulasi udara yang baik.',
      'Rutin membersihkan daun yang gugur di sekitar tanaman.',
    ],
    severity: 'Tinggi',
    symptoms: ['Bintik hitam pada daun', 'Buah membusuk', 'Mati ranting'],
  ),
  DiseaseDetail(
    id: 4,
    name: 'Kanker Bakteri',
    desc:
        'Infeksi bakteri yang menyebabkan kanker atau luka pada cabang tanaman.',
    treatment: [
      'Gunakan fungisida berbasis tembaga untuk mengurangi infeksi bakteri.',
      'Pangkas dan buang cabang yang terinfeksi untuk mencegah penyebaran.',
      'Sterilkan alat pemangkasan untuk menghindari penyebaran bakteri.',
    ],
    prevention: [
      'Pastikan drainase tanah yang baik untuk mencegah genangan air.',
      'Hindari penyiraman langsung pada daun dan cabang tanaman.',
      'Berikan pupuk yang seimbang untuk meningkatkan daya tahan tanaman.',
    ],
    severity: 'Sedang',
    symptoms: ['Lendir keluar dari cabang', 'Kanker pada cabang', 'Daun layu'],
  ),
  DiseaseDetail(
    id: 5,
    name: 'Infestasi Kumbang Pemotong',
    desc:
        'Infestasi serangga yang menyebabkan kerusakan berupa potongan pada cabang dan buah.',
    treatment: [
      'Gunakan insektisida yang efektif terhadap kumbang pemotong.',
      'Pangkas dan buang cabang atau buah yang terinfestasi.',
      'Pasang perangkap serangga untuk mengurangi populasi kumbang.',
    ],
    prevention: [
      'Inspeksi tanaman secara rutin untuk mendeteksi infestasi lebih awal.',
      'Jaga kebersihan area sekitar tanaman.',
      'Hindari tumpukan dedaunan yang bisa menjadi sarang serangga.',
    ],
    severity: 'Sedang',
    symptoms: ['Potongan pada cabang', 'Buah rusak', 'Daun rontok'],
  ),
  DiseaseDetail(
    id: 6,
    name: 'Die Back',
    desc: 'Penyakit yang menyebabkan pengeringan dan kematian cabang tanaman.',
    treatment: [
      'Gunakan fungisida yang sesuai untuk mengatasi infeksi jamur.',
      'Pangkas cabang yang kering dan mati.',
      'Buang bagian tanaman yang terinfeksi jauh dari area kebun.',
    ],
    prevention: [
      'Jaga kelembapan tanah yang seimbang.',
      'Berikan nutrisi yang cukup untuk menjaga kesehatan tanaman.',
      'Pantau tanaman secara berkala untuk mendeteksi gejala dini.',
    ],
    severity: 'Tinggi',
    symptoms: ['Cabang mengering', 'Buah rontok', 'Perubahan warna daun'],
  ),
  DiseaseDetail(
    id: 7,
    name: 'Gall Midge',
    desc:
        'Larva serangga yang membentuk galls (benjolan) pada daun dan batang.',
    treatment: [
      'Gunakan insektisida sistemik untuk membasmi larva.',
      'Pangkas dan buang bagian tanaman yang terdapat galls.',
      'Gunakan perangkap untuk mengurangi populasi serangga dewasa.',
    ],
    prevention: [
      'Pantau tanaman secara rutin untuk mendeteksi keberadaan galls.',
      'Jaga kebersihan area sekitar tanaman.',
      'Hindari penumpukan dedaunan kering di sekitar tanaman.',
    ],
    severity: 'Rendah',
    symptoms: [
      'Benjolan pada daun',
      'Daun menggulung',
      'Pertumbuhan terhambat'
    ],
  ),
  DiseaseDetail(
    id: 8,
    name: 'Embun Tepung',
    desc: 'Penyakit jamur yang menyebabkan pertumbuhan serbuk putih pada daun.',
    treatment: [
      'Gunakan fungisida berbasis sulfur untuk mengendalikan jamur.',
      'Pangkas dan buang daun yang terinfeksi.',
      'Semprotkan campuran air dan soda kue sebagai langkah alternatif.',
    ],
    prevention: [
      'Hindari penyiraman dari atas untuk mencegah kelembapan berlebih.',
      'Pastikan sirkulasi udara yang baik di sekitar tanaman.',
      'Berikan pupuk yang sesuai untuk meningkatkan daya tahan tanaman.',
    ],
    severity: 'Sedang',
    symptoms: [
      'Serbuk putih pada daun',
      'Daun menggulung',
      'Daun rontok sebelum waktunya'
    ],
  ),
  DiseaseDetail(
    id: 2,
    name: 'Jamur Jelaga',
    desc:
        'Lapisan hitam pada daun yang disebabkan oleh ekskresi hama seperti kutu daun.',
    treatment: [
      'Cuci daun dengan campuran air dan sabun lembut untuk membersihkan jamur.',
      'Gunakan insektisida untuk mengendalikan hama penyebab ekskresi.',
      'Semprotkan air bersih untuk menghilangkan sisa-sisa ekskresi hama.',
    ],
    prevention: [
      'Cegah infestasi hama dengan menggunakan insektisida atau pengusir serangga alami.',
      'Pantau tanaman secara rutin untuk mendeteksi keberadaan hama.',
      'Jaga kebersihan area sekitar tanaman dari daun yang gugur.',
    ],
    severity: 'Rendah',
    symptoms: [
      'Lapisan hitam pada daun',
      'Fotosintesis terganggu',
      'Daun menguning'
    ],
  ),
  DiseaseDetail(
    id: 1,
    name: 'Sehat',
    desc: 'Tanaman mangga yang sehat tanpa tanda-tanda penyakit.',
    treatment: ['Tidak ada'],
    prevention: ['Tidak ada'],
    severity: 'Tidak ada',
    symptoms: ['Daun hijau', 'Pertumbuhan sehat', 'Produksi buah'],
  ),
];
