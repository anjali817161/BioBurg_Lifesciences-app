import 'package:get/get.dart';

class CategoryDrawerController extends GetxController {
  
  // Map of Category -> List of { title: "", subcategories: [] }
  var drawerCategories = <String, List<Map<String, dynamic>>>{}.obs;
  var otherCategories = <String, List<String>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadDrawerData();
    loadOtherData();
  }
  void loadOtherData(){
    otherCategories.value={
         "Generic Medicine" : [
    "All Products",
    "Non Rx Medicine",
    "Bioburg Patent Brand",
    "Others Generic Brand",
    "Medical Equipments",
    "Tablets",
    "Capsules",
    "Injections",
    "Infusions / IV",
    "Syrups",
    "Dry Syrups",
    "Soft & Hard Gelatin",
    "Eye & Ear Drops",
    "Ointments & Creams",
    "Hot Products",
    "New Arrivals",
    "None (NA)",
    "Respules",
    "Hindi Articals",
    "Homeopathy",
    "Nutrition & Supplements",
    "Beauty & Personal Care",
    "Sexual Wellness",
    "Exclusive Store",
    "Exclusive Offers",
  ],

   "Divisions" : [
    "Rama Division (BioBurg Products)",
    "Laxmi Division (Other Generics)",
    "Third Party Manufacturing",
    "Contract Manufacturing",
    "Imports & Exports",
  ],

  "BB Shop" : ["BB-SHOP", "Manufacturing"],
    };
  }

  void loadDrawerData() {
    drawerCategories.value = {
      "Disease": [
        {
          "title": "Mind",
          "subcategories": [
            "Addiction",
            "Anxiety & Depression",
            "Sleeplessness",
            "Weak Memory",
          ]
        },
        {
          "title": "Face",
          "subcategories": [
            "Acne & Pimples",
            "Dark Circles & Marks",
            "Wrinkles & Aging"
          ]
        },
        {
          "title": "Hair",
          "subcategories": [
            "Hair Fall",
            "Dandruff",
            "Alopecia & Bald Patches",
            "Premature Graying",
            "Lice"
          ]
        },
        {
          "title": "Eyes & Ear",
          "subcategories": [
            "Conjunctivitis",
            "Cataract",
            "Eye Strain",
            "Glaucoma",
            "Styes",
            "Ear Pain",
            "Ear Wax",
          ]
        },
        {
          "title": "Nose & Throat",
          "subcategories": [
            "Allergic Rhinitis",
            "Sneezing & Running Nose",
            "Sinusitis & Blocked Nose",
            "Snoring",
            "Tonsilitis & Throat Pain",
            "Laryngitis & Hoarse Voice"
          ]
        },
        {
          "title": "Nervous System",
          "subcategories": [
            "Headache & Migraine",
            "Vertigo/Motion Sickness",
            "Neuralgia & Nerve Pain",
            "Epilepsy & Fits"
          ]
        },
        {
          "title": "Mouth, Gums & Teeth",
          "subcategories": [
            "Bad Breath",
            "Bleeding Gum/Pyorrhoea",
            "Mouth Ulcers/Aphthae",
            "Cavities & Tooth Pain",
            "Stammering"
          ]
        },
        {
          "title": "Respiratory",
          "subcategories": ["Asthma", "Bronchitis", "Cough", "Pneumonia"]
        },
        {
          "title": "Rectum & Piles",
          "subcategories": [
            "Constipation",
            "Piles & Fissures",
            "Loose Motions/Diarrhoea",
            "IBS & Colitis",
            "Fistula",
            "Worms"
          ]
        },
        {
          "title": "Digestive System",
          "subcategories": [
            "Indigestion/Acidity/Gas",
            "Loss of Appetite",
            "Jaundice & Fatty Liver",
            "Stomach Pain & Colic",
            "Vomiting & Nausea",
            "Gall Stones",
            "Appendicitis",
            "Hernia"
          ]
        },
        {
          "title": "Heart & Cardiovascular",
          "subcategories": [
            "Heart Tonics",
            "Chest Pain & Angina",
            "Cholesterol & Triglyceride"
          ]
        },
        {
          "title": "Urinary System",
          "subcategories": [
            "Urinary Tract Infection",
            "Kidney Stone",
            "Frequent Urination"
          ]
        },
        {
          "title": "Bone, Joint & Muscles",
          "subcategories": [
            "Arthritis & Joint Pains",
            "Back & Knee Pain",
            "Cervical Spondolyisis",
            "Injuries & Fractures",
            "Gout & Uric Acid",
            "Osteoporosis",
            "Sciatica",
            "Heel Pain"
          ]
        },
        {
          "title": "Skin & Nails",
          "subcategories": [
            "Bed Sores",
            "Boils & Abscesses",
            "Burns",
            "Cyst & Tumor",
            "Eczema",
            "Herpes",
            "Nail Fungus",
            "Psoriasis & Dry Skin",
            "Rash/Itch/Urticaria/Hives",
            "Vitiligo & Leucoderma",
            "Warts & Corns"
          ]
        },
        {
          "title": "Fevers & Flu",
          "subcategories": ["Dengue", "Flu & Fever", "Malaria", "Typhoid"]
        },
        {
          "title": "Male Problems",
          "subcategories": [
            "Hydrocele",
            "Premature Ejaculation",
            "Impotency",
            "Prostate Enlargement"
          ]
        },
        {
          "title": "Female Problems",
          "subcategories": [
            "Underdeveloped Breasts",
            "Enlarged Breasts",
            "Leucorrhoea",
            "Excessive Menses",
            "Vaginitis",
            "Menopause",
            "Painful, Delayed & Scanty Menses"
          ]
        },
        {
          "title": "Old Age Problems",
          "subcategories": [
            "Parkinsons & Trembling",
            "Involuntary Urination",
            "Alzheimers"
          ]
        },
        {
          "title": "Children Problems",
          "subcategories": [
            "Low Height",
            "Autism",
            "Bed Wetting",
            "Immunity",
            "Teething Troubles",
            "Irritability & Hyperactive"
          ]
        },
        {
          "title": "Lifestyle Diseases",
          "subcategories": [
            "Diabetes",
            "Blood Pressure",
            "Obesity",
            "Thyroid",
            "Hang Over",
            "Varicose Veins"
          ]
        },
        {
          "title": "Tonics",
          "subcategories": [
            "Anaemia",
            "Blood Purifiers",
            "General Tonics",
            "Weakness & Fatigue"
          ]
        },
      ],

      "Homeopathy": [
        { "title": "Medicines", "subcategories": ["SBL", "Reckeweg", "Schwabe", "Adel", "B Jain", "New Life"] },
  { "title": "Mother Tinctures", "subcategories": ["SBL", "Schwabe India", "BJain"] },
  { "title": "Dilutions", "subcategories": ["3X", "6X", "30CH", "200CH", "1M", "10M", "50M"] },
  { "title": "Biochemic", "subcategories": ["SBL", "Reckeweg", "BJain"] },
  { "title": "Cosmetics", "subcategories": ["Hair Care", "Skin Care", "Oral Care"] },
  { "title": "Bach Flower", "subcategories": ["Remedies", "Kits"] },
  { "title": "LM Potency", "subcategories": ["SBL", "BJain"] },
      ],

      "Ayurveda": [
        {
    "title": "Medicines",
    "subcategories": [
      "Himalaya",
      "Organic India",
      "Baidyanath",
      "Dabur",
      "Zandu",
      "Charak",
      "Aimil",
      "More...",
    ],
  },
  {
    "title": "Single Remedies",
    "subcategories": [
      "Ras & Sindoor",
      "Bhasm & Pishti",
      "Vati, Gutika & Guggulu",
      "Asava Arishta & Kadha",
      "Loha & Mandur",
      "Churan, Powder, Avaleha & Pak",
      "Tailam & Ghrita",
    ],
  },
  {
    "title": "Herbal Food & Juices",
    "subcategories": ["Chyawanprash", "Honey", "Digestives", "Herbal & Vegetable Juice"],
  },
      ],

      // ---------------- Nutrition Data ----------------
 "Vitamin & Nutrition" : [
  {
    "title": "Sports Nutrition",
    "subcategories": [
      "Proteins",
      "Fat Burner",
      "Weight Gainers",
      "Pre Post Workout",
      "Aminos",
      "Creatines",
    ],
  },
  { "title": "Vitamin & Dietary Supplements", "subcategories": [] },
  {
    "title": "Organic Products",
    "subcategories": ["Organic Foods", "Coffee & Tea", "Ghee", "Atta/Flour"],
  },
  {
    "title": "Health Food & Drinks",
    "subcategories": [
      "Spreads, Sugar & Honey",
      "Oils",
      "Herbal & Vegetable Juices",
      "Health Drinks",
      "Healthy Snacks & Bars",
      "Sugar Free",
      "Murabba",
      "Chyawanprash",
      "Edible Seeds",
    ],
  },
  { "title": "Green Teas", "subcategories": [] },
  { "title": "Digestives", "subcategories": [] },
],

// ---------------- Personal Care ----------------
 "Personal Care" : [
  { "title": "Aroma Oils", "subcategories": ["Essential Oils"] },
  {
    "title": "Skin Care",
    "subcategories": ["Face", "Body", "Foot Care", "Sanitizers & Hand Wash"],
  },
  {
    "title": "Hair Care",
    "subcategories": [
      "Shampoo & Conditioners",
      "Hair Oils & Creams",
      "Hair Serum & Mask",
      "Hair Color & Dyes",
      "Henna Mehandi",
    ],
  },
  { "title": "Mens Grooming", "subcategories": ["Beard Oils and Wax", "Shaving Cream & Gels", "Men Wellness"] },
  { "title": "Bath & Shower", "subcategories": ["Shower Gel & Hand Wash", "Soaps", "Talcs & Deos"] },
  { "title": "Oral Care", "subcategories": ["Toothpaste", "Gums Care"] },
  { "title": "Female Care", "subcategories": ["Intimate Care", "Pregnancy & Maternity Care"] },
  { "title": "Elderly Care", "subcategories": [] },
  { "title": "Mosquito Repellents", "subcategories": [] },
],

// ---------------- Baby Care ----------------
 "Baby Care" : [
  { "title": "Tonics & Supplements", "subcategories": [] },
  {
    "title": "Bath & Skin",
    "subcategories": ["Shampoos & Bath Gels", "Baby Oils", "Baby Powder", "Soaps"],
  },
  { "title": "Wipes & Diapers", "subcategories": [] },
  { "title": "Gift Packs", "subcategories": [] },
],

// ---------------- Fitness ----------------
 "Fitness" : [
  {
    "title": "Supports & Splints",
    "subcategories": [
      "Shoulder Support",
      "Elbow Support",
      "Forearm Support",
      "Wrist Support",
      "Chest Support",
      "Cervical Support",
      "Back Support",
      "Abdominal Support",
      "Thigh Support",
      "Knee Support",
      "Calf Support",
      "Ankle Support",
      "Finger Splint",
      "Compression Stockings",
      "Insoles & Heel cups",
    ],
  },
  {
    "title": "Health Devices",
    "subcategories": [
      "Weighing Scales",
      "BP Monitors",
      "Thermometer",
      "Respiratory Care",
      "Activity Monitor",
      "Hot and Cold Pads & Bottles",
    ],
  },
  { "title": "Fitness Equipment", "subcategories": ["Excercisers", "Weights"] },
  {
    "title": "Hospital Supplies",
    "subcategories": ["Stethoscopes", "Protective Gears", "Hospital Beds"],
  },
  { "title": "Bandages & Tapes", "subcategories": [] },
  { "title": "Walking Sticks", "subcategories": [] },
  { "title": "Aroma Therapy", "subcategories": [] },
  { "title": "Disability Aids", "subcategories": [] },
  { "title": "Massagers", "subcategories": [] },
],


// ---------------- Consultation ----------------
 "Sexual Wellness" : [
  {
    "title": "Free Treatments",
    "subcategories": ["Homeo Treatment", "Ayurveda Treatment", "Unani Treatment", "Diet Counselling"],
  },
],

// ---------------- Unani ----------------
 "Unani" : [
  { "title": "Unani Medicines", "subcategories": [] },
  { "title": "Habbe & Qurs", "subcategories": [] },
  { "title": "Majun & Jawarish", "subcategories": [] },
  { "title": "Safoof, Labub & Kushta", "subcategories": [] },
  { "title": "Sharbat, Sirka & Arq", "subcategories": [] },
  { "title": "Lauq & Saoot", "subcategories": [] },
  { "title": "Khamira & Itrifal", "subcategories": [] },
  { "title": "Roghan & Oils", "subcategories": [] },
  { "title": "Unani Brands", "subcategories": ["Hamdard", "New Shama", "Dehlvi", "Rex"] },
],


// ---------------- Allopathy ----------------
 "Allopathy" : [
  { "title": "Allopathic Medicines", "subcategories": [] },
  { "title": "Tablets & Capsules", "subcategories": [] },
  { "title": "Syrups & Suspensions", "subcategories": [] },
  { "title": "Creams & Ointments", "subcategories": [] },
  { "title": "Inhalers & Respuels", "subcategories": [] },
  { "title": "Oral Drops", "subcategories": [] },
  { "title": "Eye & Ear Drops", "subcategories": [] },
  { "title": "Nasal Drops & Spray", "subcategories": [] },
  { "title": "Injections & Infusions", "subcategories": [] },
  {
    "title": "Top Brands",
    "subcategories": [
      "Sun Pharma",
      "Cipla",
      "Lupin",
      "Pfizer",
      "Abbott",
      "Mankind Pharma",
      "Dr. Reddys",
      "Glenmark Pharma",
    ],
  },
],


//categories



    };
  }

 List<Map<String, dynamic>> getFullCategoryData(String categoryName) {
  List<Map<String, dynamic>> mainList = drawerCategories[categoryName] ?? [];
  List<String> othersList = otherCategories[categoryName] ?? [];

  // Convert "othersList" into a uniform map structure
  List<Map<String, dynamic>> formattedOthers = othersList
      .map((item) => {
            "title": item,
            "subcategories": [],
            "isOther": true, // to style differently
          })
      .toList();

  return [
    ...mainList,
    ...formattedOthers,
  ];
}

}
