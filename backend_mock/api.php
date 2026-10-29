<?php
/**
 * =========================================================================
 *  MOCK API BACKEND (Single File - Short & Concise Texts)
 * =========================================================================
 *  - نصوص قصيرة وواضحة (الأقسام كلمة واحدة: عظام، عيون، قلب...)
 *  - استجابة فورية بدون قواعد بيانات.
 *  - متوافق 100% مع فلاتر.
 * =========================================================================
 */

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS, PATCH");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, Accept");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$requestMethod = $_SERVER['REQUEST_METHOD'];

if (isset($_GET['route']) && !empty($_GET['route'])) {
    $route = '/' . ltrim($_GET['route'], '/');
} elseif (isset($_SERVER['PATH_INFO']) && !empty($_SERVER['PATH_INFO'])) {
    $route = $_SERVER['PATH_INFO'];
} else {
    $requestUri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $route = preg_replace('#^/api\.php#i', '', $requestUri);
}

$route = '/' . trim($route, '/');
if ($route === '//') $route = '/';

$rawInput = file_get_contents('php://input');
$bodyData = json_decode($rawInput, true) ?? [];
$requestParams = array_merge($_GET, $_POST, $bodyData);

// -------------------------------------------------------------------------
// 1. الأقسام والتخصصات (كلمة واحدة فقط لكل قسم)
// -------------------------------------------------------------------------
$specialties = [
    ["id" => "spec_01", "name" => "عظام", "description" => "عظام ومفاصل"],
    ["id" => "spec_02", "name" => "قلب", "description" => "قلب وأوعية"],
    ["id" => "spec_03", "name" => "أطفال", "description" => "صحة أطفال"],
    ["id" => "spec_04", "name" => "عيون", "description" => "عيون وليزر"],
    ["id" => "spec_05", "name" => "جلدية", "description" => "جلدية وتجميل"],
    ["id" => "spec_06", "name" => "أسنان", "description" => "طب أسنان"]
];

