import requests
import time

def start_strict_scan():
    base_url = "http://213.210.37.24/"
    
    # الكلمة الأولى (دائماً في البداية)
    w1_variants = ["withdrawal", "Withdrawal", "withdrawals", "Withdrawals","withdraw","withdraws","Withdraw"]
    
    # الكلمة الثانية
    w2_variants = ["amount", "Amount", "amounts", "Amounts","Ammount","Ammounts","ammount","ammounts","ammont","ammonts"]
    
    # الفواصل المطلوبة فقط
    separators = ["_", "-", ""]
    
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
    }

    print(f"🚀 بدء الفحص الصارم (Withdrawal في البداية)...")
    print("-" * 60)

    for w1 in w1_variants:
        for w2 in w2_variants:
            for sep in separators:
                # تكوين اسم الملف: الكلمة الأولى + الفاصل + الكلمة الثانية
                file_name = f"{w1}{sep}{w2}.php"
                url = f"{base_url}{file_name}"
                
                try:
                    # طلب الصفحة مع جلب المحتوى (Body)
                    response = requests.get(url, headers=headers, timeout=5)
                    
                    print(f"🔍 تجربة: {file_name}")
                    print(f"📊 الحالة: {response.status_code}")
                    
                    # طباعة البودي (تم تنظيفه من الفراغات المزعجة)
                    body_content = response.text.strip()
                    if body_content:
                        # طباعة أول 1000 حرف لتجنب إغراق الشاشة إذا كان الملف ضخماً
                        print(f"📄 البودي:\n{body_content[:1000]}")
                    else:
                        print("📄 البودي: [محتوى فارغ]")
                        
                    print("-" * 30)

                    # إذا وجدت الملف، توقف فوراً
                    if response.status_code == 200:
                        print(f"⭐ تم العثور على الملف المطلوب بنجاح: {url}")
                        return 

                    # تأخير بسيط (نصف ثانية) بين الطلبات لضمان استقرار السيرفر
                 

                except Exception as e:
                    print(f"⚠️ خطأ في الاتصال مع {file_name}: {e}")
                    continue

    print("🏁 انتهت جميع الاحتمالات المحددة.")

if __name__ == "__main__":
    start_strict_scan()