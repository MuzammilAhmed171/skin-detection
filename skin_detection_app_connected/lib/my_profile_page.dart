import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  // =========================
  // COLORS
  // =========================

  static const Color primaryColor = Color(0xFFD4A373);
  static const Color darkText = Color(0xFF26344D);
  static const Color backgroundColor = Color(0xFFFCF9F2);

  // =========================
  // PROFILE DATA
  // =========================

  String userName = 'Dermatologist';
  String email = 'Dermatologist800@gmail.com';
  String dateOfBirth = 'Not Added';
  String gender = 'Not Added';

  File? profileImage;

  bool isMyAccountSelected = true;

  // =========================
  // FAMILY MEMBERS
  // =========================

  final List<Map<String, String>> familyMembers = [];

  // =========================
  // PICK PROFILE IMAGE
  // =========================

  Future<void> _pickProfileImage() async {
    try {
      final picker = ImagePicker();

      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null && mounted) {
        setState(() {
          profileImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to select image'),
          ),
        );
      }
    }
  }

  // =========================
  // SELECT DATE
  // =========================

  Future<void> _selectDate(
    TextEditingController controller,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      controller.text =
          '${pickedDate.day.toString().padLeft(2, '0')}/'
          '${pickedDate.month.toString().padLeft(2, '0')}/'
          '${pickedDate.year}';
    }
  }

  // =========================
  // EDIT PROFILE
  // =========================

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: userName);
    final emailController = TextEditingController(text: email);
    final dobController = TextEditingController(
      text: dateOfBirth == 'Not Added' ? '' : dateOfBirth,
    );

    String selectedGender =
        gender == 'Not Added' ? 'Male' : gender;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              title: const Text(
                'Edit Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: dobController,
                      readOnly: true,
                      onTap: () {
                        _selectDate(dobController);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Date of Birth',
                        prefixIcon:
                            Icon(Icons.calendar_month_outlined),
                      ),
                    ),

                    const SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                     initialValue: selectedGender,
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        prefixIcon:
                            Icon(Icons.person_outline),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Male',
                          child: Text('Male'),
                        ),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text('Female'),
                        ),
                        DropdownMenuItem(
                          value: 'Other',
                          child: Text('Other'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            selectedGender = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      if (nameController.text.trim().isNotEmpty) {
                        userName =
                            nameController.text.trim();
                      }

                      if (emailController.text.trim().isNotEmpty) {
                        email =
                            emailController.text.trim();
                      }

                      if (dobController.text.trim().isNotEmpty) {
                        dateOfBirth =
                            dobController.text.trim();
                      }

                      gender = selectedGender;
                    });

                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // =========================
  // ADD FAMILY MEMBER
  // =========================

  void _showAddFamilyMemberDialog() {
    final nameController = TextEditingController();
    final relationController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'Add Family Member',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: relationController,
                decoration: const InputDecoration(
                  labelText: 'Relation',
                  prefixIcon:
                      Icon(Icons.family_restroom_outlined),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (nameController.text.trim().isEmpty) {
                  return;
                }

                setState(() {
                  familyMembers.add({
                    'name': nameController.text.trim(),
                    'relation':
                        relationController.text.trim().isEmpty
                            ? 'Family Member'
                            : relationController.text.trim(),
                  });
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // DELETE FAMILY MEMBER
  // =========================

  void _deleteFamilyMember(int index) {
    setState(() {
      familyMembers.removeAt(index);
    });
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // =========================
              // TOP HEADER
              // =========================

              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    // BACK BUTTON

                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: primaryColor,
                        ),
                      ),
                    ),

                    const SizedBox(width: 18),

                    // TITLE

                    const Expanded(
                   child: Text(
                        'My Profile',
                    style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: darkText,
                        ),
                      ),
                    ),

                    // EDIT PROFILE

                    TextButton.icon(
                      onPressed: _showEditProfileDialog,
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: primaryColor,
                      ),
                      label: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =========================
              // PROFILE HEADER
              // =========================

              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  // GREEN BACKGROUND

                  Container(
                    width: double.infinity,
                    height: 270,
                    color: primaryColor,
                  ),

                  // PROFILE CARD

                  Positioned(
                    top: 140,
                    left: 24,
                    right: 24,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        70,
                        20,
                        20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            userName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: darkText,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // TABS

                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9EDF4),
                              borderRadius:
                                  BorderRadius.circular(35),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isMyAccountSelected = true;
                                      });
                                    },
                                    child: Container(
                                      padding:
                                          const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isMyAccountSelected
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'My Account',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight:
                                                FontWeight.w600,
                                            color: darkText,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isMyAccountSelected = false;
                                      });
                                    },
                                    child: Container(
                                      padding:
                                          const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        color: !isMyAccountSelected
                                            ? Colors.white
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Family Members',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight:
                                                FontWeight.w600,
                                            color: darkText,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // PROFILE IMAGE

                  Positioned(
                    top: 20,
                    child: GestureDetector(
                      onTap: _pickProfileImage,
                      child: Stack(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            padding:
                                const EdgeInsets.all(7),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color(0xFFDDE1E8),
                              backgroundImage:
                                  profileImage != null
                                      ? FileImage(profileImage!)
                                      : null,
                              child: profileImage == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 80,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),

                          Positioned(
                            right: 2,
                            bottom: 4,
                            child: Container(
                              padding:
                                  const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // SPACE FOR OVERLAPPING CARD

              const SizedBox(height: 105),

              // =========================
              // PERSONAL INFO / FAMILY
              // =========================

              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                     color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: isMyAccountSelected
                    ? _buildPersonalInfo()
                    : _buildFamilyMembers(),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // PERSONAL INFO
  // =========================

  Widget _buildPersonalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Personal info',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),
            ),

            OutlinedButton.icon(
              onPressed: _showEditProfileDialog,
              icon: const Icon(
                Icons.edit_outlined,
                size: 18,
                color: darkText,
              ),
              label: const Text(
                'Edit',
                style: TextStyle(
                  color: darkText,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: primaryColor,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Divider(
          color: Colors.grey.shade200,
        ),

        const SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: _infoItem(
                icon: Icons.calendar_month,
                iconColor: Colors.teal,
                title: 'Date of Birth',
                value: dateOfBirth,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: _infoItem(
                icon: gender == 'Female'
                    ? Icons.female
                    : gender == 'Male'
                        ? Icons.male
                        : Icons.person_outline,
                iconColor: Colors.teal,
                title: 'Gender',
                value: gender,
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        _infoItem(
          icon: Icons.email_outlined,
          iconColor: Colors.deepPurple,
          title: 'Email',
          value: email,
        ),
      ],
    );
  }

  // =========================
  // FAMILY MEMBERS
  // =========================

  Widget _buildFamilyMembers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Family Members',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),
            ),

            IconButton(
              onPressed: _showAddFamilyMemberDialog,
              icon: const Icon(
                Icons.person_add_alt_1,
                color: primaryColor,
              ),
            ),
          ],
        ),

        Divider(
          color: Colors.grey.shade200,
        ),

        const SizedBox(height: 12),

        if (familyMembers.isEmpty)
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 25),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.family_restroom_outlined,
                    size: 60,
                    color: Colors.grey.shade400,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'No Family Members Added',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 18),

                  ElevatedButton.icon(
                    onPressed: _showAddFamilyMemberDialog,
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Add Family Member',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            itemCount: familyMembers.length,
            itemBuilder: (context, index) {
              final member = familyMembers[index];

              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    member['name'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: darkText,
                    ),
                  ),
                  subtitle: Text(
                    member['relation'] ?? '',
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      _deleteFamilyMember(index);
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  // =========================
  // INFO ITEM
  // =========================

  Widget _infoItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 28,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                value,
                style: const TextStyle(
                  color: darkText,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}