// -------------------------------------------------------------------------
// 2. قائمة الأطباء (نصوص مختصرة ومباشرة مع الصور)
// -------------------------------------------------------------------------
$doctors = [
    [
        "phone" => "771234567",
        "full_name" => "د. عبد الرحمن باوزير",
        "email" => "dr.bawazir@example.com",
        "bio" => "استشاري عظام ومفاصل",
        "edu_cv" => "بورد جراحة عظام",
        "rate" => 4.9,
        "experience_years" => 16,
        "license_number" => "98421",
        "license_issuer" => "وزارة الصحة",
        "clinic" => [
            "id" => "cl_01",
            "name" => "عيادة النخبة",
            "city" => "صنعاء",
            "address" => "حدة - برج السلام",
            "phone" => "01445566",
            "location_link" => "https://maps.google.com"
        ],
        "specialty_rel" => [
            "id" => "spec_01",
            "name" => "عظام",
            "description" => "عظام ومفاصل"
        ],
        "schedules" => [
            ["day_of_week" => "السبت", "start_time" => "09:00", "end_time" => "13:00", "session_duration" => 30],
            ["day_of_week" => "الإثنين", "start_time" => "09:00", "end_time" => "13:00", "session_duration" => 30]
        ],
        "profile_image" => "https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=600&q=80"
    ],
    [
        "phone" => "777889900",
        "full_name" => "د. سارة المنصوري",
        "email" => "dr.sara@example.com",
        "bio" => "استشارية أمراض قلب",
        "edu_cv" => "دكتوراه قسطرة قلب",
        "rate" => 4.8,
        "experience_years" => 12,
        "license_number" => "55120",
        "license_issuer" => "وزارة الصحة",
        "clinic" => [
            "id" => "cl_02",
            "name" => "مركز القلب",
            "city" => "الرياض",
            "address" => "طريق الملك فهد",
            "phone" => "011234567",
            "location_link" => "https://maps.google.com"
        ],
        "specialty_rel" => [
            "id" => "spec_02",
            "name" => "قلب",
            "description" => "قلب وأوعية"
        ],
        "schedules" => [
            ["day_of_week" => "الأحد", "start_time" => "10:00", "end_time" => "15:00", "session_duration" => 30],
            ["day_of_week" => "الثلاثاء", "start_time" => "10:00", "end_time" => "15:00", "session_duration" => 30]
        ],
        "profile_image" => "https://images.unsplash.com/photo-1594824813590-48995a5f7823?auto=format&fit=crop&w=600&q=80"
    ],
    [
        "phone" => "773344556",
        "full_name" => "د. أحمد المهدي",
        "email" => "dr.mahdi@example.com",
        "bio" => "استشاري طب أطفال",
        "edu_cv" => "بورد أطفال",
        "rate" => 4.9,
        "experience_years" => 14,
        "license_number" => "44211",
        "license_issuer" => "وزارة الصحة",
        "clinic" => [
            "id" => "cl_03",
            "name" => "مستشفى الأمل",
            "city" => "صنعاء",
            "address" => "الستين الجنوبي",
            "phone" => "01238899",
            "location_link" => "https://maps.google.com"
        ],
        "specialty_rel" => [
            "id" => "spec_03",
            "name" => "أطفال",
            "description" => "صحة أطفال"
        ],
        "schedules" => [
            ["day_of_week" => "السبت", "start_time" => "09:00", "end_time" => "13:00", "session_duration" => 20],
            ["day_of_week" => "الأحد", "start_time" => "09:00", "end_time" => "13:00", "session_duration" => 20]
        ],
        "profile_image" => "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?auto=format&fit=crop&w=600&q=80"
    ],
    [
        "phone" => "775566778",
        "full_name" => "د. ريم الشامي",
        "email" => "dr.reem@example.com",
        "bio" => "أخصائية عيون وليزك",
        "edu_cv" => "ماجستير جراحة عيون",
        "rate" => 4.8,
        "experience_years" => 10,
        "license_number" => "77632",
        "license_issuer" => "وزارة الصحة",
        "clinic" => [
            "id" => "cl_04",
            "name" => "مركز البصر",
            "city" => "جدة",
            "address" => "حي الروضة",
            "phone" => "012654321",
            "location_link" => "https://maps.google.com"
        ],
        "specialty_rel" => [
            "id" => "spec_04",
            "name" => "عيون",
            "description" => "عيون وليزر"
        ],
        "schedules" => [
            ["day_of_week" => "الإثنين", "start_time" => "16:00", "end_time" => "21:00", "session_duration" => 30],
            ["day_of_week" => "الأربعاء", "start_time" => "16:00", "end_time" => "21:00", "session_duration" => 30]
        ],
        "profile_image" => "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=600&q=80"
    ],
    [
        "phone" => "772211445",
        "full_name" => "د. ياسر العمري",
        "email" => "dr.yasser@example.com",
        "bio" => "استشاري جلدية وتجميل",
        "edu_cv" => "بورد جلدية وليزر",
        "rate" => 4.7,
        "experience_years" => 11,
        "license_number" => "33490",
        "license_issuer" => "وزارة الصحة",
        "clinic" => [
            "id" => "cl_05",
            "name" => "عيادة ديرما",
            "city" => "الرياض",
            "address" => "حي الورود",
            "phone" => "011889977",
            "location_link" => "https://maps.google.com"
        ],
        "specialty_rel" => [
            "id" => "spec_05",
            "name" => "جلدية",
            "description" => "جلدية وتجميل"
        ],
        "schedules" => [
            ["day_of_week" => "السبت", "start_time" => "16:00", "end_time" => "20:00", "session_duration" => 25],
            ["day_of_week" => "الإثنين", "start_time" => "16:00", "end_time" => "20:00", "session_duration" => 25]
        ],
        "profile_image" => "https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=600&q=80"
    ],
    [
        "phone" => "779988112",
        "full_name" => "د. مريم السقاف",
        "email" => "dr.mariam@example.com",
        "bio" => "أخصائية طب أسنان",
        "edu_cv" => "ماجستير زراعة وتجميل",
        "rate" => 4.9,
        "experience_years" => 9,
        "license_number" => "11884",
        "license_issuer" => "وزارة الصحة",
        "clinic" => [
            "id" => "cl_06",
            "name" => "مركز دينتال",
            "city" => "صنعاء",
            "address" => "حدة - الكميم",
            "phone" => "01424242",
            "location_link" => "https://maps.google.com"
        ],
        "specialty_rel" => [
            "id" => "spec_06",
            "name" => "أسنان",
            "description" => "طب أسنان"
        ],
        "schedules" => [
            ["day_of_week" => "الأحد", "start_time" => "09:00", "end_time" => "14:00", "session_duration" => 30],
            ["day_of_week" => "الثلاثاء", "start_time" => "09:00", "end_time" => "14:00", "session_duration" => 30]
        ],
        "profile_image" => "https://images.unsplash.com/photo-1629909613654-28e377c37b09?auto=format&fit=crop&w=600&q=80"
    ]
];

