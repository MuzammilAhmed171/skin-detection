import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_screen.dart';
import 'navigation_drawer.dart';
import 'treatment_details_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dual-Lens Dermatologist',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: const Color(0xFFD6A58E),
        scaffoldBackgroundColor: const Color(0xFFFBF9F6),
        textTheme: GoogleFonts.dmSansTextTheme(),
      ),
      home: const LoginScreen(
        homeScreen: SkinDetectionScreen(),
      ),
    );
  }
}

class SkinDetectionScreen extends StatefulWidget {
  const SkinDetectionScreen({super.key});

  @override
  State<SkinDetectionScreen> createState() => _SkinDetectionScreenState();
}

class _SkinDetectionScreenState extends State<SkinDetectionScreen> {
  static const String _defaultApiBaseUrl = 'https://skin-detection-api-v4.vercel.app';

  String _apiBaseUrl = const String.fromEnvironment(
    'API_URL',
    defaultValue: _defaultApiBaseUrl,
  );

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  Uint8List? _selectedImageBytes;
  bool _isLoading = false;
  bool _isAnalyzing = false;
  String? _predictionResult;
  double? _confidenceScore;
  String? _treatmentSuggestion;
  String? _reasoning;
  bool _isNotFound = false;
  String? _notFoundMessage;
  double? _skinPercentage;

  String _normalizeDiseaseName(String value) {
    final normalized = value.trim().toLowerCase();

    if (normalized == 'acne') return 'Acne';
    if (normalized.contains('chickenpox') ||
        normalized.contains('chicken pox')) {
      return 'Chickenpox';
    }
    if (normalized.contains('dyshidrotic') ||
        normalized.contains('pompholyx')) {
      return 'Dyshidrotic Eczema';
    }
    if (normalized.contains('ringworm') ||
        normalized.contains('tinea') ||
        normalized.contains('fungal')) {
      return 'Ringworm';
    }

    return value.trim();
  }

