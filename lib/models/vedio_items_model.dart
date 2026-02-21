class VideoItem {
  final String id; // ممكن تحط URL كامل أو ID بس
  final String title;
  final String channel;
  final String duration;
  final String category;

  const VideoItem({
    required this.id,
    required this.title,
    required this.channel,
    required this.duration,
    required this.category,
  });

  // ✅ بيستخرج الـ ID تلقائياً سواء حطيت URL أو ID
  String get videoId {
    // لو حط URL كامل → استخرج الـ v= منه
    final uri = Uri.tryParse(id);
    if (uri != null && uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v']!;
    }
    // لو youtu.be/ID
    if (id.contains('youtu.be/')) {
      return id.split('youtu.be/').last.split('?').first;
    }
    // لو ID بس → رجّعه كما هو
    return id;
  }

  // ✅ الصورة بتيجي تلقائياً من الـ ID
  String get thumbnail => 'https://img.youtube.com/vi/$videoId/mqdefault.jpg';
}

// ────────── Sample Videos ──────────────────
const List<VideoItem> kVideos = [
  VideoItem(
    // ✅ ممكن تحط URL كامل
    id: 'https://www.youtube.com/watch?v=qKS4ZfKENew&list=PLH-n8YK76vIiuIZoWvHL7AvtrDV7hR3He',
    title: 'CompTIA Network+ | شرح Ethernet',
    channel: 'Sameh Ramadan Tech',
    duration: '43:33',
    category: 'Education',
  ),
  VideoItem(
    // ✅ أو ID بس
    id: 'https://www.youtube.com/watch?v=hir13v7NJpw&list=PLu3BfVDe4WGF_lBG523k-oW3TMpS9gkVP&index=10',
    title: '‫أذكي طريقة تدير بيها وقتك وجدول يومك',
    channel: 'Fireship',
    duration: '2:14',
    category: 'Tech',
  ),
  VideoItem(
    id: 'https://www.youtube.com/watch?v=5GNnnax4mmk',
    title: 'لا تتعلم برمجة في 2026 قبل ما تشوف الفيديو ده',
    channel: 'Ali Shahin',
    duration: '16:23',
    category: 'Education',
  ),
  VideoItem(
    id: 'https://www.youtube.com/watch?v=jfayBgel028',
    title: 'تلاوه هادئـه لتستريح | ناصـر القطامـى',
    channel: 'عفو',
    duration: '15:19',
    category: 'Relax',
  ),
  VideoItem(
    id: 'https://www.youtube.com/watch?v=SP0E1XXXcyw',
    title: 'إن شعرت بالضيق... فاستمع لكتاب الله يُنير قلبك ويشرح صدرك',
    channel: 'القرآن الكريم',
    duration: '42:55',
    category: 'Relax',
  ),
];