// -------------------------------------------------------------------------
// 3. بيانات المريض
// -------------------------------------------------------------------------
$currentPatient = [
    "id" => "pat_101",
    "full_name" => "محمد العولقي",
    "email" => "mohammed@example.com",
    "phone" => "777123456",
    "gender" => "ذكر",
    "birth_date" => "1996-06-20",
    "profile_image" => "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=400&q=80"
];

// -------------------------------------------------------------------------
// 4. الفلل والعقارات (نصوص مختصرة ومباشرة)
// -------------------------------------------------------------------------
$properties = [
    [
        "id" => "villa_01",
        "titleAr" => "فيلا الملقا",
        "locationAr" => "الرياض - الملقا",
        "priceLabel" => "4.5 مليون ر.س",
        "statusLabel" => "للبيع",
        "statusColorHex" => "0xFFB76A40",
        "imageAsset" => "https://images.unsplash.com/photo-1613977257363-707ba9348227?auto=format&fit=crop&w=1200&q=80",
        "bedrooms" => 5,
        "bathrooms" => 6,
        "area" => 450,
        "isFavorite" => true
    ],
    [
        "id" => "villa_02",
        "titleAr" => "قصر الشاطئ",
        "locationAr" => "جدة - الشاطئ",
        "priceLabel" => "8.2 مليون ر.س",
        "statusLabel" => "للبيع",
        "statusColorHex" => "0xFFB76A40",
        "imageAsset" => "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=1200&q=80",
        "bedrooms" => 6,
        "bathrooms" => 8,
        "area" => 680,
        "isFavorite" => false
    ],
    [
        "id" => "villa_03",
        "titleAr" => "فيلا حدة",
        "locationAr" => "صنعاء - حدة",
        "priceLabel" => "3.8 مليون ر.س",
        "statusLabel" => "للبيع",
        "statusColorHex" => "0xFFB76A40",
        "imageAsset" => "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80",
        "bedrooms" => 5,
        "bathrooms" => 5,
        "area" => 520,
        "isFavorite" => true
    ],
    [
        "id" => "villa_04",
        "titleAr" => "فيلا الراكة",
        "locationAr" => "الدمام - الراكة",
        "priceLabel" => "5.1 مليون ر.س",
        "statusLabel" => "للبيع",
        "statusColorHex" => "0xFFB76A40",
        "imageAsset" => "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1200&q=80",
        "bedrooms" => 4,
        "bathrooms" => 5,
        "area" => 480,
        "isFavorite" => false
    ],
    [
        "id" => "villa_05",
        "titleAr" => "فيلا حطين",
        "locationAr" => "الرياض - حطين",
        "priceLabel" => "6.7 مليون ر.س",
        "statusLabel" => "للبيع",
        "statusColorHex" => "0xFFB76A40",
        "imageAsset" => "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=1200&q=80",
        "bedrooms" => 6,
        "bathrooms" => 7,
        "area" => 600,
        "isFavorite" => true
    ]
];

// تصنيفات العقارات (كلمة واحدة)
$categories = [
    ["id" => "all", "labelAr" => "الكل", "isSelected" => true],
    ["id" => "villas", "labelAr" => "فلل", "isSelected" => false],
    ["id" => "apartments", "labelAr" => "شقق", "isSelected" => false],
    ["id" => "floors", "labelAr" => "أدوار", "isSelected" => false],
    ["id" => "palaces", "labelAr" => "قصور", "isSelected" => false],
    ["id" => "lands", "labelAr" => "أراضي", "isSelected" => false]
];

