<?php
/**
 * =========================================================================
 *  SAKAN & APPOINTMENTS - MOCK API BACKEND (PHP In-Memory Simulation)
 * =========================================================================
 *  - No Database Required (100% Stateless & In-Memory).
 *  - Compatible with Flutter DioClient, Real Estate & Medical Services.
 *  - Full CORS Support for Flutter Web (Edge / Chrome) & Mobile.
 *  - Host: https://desraj.in/
 * =========================================================================
 */

// -------------------------------------------------------------------------
// 1. CORS Headers (ضروري جداً ليعمل فلاتر من المتصفح ومن أي جهاز)
// -------------------------------------------------------------------------
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS, PATCH");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With, Accept");
header("Content-Type: application/json; charset=UTF-8");

// التعامل مع طلبات Preflight (OPTIONS)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// -------------------------------------------------------------------------
// 2. تحليل وتوحيد مسار الرابط (Route Normalization)
// -------------------------------------------------------------------------
$requestMethod = $_SERVER['REQUEST_METHOD'];
$requestUri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

// إزالة اسم الملف إن وُجد (مثل /index.php أو /api.php)
$route = preg_replace('#^/(index|api)\.php#i', '', $requestUri);

// إزالة بادئة الإصدار إن وُجدت (مثل /api/v1 أو /api)
$route = preg_replace('#^/api(/v1)?#i', '', $route);

// إتاحة تمرير المسار كـ Query Param (?route=/auth/login) لمرونة إضافية
if (isset($_GET['route']) && !empty($_GET['route'])) {
    $route = '/' . ltrim($_GET['route'], '/');
}

// تنظيف المسار
$route = '/' . trim($route, '/');
if ($route === '//') $route = '/';

// قراءة جسم الطلب (Body) سواء كان JSON أو Form Data
$rawInput = file_get_contents('php://input');
$bodyData = json_decode($rawInput, true) ?? [];
$requestParams = array_merge($_GET, $_POST, $bodyData);

// -------------------------------------------------------------------------
// 3. قاعدة البيانات الوهمية (Mock Datasets)
// -------------------------------------------------------------------------

// أ) بيانات العقارات والفلل الفاخرة (روابط صور فلل حقيقية عالية الجودة)
$properties = [
    [
        "id" => "villa_01",
        "titleAr" => "فيلا نرجس الملقة الفاخرة",
        "locationAr" => "الرياض، حي الملقا",
        "priceLabel" => "4,500,000 ر.س",
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
        "titleAr" => "قصر مودرن شاطئي بإطلالة بانورامية ومسبح",
        "locationAr" => "جدة، حي الشاطئ",
        "priceLabel" => "8,200,000 ر.س",
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
        "titleAr" => "فيلا كلاسيكية حديثة بتشطيب سوبر ديلوكس",
        "locationAr" => "صنعاء، حي حدة السكني",
        "priceLabel" => "3,800,000 ر.س",
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
        "titleAr" => "فيلا شاطئية مع حديقة خاصة وتراس",
        "locationAr" => "الدمام، حي الراكة",
        "priceLabel" => "5,100,000 ر.س",
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
        "titleAr" => "فيلا نيوكلاسيك ذكية بالكامل (Smart Villa)",
        "locationAr" => "الرياض، حي حطين",
        "priceLabel" => "6,750,000 ر.س",
        "statusLabel" => "للبيع",
        "statusColorHex" => "0xFFB76A40",
        "imageAsset" => "https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=1200&q=80",
        "bedrooms" => 6,
        "bathrooms" => 7,
        "area" => 600,
        "isFavorite" => true
    ],
    [
        "id" => "villa_06",
        "titleAr" => "فيلا بتصميم إسباني مع حديقة ومسبح خاص",
        "locationAr" => "صنعاء، بيت بوس",
        "priceLabel" => "4,100,000 ر.س",
        "statusLabel" => "للإيجار",
        "statusColorHex" => "0xFF2E7D32",
        "imageAsset" => "https://images.unsplash.com/photo-1600566753376-12c8ab7fb75b?auto=format&fit=crop&w=1200&q=80",
        "bedrooms" => 4,
        "bathrooms" => 4,
        "area" => 420,
        "isFavorite" => false
    ]
];