  final Map<String, Map<String, dynamic>> _diseaseDatabase = {
    'Acne': {
      'allopathic': [
        {
          'icon': Icons.medication,
          'title': 'MEDICINE (ORAL)',
          'desc': 'Precision oral treatments for internal conditions.'
        },
        {
          'icon': Icons.clean_hands,
          'title': 'CREAMS & TOPICALS',
          'desc': 'Prescription-grade creams for localized relief.'
        },
        {
          'icon': Icons.medical_information,
          'title': 'MEDICAL ADVICE',
          'desc': 'Professional guidance from specialists.'
        },
        {
          'icon': Icons.health_and_safety,
          'title': 'TAKE CARE (ROUTINE)',
          'desc': 'Daily skincare hygiene and preventive care.'
        },
      ],
      'homeopathic': [
        {
          'icon': Icons.spa,
          'title': 'HERBAL REMEDIES',
          'desc': 'Natural extracts for holistic symptom support.'
        },
        {
          'icon': Icons.water_drop,
          'title': 'NATURAL OILS',
          'desc': 'Therapeutic plant oils for skin nourishment.'
        },
        {
          'icon': Icons.restaurant_menu,
          'title': 'DIETARY GUIDE',
          'desc': 'Holistic nutritional and lifestyle recommendations.'
        },
        {
          'icon': Icons.block,
          'title': "DO'S & DON'TS",
          'desc': 'Essential lifestyle changes and precautions.'
        },
      ],
      'reasoning': 'Detected typical acne vulgaris patterns.'
    },
    'Chickenpox': {
      'allopathic': [
        {
          'icon': Icons.medication,
          'title': 'MEDICINE (ORAL)',
          'desc': 'Antiviral meds and antihistamines for itch.'
        },
        {
          'icon': Icons.clean_hands,
          'title': 'CREAMS & TOPICALS',
          'desc': 'Calamine lotion for soothing the rash.'
        },
        {
          'icon': Icons.medical_information,
          'title': 'MEDICAL ADVICE',
          'desc': 'Consult doctor if fever persists or spots infect.'
        },
        {
          'icon': Icons.health_and_safety,
          'title': 'TAKE CARE (ROUTINE)',
          'desc': 'Keep skin cool. Do not scratch blisters.'
        },
      ],
      'homeopathic': [
        {
          'icon': Icons.spa,
          'title': 'HERBAL REMEDIES',
          'desc': 'Oatmeal baths to relieve severe itching.'
        },
        {
          'icon': Icons.water_drop,
          'title': 'NATURAL OILS',
          'desc': 'Neem or sandalwood paste for cooling effect.'
        },
        {
          'icon': Icons.restaurant_menu,
          'title': 'DIETARY GUIDE',
          'desc': 'Soft, bland foods to prevent mouth sores.'
        },
        {
          'icon': Icons.block,
          'title': "DO'S & DON'TS",
          'desc': 'Do not pop blisters to prevent scarring.'
        },
      ],
      'reasoning': 'Detected vesicular rashes characteristic of chickenpox.'
    },
    'Dyshidrotic Eczema': {
      'allopathic': [
        {
          'icon': Icons.medication,
          'title': 'MEDICINE (ORAL)',
          'desc': 'Oral corticosteroids for severe flare-ups.'
        },
        {
          'icon': Icons.clean_hands,
          'title': 'CREAMS & TOPICALS',
          'desc': 'Topical steroids and thick emollients.'
        },
        {
          'icon': Icons.medical_information,
          'title': 'MEDICAL ADVICE',
          'desc': 'Allergy testing to identify specific triggers.'
        },
        {
          'icon': Icons.health_and_safety,
          'title': 'TAKE CARE (ROUTINE)',
          'desc': 'Moisturize immediately after lukewarm baths.'
        },
      ],
      'homeopathic': [
        {
          'icon': Icons.spa,
          'title': 'HERBAL REMEDIES',
          'desc': 'Aloe vera and calendula for natural soothing.'
        },
        {
          'icon': Icons.water_drop,
          'title': 'NATURAL OILS',
          'desc': 'Coconut or sunflower seed oil for hydration.'
        },
        {
          'icon': Icons.restaurant_menu,
          'title': 'DIETARY GUIDE',
          'desc': 'Anti-inflammatory diet, avoid common allergens.'
        },
        {
          'icon': Icons.block,
          'title': "DO'S & DON'TS",
          'desc': 'Avoid harsh soaps and synthetic fabrics.'
        },
      ],
      'reasoning':
          'Detected red, itchy, and inflamed skin typical of dyshidrotic eczema.'
    },
    'Ringworm': {
      'allopathic': [
        {
          'icon': Icons.medication,
          'title': 'MEDICINE (ORAL)',
          'desc': 'Antifungal pills for widespread infections.'
        },
        {
          'icon': Icons.clean_hands,
          'title': 'CREAMS & TOPICALS',
          'desc': 'Antifungal creams (clotrimazole, terbinafine).'
        },
        {
          'icon': Icons.medical_information,
          'title': 'MEDICAL ADVICE',
          'desc': 'Consult if rash doesn\'t improve in 2 weeks.'
        },
        {
          'icon': Icons.health_and_safety,
          'title': 'TAKE CARE (ROUTINE)',
          'desc': 'Keep affected area clean and dry.'
        },
      ],
      'homeopathic': [
        {
          'icon': Icons.spa,
          'title': 'HERBAL REMEDIES',
          'desc': 'Tea tree oil extracts (diluted) applied topically.'
        },
        {
          'icon': Icons.water_drop,
          'title': 'NATURAL OILS',
          'desc': 'Oregano oil or lemongrass oil as antifungals.'
        },
        {
          'icon': Icons.restaurant_menu,
          'title': 'DIETARY GUIDE',
          'desc': 'Reduce sugar intake to limit fungal growth.'
        },
        {
          'icon': Icons.block,
          'title': "DO'S & DON'TS",
          'desc': 'Do not share towels or personal items.'
        },
      ],
      'reasoning': 'Detected distinct ring-shaped scaly patches.'
    },
  };

