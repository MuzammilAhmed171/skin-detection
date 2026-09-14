import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data/treatment_data.dart';

class TreatmentDetailsPage extends StatefulWidget {
  final String diseaseName;
  final bool isAllopathic;
  final int initialTab;

  const TreatmentDetailsPage({
    super.key,
    required this.diseaseName,
    required this.isAllopathic,
    this.initialTab = 0,
  });

  @override
  State<TreatmentDetailsPage> createState() => _TreatmentDetailsPageState();
}

class _TreatmentDetailsPageState extends State<TreatmentDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> _data;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: widget.initialTab,
    );
    
    String treatmentType = widget.isAllopathic ? 'allopathic' : 'homeopathic';
    _data = TreatmentData.data[widget.diseaseName]?[treatmentType] ?? {};
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCF9F2),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF2C2522), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${widget.diseaseName} - ${widget.isAllopathic ? 'Allopathic' : 'Homeopathic'}',
          style: GoogleFonts.dmSans(
            color: const Color(0xFF2C2522),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF2C2522)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart is empty.')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Top Tabs
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE6DFD5), width: 1),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: const Color(0xFFFCF9F2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFD4A373), width: 1),
              ),
              labelColor: const Color(0xFF2C2522),
              unselectedLabelColor: const Color(0xFF2C2522).withValues(alpha: 0.5),
              labelStyle: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.bold),
              unselectedLabelStyle: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w500),
              indicatorSize: TabBarIndicatorSize.tab,
              padding: const EdgeInsets.all(4),
              labelPadding: EdgeInsets.zero,
              tabs: const [
                Tab(
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.medication, size: 20),
                      SizedBox(height: 4),
                      Text('Medicine\n(Oral)', textAlign: TextAlign.center),
                    ],
                  ),
                ),
                Tab(
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.clean_hands, size: 20),
                      SizedBox(height: 4),
                      Text('Creams &\nTopicals', textAlign: TextAlign.center),
                    ],
                  ),
                ),
                Tab(
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.medical_information, size: 20),
                      SizedBox(height: 4),
                      Text('Medical\nAdvice', textAlign: TextAlign.center),
                    ],
                  ),
                ),
                Tab(
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.health_and_safety, size: 20),
                      SizedBox(height: 4),
                      Text('Take Care\nRoutine', textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProductList('Medicine'),
                _buildProductList('Creams'),
                _buildAdviceView(),
                _buildRoutineView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(String category) {
    List products = _data[category] ?? [];
    
    if (products.isEmpty) {
      return const Center(child: Text('No products available.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        var product = products[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE6DFD5), width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Placeholder
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCF9F2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE6DFD5)),
                ),
                child: Icon(
                  category == 'Medicine' ? Icons.medication_liquid : Icons.vaccines,
                  color: const Color(0xFFD4A373),
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: const Color(0xFF1C1715),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      product['desc'],
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${product['rating']} (${product['reviews']})',
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product['price']}',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: const Color(0xFF1C1715),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${product['name']} added to cart!')),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFCF9F2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFFD4A373)),
                            ),
                            child: Text(
                              'ADD TO CART >',
                              style: GoogleFonts.dmSans(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFD4A373),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAdviceView() {
    var advice = _data['Advice'] ?? {};
    List tips = advice['tips'] ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE6DFD5), width: 1),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCF9F2),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFD4A373)),
                  ),
                  child: const Icon(Icons.person, color: Color(0xFFD4A373), size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        advice['title'] ?? 'Consult a Doctor',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: const Color(0xFF1C1715),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        advice['desc'] ?? '',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Quick Tips',
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: const Color(0xFF1C1715),
            ),
          ),
          const SizedBox(height: 12),
          ...tips.map((tip) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check, color: Color(0xFFD4A373), size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tip,
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      color: const Color(0xFF2C2522),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Consultation booked!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD09068),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Book Consultation ->',
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutineView() {
    List routines = _data['Routine'] ?? [];
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Take Care Routine',
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: const Color(0xFF1C1715),
            ),
          ),
          const SizedBox(height: 16),
          ...routines.map((routine) => Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE6DFD5), width: 1),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCF9F2),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFD4A373).withValues(alpha: 0.3)),
                  ),
                  child: Icon(routine['icon'], color: const Color(0xFFD4A373), size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        routine['title'],
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: const Color(0xFF1C1715),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        routine['desc'],
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 16),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.eco, color: Color(0xFFD4A373)),
                const SizedBox(width: 8),
                Text(
                  'Healthy habits\n= Clearer skin',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: const Color(0xFF2C2522),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