// ب) أقسام وتصنيفات العقارات (Categories)
$categories = [
    ["id" => "all", "labelAr" => "الكل", "isSelected" => true],
    ["id" => "villas", "labelAr" => "فلل فاخرة", "isSelected" => false],
    ["id" => "apartments", "labelAr" => "شقق سكنية", "isSelected" => false],
    ["id" => "floors", "labelAr" => "ادوار مستقلة", "isSelected" => false],
    ["id" => "palaces", "labelAr" => "قصور", "isSelected" => false],
    ["id" => "lands", "labelAr" => "اراضي تجارية", "isSelected" => false]
];

// ج) المدن الرئيسية (Top Cities)
$cities = [
    [
        "id" => "riyadh",
        "nameAr" => "الرياض",
        "locationHintAr" => "حي الملقا وحطين",
        "availableLabelAr" => "24 عقار",
        "isSelected" => true,
        "imageAsset" => "https://images.unsplash.com/photo-1586724237569-f3d0c1dee8c6?auto=format&fit=crop&w=800&q=80"
    ],
    [
        "id" => "jeddah",
        "nameAr" => "جدة",
        "locationHintAr" => "حي الشاطئ وأبحر",
        "availableLabelAr" => "18 عقار",
        "isSelected" => false,
        "imageAsset" => "https://images.unsplash.com/photo-1578895101407-338274d12c81?auto=format&fit=crop&w=800&q=80"
    ],
    [
        "id" => "sanaa",
        "nameAr" => "صنعاء",
        "locationHintAr" => "حي حدة وبيت بوس",
        "availableLabelAr" => "15 عقار",
        "isSelected" => false,
        "imageAsset" => "https://images.unsplash.com/photo-1541971875076-8f970d573be6?auto=format&fit=crop&w=800&q=80"
    ],
    [
        "id" => "dammam",
        "nameAr" => "الدمام",
        "locationHintAr" => "حي الراكة والشاطئ",
        "availableLabelAr" => "12 عقار",
        "isSelected" => false,
        "imageAsset" => "https://images.unsplash.com/photo-1580587771525-78b9dba3b914?auto=format&fit=crop&w=800&q=80"
    ]
];

// د) التخصصات الطبية (Specialties)
$specialties = [
    ["id" => "spec_01", "name" => "جراحة العظام", "description" => "تشخيص وعلاج أمراض وجراحة العظام والمفاصل والعمود الفقري"],
    ["id" => "spec_02", "name" => "أمراض القلب والأوعية", "description" => "علاج أمراض القلب وقسطرة وتخطيط الشرايين"],
    ["id" => "spec_03", "name" => "طب الأطفال وحديثي الولادة", "description" => "رعاية صحة ونمو الأطفال وعلاج الأمراض المعدية"],
    ["id" => "spec_04", "name" => "طب وجراحة العيون", "description" => "تصحيح النظر وعلاج أمراض الشبكية والقرنية"],
    ["id" => "spec_05", "name" => "الجلدية والتجميل والليزر", "description" => "علاج مشاكل البشرة والشعر والعمليات التجميلية غير الجراحية"]
];

