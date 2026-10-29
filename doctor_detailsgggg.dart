// ===================== HospitalCard ======================
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> hospitals = const [
  {
    "name": "مستشفى العام",
    "distance": "0.5 كم",
    "duration": "15 دقيقة",
    "rating": 4.5,
    "image": "assets/hospital1.jpg",
    "heroTag": "hospital1",
  },
  {
    "name": "مستشفى المدينة",
    "distance": "1.2 كم",
    "duration": "20 دقيقة",
    "rating": 4.2,
    "image": "assets/hospital2.jpg",
    "heroTag": "hospital2",
  },
  {
    "name": "مستشفى الشفاء",
    "distance": "2 كم",
    "duration": "30 دقيقة",
    "rating": 4.8,
    "image": "assets/hospital3.jpg",
    "heroTag": "hospital3",
  },
];

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HospitalCard(
        name: 'ff',
        distance: 'gggj',
        duration: 'gkgkg',
        rating: 44,
        image: 'images/1.png',
        heroTag: 'ff',
      ),
    );
  }
}

class _HospitalCard extends StatelessWidget {
  final String name;
  final String distance;
  final String duration;
  final double rating;
  final String image;
  final String heroTag;

  const _HospitalCard({
    required this.name,
    required this.distance,
    required this.duration,
    required this.rating,
    required this.image,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(image, width: 60, height: 60, fit: BoxFit.cover),
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'almarai',
            ),
          ),
          subtitle: Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.orange),
              const SizedBox(width: 4),
              Text(
                "$rating",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'almarai',
                ),
              ),
              const SizedBox(width: 16),
              Text(
                distance,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'almarai',
                ),
              ),
              const SizedBox(width: 8),
              Text(
                duration,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'almarai',
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    HospitalDetailPage(name: name, heroTag: heroTag),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ===================== HospitalDetailPage ======================
// يمكنك استخدام الكود التفصيلي الذي أعطيتك إياه مسبقًا للـ Tabs
// ===================== صفحة تفصيلية احترافية لكل مستشفى ======================
class HospitalDetailPage extends StatefulWidget {
  final String name;
  final String heroTag;

  const HospitalDetailPage({
    required this.name,
    required this.heroTag,
    super.key,
  });

  @override
  State<HospitalDetailPage> createState() => _HospitalDetailPageState();
}

class _HospitalDetailPageState extends State<HospitalDetailPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.blue[800],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'almarai',
                ),
              ),
              background: Hero(
                tag: widget.heroTag,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[400],
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/hospital_bg.jpg',
                      ), // صورة افتراضية للمستشفى
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                // ====== معلومات سريعة ======
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _InfoTile(
                        icon: Icons.star,
                        title: "4.5",
                        subtitle: "التقييم",
                      ),
                      _InfoTile(
                        icon: Icons.local_hospital,
                        title: "15",
                        subtitle: "الأطباء",
                      ),
                      _InfoTile(
                        icon: Icons.medical_services,
                        title: "8",
                        subtitle: "الخدمات",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // ====== Tabs ======
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.blue[800],
                  labelColor: Colors.blue[800],
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: "معلومات"),
                    Tab(text: "الأطباء"),
                    Tab(text: "الخدمات"),
                    Tab(text: "ساعات العمل"),
                  ],
                ),
                SizedBox(
                  height: 400,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _HospitalInfoTab(),
                      _DoctorsTab(),
                      _ServicesTab(),
                      _HoursTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text(
          "احجز موعد",
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'almarai'),
        ),
        icon: const Icon(Icons.calendar_today),
        backgroundColor: Colors.blue[800],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// ===================== Info Tile ======================
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.blue[800]),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'almarai',
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontFamily: 'almarai',
          ),
        ),
      ],
    );
  }
}

// ===================== Tab Pages ======================
class _HospitalInfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Text(
          "هذا نص توضيحي لمعلومات المستشفى. يمكن إضافة عنوان المستشفى، نوع التخصصات، الموقع، وصف عام عن الخدمات المتاحة، وغيرها من التفاصيل التي تساعد المستخدم على اتخاذ القرار.",
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
    );
  }
}

class _DoctorsTab extends StatelessWidget {
  final List<Map<String, String>> doctors = [
    {"name": "د. أحمد علي", "specialty": "أمراض القلب"},
    {"name": "د. سارة محمود", "specialty": "أطفال"},
    {"name": "د. خالد حسن", "specialty": "جراحة"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: doctors.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, index) {
        final doc = doctors[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(
              'assets/doctor${index + 1}.jpg',
            ), // صورة افتراضية للطبيب
          ),
          title: Text(
            doc["name"]!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'almarai',
            ),
          ),
          subtitle: Text(
            doc["specialty"]!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'almarai',
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        );
      },
    );
  }
}

class _ServicesTab extends StatelessWidget {
  final List<String> services = [
    "قسم الطوارئ",
    "الأشعة",
    "المختبرات",
    "العيادات الخارجية",
    "العلاج الطبيعي",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: services.length,
      itemBuilder: (_, index) {
        return ListTile(
          leading: const Icon(Icons.check_circle, color: Colors.green),
          title: Text(
            services[index],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'almarai',
            ),
          ),
        );
      },
    );
  }
}

class _HoursTab extends StatelessWidget {
  final Map<String, String> hours = {
    "السبت": "8 صباحًا - 8 مساءً",
    "الأحد": "8 صباحًا - 8 مساءً",
    "الاثنين": "8 صباحًا - 8 مساءً",
    "الثلاثاء": "8 صباحًا - 8 مساءً",
    "الأربعاء": "8 صباحًا - 8 مساءً",
    "الخميس": "8 صباحًا - 8 مساءً",
    "الجمعة": "مغلق",
  };

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: hours.entries
          .map(
            (e) => ListTile(
              leading: const Icon(Icons.access_time, color: Colors.blue),
              title: Text(
                e.key,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'almarai',
                ),
              ),
              trailing: Text(
                e.value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'almarai',
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
