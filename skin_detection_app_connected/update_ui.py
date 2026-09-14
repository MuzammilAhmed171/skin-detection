import sys

file_path = r'c:\Users\N TECH\Desktop\skin disease dataset\skin_detection_app_connected\lib\main.dart'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Replace ThemeData
old_theme = '''      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFFF8F9FE),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),'''
new_theme = '''      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: const Color(0xFFD6A58E),
        scaffoldBackgroundColor: const Color(0xFFFBF9F6),
        textTheme: GoogleFonts.dmSansTextTheme(),
      ),'''
content = content.replace(old_theme, new_theme)

old_scaffold_bg = '''      backgroundColor: const Color(0xFFF8F9FE),'''
new_scaffold_bg = '''      backgroundColor: const Color(0xFFFBF9F6),'''
content = content.replace(old_scaffold_bg, new_scaffold_bg)

old_app_bar = '''      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF8B83FF)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.medical_services,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'DermaScan AI',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: _showServerConfigDialog,
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.wifi_tethering,
                    color: Color(0xFF6C63FF),
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'IP',
                    style: TextStyle(
                      color: Color(0xFF6C63FF),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),'''

new_app_bar = '''      appBar: AppBar(
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
            Text(
              'DermaScan AI',
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2C2522),
                letterSpacing: -0.3,
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
      ),'''
content = content.replace(old_app_bar, new_app_bar)

old_image_card = '''              // Image Card
              Container(
                width: double.infinity,
                height: 340,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _selectedImage == null
                          ? const Color(0xFF6C63FF)
                          : const Color(0xFF6C63FF).withValues(alpha: 0.1),
                      _selectedImage == null
                          ? const Color(0xFF8B83FF)
                          : const Color(0xFF8B83FF).withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
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
                                        color: Colors.black.withValues(alpha: 0.1),
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
                                    color: Colors.white.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.photo_camera_outlined,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Upload Skin Image',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap camera or gallery below',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
              ),'''

new_image_card = '''              // Image Card
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
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
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
                                        color: Colors.black.withValues(alpha: 0.1),
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
                                    color: const Color(0xFFDCA993).withValues(alpha: 0.6),
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
                                    color: const Color(0xFF2C2522).withValues(alpha: 0.8),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
              ),'''
content = content.replace(old_image_card, new_image_card)

old_action_buttons = '''              // Action Buttons - Glassmorphism Style
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.8),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.08),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.camera_alt,
                        label: 'Camera',
                        color: const Color(0xFF6C63FF),
                        onTap: _isLoading ? null : _openCamera,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey.shade200,
                    ),
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.photo_library,
                        label: 'Gallery',
                        color: const Color(0xFF8B5CF6),
                        onTap: _isLoading ? null : _openGallery,
                      ),
                    ),
                  ],
                ),
              ),'''

new_action_buttons = '''              // Action Buttons Card
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
              ),'''
content = content.replace(old_action_buttons, new_action_buttons)

old_disease_section = '''              // Disease List Section
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
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.healing,
                            color: Color(0xFF6C63FF),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Detectable Diseases',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _diseaseDatabase.keys.map((disease) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF6C63FF).withValues(alpha: 0.1),
                                const Color(0xFF8B83FF).withValues(alpha: 0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
                            ),
                          ),
                          child: Text(
                            disease,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6C63FF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),'''

new_disease_section = '''              // Disease List Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFC78B74),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.healing,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Detectable Diseases',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2C2522),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _diseaseDatabase.keys.map((disease) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD6A58E).withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            disease,
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              color: const Color(0xFF2C2522),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),'''
content = content.replace(old_disease_section, new_disease_section)


old_action_button_widget = '''  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }'''

new_action_button_widget = '''  Widget _buildActionButton({
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
  }'''
content = content.replace(old_action_button_widget, new_action_button_widget)

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Done")
