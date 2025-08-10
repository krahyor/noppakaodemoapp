# Noppakao Flutter App

โครงสร้างโปรเจคที่ออกแบบตามแนวคิด Clean Architecture + Modular Feature + State Management (Riverpod) เพื่อให้ง่ายต่อการขยายและดูแลในระยะยาว

---
## ภาพรวมโปรเจค
แอปนี้จัดวางเลเยอร์แยกตามความรับผิดชอบ (Separation of Concerns) ได้แก่
1. Presentation Layer – UI / Widgets / Providers (State)
2. Domain Layer – Business Rules (Entities, UseCases, Repository Interface)
3. Data Layer – Data Source (API/Local), Models (DTO), Repository Implementation
4. Core & Shared – สิ่งที่ใช้ซ้ำ (utilities, theme, routing, constants)

เลือกใช้ Riverpod เพราะ:
- Type safety / Compile-time safety
- Scope ของ provider ยืดหยุ่นและง่ายต่อการทดสอบ
- แยก business logic ออกจาก UI ได้สะอาด

---
## โครงสร้างโฟลเดอร์ (Tree View)
```
## 📂 โครงสร้างโฟลเดอร์

```plaintext
lib/
├── main.dart                      # จุดเริ่มรันแอป (ProviderScope)
└── src
    ├── app
    │   └── app.dart               # MaterialApp.router หลักของแอป
    ├── config
    │   └── theme.dart             # Theme (Material 3 / ColorScheme)
    ├── core
    │   ├── constants              # ค่าคงที่ เช่น route names, keys
    │   ├── errors                 # การจัดการข้อผิดพลาด / Failure mapping
    │   └── utils                  # Utilities เช่น logger, formatters
    ├── features
    │   └── home
    │       ├── data
    │       │   ├── datasources    # Data source (API, Local DB)
    │       │   ├── models         # DTO / Model สำหรับ JSON <-> Entity
    │       │   └── repositories   # Implement repository (เรียก datasource)
    │       ├── domain
    │       │   ├── entities       # Entity บริสุทธิ์ (Pure Dart)
    │       │   ├── repositories   # Interface repository
    │       │   └── usecases       # Use case (1 action ต่อ 1 class)
    │       └── presentation
    │           ├── pages
    │           │   └── home_page.dart      # UI หน้า Home
    │           ├── providers
    │           │   └── counter_provider.dart # StateNotifier/Provider
    │           └── widgets        # Widgets เฉพาะของ feature นี้
    ├── l10n                       # Localization (.arb)
    ├── routing
    │   └── app_router.dart        # GoRouter + route tree
    ├── services                   # Services กลาง เช่น storage, analytics
    └── shared                     # Widgets/Providers ที่ใช้ข้ามหลาย feature
