import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController(text: "Kashif Meer");

  final TextEditingController emailController =
      TextEditingController(text: "kashifmehar800@gmail.com");

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController subjectController =
      TextEditingController();

  final TextEditingController messageController =
      TextEditingController();

  String selectedCountry = "🇮🇳";
  String selectedCode = "+91";

  final List<Map<String, String>> countries = [
    {
      "flag": "🇮🇳",
      "code": "+91",
      "name": "India",
    },
    {
      "flag": "🇵🇰",
      "code": "+92",
      "name": "Pakistan",
    },
    {
      "flag": "🇺🇸",
      "code": "+1",
      "name": "USA",
    },
    {
      "flag": "🇬🇧",
      "code": "+44",
      "name": "UK",
    },
    {
      "flag": "🇦🇪",
      "code": "+971",
      "name": "UAE",
    },
    {
      "flag": "🇸🇦",
      "code": "+966",
      "name": "Saudi Arabia",
    },
  ];

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Your message has been submitted successfully!",
          ),
          backgroundColor: Color(0xFFD4A373),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  InputDecoration fieldDecoration({
    required String hintText,
  }) {
    return InputDecoration(
      hintText: hintText,

      hintStyle: const TextStyle(
        color: Color(0xFF999999),
        fontSize: 16,
      ),

      filled: true,

      fillColor: const Color(0xFFFCF9F2),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFFD4A373),
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );
  }

  Widget fieldTitle(
    String title, {
    bool required = true,
  }) {
    return RichText(
      text: TextSpan(
        text: title,

        style: const TextStyle(
          color: Color(0xFF2D3B5F),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),

        children: required
            ? const [
                TextSpan(
                  text: " *",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ]
            : [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // =================================================
      // APP BAR
      // =================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,

        leading: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            top: 8,
            bottom: 8,
          ),

          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(14),

              border: Border.all(
                color: const Color(0xFFE8E8E8),
                width: 1.5,
              ),
            ),

            child: IconButton(
              padding: EdgeInsets.zero,

              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFFD4A373),
                size: 20,
              ),

              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),

        title: const Text(
          "Contact us",

          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),

        toolbarHeight: 75,
      ),

      // =================================================
      // BODY
      // =================================================

      body: Form(
        key: _formKey,

        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            10,
            24,
            25,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // =================================================
              // FULL NAME
              // =================================================

              fieldTitle("Full Name"),

              const SizedBox(height: 8),

              TextFormField(
                controller: nameController,

                style: const TextStyle(
                  color: Color(0xFF2D3B5F),
                  fontSize: 16,
                ),

                decoration: fieldDecoration(
                  hintText: "Full Name",
                ),

                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Please enter your full name";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // =================================================
              // EMAIL
              // =================================================

              fieldTitle("Email"),

              const SizedBox(height: 8),

              TextFormField(
                controller: emailController,

                keyboardType:
                    TextInputType.emailAddress,

                style: const TextStyle(
                  color: Color(0xFF2D3B5F),
                  fontSize: 16,
                ),

                decoration: fieldDecoration(
                  hintText: "Email",
                ),

                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Please enter your email";
                  }

                  if (!value.contains("@") ||
                      !value.contains(".")) {
                    return "Please enter a valid email";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // =================================================
              // PHONE NUMBER
              // =================================================

              fieldTitle(
                "Phone Number",
                required: false,
              ),

              const SizedBox(height: 8),

              Container(
                height: 54,

                decoration: BoxDecoration(
                  color: const Color(0xFFFCF9F2),

                  borderRadius:
                      BorderRadius.circular(10),
                ),

                child: Row(
                  children: [

                    // COUNTRY SELECTOR
                    InkWell(
                      borderRadius:
                          const BorderRadius.only(
                        topLeft:
                            Radius.circular(10),
                        bottomLeft:
                            Radius.circular(10),
                      ),

                      onTap: () {
                        showModalBottomSheet(
                          context: context,

                          backgroundColor:
                              Colors.white,

                          shape:
                              const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),

                          builder: (context) {
                            return SafeArea(
                              child: ListView(
                                shrinkWrap: true,

                                children:
                                    countries.map(
                                  (country) {
                                    return ListTile(
                                      leading: Text(
                                        country["flag"]!,
                                        style:
                                            const TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),

                                      title: Text(
                                        country["name"]!,
                                        style:
                                            const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),

                                      trailing: Text(
                                        country["code"]!,
                                        style:
                                            const TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color(0xFF2D3B5F),
                                        ),
                                      ),

                                      onTap: () {
                                        setState(() {
                                          selectedCountry =
                                              country["flag"]!;

                                          selectedCode =
                                              country["code"]!;
                                        });

                                        Navigator.pop(
                                          context,
                                        );
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                            );
                          },
                        );
                      },

                      child: SizedBox(
                        width: 105,

                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [

                            Text(
                              selectedCountry,

                              style:
                                  const TextStyle(
                                fontSize: 23,
                              ),
                            ),

                            const SizedBox(width: 5),

                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 23,
                            ),

                            Container(
                              height: 34,
                              width: 1,

                              margin:
                                  const EdgeInsets.only(
                                left: 5,
                              ),

                              color:
                                  const Color(0xFFE2E2E2),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // COUNTRY CODE
                    Text(
                      selectedCode,

                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(width: 7),

                    // PHONE
                    Expanded(
                      child: TextFormField(
                        controller: phoneController,

                        keyboardType:
                            TextInputType.phone,

                        style: const TextStyle(
                          color:
                              Color(0xFF2D3B5F),
                          fontSize: 16,
                        ),

                        decoration:
                            const InputDecoration(
                          hintText:
                              "Phone Number",

                          hintStyle:
                              TextStyle(
                            color:
                                Color(0xFF999999),
                            fontSize: 15,
                          ),

                          border:
                              InputBorder.none,

                          contentPadding:
                              EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =================================================
              // SUBJECT
              // =================================================

              fieldTitle("Subject"),

              const SizedBox(height: 8),

              TextFormField(
                controller: subjectController,

                style: const TextStyle(
                  color: Color(0xFF2D3B5F),
                  fontSize: 16,
                ),

                decoration: fieldDecoration(
                  hintText: "Subject",
                ),

                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Please enter a subject";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // =================================================
              // MESSAGE
              // =================================================

              fieldTitle("Message"),

              const SizedBox(height: 8),

              TextFormField(
                controller: messageController,

                maxLines: 4,

                style: const TextStyle(
                  color: Color(0xFF2D3B5F),
                  fontSize: 16,
                ),

                decoration:
                    fieldDecoration(
                  hintText: "Write here...",
                ).copyWith(
                  contentPadding:
                      const EdgeInsets.all(18),
                ),

                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Please enter your message";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // =================================================
              // SUBMIT BUTTON
              // =================================================

              SizedBox(
                width: double.infinity,

                height: 54,

                child: ElevatedButton(
                  onPressed: submitForm,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFD4A373),

                    foregroundColor:
                        Colors.white,

                    elevation: 0,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(28),
                    ),
                  ),

                  child: const Text(
                    "Submit",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}