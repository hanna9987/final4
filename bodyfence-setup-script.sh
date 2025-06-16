#!/bin/bash

# BODYFENCE 프로젝트 자동 설정 스크립트
# 사용법: chmod +x setup-bodyfence.sh && ./setup-bodyfence.sh

set -e

echo "🚀 BODYFENCE 프로젝트 설정을 시작합니다..."

# 프로젝트 이름
PROJECT_NAME="bodyfence-app"

# 1. React + TypeScript + Vite 프로젝트 생성
echo "📦 React 프로젝트를 생성 중..."
npm create vite@latest $PROJECT_NAME -- --template react-ts
cd $PROJECT_NAME

# 2. 필요한 패키지 설치
echo "📚 필요한 패키지들을 설치 중..."
npm install react-router-dom lucide-react
npm install -D tailwindcss postcss autoprefixer @types/node

# 3. Tailwind CSS 설정
echo "🎨 Tailwind CSS를 설정 중..."
npx tailwindcss init -p

# 4. 폴더 구조 생성
echo "📁 프로젝트 폴더 구조를 생성 중..."
mkdir -p src/components/common
mkdir -p src/components/ui
mkdir -p src/components/charts
mkdir -p src/pages
mkdir -p src/hooks
mkdir -p src/types
mkdir -p src/utils

# 5. Tailwind 설정 파일 생성
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        'sans': ['-apple-system', 'BlinkMacSystemFont', 'San Francisco', 'Helvetica Neue', 'sans-serif'],
      },
      maxWidth: {
        'mobile': '428px', // iPhone 14 Plus width
      },
      colors: {
        'bodyfence': {
          50: '#eff6ff',
          100: '#dbeafe',
          500: '#3b82f6',
          600: '#2563eb',
        }
      }
    },
  },
  plugins: [],
}
EOF

# 6. index.css 파일 업데이트
cat > src/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  html {
    font-family: -apple-system, BlinkMacSystemFont, 'San Francisco', 'Helvetica Neue', sans-serif;
  }
  
  body {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
  }
}

@layer components {
  .mobile-container {
    @apply max-w-mobile mx-auto bg-white min-h-screen relative;
  }
  
  .gradient-bg {
    @apply bg-gradient-to-b from-blue-50 to-blue-100;
  }
}
EOF

# 7. types/index.ts 생성
cat > src/types/index.ts << 'EOF'
export interface HealthData {
  id: string;
  label: string;
  value: string;
  status: 'normal' | 'warning' | 'danger';
  icon: string;
  timestamp: Date;
}

export interface TestResult {
  id: string;
  type: 'fall_risk' | 'cognitive';
  score: number;
  date: Date;
  details: {
    reaction_time?: number;
    balance_score?: number;
    memory_score?: number;
  };
}

export interface WalkingData {
  timestamp: Date;
  steps: number;
  stability: number;
  location: {
    lat: number;
    lng: number;
  };
}

export interface User {
  id: string;
  name: string;
  age: number;
  emergency_contacts: Array<{
    name: string;
    phone: string;
    relation: string;
  }>;
}
EOF

# 8. utils/constants.ts 생성
cat > src/utils/constants.ts << 'EOF'
export const HEALTH_STATUS = {
  NORMAL: 'normal',
  WARNING: 'warning', 
  DANGER: 'danger'
} as const;

export const TEST_TYPES = {
  FALL_RISK_1: 'fall_risk_1',
  FALL_RISK_2: 'fall_risk_2',
  COGNITIVE: 'cognitive'
} as const;

export const ROUTES = {
  HOME: '/',
  HEALTH: '/health',
  TEST: '/test',
  TEST_RESULTS: '/test/results',
  WALKING: '/walking'
} as const;

export const COLORS = {
  PRIMARY: '#3b82f6',
  SUCCESS: '#10b981',
  WARNING: '#f59e0b',
  DANGER: '#ef4444',
  GRAY: '#6b7280'
} as const;
EOF

# 9. Layout.tsx 생성
cat > src/components/common/Layout.tsx << 'EOF'
import React from 'react';
import { Outlet } from 'react-router-dom';
import BottomNav from './BottomNav';

const Layout: React.FC = () => {
  return (
    <div className="min-h-screen gradient-bg">
      <div className="mobile-container">
        <main className="pb-20">
          <Outlet />
        </main>
        <BottomNav />
      </div>
    </div>
  );
};

export default Layout;
EOF