  Future<void> _saveImageLocally(File imageFile) async {
    try {
      if (kIsWeb) {
        if (mounted) {
          setState(() {
            _selectedImage = imageFile;
            _predictionResult = null;
            _confidenceScore = null;
            _treatmentSuggestion = null;
            _reasoning = null;
            _isNotFound = false;
            _notFoundMessage = null;
            _skinPercentage = null;
          });
        }
        return;
      }
      final directory = await getApplicationDocumentsDirectory();
      final path =
          '${directory.path}/skin_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage = await imageFile.copy(path);

      if (mounted) {
        setState(() {
          _selectedImage = savedImage;
          _predictionResult = null;
          _confidenceScore = null;
          _treatmentSuggestion = null;
          _reasoning = null;
          _isNotFound = false;
          _notFoundMessage = null;
          _skinPercentage = null;
        });
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error saving image: $e', Colors.red);
      }
    }
  }

  Future<void> _openCamera() async {
    try {
      if (mounted) setState(() => _isLoading = true);

      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
        maxWidth: 1500,
        maxHeight: 1500,
      );

      if (photo != null) {
        final bytes = await photo.readAsBytes();
        if (mounted) {
          setState(() {
            _selectedImageBytes = bytes;
            if (!kIsWeb) {
              _selectedImage = File(photo.path);
            } else {
              _selectedImage = null;
            }
            _predictionResult = null;
            _confidenceScore = null;
            _treatmentSuggestion = null;
            _reasoning = null;
            _isNotFound = false;
            _notFoundMessage = null;
            _skinPercentage = null;
            _isLoading = false;
          });
          _showSnackBar(
              '📸 Photo captured successfully!', const Color(0xFF6C63FF));
        }
      } else {
        if (mounted) setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar('Camera error: $e', Colors.red);
      }
    }
  }

  Future<void> _openGallery() async {
    try {
      if (mounted) setState(() => _isLoading = true);

      final XFile? photo = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
        maxWidth: 1500,
        maxHeight: 1500,
      );

      if (photo != null) {
        final bytes = await photo.readAsBytes();
        if (mounted) {
          setState(() {
            _selectedImageBytes = bytes;
            if (!kIsWeb) {
              _selectedImage = File(photo.path);
            } else {
              _selectedImage = null;
            }
            _predictionResult = null;
            _confidenceScore = null;
            _treatmentSuggestion = null;
            _reasoning = null;
            _isNotFound = false;
            _notFoundMessage = null;
            _skinPercentage = null;
            _isLoading = false;
          });
          _showSnackBar(
              '🖼️ Image selected successfully!', const Color(0xFF6C63FF));
        }
      } else {
        if (mounted) setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSnackBar('Gallery error: $e', Colors.red);
      }
    }
  }

  Future<void> _analyzeImage() async {
    if (_selectedImageBytes == null && _selectedImage == null) {
      _showSnackBar('Please select an image first!', Colors.orange);
      return;
    }

    try {
      if (mounted) setState(() => _isAnalyzing = true);

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$_apiBaseUrl/predict'),
      );

      if (_selectedImageBytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes('image', _selectedImageBytes!, filename: 'upload.jpg'),
        );
      } else {
        request.files.add(
          await http.MultipartFile.fromPath('image', _selectedImage!.path),
        );
      }
      final streamedResponse = await request.send().timeout(
            const Duration(seconds: 30),
          );
      final response = await http.Response.fromStream(streamedResponse);
      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw Exception('Server returned an invalid response.');
      }
      final data = decoded;

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception(data['error'] ?? 'Model could not analyze this image.');
      }

      final predictionValue = data['prediction'] ?? data['disease'];
      if (predictionValue is! String || predictionValue.trim().isEmpty) {
        throw Exception(data['error'] ??
            'No disease prediction was returned by the AI server.');
      }

      final bool isSkin = data['is_skin'] as bool? ?? true;
      final bool isValidDisease = data['is_valid_disease'] as bool? ?? true;
      final rawDisease = predictionValue.trim();
      final String predictedDisease = _normalizeDiseaseName(rawDisease);
      final confidenceValue = data['confidence'];
      final double confidence =
          confidenceValue is num ? confidenceValue.toDouble() : 0.0;
      final double? skinPct = data['skin_percentage'] != null
          ? (data['skin_percentage'] as num?)?.toDouble()
          : null;
      final String? serverMsg = data['message'] as String?;

      // Check if image is not skin or disease is not recognized
      if (!isSkin ||
          !isValidDisease ||
          predictedDisease.toLowerCase() == 'not found' ||
          !_diseaseDatabase.containsKey(predictedDisease)) {
        if (mounted) {
          setState(() {
            _isNotFound = true;
            _predictionResult = 'Not Found';
            _confidenceScore = confidence;
            _skinPercentage = skinPct;
            _notFoundMessage = serverMsg ??
                (!isSkin
                    ? 'No human skin detected in this image. Please upload a clear photo of the affected skin area.'
                    : 'Condition "$rawDisease" is not supported by this app. Please consult a dermatologist.');
            _treatmentSuggestion = null;
            _reasoning = null;
            _isAnalyzing = false;
          });

          _showSnackBar(
            '⚠️ Not Found: ${!isSkin ? "Skin not detected in image." : "Condition could not be recognized."}',
            const Color(0xFFF59E0B),
          );
        }
        return;
      }

      final treatment = _diseaseDatabase[predictedDisease] ??
          {
            'allopathic': 'Use this result only as a screening aid.',
            'homeopathic': 'Please consult a qualified dermatologist.',
            'reasoning': 'The trained model returned this result.',
          };

      if (mounted) {
        setState(() {
          _isNotFound = false;
          _notFoundMessage = null;
          _skinPercentage = skinPct;
          _predictionResult = predictedDisease;
          _confidenceScore = confidence;
          _treatmentSuggestion =
              '💊 Allopathic: ${treatment['allopathic']}\n🌿 Homeopathic: ${treatment['homeopathic']}';
          _reasoning = treatment['reasoning'];
          _isAnalyzing = false;
        });

        _showSnackBar(
          '✅ Diagnosis: $predictedDisease (${confidence.toStringAsFixed(1)}%)',
          const Color(0xFF22C55E),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isAnalyzing = false);
        String msg = 'Analysis error: $e';
        if (e.toString().contains('SocketException') ||
            e.toString().contains('ClientException') ||
            e.toString().contains('TimeoutException') ||
            e.toString().contains('No route to host')) {
          msg =
              '⚠️ AI server is unreachable ($_apiBaseUrl).\n1. Run "python app.py" on the PC.\n2. Make sure it listens on 0.0.0.0:5000.\n3. Allow port 5000 through Windows Firewall.\n4. Keep phone and PC on the same Wi-Fi.';
        }
        _showSnackBar(msg, Colors.red);
      }
    }
  }

  void _deleteImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: const Text(
            'Delete Image',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
          ),
          content: const Text(
            'Are you sure you want to delete this image?',
            style: TextStyle(color: Color(0xFF4A4A6A)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: Color(0xFF6C63FF), fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_selectedImage != null) {
                  try {
                    await _selectedImage!.delete();
                  } catch (e) {
                    // Error handled silently
                  }
                }
                if (mounted) {
                  setState(() {
                    _selectedImage = null;
                    _predictionResult = null;
                    _confidenceScore = null;
                    _treatmentSuggestion = null;
                    _reasoning = null;
                    _isNotFound = false;
                    _notFoundMessage = null;
                    _skinPercentage = null;
                  });
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  _showSnackBar('🗑️ Image deleted successfully!',
                      const Color(0xFFEF4444));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message, Color color) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.all(16),
          elevation: 0,
        ),
      );
    }
  }

  void _showServerConfigDialog() {
    final controller = TextEditingController(text: _apiBaseUrl);
    String testStatus = '';
    Color statusColor = Colors.grey;
    bool isTesting = false;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Row(
                children: [
                  Icon(Icons.dns_rounded, color: Color(0xFF6C63FF)),
                  SizedBox(width: 10),
                  Text('Server Connection',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter your PC/Backend IP address:',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'https://skin-detection-api-v4.vercel.app',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        prefixIcon: const Icon(Icons.link, size: 20),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: isTesting
                          ? null
                          : () async {
                              setModalState(() {
                                isTesting = true;
                                testStatus = 'Testing connection...';
                                statusColor = Colors.orange;
                              });
                              try {
                                final res = await http
                                    .get(Uri.parse(
                                        '${controller.text.trim()}/health'))
                                    .timeout(const Duration(seconds: 4));
                                if (res.statusCode == 200) {
                                  setModalState(() {
                                    isTesting = false;
                                    testStatus = '✅ Connected to AI server!';
                                    statusColor = Colors.green;
                                  });
                                } else {
                                  setModalState(() {
                                    isTesting = false;
                                    testStatus =
                                        '⚠️ Status ${res.statusCode}: Unexpected response';
                                    statusColor = Colors.red;
                                  });
                                }
                              } catch (e) {
                                setModalState(() {
                                  isTesting = false;
                                  testStatus =
                                      '❌ Could not connect.\nRun "python app.py" on PC & check Wi-Fi.';
                                  statusColor = Colors.red;
                                });
                              }
                            },
                      icon: isTesting
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(Icons.wifi_find_rounded, size: 18),
                      label: const Text('Test Connection'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C63FF),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    if (testStatus.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Text(
                        testStatus,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() => _apiBaseUrl = _defaultApiBaseUrl);
                    controller.text = _defaultApiBaseUrl;
                    setModalState(() {
                      testStatus = 'Default PC server address restored.';
                      statusColor = Colors.blue;
                    });
                  },
                  child: const Text('Use PC Default'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final trimmed = controller.text.trim();
                    if (trimmed.isNotEmpty) {
                      setState(() {
                        _apiBaseUrl = trimmed.endsWith('/')
                            ? trimmed.substring(0, trimmed.length - 1)
                            : trimmed;
                      });
                      Navigator.pop(ctx);
                      _showSnackBar('Server updated: $_apiBaseUrl',
                          const Color(0xFF22C55E));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF9F6),
      drawer: const CustomNavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF2C2522)),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFD09068),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.medical_services_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                _predictionResult != null && !_isNotFound
                    ? 'Dual-lens Dermatologist'
                    : 'Dual-lens Dermatologist',
                style: GoogleFonts.dmSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C2522),
                  letterSpacing: -0.3,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: _showServerConfigDialog,
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFC78B74).withValues(alpha: 0.5),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.sensors,
                    color: Color(0xFFC78B74),
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'IP',
                    style: TextStyle(
                      color: Color(0xFFC78B74),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              // Image Card
              Container(
                width: double.infinity,
                height: 360,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _selectedImage == null
                          ? const Color(0xFFD3A28E)
                          : const Color(0xFFD3A28E).withValues(alpha: 0.1),
                      _selectedImage == null
                          ? const Color(0xFFC78B74)
                          : const Color(0xFFC78B74).withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    if (_selectedImage == null)
                      BoxShadow(
                        color: const Color(0xFFC78B74).withValues(alpha: 0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                  ],
                ),
                child: (_selectedImageBytes != null || _selectedImage != null)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            _selectedImageBytes != null
                                ? Image.memory(
                                    _selectedImageBytes!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.3),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: GestureDetector(
                                onTap: _deleteImage,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Color(0xFFEF4444),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            if (_isLoading)
                              const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              ),
                          ],
                        ),
                      )
                    : _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDCA993)
                                        .withValues(alpha: 0.6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 40,
                                    color: Color(0xFF9E654E),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Upload Skin Image',
                                  style: GoogleFonts.playfairDisplay(
                                    color: const Color(0xFF2C2522),
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap camera or gallery below',
                                  style: GoogleFonts.dmSans(
                                    color: const Color(0xFF2C2522)
                                        .withValues(alpha: 0.8),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
              ),
              const SizedBox(height: 24),

              // Action Buttons Card
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: const Color(0xFFE6DFD5),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.camera_alt,
                        label: 'Camera',
                        color: const Color(0xFFC78B74),
                        onTap: _isLoading ? null : _openCamera,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: const Color(0xFFE6DFD5),
                    ),
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.photo_library,
                        label: 'Gallery',
                        color: const Color(0xFFC78B74),
                        onTap: _isLoading ? null : _openGallery,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Analyze & Delete Row
              if (_selectedImage != null || _selectedImageBytes != null) ...[
                Row(
                  children: [
                    Expanded(
                      child: _buildGradientButton(
                        onPressed: _isAnalyzing ? null : _analyzeImage,
                        isLoading: _isAnalyzing,
                        icon: Icons.analytics_outlined,
                        label: _isAnalyzing ? 'Analyzing...' : 'Analyze',
                        gradient: const LinearGradient(
                          colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildGradientButton(
                        onPressed: _deleteImage,
                        isLoading: false,
                        icon: Icons.delete_outline,
                        label: 'Delete',
                        gradient: const LinearGradient(
                          colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],

              // Prediction Result Card
              if (_isNotFound)
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE11D48), Color(0xFFF97316)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE11D48).withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.search_off_rounded,
                          color: Colors.white,
                          size: 38,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Not Found / Invalid Image',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_skinPercentage != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _skinPercentage! < 20.0
                                ? 'Skin Area: ${_skinPercentage!.toStringAsFixed(1)}% (Not Skin)'
                                : 'Confidence: Too Low (${(_confidenceScore ?? 0).toStringAsFixed(1)}%)',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      const SizedBox(height: 14),
                      Text(
                        _notFoundMessage ??
                            'The uploaded image is either not human skin or does not match any known condition in our AI model.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.95),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                )
              else if (_predictionResult != null && _confidenceScore != null)
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    border:
                        Border.all(color: const Color(0xFFE6DFD5), width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.medical_services_outlined,
                              color: Color(0xFFC78B74), size: 24),
                          const SizedBox(width: 8),
                          Text(
                            'Diagnosis Result',
                            style: GoogleFonts.dmSans(
                              color: const Color(0xFF2C2522),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _predictionResult!,
                        style: GoogleFonts.playfairDisplay(
                          color: const Color(0xFF1C1715),
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_confidenceScore!.toStringAsFixed(1)}% Confidence',
                        style: GoogleFonts.dmSans(
                          color: const Color(0xFF2C2522).withValues(alpha: 0.7),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              if (_predictionResult != null) const SizedBox(height: 20),

              // Help Tips Card when Not Found
              if (_isNotFound)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.tips_and_updates_outlined,
                              color: Color(0xFFF59E0B), size: 22),
                          SizedBox(width: 8),
                          Text(
                            'How to take a valid photo:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _buildHelpBullet(
                        icon: Icons.wb_sunny_outlined,
                        title: 'Good Lighting',
                        description:
                            'Ensure natural, clear lighting without heavy shadows or glare.',
                      ),
                      const SizedBox(height: 10),
                      _buildHelpBullet(
                        icon: Icons.center_focus_strong_outlined,
                        title: 'Close & In-Focus',
                        description:
                            'Center the camera on the affected skin lesion and tap to focus.',
                      ),
                      const SizedBox(height: 10),
                      _buildHelpBullet(
                        icon: Icons.block_outlined,
                        title: 'Skin Lesion Only',
                        description:
                            'Avoid background objects, animals, furniture, or clothes.',
                      ),
                    ],
                  ),
                ),
              if (_isNotFound) const SizedBox(height: 20),

              // Treatment Card
              if (_predictionResult != null &&
                  !_isNotFound &&
                  _diseaseDatabase.containsKey(_predictionResult))
                TreatmentToggleCard(
                  diseaseData: _diseaseDatabase[_predictionResult]!,
                  diseaseName: _predictionResult!,
                ),
              if (_predictionResult != null && !_isNotFound)
                const SizedBox(height: 24),

              // Disease List Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3EBE1),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: const Color(0xFFE6DFD5), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detectable Diseases',
                      style: GoogleFonts.dmSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1C1715),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDiseaseListItem(Icons.face, 'Acne'),
                    const SizedBox(height: 12),
                    _buildDiseaseListItem(Icons.healing, 'Chickenpox'),
                    const SizedBox(height: 12),
                    _buildDiseaseListItem(
                        Icons.coronavirus_outlined, 'Dyshidrotic Eczema'),
                    const SizedBox(height: 12),
                    _buildDiseaseListItem(Icons.all_inclusive, 'Ringworm'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.info_outline,
                        color: Color(0xFF6C63FF),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Take clear, well-lit photos for accurate AI diagnosis',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF4A4A6A),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: GoogleFonts.dmSans(
                color: const Color(0xFF2C2522),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required VoidCallback? onPressed,
    required bool isLoading,
    required IconData icon,
    required String label,
    required LinearGradient gradient,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: gradient.colors.first.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildTreatmentItem({
    required String icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(icon, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF1A1A2E),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHelpBullet({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: const Color(0xFF6C63FF)),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 13, color: Color(0xFF4A4A6A), height: 1.4),
              children: [
                TextSpan(
                  text: '$title: ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
                ),
                TextSpan(text: description),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDiseaseListItem(IconData icon, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFFC78B74), size: 18),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 15,
            color: const Color(0xFF2C2522),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class TreatmentToggleCard extends StatefulWidget {
  final Map<String, dynamic> diseaseData;
  final String diseaseName;

  const TreatmentToggleCard({
    super.key,
    required this.diseaseData,
    required this.diseaseName,
  });

  @override
  State<TreatmentToggleCard> createState() => _TreatmentToggleCardState();
}

class _TreatmentToggleCardState extends State<TreatmentToggleCard> {
  bool _isAllopathic = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFFE6DFD5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header / Toggle
          Container(
            height: 52,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFD6A58E).withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isAllopathic = true),
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        'Allopathic treatment',
                        style: GoogleFonts.dmSans(
                          color: _isAllopathic ? Colors.white : Colors.white70,
                          fontWeight:
                              _isAllopathic ? FontWeight.bold : FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _isAllopathic = !_isAllopathic),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isAllopathic = false),
                    child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Homeopathic',
                            style: GoogleFonts.dmSans(
                              color: !_isAllopathic
                                  ? Colors.white
                                  : Colors.white70,
                              fontWeight: !_isAllopathic
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.eco,
                              size: 16,
                              color: !_isAllopathic
                                  ? Colors.white
                                  : Colors.white70),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Treatment Grid (2 columns)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column 1 (Items 0, 1)
                Expanded(
                  child: Column(
                    children: [
                      _buildGridItem(
                          context,
                          widget.diseaseData[
                              _isAllopathic ? 'allopathic' : 'homeopathic'][0],
                          0),
                      const SizedBox(height: 20),
                      _buildGridItem(
                          context,
                          widget.diseaseData[
                              _isAllopathic ? 'allopathic' : 'homeopathic'][1],
                          1),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Column 2 (Items 2, 3)
                Expanded(
                  child: Column(
                    children: [
                      _buildGridItem(
                          context,
                          widget.diseaseData[
                              _isAllopathic ? 'allopathic' : 'homeopathic'][2],
                          2),
                      const SizedBox(height: 20),
                      _buildGridItem(
                          context,
                          widget.diseaseData[
                              _isAllopathic ? 'allopathic' : 'homeopathic'][3],
                          3),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildGridItem(
      BuildContext context, Map<String, dynamic> item, int tabIndex) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TreatmentDetailsPage(
              diseaseName: widget.diseaseName,
              isAllopathic: _isAllopathic,
              initialTab: tabIndex,
            ),
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item['icon'], color: const Color(0xFFC78B74), size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1C1715),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['desc'],
                  style: GoogleFonts.dmSans(
                    color: const Color(0xFF2C2522).withValues(alpha: 0.7),
                    fontSize: 11,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