// هـ) قائمة الأطباء (Doctors)
$doctors = [
    [
        "phone" => "771234567",
        "full_name" => "د. عبد الرحمن باوزير",
        "email" => "dr.bawazir@example.com",
        "bio" => "استشاري أول جراحة العظام والمفاصل واستبدال الركبة، خبرة تفوق 16 عاماً.",
        "edu_cv" => "بورد عربي في جراحة العظام، زمالة الكلية الملكية للجراحين (FRCS - لندن)",
        "rate" => 4.9,
        "experience_years" => 16,
        "license_number" => "MED-98421",
        "license_issuer" => "وزارة الصحة العامة",
        "clinic" => [
            "id" => "cl_01",
            "name" => "عيادات النخبة التخصصية",
            "city" => "صنعاء",
            "address" => "شارع حدة - أمام فندق شيراتون - برج السلام",
            "phone" => "01445566",
            "location_link" => "https://maps.google.com"
        ],
        "specialty_rel" => [
            "id" => "spec_01",
            "name" => "جراحة العظام",
            "description" => "عظام ومفاصل"
        ],
        "schedules" => [
            ["day_of_week" => "السبت", "start_time" => "09:00", "end_time" => "13:00", "session_duration" => 30],
            ["day_of_week" => "الإثنين", "start_time" => "09:00", "end_time" => "13:00", "session_duration" => 30],
            ["day_of_week" => "الأربعاء", "start_time" => "16:00", "end_time" => "20:00", "session_duration" => 30]
        ],
        "profile_image" => "https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=600&q=80"
    ],
    [
        "phone" => "777889900",
        "full_name" => "د. سارة المنصوري",
        "email" => "dr.sara@example.com",
        "bio" => "استشارية أمراض القلب التداخلية والقسطرة العلاجية، أستاذة مشاركة بكلية الطب.",
        "edu_cv" => "الدكتوراه في أمراض القلب، الزمالة الكندية في أمراض القلب التداخلية",
        "rate" => 4.8,
        "experience_years" => 12,
        "license_number" => "MED-55120",
        "license_issuer" => "وزارة الصحة",
        "clinic" => [
            "id" => "cl_02",
            "name" => "المركز الدولي للقلب",
            "city" => "الرياض",
            "address" => "طريق الملك فهد - حي العليا",
            "phone" => "011234567",
            "location_link" => "https://maps.google.com"
        ],
        "specialty_rel" => [
            "id" => "spec_02",
            "name" => "أمراض القلب والأوعية",
            "description" => "قلب وقسطرة"
        ],
        "schedules" => [
            ["day_of_week" => "الأحد", "start_time" => "10:00", "end_time" => "15:00", "session_duration" => 30],
            ["day_of_week" => "الثلاثاء", "start_time" => "10:00", "end_time" => "15:00", "session_duration" => 30],
            ["day_of_week" => "الخميس", "start_time" => "10:00", "end_time" => "14:00", "session_duration" => 30]
        ],
        "profile_image" => "https://images.unsplash.com/photo-1594824813590-48995a5f7823?auto=format&fit=crop&w=600&q=80"
    ]
];

// و) بيانات المريض الافتراضي (Patient Profile)
$currentPatient = [
    "id" => "pat_101",
    "full_name" => "محمد أحمد العولقي",
    "email" => "mohammed@example.com",
    "phone" => "777123456",
    "gender" => "ذكر",
    "birth_date" => "1996-06-20",
    "profile_image" => "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=400&q=80"
];

// ز) طلبات الحجز المسبقة (Bookings)
$bookingRequests = [
    [
        "id" => "req_001",
        "doctor_phone" => "771234567",
        "patient_phone" => "777123456",
        "appointment_date" => date('Y-m-d', strtotime('+2 days')),
        "start_time" => "10:30",
        "end_time" => "11:00",
        "status" => "confirmed",
        "reason" => "كشف متابعة لمفصل الركبة"
    ]
];

// -------------------------------------------------------------------------
// 4. توجيه الطلبات (API Routing)
// -------------------------------------------------------------------------