# 10. BottomNav.tsx 생성
cat > src/components/common/BottomNav.tsx << 'EOF'
import React from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { Home, User, Calendar, MessageCircle } from 'lucide-react';
import { ROUTES } from '../../utils/constants';

const BottomNav: React.FC = () => {
  const navigate = useNavigate();
  const location = useLocation();

  const navItems = [
    { path: ROUTES.HOME, icon: Home, label: '홈' },
    { path: ROUTES.WALKING, icon: MessageCircle, label: '분석' },
    { path: ROUTES.HEALTH, icon: User, label: '건강' },
    { path: ROUTES.TEST, icon: Calendar, label: '테스트' },
  ];

  return (
    <nav className="fixed bottom-0 left-1/2 transform -translate-x-1/2 w-full max-w-mobile bg-white border-t border-gray-200 z-50">
      <div className="flex justify-around items-center py-2">
        {navItems.map((item) => {
          const Icon = item.icon;
          const isActive = location.pathname === item.path;
          
          return (
            <button
              key={item.path}
              onClick={() => navigate(item.path)}
              className={`flex flex-col items-center p-2 rounded-lg transition-colors ${
                isActive 
                  ? 'text-blue-500 bg-blue-50' 
                  : 'text-gray-500 hover:text-blue-400'
              }`}
            >
              <Icon size={24} />
              <span className="text-xs mt-1">{item.label}</span>
            </button>
          );
        })}
      </div>
    </nav>
  );
};

export default BottomNav;
EOF

# 11. App.tsx 생성
cat > src/App.tsx << 'EOF'
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Layout from './components/common/Layout';
import Home from './pages/Home';
import HealthInfo from './pages/HealthInfo';
import TestMain from './pages/TestMain';
import TestResults from './pages/TestResults';
import WalkingAnalysis from './pages/WalkingAnalysis';
import { ROUTES } from './utils/constants';

function App() {
  return (
    <Router>
      <div className="App">
        <Routes>
          <Route path="/" element={<Layout />}>
            <Route index element={<Home />} />
            <Route path={ROUTES.HEALTH} element={<HealthInfo />} />
            <Route path={ROUTES.TEST} element={<TestMain />} />
            <Route path={ROUTES.TEST_RESULTS} element={<TestResults />} />
            <Route path={ROUTES.WALKING} element={<WalkingAnalysis />} />
          </Route>
        </Routes>
      </div>
    </Router>
  );
}

export default App;
EOF

# 12. Home.tsx 생성
cat > src/pages/Home.tsx << 'EOF'
import React from 'react';
import { useNavigate } from 'react-router-dom';
import { Bell, Settings, Mic, Search, Brain } from 'lucide-react';
import { ROUTES } from '../utils/constants';

const Home: React.FC = () => {
  const navigate = useNavigate();

  const healthStats = [
    { label: '건강 상태', value: '86%', description: '건강 상태 매우 양호', color: 'green' },
    { label: '보행 분석', value: '46점', description: '보행 안정성 낮은 상태', color: 'orange' },
    { label: '에어백 상태', value: '100%', description: '점웨어 매우 안정적', color: 'green' },
    { label: '보행 기록', value: '위치 찾기', description: '정상 위치 확인됨', color: 'blue' },
  ];

  return (
    <div className="p-4 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between pt-8">
        <div>
          <h1 className="text-3xl font-bold text-blue-600">BODYFENCE</h1>
          <p className="text-sm text-gray-600 mt-1">Walk Safe, Live Smart</p>
        </div>
        <div className="flex space-x-2">
          <button className="p-2 bg-blue-50 rounded-full hover:bg-blue-100 transition-colors">
            <Bell size={20} className="text-blue-600" />
          </button>
          <button className="p-2 bg-blue-50 rounded-full hover:bg-blue-100 transition-colors">
            <Settings size={20} className="text-blue-600" />
          </button>
        </div>
      </div>

      {/* Greeting */}
      <div className="text-center py-4">
        <h2 className="text-xl font-semibold text-gray-800">안녕하세요 김순자님!</h2>
      </div>

      {/* Voice Search */}
      <div className="bg-white rounded-2xl p-4 shadow-sm border border-blue-100">
        <div className="flex items-center space-x-3">
          <Mic className="text-blue-500" size={24} />
          <Search className="text-blue-500" size={24} />
          <span className="text-gray-600">위키를 물어보세요</span>
        </div>
      </div>

      {/* Test Mode */}
      <button
        onClick={() => navigate(ROUTES.TEST)}
        className="w-full bg-gradient-to-r from-blue-500 to-blue-600 rounded-2xl p-6 text-white shadow-lg hover:shadow-xl transition-shadow"
      >
        <div className="flex items-center justify-between">
          <div className="text-left">
            <h3 className="text-lg font-semibold">테스트 모드</h3>
            <p className="text-sm opacity-90 mt-1">낙상 위험 및 인지기능 검사</p>
          </div>
          <div className="text-right">
            <div className="text-3xl font-bold">88점</div>
            <Brain size={24} className="mt-1 ml-auto" />
          </div>
        </div>
      </button>

      {/* Health Stats Grid */}
      <div className="grid grid-cols-2 gap-4">
        {healthStats.map((stat, index) => (
          <div key={index} className="bg-white rounded-2xl p-4 shadow-sm border border-blue-100 hover:shadow-md transition-shadow">
            <h4 className="text-sm font-medium text-gray-600">{stat.label}</h4>
            <div className="mt-2">
              <div className="text-xl font-bold text-gray-800">{stat.value}</div>
              <p className="text-xs text-gray-500 mt-1">{stat.description}</p>
            </div>
          </div>
        ))}
      </div>

      {/* Emergency Button */}
      <button className="w-full bg-red-500 hover:bg-red-600 text-white font-semibold py-4 rounded-2xl transition-colors shadow-lg">
        🚨 긴급 연락
      </button>
    </div>
  );
};