```

---
## คำอธิบายโฟลเดอร์ / ไฟล์สำคัญ

### root
`main.dart` – สร้าง `ProviderScope` และเรียก `NoppakaoApp`

### src/app
`app.dart` – กำหนด MaterialApp.router, theme, และ routerConfig

### src/config
`theme.dart` – เก็บ ThemeData เดียวให้ทั้งแอป สามารถแตกเป็น light/dark ได้ภายหลัง

### src/routing
`app_router.dart` – รวมเส้นทางทั้งหมด ใช้ `go_router` เพื่อรองรับ declarative navigation และ deep link ได้ง่าย

### src/core
- constants: เก็บค่าคงที่ เช่น ชื่อ route, timeout, baseURL
- errors: แปลง error ภายนอกเป็น Failure ภายในโดเมน
- utils: ฟังก์ชันอรรถประโยชน์ เช่น date format, logger

### src/features/<feature-name>
โครงสร้างซ้ำรูปแบบเดียวกันทุก feature เพื่อ scale แนวนอน

#### domain
- entities: วัตถุเชิงโดเมน ปราศจาก dependency กับ Flutter หรือ package ภายนอก
- repositories: interface ที่ layer data ต้อง implement
- usecases: คลาสเดี่ยว ทำหน้าที่เดียว (Single Responsibility) เรียก repository interface

#### data
- datasources: ติดต่อโลกภายนอก (REST, GraphQL, Local DB, Cache)
- models: แปลง JSON/Map -> Entity และกลับกัน
- repositories: implement repository interface (mapping model <-> entity + เรียก datasource)

#### presentation
- pages: หน้าจอหลักของ feature
- widgets: ส่วนประกอบ UI ย่อยที่ใช้เฉพาะใน feature นี้ (ถ้าข้าม feature ให้ย้ายไป shared)
- providers: Riverpod providers (StateNotifier, FutureProvider, etc.)

### shared
Widget / Provider / Component ที่ใช้ซ้ำได้หลาย feature เช่น AppButton, LoadingOverlay

### services
บริการกลาง เช่น LocalStorageService, AnalyticsService, CrashReportingService

### l10n
ไฟล์ ARB และการตั้งค่า localization (เพิ่มได้ภายหลัง)

---
## ตัวอย่างโค้ดเริ่มต้นสำคัญ
`main.dart`
```dart
Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
	runApp(const ProviderScope(child: NoppakaoApp()));
}
```

`counter_provider.dart`
```dart
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
	return CounterNotifier();
});
```

`home_page.dart`
```dart
class HomePage extends ConsumerWidget { /* ... */ }
```

---
## วิธีเริ่มต้นใช้งาน (Setup & Run)
1. ติดตั้ง Flutter SDK (>= 3.7.2 ตาม pubspec)
2. เรียกคำสั่งติดตั้ง dependency
	 ```bash
	 flutter pub get
	 ```
3. รันแอป (เลือก device หรือ emulator ก่อน)
	 ```bash
	 flutter run
	 ```
4. ทดสอบ (เพิ่ม test เพิ่มได้ภายหลัง)
	 ```bash
	 flutter test
	 ```

---
## แนวทางขยายโปรเจค
1. สร้าง Feature ใหม่: คัดลอกโครง `features/home` แล้วปรับชื่อ เช่น `features/profile`
2. เพิ่ม UseCase: 1 UseCase = 1 action ชัดเจน (เช่น `FetchUserProfile`) คืนค่าเป็น Either/Result หรือ throw Failure (สามารถเพิ่มแพ็กเกจ functional ได้ภายหลัง)
3. แยก State: ใช้ StateNotifier หรือ AsyncNotifier สำหรับ logic ซับซ้อน / ใช้ Provider/FutureProvider สำหรับ simple fetch
4. Error Handling: สร้าง Failure class กลางใน `core/errors` และ map error จาก datasource ที่ Repository
5. Theming: หากต้องการ Dark Mode เพิ่ม `darkTheme` และ state สำหรับ toggle ใน provider กลาง เช่น `themeModeProvider`
6. Routing: ใช้ nested routes / shell routes ใน `app_router.dart` เมื่อเพิ่ม bottom navigation หรือ auth flow
7. Localization: เพิ่มไฟล์ `intl_xx.arb` ใน `l10n/` แล้วรันคำสั่ง `flutter gen-l10n`
8. CI/CD: เพิ่ม workflow (GitHub Actions) รัน `flutter analyze`, `flutter test`, build release
9. Caching Layer: เพิ่ม local datasource (เช่น Hive/SharedPreferences) ใน `data/datasources`
10. Dependency Injection: Riverpod ทำหน้าที่ DI โดยใช้ provider เป็น container สามารถสร้าง provider สำหรับ repository/usecase ได้เลย

---
## คำถามที่พบบ่อย (FAQ ย่อ)
Q: ทำไมต้องแยก domain/data?  
A: เพื่อให้ business logic ไม่ผูกกับ implementation ของ API/DB ทำให้ทดสอบง่าย เปลี่ยน datasource ได้ไม่กระทบเลเยอร์อื่น

Q: ถ้า feature มีขนาดเล็ก จะต้องครบทุกโฟลเดอร์ไหม?  
A: ไม่จำเป็น โดยเฉพาะ usecases/entities สามารถเริ่มเล็ก แล้วค่อยแตกเมื่อ logic ซับซ้อนขึ้น

---
## License
Internal Project (เพิ่ม License ภายหลังได้)

---
หากต้องการตัวอย่าง feature เพิ่มเติม แจ้งได้เลยครับ 🙌
