# 2024-OUTFOOT-client

### 폴더 구조
#### models
  - 앱에서 사용되는 데이터 모델
  - 데이터베이스와 데이터를 주고받기 위해 사용하는 파일들을 모아두는 폴더
#### screens
- 화면 UI에 대한 폴더, 해당 화면을 표현하는 코드들을 모아두는 곳
#### widgets
- 전체적으로 사용되는 위젯 AppBar등 여러 화면에서 이용되는 Widget들을 모아두는 공간
- screens폴더가 화면 전반을 담당한다면, widgets은 그 화면의 부분부분의 요소들 중 재사용되는 UI들을 모아둔 곳
#### utils
- 앱 전체적으로 사용되는 기능을 위한 것.
- 반복되는 logic이나 func 모아두는 공간
#### services
 - 이 폴더에는 API 호출, 데이터 저장소 또는 기타 서비스를 처리하기 위한 클래스가 포함
#### assets 폴더
- 안에 fonts, images, logo 등의 세부 폴더들이 위치할 수 있으며, 앱에서 사용할 asset들을 모아두는 폴더
---
#### Naming for files and directories
'''
//this is the right method
user_data.dart (lower case for both words separated by underscore)
//these methods should be avoided
userData.dart (camel case)
UserData.dart (upper case for both words)
Loginview.dart (upper case for first word)
Login_View.dart (upper case for both words separated by underscore)
'''
