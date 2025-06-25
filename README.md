# GoldWorkshopManager

تطبيق متكامل لإدارة وتتبع مخزون الذهب في ورش المجوهرات، مع دعم كافة المنصات (Android, iOS, Web, macOS, Windows, Linux).

## الميزات الأساسية

- إدارة المنتجات: إضافة، تحديث، قراءة، وحذف تفاصيل المنتجات.
- تكامل Supabase: استخدام Supabase كقاعدة بيانات خلفية لتخزين وإدارة بيانات المخزون.
- تحديثات فورية: انعكاس التغييرات على المخزون في الوقت الفعلي.
- إحصائيات قاعدة البيانات: تصور بيانات المخزون باستخدام رسوم بيانية ومخططات تفاعلية.
- مصادقة المستخدم: تأمين مصادقة المستخدم لضمان خصوصية البيانات والتحكم في الوصول.
- تصميم متجاوب: يعمل بسلاسة عبر مختلف الأجهزة وأحجام الشاشات.
- واجهة مستخدم بديهية: واجهة سهلة الاستخدام للتنقل والتفاعل.
- دعم الباركود: القدرة على مسح الباركود لتتبع العناصر (ميزة مستقبلية).
- التكامل مع الموازين الرقمية: ربط التطبيق بالموازين الرقمية لتسجيل أوزان الذهب بدقة (ميزة مستقبلية).
- تتبع المواد الخام: إدارة وتتبع المواد الخام الذهبية.
- سجلات الإدخال/الإخراج: تسجيل حركة دخول وخروج الذهب.
- تقارير الجرد: إنشاء تقارير مفصلة عن المخزون.
- دعم تعدد اللغات: دعم اللغتين العربية والإنجليزية مع دعم RTL.
- دعم النسخ الاحتياطي: نسخ احتياطي تلقائي محلي وسحابي.
- تقارير PDF/Excel: إنشاء تقارير بصيغة PDF و Excel.
- تكامل API سعر الذهب: جلب سعر الذهب الحالي من API خارجي.

## الإعداد والتشغيل

### المتطلبات المسبقة

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Supabase CLI](https://supabase.com/docs/guides/cli)

### خطوات الإعداد

1.  **استنساخ المستودع:**
    ```bash
    git clone https://github.com/ebramanus1/Gold-supabase.git gold_workshop_manager
    cd gold_workshop_manager
    ```

2.  **تثبيت التبعيات:**
    ```bash
    flutter pub get
    ```

3.  **إعداد Supabase:**
    - أنشئ مشروعًا جديدًا في Supabase.
    - قم بتحديث ملف `.env` في جذر المشروع باستخدام `SUPABASE_URL` و `SUPABASE_ANON_KEY` الخاصين بك. (تم تحديثه بالفعل في هذا الإصدار)
    - قم بتشغيل سكربتات SQL التالية في محرر SQL الخاص بـ Supabase لإنشاء الجداول المطلوبة:

    **users.sql:**
    ```sql
    CREATE TABLE users (
      id UUID PRIMARY KEY REFERENCES auth.users(id),
      username TEXT UNIQUE NOT NULL,
      created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
    ```

    **materials.sql:**
    ```sql
    CREATE TABLE materials (
      id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
      name TEXT UNIQUE NOT NULL,
      karat TEXT NOT NULL,
      created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
    ```

    **items.sql:**
    ```sql
    CREATE TABLE items (
      id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
      name TEXT NOT NULL,
      material_id UUID REFERENCES materials(id),
      weight DECIMAL(10, 3) NOT NULL,
      status TEXT NOT NULL,
      created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
    ```

    **entries.sql:**
    ```sql
    CREATE TABLE entries (
      id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
      item_id UUID REFERENCES items(id),
      quantity INT NOT NULL,
      entry_date TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
    ```

    **outputs.sql:**
    ```sql
    CREATE TABLE outputs (
      id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
      item_id UUID REFERENCES items(id),
      quantity INT NOT NULL,
      output_date TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
    ```
    - تأكد من تفعيل Realtime Listener في Supabase للجداول التي ترغب في الحصول على تحديثات فورية منها (مثل `items`, `entries`, `outputs`).

4.  **توليد ملفات الترجمة و JSON:**
    ```bash
    flutter gen-l10n
    flutter pub run build_runner build
    ```

### تشغيل التطبيق

لتشغيل التطبيق على منصة معينة، استخدم الأمر التالي:

-   **Android:**
    ```bash
    flutter run
    ```

-   **iOS:**
    ```bash
    flutter run
    ```

-   **Web:**
    ```bash
    flutter run -d web
    ```

-   **macOS:**
    ```bash
    flutter run -d macos
    ```

-   **Windows:**
    ```bash
    flutter run -d windows
    ```

-   **Linux:**
    ```bash
    flutter run -d linux
    ```

## إرشادات الصيانة

-   **تحديث المكتبات:** قم بتحديث المكتبات بانتظام باستخدام `flutter pub upgrade`.
-   **استكشاف الأخطاء وإصلاحها:** استخدم `flutter doctor` للتحقق من أي مشاكل في بيئة Flutter.
-   **النسخ الاحتياطي:** تأكد من أن وظائف النسخ الاحتياطي تعمل بشكل صحيح وقم باختبار استعادة البيانات بشكل دوري.


