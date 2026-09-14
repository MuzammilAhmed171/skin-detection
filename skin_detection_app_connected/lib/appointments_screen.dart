import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final Color primary = const Color(0xFFD4A373);
  final Color darkText = const Color(0xFF1D1D35);
  final Color bg = const Color(0xFFFCF9F2);

  String selectedDisease = "All";
  String searchText = "";

  final List<String> diseases = [
    "All",
    "Acne",
    "Eczema",
    "Psoriasis",
    "Fungal Infection",
  ];

  final List<Doctor> doctors = [
    Doctor(
      name: "Dr. Ayesha Khan",
      specialty: "Acne & Skin Specialist",
      experience: "8+ Years",
      rating: "4.9",
      reviews: "214",
      fee: "Rs. 2,500",
      clinic: "DermaCare Skin Clinic",
      location: "Lahore",
      nextAvailable: "Today, 5:30 PM",
      mode: "Online & In Clinic",
      diseases: ["Acne"],
      avatar: "AK",
    ),
    Doctor(
      name: "Dr. Ahmed Raza",
      specialty: "Clinical Dermatologist",
      experience: "10+ Years",
      rating: "4.8",
      reviews: "187",
      fee: "Rs. 3,000",
      clinic: "Skin Health Center",
      location: "Islamabad",
      nextAvailable: "Tomorrow, 11:00 AM",
      mode: "In Clinic",
      diseases: ["Eczema", "Acne"],
      avatar: "AR",
    ),
    Doctor(
      name: "Dr. Sara Malik",
      specialty: "Eczema Specialist",
      experience: "7+ Years",
      rating: "4.9",
      reviews: "156",
      fee: "Rs. 2,000",
      clinic: "Healthy Skin Hospital",
      location: "Karachi",
      nextAvailable: "Today, 7:00 PM",
      mode: "Online & In Clinic",
      diseases: ["Eczema"],
      avatar: "SM",
    ),
    Doctor(
      name: "Dr. Usman Ali",
      specialty: "Psoriasis Specialist",
      experience: "12+ Years",
      rating: "4.8",
      reviews: "263",
      fee: "Rs. 3,500",
      clinic: "Advanced Dermatology Center",
      location: "Lahore",
      nextAvailable: "Wed, 10:30 AM",
      mode: "In Clinic",
      diseases: ["Psoriasis"],
      avatar: "UA",
    ),
    Doctor(
      name: "Dr. Hina Shah",
      specialty: "Fungal Skin Specialist",
      experience: "6+ Years",
      rating: "4.7",
      reviews: "128",
      fee: "Rs. 1,800",
      clinic: "Skin & Allergy Clinic",
      location: "Rawalpindi",
      nextAvailable: "Tomorrow, 4:00 PM",
      mode: "Online & In Clinic",
      diseases: ["Fungal Infection"],
      avatar: "HS",
    ),
    Doctor(
      name: "Dr. Bilal Hassan",
      specialty: "General Dermatologist",
      experience: "9+ Years",
      rating: "4.8",
      reviews: "201",
      fee: "Rs. 2,200",
      clinic: "Derma Plus Clinic",
      location: "Faisalabad",
      nextAvailable: "Thu, 2:00 PM",
      mode: "Online & In Clinic",
      diseases: ["Acne", "Eczema", "Psoriasis"],
      avatar: "BH",
    ),
    Doctor(
      name: "Dr. Maryam Noor",
      specialty: "Skin Disease Consultant",
      experience: "11+ Years",
      rating: "4.9",
      reviews: "239",
      fee: "Rs. 2,800",
      clinic: "Noor Dermatology Clinic",
      location: "Islamabad",
      nextAvailable: "Fri, 6:00 PM",
      mode: "Online & In Clinic",
      diseases: ["Acne", "Eczema", "Fungal Infection"],
      avatar: "MN",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = doctors.where((doctor) {
      final matchesDisease = selectedDisease == "All" ||
          doctor.diseases.contains(selectedDisease);

      final matchesSearch = doctor.name
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          doctor.specialty
              .toLowerCase()
              .contains(searchText.toLowerCase());

      return matchesDisease && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUpcomingAppointment(),

                    _buildPatientTools(),

                    _buildDiseaseFilter(),

                    _buildDoctorsSection(filteredDoctors),

                    _buildSkinProgress(),

                    _buildHealthTips(),

                    _buildBottomBookButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // HEADER
  // ----------------------------------------------------------

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primary,
            const Color(0xFFE8C39E),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const Expanded(
                child: Text(
                  "Appointments",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _showSearchDialog();
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      _showMessage("You have 2 appointment reminders");
                    },
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                      size: 29,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Search
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: "Search dermatologist...",
                hintStyle: TextStyle(
                  color: Colors.white70,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // QUICK ACTIONS
  // ----------------------------------------------------------

  

  Widget _buildQuickActions() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 18, 16, 10),
    padding: const EdgeInsets.symmetric(
      vertical: 16,
      horizontal: 5,
    ),
    decoration: _cardDecoration(),
    child: Row(
      children: [
        _quickAction(
          icon: Icons.add_box_outlined,
          title: "Book",
          subtitle: "Appointment",
          onTap: () {
            _showAllDoctorsDialog();
          },
        ),

        _quickAction(
          icon: Icons.calendar_month_outlined,
          title: "My",
          subtitle: "Appointments",
          onTap: () {
            _showMessage("My Appointments opened");
          },
        ),

        _quickAction(
          icon: Icons.notifications_none,
          title: "Reminders",
          subtitle: "Alerts",
          onTap: () {
            _showMessage("Appointment reminders opened");
          },
        ),

        _quickAction(
          icon: Icons.video_call_outlined,
          title: "Video",
          subtitle: "Consultation",
          onTap: () {
            _showMessage("Video consultation opened");
          },
        ),

        _quickAction(
          icon: Icons.location_on_outlined,
          title: "Clinic",
          subtitle: "Location",
          onTap: () {
            _showMessage("Clinic location opened");
          },
        ),
      ],
    ),
  );
}

Widget _quickAction({
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 2,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: primary,
              size: 29,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: darkText,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}// ----------------------------------------------------------
  // UPCOMING APPOINTMENT
  // ----------------------------------------------------------

  Widget _buildUpcomingAppointment() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            "Upcoming Appointment",
            action: "View All",
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: primary.withOpacity(.18),
              ),
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(.06),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _doctorAvatar("AK", size: 62),
                    const SizedBox(width: 13),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Dr. Ayesha Khan",
                                style: TextStyle(
                                  color: darkText,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.verified,
                                color: primary,
                                size: 17,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Dermatologist • 8+ Years",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    _statusBadge(
                      "Confirmed",
                      Colors.green,
                    ),
                  ],
                ),

                const SizedBox(height: 17),

                Row(
                  children: [
                    _infoIcon(
                      Icons.calendar_month,
                      "Tomorrow",
                    ),
                    const SizedBox(width: 18),
                    _infoIcon(
                      Icons.access_time,
                      "11:00 AM",
                    ),
                    const SizedBox(width: 18),
                    _infoIcon(
                      Icons.video_call,
                      "Online",
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Skin Consultation • Acne Follow-up",
                    style: TextStyle(
                      color: darkText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _showRescheduleDialog();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text("Reschedule"),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(
                            color: Colors.redAccent,
                          ),
                        ),
                        onPressed: () {
                          _showCancelDialog();
                        },
                        icon: const Icon(Icons.close),
                        label: const Text("Cancel"),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      _showAppointmentDetails();
                    },
                    child: const Text(
                      "Appointment Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // PATIENT TOOLS
  // ----------------------------------------------------------

  Widget _buildPatientTools() {
    final tools = [
      {
        "icon": Icons.search,
        "title": "Find Specialist",
        "sub": "Search doctor",
      },
      {
        "icon": Icons.health_and_safety_outlined,
        "title": "Symptoms Checker",
        "sub": "Check symptoms",
      },
      {
        "icon": Icons.camera_alt_outlined,
        "title": "Skin Scan",
        "sub": "Upload skin image",
      },
      {
        "icon": Icons.upload_file_outlined,
        "title": "Upload Reports",
        "sub": "Reports & images",
      },
      {
        "icon": Icons.medical_information_outlined,
        "title": "Treatment Plans",
        "sub": "Your treatments",
      },
      {
        "icon": Icons.medication_outlined,
        "title": "Medications",
        "sub": "Current medicines",
      },
      {
        "icon": Icons.note_alt_outlined,
        "title": "Health Notes",
        "sub": "Personal notes",
      },
      {
        "icon": Icons.history,
        "title": "Visit History",
        "sub": "Past visits",
      },
      {
        "icon": Icons.receipt_long_outlined,
        "title": "Prescriptions",
        "sub": "Past prescriptions",
      },
      {
        "icon": Icons.photo_library_outlined,
        "title": "Skin Progress",
        "sub": "Compare photos",
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("What would you like to do?"),
          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tools.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.55,
            ),
            itemBuilder: (context, index) {
              final tool = tools[index];

              return InkWell(
                onTap: () {
                  _showMessage(
                    "${tool["title"]} selected",
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(13),
                  decoration: _cardDecoration(),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: primary.withOpacity(.10),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Icon(
                          tool["icon"] as IconData,
                          color: primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              tool["title"] as String,
                              maxLines: 2,
                              style: TextStyle(
                                color: darkText,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              tool["sub"] as String,
                              maxLines: 2,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // DISEASE FILTER
  // ----------------------------------------------------------

  Widget _buildDiseaseFilter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("Find Dermatologist"),

          const SizedBox(height: 10),

          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: diseases.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final disease = diseases[index];
                final selected =
                    selectedDisease == disease;

                return ChoiceChip(
                  label: Text(disease),
                  selected: selected,
                  selectedColor: primary,
                  labelStyle: TextStyle(
                    color: selected
                        ? Colors.white
                        : darkText,
                    fontWeight: FontWeight.w600,
                  ),
                  onSelected: (_) {
                    setState(() {
                      selectedDisease = disease;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // DOCTORS
  // ----------------------------------------------------------

  Widget _buildDoctorsSection(
    List<Doctor> filteredDoctors,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Available Dermatologists",
                  style: TextStyle(
                    color: darkText,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "${filteredDoctors.length} Doctors",
                style: TextStyle(
                  color: primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (filteredDoctors.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: _cardDecoration(),
              child: const Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 50,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "No dermatologist found",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

          ...filteredDoctors.map(
            (doctor) => _doctorCard(doctor),
          ),
        ],
      ),
    );
  }

  Widget _doctorCard(Doctor doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(15),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _doctorAvatar(
                doctor.avatar,
                size: 65,
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            doctor.name,
                            style: TextStyle(
                              color: darkText,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.verified,
                          color: primary,
                          size: 16,
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Text(
                      doctor.specialty,
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "${doctor.experience} Experience",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 17,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          doctor.rating,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " (${doctor.reviews})",
                          style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    doctor.fee,
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "consultation",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const Divider(height: 24),

          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 17,
                color: Colors.black54,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  "${doctor.clinic}, ${doctor.location}",
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 17,
                color: primary,
              ),
              const SizedBox(width: 4),
              Text(
                doctor.nextAvailable,
                style: TextStyle(
                  color: primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                doctor.mode,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 10,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _showDoctorDetails(doctor);
                  },
                  child: const Text(
                    "View Details",
                  ),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    _showBookingDialog(doctor);
                  },
                  child: const Text(
                    "Book Now",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // SKIN PROGRESS
  // ----------------------------------------------------------

  Widget _buildSkinProgress() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            "Skin Progress",
            action: "View All",
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: Row(
              children: [
                _progressBox(
                  "Before",
                  Icons.image_outlined,
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.black38,
                ),
                _progressBox(
                  "Today",
                  Icons.photo_camera_outlined,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Acne Progress",
                        style: TextStyle(
                          color: darkText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Track your skin changes over time.",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Compare Photos →",
                        style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressBox(
    String title,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: primary.withOpacity(.08),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: primary,
            size: 30,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // ----------------------------------------------------------
  // HEALTH TIPS
  // ----------------------------------------------------------

  Widget _buildHealthTips() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            "Skin Health Tips",
            action: "View All",
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: Row(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(.10),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.water_drop_outlined,
                    color: primary,
                    size: 32,
                  ),
                ),

                const SizedBox(width: 13),

                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Keep your skin clean & hydrated",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Use a gentle cleanser and keep your skin hydrated according to your skin type.",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // BOOK BUTTON
  // ----------------------------------------------------------

  Widget _buildBottomBookButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 5),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            _showAllDoctorsDialog();
          },
          icon: const Icon(Icons.add_circle_outline),
          label: const Text(
            "Book New Appointment",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // DOCTOR DETAILS
  // ----------------------------------------------------------

  void _showDoctorDetails(Doctor doctor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height * .72,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                _doctorAvatar(
                  doctor.avatar,
                  size: 95,
                ),

                const SizedBox(height: 13),

                Text(
                  doctor.name,
                  style: TextStyle(
                    color: darkText,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  doctor.specialty,
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                  children: [
                    _detailStat(
                      doctor.experience,
                      "Experience",
                    ),
                    _detailStat(
                      doctor.rating,
                      "Rating",
                    ),
                    _detailStat(
                      doctor.reviews,
                      "Reviews",
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                _detailRow(
                  Icons.location_on_outlined,
                  "Clinic",
                  "${doctor.clinic}, ${doctor.location}",
                ),

                _detailRow(
                  Icons.payments_outlined,
                  "Consultation Fee",
                  doctor.fee,
                ),

                _detailRow(
                  Icons.video_call_outlined,
                  "Consultation Mode",
                  doctor.mode,
                ),

                _detailRow(
                  Icons.access_time,
                  "Next Available",
                  doctor.nextAvailable,
                ),

                _detailRow(
                  Icons.medical_services_outlined,
                  "Specializes In",
                  doctor.diseases.join(", "),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _showBookingDialog(doctor);
                    },
                    child: const Text(
                      "Book Appointment",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ----------------------------------------------------------
  // BOOKING
  // ----------------------------------------------------------

  void _showBookingDialog(Doctor doctor) {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = const TimeOfDay(
      hour: 11,
      minute: 0,
    );

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              title: const Text(
                "Book Appointment",
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _doctorAvatar(
                          doctor.avatar,
                          size: 52,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                doctor.specialty,
                                style: TextStyle(
                                  color: primary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Select Date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    OutlinedButton.icon(
                      onPressed: () async {
                        final date =
                            await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 60),
                          ),
                          initialDate: selectedDate,
                        );

                        if (date != null) {
                          setDialogState(() {
                            selectedDate = date;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                      label: Text(
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Select Time",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    OutlinedButton.icon(
                      onPressed: () async {
                        final time =
                            await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );

                        if (time != null) {
                          setDialogState(() {
                            selectedTime = time;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.access_time,
                      ),
                      label: Text(
                        selectedTime.format(context),
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Consultation Type",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      value: "Online Consultation",
                      items: const [
                        DropdownMenuItem(
                          value: "Online Consultation",
                          child: Text(
                            "Online Consultation",
                          ),
                        ),
                        DropdownMenuItem(
                          value: "In Clinic",
                          child: Text("In Clinic"),
                        ),
                      ],
                      onChanged: (_) {},
                      decoration:
                          const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Reason for Visit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText:
                            "Describe your skin problem...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);

                    _showMessage(
                      "Appointment booked successfully!",
                    );
                  },
                  child: const Text("Confirm"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ----------------------------------------------------------
  // APPOINTMENT DETAILS
  // ----------------------------------------------------------

  void _showAppointmentDetails() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Appointment Details",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                _detailRow(
                  Icons.person_outline,
                  "Doctor",
                  "Dr. Ayesha Khan",
                ),

                _detailRow(
                  Icons.medical_services_outlined,
                  "Specialization",
                  "Acne & Skin Specialist",
                ),

                _detailRow(
                  Icons.calendar_month,
                  "Date",
                  "Tomorrow",
                ),

                _detailRow(
                  Icons.access_time,
                  "Time",
                  "11:00 AM",
                ),

                _detailRow(
                  Icons.video_call_outlined,
                  "Type",
                  "Online Consultation",
                ),

                _detailRow(
                  Icons.healing_outlined,
                  "Reason",
                  "Acne Follow-up",
                ),

                _detailRow(
                  Icons.payments_outlined,
                  "Fee",
                  "Rs. 2,500",
                ),

                const SizedBox(height: 15),

                const Text(
                  "Patient Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                _simpleInfoCard(
                  Icons.camera_alt_outlined,
                  "Latest Skin Scan",
                  "1 skin image uploaded",
                ),

                _simpleInfoCard(
                  Icons.description_outlined,
                  "Medical Reports",
                  "2 reports uploaded",
                ),

                _simpleInfoCard(
                  Icons.medication_outlined,
                  "Current Medication",
                  "View current medicines",
                ),

                _simpleInfoCard(
                  Icons.note_alt_outlined,
                  "Health Notes",
                  "3 notes available",
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _showMessage(
                        "Opening video consultation...",
                      );
                    },
                    icon: const Icon(
                      Icons.video_call,
                    ),
                    label: const Text(
                      "Join Video Consultation",
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ----------------------------------------------------------
  // RESCHEDULE
  // ----------------------------------------------------------

  void _showRescheduleDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Reschedule Appointment"),
        content: const Text(
          "Choose a new date and time for your dermatologist appointment.",
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: const Text("Close"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6254F4),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              _showMessage(
                "Reschedule options opened",
              );
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // CANCEL
  // ----------------------------------------------------------

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Cancel Appointment?",
        ),
        content: const Text(
          "Are you sure you want to cancel your upcoming appointment?",
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: const Text("Keep"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              _showMessage(
                "Appointment cancelled",
              );
            },
            child: const Text("Cancel Appointment"),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // SEARCH
  // ----------------------------------------------------------

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            "Search Dermatologist",
          ),
          content: TextField(
            autofocus: true,
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: const InputDecoration(
              hintText: "Doctor or specialization",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text("Done"),
            ),
          ],
        );
      },
    );
  }

  // ----------------------------------------------------------
  // ALL DOCTORS
  // ----------------------------------------------------------

  void _showAllDoctorsDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .82,
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Text(
                "Choose Dermatologist",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];

                    return ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      leading: _doctorAvatar(
                        doctor.avatar,
                        size: 50,
                      ),
                      title: Text(
                        doctor.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "${doctor.specialty}\n${doctor.fee}",
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _showBookingDialog(doctor);
                        },
                        child: const Text("Book"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ----------------------------------------------------------
  // HELPERS
  // ----------------------------------------------------------

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.035),
          blurRadius: 14,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }

  Widget _sectionTitle(
    String title, {
    String? action,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: darkText,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (action != null)
          Text(
            action,
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  Widget _doctorAvatar(
    String initials, {
    double size = 60,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            primary.withOpacity(.25),
            primary.withOpacity(.75),
          ],
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size * .27,
          ),
        ),
      ),
    );
  }

  Widget _statusBadge(
    String text,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.10),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoIcon(
    IconData icon,
    String text,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: primary,
          size: 17,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _detailStat(
    String value,
    String title,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: primary,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _detailRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: primary,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    color: darkText,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _simpleInfoCard(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: primary.withOpacity(.06),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: darkText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: primary,
            size: 15,
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: primary,
      ),
    );
  }
}

// ============================================================
// DOCTOR MODEL
// ============================================================

class Doctor {
  final String name;
  final String specialty;
  final String experience;
  final String rating;
  final String reviews;
  final String fee;
  final String clinic;
  final String location;
  final String nextAvailable;
  final String mode;
  final List<String> diseases;
  final String avatar;

  Doctor({
    required this.name,
    required this.specialty,
    required this.experience,
    required this.rating,
    required this.reviews,
    required this.fee,
    required this.clinic,
    required this.location,
    required this.nextAvailable,
    required this.mode,
    required this.diseases,
    required this.avatar,
  });
}