// المدن (مختصرة)
$cities = [
    [
        "id" => "riyadh",
        "nameAr" => "الرياض",
        "locationHintAr" => "الملقا",
        "availableLabelAr" => "24 عقار",
        "isSelected" => true,
        "imageAsset" => "https://images.unsplash.com/photo-1586724237569-f3d0c1dee8c6?auto=format&fit=crop&w=800&q=80"
    ],
    [
        "id" => "jeddah",
        "nameAr" => "جدة",
        "locationHintAr" => "الشاطئ",
        "availableLabelAr" => "18 عقار",
        "isSelected" => false,
        "imageAsset" => "https://images.unsplash.com/photo-1578895101407-338274d12c81?auto=format&fit=crop&w=800&q=80"
    ],
    [
        "id" => "sanaa",
        "nameAr" => "صنعاء",
        "locationHintAr" => "حدة",
        "availableLabelAr" => "15 عقار",
        "isSelected" => false,
        "imageAsset" => "https://images.unsplash.com/photo-1541971875076-8f970d573be6?auto=format&fit=crop&w=800&q=80"
    ],
    [
        "id" => "dammam",
        "nameAr" => "الدمام",
        "locationHintAr" => "الراكة",
        "availableLabelAr" => "12 عقار",
        "isSelected" => false,
        "imageAsset" => "https://images.unsplash.com/photo-1580587771525-78b9dba3b914?auto=format&fit=crop&w=800&q=80"
    ]
];

// -------------------------------------------------------------------------
// 5. التوجيه (Routing)
// -------------------------------------------------------------------------

if ($route === '/' || $route === '') {
    echo json_encode([
        "status" => "online",
        "service" => "Mock API (Short Texts)",
        "version" => "2.2.0"
    ], JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
    exit();
}

if ($route === '/auth/login') {
    $role = $requestParams['role'] ?? 'patient';
    echo json_encode([
        "access_token" => "mock_token_" . bin2hex(random_bytes(16)),
        "token_type" => "bearer",
        "role" => $role
    ], JSON_UNESCAPED_UNICODE);
    exit();
}

if ($route === '/auth/register/patient') {
    echo json_encode(["success" => true, "message" => "تم التسجيل"], JSON_UNESCAPED_UNICODE);
    exit();
}

if ($route === '/patients/me') {
    echo json_encode($currentPatient, JSON_UNESCAPED_UNICODE);
    exit();
}

if ($route === '/doctors/doctors') {
    $cityFilter = $requestParams['city'] ?? null;
    $specialtyFilter = $requestParams['specialty_id'] ?? null;
    $minRating = isset($requestParams['minRating']) ? (float)$requestParams['minRating'] : null;

    $filtered = array_values(array_filter($doctors, function ($doc) use ($cityFilter, $specialtyFilter, $minRating) {
        if ($cityFilter && stripos($doc['clinic']['city'], $cityFilter) === false) return false;
        if ($specialtyFilter && $doc['specialty_rel']['id'] !== $specialtyFilter) return false;
        if ($minRating !== null && $doc['rate'] < $minRating) return false;
        return true;
    }));

    echo json_encode(!empty($filtered) ? $filtered : $doctors, JSON_UNESCAPED_UNICODE);
    exit();
}

if ($route === '/specialties' || $route === '/specialties/') {
    echo json_encode($specialties, JSON_UNESCAPED_UNICODE);
    exit();
}

if ($route === '/bookings/requests' || $route === '/patients/doctor/requests') {
    if ($requestMethod === 'POST') {
        echo json_encode([
            "id" => "req_" . time(),
            "doctor_phone" => $requestParams['doctor_phone'] ?? "771234567",
            "patient_phone" => "777123456",
            "appointment_date" => $requestParams['appointment_date'] ?? date('Y-m-d'),
            "start_time" => $requestParams['start_time'] ?? "10:00",
            "end_time" => "10:30",
            "status" => "confirmed",
            "reason" => $requestParams['reason'] ?? "كشف"
        ], JSON_UNESCAPED_UNICODE);
    } else {
        echo json_encode([[
            "id" => "req_001",
            "doctor_phone" => "771234567",
            "patient_phone" => "777123456",
            "appointment_date" => date('Y-m-d', strtotime('+1 day')),
            "start_time" => "10:00",
            "end_time" => "10:30",
            "status" => "confirmed",
            "reason" => "متابعة"
        ]], JSON_UNESCAPED_UNICODE);
    }
    exit();
}

if (preg_match('#^/(realestate/)?(featured|properties)#', $route)) {
    echo json_encode($properties, JSON_UNESCAPED_UNICODE);
    exit();
}

if (preg_match('#^/(realestate/)?cities#', $route)) {
    echo json_encode($cities, JSON_UNESCAPED_UNICODE);
    exit();
}

if (preg_match('#^/(realestate/)?categories#', $route)) {
    echo json_encode($categories, JSON_UNESCAPED_UNICODE);
    exit();
}

http_response_code(404);
echo json_encode(["error" => "Not found"], JSON_UNESCAPED_UNICODE);
