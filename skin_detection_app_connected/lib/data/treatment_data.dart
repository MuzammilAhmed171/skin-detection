import 'package:flutter/material.dart';

class TreatmentData {
  static final Map<String, dynamic> data = {
    'Acne': {
      'allopathic': {
        'Medicine': [
          {
            'name': 'Isotretinoin 10mg',
            'desc': 'For severe acne',
            'rating': 4.7,
            'reviews': 231,
            'price': 12.99,
          },
          {
            'name': 'Doxycycline 100mg',
            'desc': 'For inflammatory acne',
            'rating': 4.5,
            'reviews': 189,
            'price': 9.99,
          },
          {
            'name': 'Minocycline 50mg',
            'desc': 'For persistent acne',
            'rating': 4.2,
            'reviews': 142,
            'price': 8.99,
          }
        ],
        'Creams': [
          {
            'name': 'Benzoyl Peroxide Gel 5%',
            'desc': 'For acne & pimples',
            'rating': 4.6,
            'reviews': 248,
            'price': 11.99,
          },
          {
            'name': 'Clindamycin Gel 1%',
            'desc': 'For acne-causing bacteria',
            'rating': 4.5,
            'reviews': 315,
            'price': 13.99,
          },
          {
            'name': 'Adapalene Gel 0.1%',
            'desc': 'For acne & clogged pores',
            'rating': 4.3,
            'reviews': 156,
            'price': 14.99,
          }
        ],
        'Advice': {
          'title': 'Consult a Dermatologist',
          'desc': 'Get expert advice for the right medicine and personalized treatment plan.',
          'tips': [
            'Avoid touching your face.',
            'Use non-comedogenic products.',
            'Keep your skin clean and hydrated.',
            'Avoid junk food and excess sugar.'
          ]
        },
        'Routine': [
          {
            'title': 'Cleanse',
            'desc': 'Use a gentle face wash twice daily.',
            'icon': Icons.wash
          },
          {
            'title': 'Moisturize',
            'desc': 'Keep your skin hydrated.',
            'icon': Icons.water_drop
          },
          {
            'title': 'Protect',
            'desc': 'Always use sunscreen (SPF 30+).',
            'icon': Icons.wb_sunny
          },
          {
            'title': 'Avoid',
            'desc': 'Avoid oily food, stress & touching pimples.',
            'icon': Icons.block
          }
        ]
      },
      'homeopathic': {
        'Medicine': [
          {
            'name': 'Sulphur 30',
            'desc': 'For stubborn acne',
            'rating': 4.4,
            'reviews': 120,
            'price': 8.99,
          },
          {
            'name': 'Calcarea Carbonica 30',
            'desc': 'For hormonal acne',
            'rating': 4.2,
            'reviews': 105,
            'price': 7.99,
          },
          {
            'name': 'Graphites 30',
            'desc': 'For oily & pustular acne',
            'rating': 4.1,
            'reviews': 87,
            'price': 7.49,
          }
        ],
        'Creams': [
          {
            'name': 'Calendula Cream',
            'desc': 'Soothes inflamed acne',
            'rating': 4.5,
            'reviews': 93,
            'price': 9.99,
          },
          {
            'name': 'Sulphur Skin Cream',
            'desc': 'For persistent acne',
            'rating': 4.2,
            'reviews': 76,
            'price': 8.99,
          },
          {
            'name': 'Aloe Vera Gel (Homeopathic)',
            'desc': 'Calms & heals skin',
            'rating': 4.6,
            'reviews': 64,
            'price': 7.99,
          }
        ],
        'Advice': {
          'title': 'Consult a Homeopath',
          'desc': 'Get personalized treatment based on your unique symptoms and body type.',
          'tips': [
            'Maintain a clean diet.',
            'Avoid harsh chemicals.',
            'Manage stress and get enough sleep.',
            'Follow your prescribed remedy regularly.'
          ]
        },
        'Routine': [
          {
            'title': 'Cleanse',
            'desc': 'Use mild, natural face wash.',
            'icon': Icons.spa
          },
          {
            'title': 'Hydrate',
            'desc': 'Drink plenty of water.',
            'icon': Icons.local_drink
          },
          {
            'title': 'Eat Healthy',
            'desc': 'More fruits, vegetables & zinc-rich food.',
            'icon': Icons.restaurant
          },
          {
            'title': 'Rest',
            'desc': 'Get 7-8 hours of sleep.',
            'icon': Icons.nightlight_round
          }
        ]
      }
    },
    'Chickenpox': {
      'allopathic': {
        'Medicine': [
          {'name': 'Acyclovir 400mg', 'desc': 'Antiviral medication', 'rating': 4.8, 'reviews': 310, 'price': 15.99},
          {'name': 'Paracetamol 500mg', 'desc': 'For fever relief', 'rating': 4.9, 'reviews': 500, 'price': 5.99},
          {'name': 'Cetirizine 10mg', 'desc': 'For severe itching', 'rating': 4.6, 'reviews': 210, 'price': 8.49}
        ],
        'Creams': [
          {'name': 'Calamine Lotion', 'desc': 'Soothes itching & rash', 'rating': 4.7, 'reviews': 450, 'price': 6.99},
          {'name': 'Hydrocortisone 1%', 'desc': 'Reduces inflammation', 'rating': 4.5, 'reviews': 120, 'price': 9.99}
        ],
        'Advice': {
          'title': 'Consult a Doctor',
          'desc': 'Medical supervision is critical if fever persists.',
          'tips': ['Do not scratch the blisters.', 'Keep nails trimmed short.', 'Rest at home to prevent spreading.', 'Stay hydrated.']
        },
        'Routine': [
          {'title': 'Cool Baths', 'desc': 'Add oatmeal or baking soda.', 'icon': Icons.bathtub},
          {'title': 'Loose Clothing', 'desc': 'Wear soft, cotton clothes.', 'icon': Icons.checkroom},
          {'title': 'Hydrate', 'desc': 'Drink water and clear broths.', 'icon': Icons.local_drink},
          {'title': 'Isolate', 'desc': 'Stay away from others.', 'icon': Icons.home}
        ]
      },
      'homeopathic': {
        'Medicine': [
          {'name': 'Rhus Tox 30', 'desc': 'For intense itching', 'rating': 4.6, 'reviews': 180, 'price': 8.99},
          {'name': 'Antimonium Tart 30', 'desc': 'For slow healing erupts', 'rating': 4.3, 'reviews': 90, 'price': 7.49}
        ],
        'Creams': [
          {'name': 'Neem Ointment', 'desc': 'Natural antibacterial', 'rating': 4.5, 'reviews': 140, 'price': 8.99},
          {'name': 'Calendula Gel', 'desc': 'Promotes skin healing', 'rating': 4.7, 'reviews': 210, 'price': 9.49}
        ],
        'Advice': {
          'title': 'Consult a Homeopath',
          'desc': 'Get remedies specific to your rash stages.',
          'tips': ['Avoid touching spots.', 'Keep room well ventilated.', 'Eat light, easily digestible food.']
        },
        'Routine': [
          {'title': 'Sponge Bath', 'desc': 'Use lukewarm water with neem.', 'icon': Icons.wash},
          {'title': 'Rest', 'desc': 'Allow body to heal naturally.', 'icon': Icons.bed},
          {'title': 'Bland Diet', 'desc': 'Avoid spicy or salty foods.', 'icon': Icons.fastfood},
          {'title': 'Trim Nails', 'desc': 'Prevent accidental scratching.', 'icon': Icons.content_cut}
        ]
      }
    },
    'Dyshidrotic Eczema': {
      'allopathic': {
        'Medicine': [
          {'name': 'Prednisone 10mg', 'desc': 'Oral corticosteroid', 'rating': 4.5, 'reviews': 150, 'price': 14.99},
          {'name': 'Fexofenadine 180mg', 'desc': 'For allergy relief', 'rating': 4.7, 'reviews': 220, 'price': 11.99}
        ],
        'Creams': [
          {'name': 'Tacrolimus 0.1%', 'desc': 'For inflammation', 'rating': 4.5, 'reviews': 190, 'price': 16.99},
          {'name': 'Clobetasol Propionate', 'desc': 'Strong topical steroid', 'rating': 4.6, 'reviews': 110, 'price': 12.99}
        ],
        'Advice': {
          'title': 'Consult a Dermatologist',
          'desc': 'Identify triggers and get prescription ointments.',
          'tips': ['Identify and avoid allergic triggers.', 'Use mild soaps.', 'Apply thick moisturizers immediately after washing.']
        },
        'Routine': [
          {'title': 'Gentle Wash', 'desc': 'Use soap-free cleansers.', 'icon': Icons.wash},
          {'title': 'Moisturize', 'desc': 'Apply thick creams often.', 'icon': Icons.water_drop},
          {'title': 'Cotton Gloves', 'desc': 'Wear at night over cream.', 'icon': Icons.back_hand},
          {'title': 'Avoid Triggers', 'desc': 'Metals, harsh chemicals.', 'icon': Icons.block}
        ]
      },
      'homeopathic': {
        'Medicine': [
          {'name': 'Graphites 30', 'desc': 'For dry & cracked skin', 'rating': 4.3, 'reviews': 102, 'price': 8.39},
          {'name': 'Petroleum 30', 'desc': 'For chronic eczema', 'rating': 4.2, 'reviews': 72, 'price': 7.99}
        ],
        'Creams': [
          {'name': 'Topi Cardiospermum', 'desc': 'Relieves itching', 'rating': 4.4, 'reviews': 85, 'price': 9.99},
          {'name': 'Graphites Ointment', 'desc': 'For rough, hard skin', 'rating': 4.1, 'reviews': 45, 'price': 8.49}
        ],
        'Advice': {
          'title': 'Consult a Homeopath',
          'desc': 'Holistic healing focusing on immune balance.',
          'tips': ['Manage stress levels.', 'Ensure adequate sleep.', 'Stay hydrated.']
        },
        'Routine': [
          {'title': 'Hydrate', 'desc': 'Drink plenty of water.', 'icon': Icons.local_drink},
          {'title': 'Cool Compresses', 'desc': 'Soothe itchy areas.', 'icon': Icons.ac_unit},
          {'title': 'Natural Oils', 'desc': 'Apply coconut oil.', 'icon': Icons.spa},
          {'title': 'Stress Relief', 'desc': 'Yoga or meditation.', 'icon': Icons.self_improvement}
        ]
      }
    },
    'Ringworm': {
      'allopathic': {
        'Medicine': [
          {'name': 'Terbinafine 250mg', 'desc': 'Oral antifungal', 'rating': 4.7, 'reviews': 340, 'price': 18.99},
          {'name': 'Itraconazole 100mg', 'desc': 'Systemic antifungal', 'rating': 4.6, 'reviews': 215, 'price': 16.99}
        ],
        'Creams': [
          {'name': 'Clotrimazole 1%', 'desc': 'Topical antifungal cream', 'rating': 4.8, 'reviews': 510, 'price': 8.99},
          {'name': 'Ketoconazole 2%', 'desc': 'Broad-spectrum antifungal', 'rating': 4.7, 'reviews': 380, 'price': 10.99}
        ],
        'Advice': {
          'title': 'Consult a Doctor',
          'desc': 'Required if infection covers large areas or doesn\'t clear up.',
          'tips': ['Keep the area clean and dry.', 'Do not share personal items.', 'Wash clothing in hot water.']
        },
        'Routine': [
          {'title': 'Clean & Dry', 'desc': 'Fungi thrive in moisture.', 'icon': Icons.dry},
          {'title': 'Loose Clothes', 'desc': 'Allow skin to breathe.', 'icon': Icons.checkroom},
          {'title': 'Wash Hands', 'desc': 'After touching the rash.', 'icon': Icons.clean_hands},
          {'title': 'Disinfect', 'desc': 'Clean shared surfaces.', 'icon': Icons.cleaning_services}
        ]
      },
      'homeopathic': {
        'Medicine': [
          {'name': 'Bacillinum 200', 'desc': 'Constitutional remedy', 'rating': 4.5, 'reviews': 95, 'price': 9.99},
          {'name': 'Tellurium 30', 'desc': 'For ring-like lesions', 'rating': 4.4, 'reviews': 120, 'price': 8.49}
        ],
        'Creams': [
          {'name': 'Chrysarobinum Ointment', 'desc': 'For vesicular ringworm', 'rating': 4.3, 'reviews': 65, 'price': 9.49},
          {'name': 'Tea Tree Cream', 'desc': 'Natural antifungal', 'rating': 4.6, 'reviews': 210, 'price': 11.99}
        ],
        'Advice': {
          'title': 'Consult a Homeopath',
          'desc': 'For stubborn or recurring fungal infections.',
          'tips': ['Avoid sugary foods.', 'Enhance immunity naturally.', 'Keep skin airy and dry.']
        },
        'Routine': [
          {'title': 'Tea Tree Oil', 'desc': 'Apply diluted on rash.', 'icon': Icons.spa},
          {'title': 'Sunlight', 'desc': 'Mild sun exposure helps.', 'icon': Icons.wb_sunny},
          {'title': 'Clean Diet', 'desc': 'Reduce sugar intake.', 'icon': Icons.restaurant},
          {'title': 'Separate Towels', 'desc': 'Prevent spreading.', 'icon': Icons.dry_cleaning}
        ]
      }
    }
  };
}