export default Home;
EOF

# 13. HealthInfo.tsx 생성
cat > src/pages/HealthInfo.tsx << 'EOF'
import React from 'react';
import { ArrowLeft, Bell, Settings } from 'lucide-react';
import { useNavigate } from 'react-router-dom';

const HealthInfo: React.FC = () => {
  const navigate = useNavigate();

  const healthData = [
    { label: '혈압', value: '125/80 mmHg', status: '정상', icon: '🫀' },
    { label: '심박수', value: '72 bpm', status: '정상', icon: '💓' },
    { label: 'BMI 수치', value: '23.5', status: '미달', icon: '👤' },
  ];

  const weeklyStatus = [
    { date: '5/25', status: 'warning' },
    { date: '5/26', status: 'danger' },
    { date: '5/27', status: 'good' },
    { date: '5/28', status: 'good' },
    { date: '5/29', status: 'good' },
  ];

  return (
    <div className="p-4 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between pt-8">
        <button onClick={() => navigate(-1)} className="p-2 hover:bg-gray-100 rounded-full transition-colors">
          <ArrowLeft className="text-blue-600" size={24} />
        </button>
        <h1 className="text-xl font-bold text-gray-800">건강 상태</h1>
        <div className="flex space-x-2">
          <Bell size={20} className="text-blue-600" />
          <Settings size={20} className="text-blue-600" />
        </div>
      </div>

      {/* Health Score */}
      <div className="bg-white rounded-2xl p-6 shadow-sm border border-blue-100">
        <div className="text-center">
          <div className="text-sm text-gray-600 mb-2">건강 점수</div>
          <div className="text-4xl font-bold text-blue-600 mb-2">82점</div>
          <div className="text-sm text-gray-500">평웨어 매우 안정적</div>
          <div className="mt-6 w-24 h-24 bg-blue-100 rounded-full flex items-center justify-center mx-auto">
            <span className="text-3xl">😊</span>
          </div>
        </div>
      </div>

      {/* Toggle Buttons */}
      <div className="flex bg-gray-100 rounded-xl p-1">
        <button className="flex-1 py-3 px-4 bg-white rounded-lg shadow-sm text-sm font-medium text-gray-700 transition-colors">
          건강 정보
        </button>
        <button className="flex-1 py-3 px-4 text-sm font-medium text-gray-500 hover:text-gray-700 transition-colors">
          상세 통계
        </button>
      </div>

      {/* Vital Signs */}
      <div className="space-y-4">
        <h3 className="text-lg font-semibold text-gray-800">생체 신호</h3>
        {healthData.map((item, index) => (
          <div key={index} className="bg-white rounded-xl p-4 shadow-sm border border-gray-100">
            <div className="flex items-center justify-between">
              <div className="flex items-center space-x-3">
                <div className="w-12 h-12 bg-blue-50 rounded-full flex items-center justify-center">
                  <span className="text-xl">{item.icon}</span>
                </div>
                <div>
                  <div className="font-medium text-gray-600 text-sm">{item.label}</div>
                  <div className="text-lg font-bold text-gray-900">{item.value}</div>
                </div>
              </div>
              <div className={`px-3 py-1 rounded-full text-sm font-medium ${
                item.status === '정상' 
                  ? 'bg-green-100 text-green-800' 
                  : 'bg-orange-100 text-orange-800'
              }`}>
                {item.status}
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Weekly Status */}
      <div className="space-y-4">
        <h3 className="text-lg font-semibold text-gray-800">낙상 이력</h3>
        <div className="flex justify-between items-center">
          {weeklyStatus.map((day, index) => (
            <div key={index} className="flex flex-col items-center space-y-2">
              <div className={`w-10 h-10 rounded-full ${
                day.status === 'good' ? 'bg-green-500' :
                day.status === 'warning' ? 'bg-yellow-500' : 'bg-red-500'
              }`}></div>
              <span className="text-xs text-gray-600">{day.date}</span>
            </div>
          ))}
        </div>
        
        <div className="bg-red-50 border border-red-200 rounded-xl p-4 mt-4">
          <div className="flex items-start space-x-3">
            <span className="text-red-500 text-xl">⚠️</span>
            <div>
              <div className="font-semibold text-red-800">낙상 감지됨</div>
              <div className="text-sm text-red-600 mt-1">
                5/26일에 낙상이 감지되었습니다. 보호자께 알림이 전송되었습니다.
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default HealthInfo;
EOF

# 14. TestMain.tsx 생성
cat > src/pages/TestMain.tsx << 'EOF'
import React from 'react';
import { ArrowLeft } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '../utils/constants';

const TestMain: React.FC = () => {
  const navigate = useNavigate();

  const testOptions = [
    {
      title: '낙상 위험도 검사 I',
      description: '낙상 위험 및 인지기능 검사',
      type: 'outline' as const,
      action: () => navigate(ROUTES.TEST_RESULTS)
    },
    {
      title: '낙상 위험도 검사 II',
      description: '낙상 위험 및 인지기능 검사',
      type: 'filled' as const,
      action: () => navigate(ROUTES.TEST_RESULTS)
    },
    {
      title: '인지기능 검사',
      description: '인지기능 검사',
      type: 'outline' as const,
      action: () => navigate(ROUTES.TEST_RESULTS)
    }
  ];

  return (
    <div className="p-4 space-y-6">
      {/* Header */}
      <div className="flex items-center pt-8">
        <button 
          onClick={() => navigate(-1)} 
          className="mr-4 p-2 hover:bg-gray-100 rounded-full transition-colors"
        >
          <ArrowLeft className="text-blue-600" size={24} />
        </button>
        <span className="text-gray-600">뒤로가기</span>
      </div>

      {/* Title */}
      <div className="space-y-2">
        <h2 className="text-2xl font-bold text-blue-600">낙상 & 인지기능</h2>
        <h2 className="text-2xl font-bold text-blue-600">테스트</h2>
      </div>

      {/* Medical Icons */}
      <div className="flex justify-center items-center space-x-6 py-8">
        <div className="w-16 h-16 bg-blue-50 rounded-xl flex items-center justify-center">
          <span className="text-3xl">📋</span>
        </div>
        <div className="w-24 h-24 bg-red-100 rounded-2xl flex items-center justify-center">
          <div className="relative">
            <span className="text-4xl">❤️</span>
            <span className="absolute -top-1 -right-1 text-2xl">⚡</span>
          </div>
        </div>
        <div className="w-16 h-16 bg-gray-100 rounded-xl flex items-center justify-center">
          <span className="text-3xl">🩺</span>
        </div>
      </div>

      {/* Test Options */}
      <div className="space-y-4">
        {testOptions.map((option, index) => (
          <button
            key={index}
            onClick={option.action}
            className={`w-full p-6 rounded-2xl border-2 transition-all hover:scale-[1.02] ${
              option.type === 'filled'
                ? 'bg-blue-500 border-blue-500 text-white shadow-lg'
                : 'bg-white border-blue-200 text-blue-600 hover:bg-blue-50 shadow-sm'
            }`}
          >
            <div className="text-left">
              <div className="font-semibold text-lg">{option.title}</div>
              <div className={`text-sm mt-2 ${
                option.type === 'filled' ? 'text-blue-100' : 'text-gray-600'
              }`}>
                {option.description}
              </div>
            </div>
          </button>
        ))}
      </div>
    </div>
  );
};

export default TestMain;
EOF

# 15. 나머지 페이지들 생성
cat > src/pages/TestResults.tsx << 'EOF'
import React from 'react';
import { ArrowLeft, Brain, Activity, User } from 'lucide-react';
import { useNavigate } from 'react-router-dom';

const TestResults: React.FC = () => {
  const navigate = useNavigate();

  return (
    <div className="p-4 space-y-6">
      <div className="flex items-center pt-8">
        <button onClick={() => navigate(-1)} className="mr-4">
          <ArrowLeft className="text-blue-600" size={24} />
        </button>
        <h1 className="text-xl font-bold text-gray-800">테스트 결과</h1>
      </div>

      <div className="bg-white rounded-2xl p-6 shadow-sm border border-blue-100">
        <div className="text-center">
          <div className="text-sm text-gray-600 mb-2">종합 점수</div>
          <div className="text-4xl font-bold text-blue-600 mb-2">84점</div>
          <div className="text-sm text-gray-500">인지 기능 전반이 안정적</div>
        </div>
      </div>

      <div className="space-y-4">
        <div className="bg-white rounded-xl p-4 border-l-4 border-green-500">
          <div className="flex items-center space-x-3">
            <Brain className="text-green-500" size={24} />
            <div>
              <div className="font-medium">주의 배분 능력</div>
              <div className="text-sm text-gray-600">92 / 100</div>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-xl p-4 border-l-4 border-yellow-500">
          <div className="flex items-center space-x-3">
            <Activity className="text-yellow-500" size={24} />
            <div>
              <div className="font-medium">작업 기억 능력</div>
              <div className="text-sm text-gray-600">73 / 100</div>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-xl p-4 border-l-4 border-red-500">
          <div className="flex items-center space-x-3">
            <User className="text-red-500" size={24} />
            <div>
              <div className="font-medium">행동 조절 능력</div>
              <div className="text-sm text-gray-600">52 / 100</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default TestResults;
EOF

cat > src/pages/WalkingAnalysis.tsx << 'EOF'
import React from 'react';
import { ArrowLeft } from 'lucide-react';
import { useNavigate } from 'react-router-dom';

const WalkingAnalysis: React.FC = () => {
  const navigate = useNavigate();

  return (
    <div className="p-4 space-y-6">
      <div className="flex items-center pt-8">
        <button onClick={() => navigate(-1)} className="mr-4">
          <ArrowLeft className="text-blue-600" size={24} />
        </button>
        <h1 className="text-xl font-bold text-gray-800">보행 분석</h1>
      </div>

      <div className="bg-white rounded-2xl p-6 shadow-sm">
        <h3 className="text-lg font-semibold mb-4">오늘의 보행 데이터</h3>
        <div className="space-y-4">
          <div className="flex justify-between">
            <span>걸음 수</span>
            <span className="font-semibold">3,247 걸음</span>
          </div>
          <div className="flex justify-between">
            <span>보행 거리</span>
            <span className="font-semibold">2.1 km</span>
          </div>
          <div className="flex justify-between">
            <span>안정성 점수</span>
            <span className="font-semibold text-orange-600">46점</span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default WalkingAnalysis;
EOF

# 16. package.json 스크립트 업데이트
echo "📝 package.json 스크립트를 업데이트 중..."
npm pkg set scripts.dev="vite"
npm pkg set scripts.build="tsc && vite build"
npm pkg set scripts.preview="vite preview"
npm pkg set scripts.lint="eslint src --ext ts,tsx --report-unused-disable-directives --max-warnings 0"

# 17. 개발 서버 시작 옵션 제공
echo ""
echo "✅ BODYFENCE 프로젝트 설정이 완료되었습니다!"
echo ""
echo "📂 프로젝트 폴더: $PROJECT_NAME"
echo ""
echo "🚀 다음 명령어로 개발 서버를 시작하세요:"
echo "   cd $PROJECT_NAME"
echo "   npm run dev"
echo ""
echo "🌐 개발 서버가 시작되면 http://localhost:5173 에서 확인하세요"
echo ""

# 18. 자동 실행 여부 묻기
read -p "🤔 지금 바로 개발 서버를 실행하시겠습니까? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🚀 개발 서버를 시작합니다..."
    npm run dev
else
    echo "👋 설정이 완료되었습니다. 나중에 'cd $PROJECT_NAME && npm run dev'로 실행하세요!"
fi