// 1) فحص حالة الخادم الرئيسية (Health Check / Overview)
if ($route === '/' || $route === '') {
    echo json_encode([
        "status" => "online",
        "message" => "SAKAN & Appointments Mock Backend is running successfully!",
        "version" => "2.0.0",
        "mode" => "In-Memory Simulation (No DB required)",
        "available_endpoints" => [
            "POST /auth/login" => "تسجيل الدخول",
            "POST /auth/register/patient" => "تسجيل مريض جديد",
            "GET  /patients/me" => "الملف الشخصي للمريض",
            "GET  /doctors/doctors" => "قائمة الأطباء مع التصفية",
            "GET  /specialties/" => "قائمة التخصصات الطبية",
            "GET  /bookings/requests" => "طلبات الحجز الحالية",
            "POST /bookings/requests" => "إنشاء طلب حجز جديد",
            "GET  /realestate/featured (أو /properties)" => "قائمة الفلل والعقارات مع روابط الصور",
            "GET  /realestate/cities (أو /cities)" => "قائمة المدن",
            "GET  /realestate/categories (أو /categories)" => "تصنيفات العقارات"
        ]
    ], JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
    exit();
}

// 2) تسجيل الدخول (POST /auth/login)
if ($route === '/auth/login') {
    $phone = $requestParams['phone'] ?? '777123456';
    $role = $requestParams['role'] ?? 'patient';
    
    // إنشاء توكن وهمي يحفظ في التطبيق
    echo json_encode([
        "access_token" => "mock_token_" . bin2hex(random_bytes(16)),
        "token_type" => "bearer",
        "role" => $role,
        "user_phone" => $phone
    ], JSON_UNESCAPED_UNICODE);
    exit();
}

// 3) تسجيل مريض جديد (POST /auth/register/patient)
if ($route === '/auth/register/patient') {
    echo json_encode([
        "success" => true,
        "message" => "تم تسجيل المريض بنجاح في النظام المحاكي",
        "patient" => array_merge($currentPatient, $bodyData)
    ], JSON_UNESCAPED_UNICODE);
    exit();
}

// 4) جلب بيانات المريض الشخصية (GET /patients/me)
if ($route === '/patients/me') {
    echo json_encode($currentPatient, JSON_UNESCAPED_UNICODE);
    exit();
}

// 5) جلب الأطباء (GET /doctors/doctors)
if ($route === '/doctors/doctors') {
    $cityFilter = $requestParams['city'] ?? null;
    $specialtyFilter = $requestParams['specialty_id'] ?? null;
    $minRating = isset($requestParams['minRating']) ? (float)$requestParams['minRating'] : null;

    $filteredDoctors = array_values(array_filter($doctors, function ($doc) use ($cityFilter, $specialtyFilter, $minRating) {
        if ($cityFilter && stripos($doc['clinic']['city'], $cityFilter) === false) return false;
        if ($specialtyFilter && $doc['specialty_rel']['id'] !== $specialtyFilter) return false;
        if ($minRating !== null && $doc['rate'] < $minRating) return false;
        return true;
    }));

    echo json_encode(!empty($filteredDoctors) ? $filteredDoctors : $doctors, JSON_UNESCAPED_UNICODE);
    exit();
}

// 6) جلب التخصصات (GET /specialties/ أو /specialties)
if ($route === '/specialties' || $route === '/specialties/') {
    echo json_encode($specialties, JSON_UNESCAPED_UNICODE);
    exit();
}

// 7) إنشاء طلب حجز (POST /bookings/requests)
if ($route === '/bookings/requests' && $requestMethod === 'POST') {
    $newRequest = [
        "id" => "req_" . time(),
        "doctor_phone" => $requestParams['doctor_phone'] ?? "771234567",
        "patient_phone" => $requestParams['patient_phone'] ?? $currentPatient['phone'],
        "appointment_date" => $requestParams['appointment_date'] ?? date('Y-m-d', strtotime('+1 day')),
        "start_time" => $requestParams['start_time'] ?? "11:00",
        "end_time" => "11:30",
        "status" => "pending",
        "reason" => $requestParams['reason'] ?? "استشارة طبية عامة"
    ];

    echo json_encode($newRequest, JSON_UNESCAPED_UNICODE);
    exit();
}

// 8) جلب طلبات الحجز للمريض أو الطبيب (GET /bookings/requests أو /patients/doctor/requests)
if ($route === '/bookings/requests' || $route === '/patients/doctor/requests') {
    echo json_encode($bookingRequests, JSON_UNESCAPED_UNICODE);
    exit();
}

// 9) جلب الفلل والعقارات المميزة (GET /realestate/featured أو /properties أو /realestate/properties)
if (preg_match('#^/(realestate/)?(featured|properties)#', $route)) {
    // إذا كان الطلب لعقار معين بالـ id مثل /properties/villa_01
    if (preg_match('#^/(realestate/)?properties/(.+)#', $route, $matches)) {
        $propId = $matches[2];
        foreach ($properties as $prop) {
            if ($prop['id'] === $propId) {
                echo json_encode($prop, JSON_UNESCAPED_UNICODE);
                exit();
            }
        }
        echo json_encode($properties[0], JSON_UNESCAPED_UNICODE);
        exit();
    }

    echo json_encode($properties, JSON_UNESCAPED_UNICODE);
    exit();
}

// 10) جلب قائمة المدن (GET /realestate/cities أو /cities)
if (preg_match('#^/(realestate/)?cities#', $route)) {
    echo json_encode($cities, JSON_UNESCAPED_UNICODE);
    exit();
}

// 11) جلب تصنيفات العقارات (GET /realestate/categories أو /categories)
if (preg_match('#^/(realestate/)?categories#', $route)) {
    echo json_encode($categories, JSON_UNESCAPED_UNICODE);
    exit();
}

// في حال لم يطابق أي مسار، إرجاع 404 بتنسيق JSON نظيف
http_response_code(404);
echo json_encode([
    "error" => "Endpoint not found",
    "requested_route" => $route,
    "method" => $requestMethod,
    "hint" => "Visit https://desraj.in/ to view available endpoints."
], JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
exit();
