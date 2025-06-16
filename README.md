# BODYFENCE - Walk Safe, Live Smart

노인 낙상 방지 및 건강 모니터링을 위한 모바일 웹 애플리케이션

## 🚀 프로젝트 개요

BODYFENCE는 노인의 건강과 안전을 모니터링하고 관리하는 것을 목적으로 하는 React 기반의 모바일 웹 애플리케이션입니다.

## ✨ 주요 기능

- **건강 상태 모니터링**: 실시간 생체 신호 및 건강 데이터 추적
- **낙상 위험도 검사**: 다양한 테스트를 통한 낙상 위험 평가
- **인지기능 검사**: 인지 능력 평가 및 모니터링
- **보행 분석**: 걸음 수, 보행 거리, 안정성 점수 분석
- **긴급 연락**: 응급 상황 시 보호자 연락 기능

## 🛠 기술 스택

- **Frontend**: React 18, TypeScript
- **Build Tool**: Vite
- **Styling**: Tailwind CSS
- **Routing**: React Router DOM
- **Icons**: Lucide React

## 📱 화면 구성

1. **홈 화면**: 건강 상태 대시보드 및 주요 기능 접근
2. **건강 정보**: 생체 신호 및 낙상 이력 확인
3. **테스트 모드**: 낙상 위험도 및 인지기능 검사
4. **테스트 결과**: 검사 결과 및 상세 분석
5. **보행 분석**: 일일 보행 데이터 및 안정성 분석

## 🚀 시작하기

### 필수 요구사항

- Node.js 18.0.0 이상
- npm 또는 yarn

### 설치 및 실행

1. 의존성 설치
```bash
npm install
```

2. 개발 서버 실행
```bash
npm run dev
```

3. 브라우저에서 `http://localhost:5173` 접속

### 빌드

```bash
npm run build
```

### 미리보기

```bash
npm run preview
```

## 📁 프로젝트 구조

```
src/
├── components/
│   ├── common/          # 공통 컴포넌트
│   ├── ui/              # UI 컴포넌트
│   └── charts/          # 차트 컴포넌트
├── pages/               # 페이지 컴포넌트
├── hooks/               # 커스텀 훅
├── types/               # TypeScript 타입 정의
└── utils/               # 유틸리티 함수
```

## 🎨 디자인 특징

- 모바일 최적화 (iPhone 14 Plus 기준)
- 직관적인 사용자 인터페이스
- 접근성을 고려한 디자인
- 시각적 피드백 및 상태 표시

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 