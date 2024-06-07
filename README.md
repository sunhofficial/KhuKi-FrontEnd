
# khukiting
경희대 학생들을 위한 안전하고 진지한 만남의 장, 경희대 CC 앱입니다. 이 앱은 경희대 학생들 간의 공감대를 형성하고, 익명성을 보장하며, 진지한 만남을 제공하는 것을 목표로 합니다.

## 주요 기능

### 경희대 특화된 프로필: 경희대 학생들이 공감할 수 있는 정보를 제공
### 익명성 보장: 이름과 얼굴 사진 대신 나이 범위, 단과대 거리 등만 제공
### 진지한 만남 유도: 하루에 한 번만 선택 가능

## 기술 스택

프론트엔드: Flutter
백엔드: Vapor
상태 관리: Provider
HTTP 클라이언트: Dio
아키텍처: Clean Architecture (MVVM 패턴)

## 폴더 구조

```plaintext
lib/
├── config/
│   └── configurations.dart
├── data/
│   ├── DTO/
│   │   └── response/
│   │       ├── CookiesResponse.dart
│   │       └── PickCookieResponse.dart
│   ├── datasources/
│   │   ├── local/
│   │   │   └── AccessTokenProvider.dart
│   │   └── remote/
│   │       └── RemoteServerDatasources.dart
│   └── services/
│       └── LoggingInterceptor.dart
├── domain/
│   ├── Model/
│   │   ├── Cookie.dart
│   │   └── NameTag.dart
│   └── repository/
│       └── UserRepository.dart
├── presentation/
│   ├── views/
│   │   ├── Login/
│   │   │   └── LoginView.dart
│   │   ├── MainPage/
│   │   │   └── MainViewModel.dart
│   │   ├── ProfileSetting/
│   │   │   ├── ThirdView.dart
│   │   │   └── SecondViewModel.dart
│   │   ├── PickedCookies/
│   │   │   └── PickedCookiesView.dart
│   │   ├── Settingpage/
│   │   │   └── SettingView.dart
│   └── widgets/
│       ├── CookieDetailBottomModal.dart
│       ├── CookieInfoStack.dart
│       └── PickedCookieStack.dart
├── utils/
│   └── ColorStyles.dart
└── main.dart
```
설치 및 실행

요구 사항

Flutter 설치 (버전 2.0 이상)

Dart SDK

Xcode (iOS 개발 시)

Android Studio (Android 개발 시)

Vapor 설치 (백엔드 서버)
