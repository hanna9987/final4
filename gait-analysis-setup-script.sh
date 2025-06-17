#!/bin/bash

# 보행 분석 앱 자동 설정 스크립트
# 사용법: chmod +x setup-gait-analysis.sh && ./setup-gait-analysis.sh

set -e

echo "🚀 보행 분석 앱 설정을 시작합니다..."

# 프로젝트 이름
PROJECT_NAME="gait-analysis-app"

# 1. React + TypeScript + Vite 프로젝트 생성
echo "📦 React 프로젝트를 생성 중..."
npm create vite@latest $PROJECT_NAME -- --template react-ts
cd $PROJECT_NAME

# 2. 필요한 패키지 설치
echo "📚 필요한 패키지들을 설치 중..."
npm install react-router-dom lucide-react framer-motion
npm install -D tailwindcss postcss autoprefixer @types/node

# 3. Tailwind CSS 설정
echo "🎨 Tailwind CSS를 설정 중..."
npx tailwindcss init -p

# 4. 폴더 구조 생성
echo "📁 프로젝트 폴더 구조를 생성 중..."
mkdir -p src/components/common
mkdir -p src/components/gait
mkdir -p src/pages
mkdir -p src/types
mkdir -p src/hooks
mkdir -p src/utils

# 5. Tailwind 설정 파일 업데이트
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
        'league-spartan': ['"League Spartan"', 'sans-serif'],
        'lilita-one': ['"Lilita One"', 'cursive'],
        'suit': ['"SUIT Variable"', 'sans-serif'],
      },
      maxWidth: {
        'mobile': '428px',
      },
      colors: {
        'bodyfence': {
          50: '#ECF1FF',
          100: '#dbeafe',
          500: '#2260ff',
          600: '#4378ff',
        }
      },
      animation: {
        'fade-in': 'fadeIn 0.5s ease-in-out',
        'slide-up': 'slideUp 0.3s ease-out',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        slideUp: {
          '0%': { transform: 'translateY(20px)', opacity: '0' },
          '100%': { transform: 'translateY(0)', opacity: '1' },
        },
      }
    },
  },
  plugins: [],
}
EOF

# 6. index.css 업데이트
cat > src/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@import url('https://fonts.googleapis.com/css2?family=League+Spartan:wght@100;200;300;400;500;600;700;800;900&family=Lilita+One&display=swap');
@import url('https://cdn.jsdelivr.net/gh/sunn-us/SUIT/fonts/variable/woff2/SUIT-Variable.css');

@layer base {
  html {
    font-family: -apple-system, BlinkMacSystemFont, 'SUIT Variable', 'Helvetica Neue', sans-serif;
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
  
  .card-shadow {
    @apply shadow-sm border border-blue-100;
  }
}
EOF

# 7. types/gait.ts 생성
cat > src/types/gait.ts << 'EOF'
export interface GaitMetric {
  id: string;
  title: string;
  value: string;
  status: 'normal' | 'warning' | 'danger';
  description: string;
  interpretation: string;
  details?: string;
}

export interface DiseaseRisk {
  name: string;
  probability: number;
  status: 'low' | 'medium' | 'high';
  description: string;
}

export interface GaitAnalysisData {
  totalScore: number;
  riskLevel: string;
  metrics: GaitMetric[];
  diseaseRisks: DiseaseRisk[];
  detailedReport: {
    riskStage: string;
    analysis: string[];
  };
}
EOF

# 8. components/common/BackButton.tsx 생성
cat > src/components/common/BackButton.tsx << 'EOF'
import React from 'react';
import { ArrowLeft } from 'lucide-react';

interface BackButtonProps {
  onClick: () => void;
  className?: string;
}

const BackButton: React.FC<BackButtonProps> = ({ onClick, className = '' }) => {
  return (
    <button
      onClick={onClick}
      className={`p-2 hover:bg-gray-100 rounded-full transition-colors ${className}`}
    >
      <ArrowLeft className="text-blue-600" size={24} />
    </button>
  );
};

export default BackButton;
EOF

# 9. components/gait/GaitScoreCard.tsx 생성
cat > src/components/gait/GaitScoreCard.tsx << 'EOF'
import React from 'react';

interface GaitScoreCardProps {
  score: number;
  riskLevel: string;
}

const GaitScoreCard: React.FC<GaitScoreCardProps> = ({ score, riskLevel }) => {
  const getScoreColor = (score: number) => {
    if (score >= 70) return 'text-green-500';
    if (score >= 40) return 'text-yellow-500';
    return 'text-red-500';
  };

  const getProgressColor = (score: number) => {
    if (score >= 70) return 'stroke-green-500';
    if (score >= 40) return 'stroke-yellow-500';
    return 'stroke-red-500';
  };

  const circumference = 2 * Math.PI * 45;
  const strokeDasharray = circumference;
  const strokeDashoffset = circumference - (score / 100) * circumference;

  return (
    <div className="bg-white rounded-2xl p-6 card-shadow mb-6">
      <div className="flex items-center justify-between">
        <div>
          <div className="text-sm text-gray-600 mb-1">보행 점수</div>
          <div className={`text-3xl font-bold ${getScoreColor(score)}`}>{score}점</div>
          <div className="text-sm text-gray-500 mt-1">{riskLevel}</div>
        </div>
        <div className="relative w-20 h-20">
          <svg className="w-20 h-20 transform -rotate-90" viewBox="0 0 100 100">
            <circle
              cx="50"
              cy="50"
              r="45"
              stroke="currentColor"
              strokeWidth="8"
              fill="transparent"
              className="text-gray-200"
            />
            <circle
              cx="50"
              cy="50"
              r="45"
              stroke="currentColor"
              strokeWidth="8"
              fill="transparent"
              strokeDasharray={strokeDasharray}
              strokeDashoffset={strokeDashoffset}
              className={getProgressColor(score)}
              strokeLinecap="round"
            />
          </svg>
          <div className="absolute inset-0 flex items-center justify-center">
            {score < 50 && <span className="text-red-500 text-xl">⚠️</span>}
          </div>
        </div>
      </div>
    </div>
  );
};

export default GaitScoreCard;
EOF

# 10. components/gait/TabSelector.tsx 생성
cat > src/components/gait/TabSelector.tsx << 'EOF'
import React from 'react';

interface TabSelectorProps {
  activeTab: 'health' | 'stats';
  onTabChange: (tab: 'health' | 'stats') => void;
}

const TabSelector: React.FC<TabSelectorProps> = ({ activeTab, onTabChange }) => {
  return (
    <div className="flex bg-gray-100 rounded-xl p-1 mb-6">
      <button
        onClick={() => onTabChange('health')}
        className={`flex-1 py-3 px-4 rounded-lg text-sm font-medium transition-all ${
          activeTab === 'health'
            ? 'bg-white text-gray-700 shadow-sm'
            : 'text-gray-500 hover:text-gray-700'
        }`}
      >
        건강 정보
      </button>
      <button
        onClick={() => onTabChange('stats')}
        className={`flex-1 py-3 px-4 rounded-lg text-sm font-medium transition-all ${
          activeTab === 'stats'
            ? 'bg-blue-500 text-white shadow-sm'
            : 'text-gray-500 hover:text-gray-700'
        }`}
      >
        상세 통계
      </button>
    </div>
  );
};

export default TabSelector;
EOF

# 11. components/gait/GaitMetricCard.tsx 생성
cat > src/components/gait/GaitMetricCard.tsx << 'EOF'
import React, { useState } from 'react';
import { ChevronDown, CheckCircle } from 'lucide-react';
import { GaitMetric } from '../../types/gait';

interface GaitMetricCardProps {
  metric: GaitMetric;
  isExpanded?: boolean;
}

const GaitMetricCard: React.FC<GaitMetricCardProps> = ({ metric, isExpanded = false }) => {
  const [expanded, setExpanded] = useState(isExpanded);

  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'normal':
        return <div className="w-4 h-4 bg-green-500 rounded-full"></div>;
      case 'warning':
        return <div className="w-4 h-4 bg-yellow-500 rounded-full"></div>;
      case 'danger':
        return <div className="w-4 h-4 bg-red-500 rounded-full"></div>;
      default:
        return <div className="w-4 h-4 bg-gray-400 rounded-full"></div>;
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'normal':
        return 'border-green-200 bg-green-50';
      case 'warning':
        return 'border-yellow-200 bg-yellow-50';
      case 'danger':
        return 'border-red-200 bg-red-50';
      default:
        return 'border-gray-200 bg-gray-50';
    }
  };

  const getResultText = (status: string) => {
    switch (status) {
      case 'normal':
        return '분석 결과 정상입니다!';
      case 'warning':
        return '분석 결과 주의입니다!';
      case 'danger':
        return '분석 결과 위험입니다!';
      default:
        return '분석 중입니다...';
    }
  };

  return (
    <div className={`rounded-2xl border-2 transition-all duration-300 ${getStatusColor(metric.status)}`}>
      <button
        onClick={() => setExpanded(!expanded)}
        className="w-full p-4 text-left hover:bg-opacity-50 transition-colors"
      >
        <div className="flex items-center justify-between">
          <div className="flex items-center space-x-3">
            <CheckCircle className="text-gray-600" size={24} />
            <div>
              <div className="font-semibold text-gray-800">{metric.title}</div>
              <div className="text-xl font-bold text-gray-900">{metric.value}</div>
            </div>
          </div>
          <div className="flex items-center space-x-2">
            {getStatusIcon(metric.status)}
            <ChevronDown 
              className={`text-gray-400 transition-transform duration-200 ${
                expanded ? 'rotate-180' : ''
              }`} 
              size={20} 
            />
          </div>
        </div>
      </button>
      
      {expanded && (
        <div className="px-4 pb-4 border-t border-gray-200 mt-2 pt-4 animate-slide-up">
          <p className="text-sm text-gray-600 mb-3">{metric.description}</p>
          <p className="text-sm font-semibold text-gray-800 mb-2">{getResultText(metric.status)}</p>
          {metric.details && (
            <p className="text-xs text-gray-500">{metric.details}</p>
          )}
        </div>
      )}
    </div>
  );
};

export default GaitMetricCard;
EOF

# 12. components/gait/AIGaitAnalysis.tsx 생성
cat > src/components/gait/AIGaitAnalysis.tsx << 'EOF'
import React from 'react';
import { GaitMetric } from '../../types/gait';
import GaitMetricCard from './GaitMetricCard';

interface AIGaitAnalysisProps {
  metrics: GaitMetric[];
}

const AIGaitAnalysis: React.FC<AIGaitAnalysisProps> = ({ metrics }) => {
  return (
    <div className="space-y-6">
      <h3 className="text-lg font-semibold text-gray-800">AI 보행 지표 분석</h3>
      
      <div className="space-y-4">
        {metrics.map((metric, index) => (
          <GaitMetricCard 
            key={metric.id} 
            metric={metric} 
            isExpanded={index === 0}
          />
        ))}
      </div>
    </div>
  );
};

export default AIGaitAnalysis;
EOF

# 13. components/gait/DiseaseRiskCard.tsx 생성
cat > src/components/gait/DiseaseRiskCard.tsx << 'EOF'
import React from 'react';
import { DiseaseRisk } from '../../types/gait';

interface DiseaseRiskCardProps {
  disease: DiseaseRisk;
}

const DiseaseRiskCard: React.FC<DiseaseRiskCardProps> = ({ disease }) => {
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'low':
        return 'border-green-200 bg-green-50 text-green-800';
      case 'medium':
        return 'border-yellow-200 bg-yellow-50 text-yellow-800';
      case 'high':
        return 'border-red-200 bg-red-50 text-red-800';
      default:
        return 'border-gray-200 bg-gray-50 text-gray-800';
    }
  };

  const getProgressColor = (status: string) => {
    switch (status) {
      case 'low':
        return 'bg-green-500';
      case 'medium':
        return 'bg-yellow-500';
      case 'high':
        return 'bg-red-500';
      default:
        return 'bg-gray-400';
    }
  };

  const getTrendIcon = (status: string) => {
    switch (status) {
      case 'low':
        return '📈';
      case 'medium':
        return '📊';
      case 'high':
        return '📉';
      default:
        return '📊';
    }
  };

  const displayProbability = Math.abs(disease.probability);

  return (
    <div className={`rounded-xl border p-4 ${getStatusColor(disease.status)}`}>
      <div className="flex items-center justify-between mb-3">
        <div className="flex items-center space-x-2">
          <span className="text-lg">{getTrendIcon(disease.status)}</span>
          <span className="font-semibold">{disease.name}</span>
        </div>
        <div className="text-right">
          <div className="text-sm opacity-75">{disease.probability < 0 ? '관찰 위치' : '위험 확률'}</div>
          <div className="font-bold">{disease.probability < 0 ? `${displayProbability}%` : `${displayProbability}%`}</div>
        </div>
      </div>
      
      <div className="w-full bg-gray-200 rounded-full h-2 mb-3">
        <div 
          className={`h-2 rounded-full ${getProgressColor(disease.status)}`}
          style={{ width: `${Math.min(displayProbability, 100)}%` }}
        ></div>
      </div>
      
      <p className="text-sm">{disease.description}</p>
    </div>
  );
};

export default DiseaseRiskCard;
EOF

# 14. components/gait/DetailedReport.tsx 생성
cat > src/components/gait/DetailedReport.tsx << 'EOF'
import React from 'react';

interface DetailedReportProps {
  riskStage: string;
  analysis: string[];
}

const DetailedReport: React.FC<DetailedReportProps> = ({ riskStage, analysis }) => {
  return (
    <div className="space-y-6">
      <h3 className="text-lg font-semibold text-gray-800">상세 분석 리포트</h3>
      
      <div className="bg-blue-50 border border-blue-200 rounded-xl p-4">
        <div className="font-semibold text-blue-800">{riskStage}</div>
      </div>
      
      <div className="space-y-4 max-h-96 overflow-y-auto">
        {analysis.map((paragraph, index) => (
          <div key={index} className="bg-white rounded-xl p-4 border border-gray-100">
            <p className="text-sm text-gray-700 leading-relaxed">{paragraph}</p>
          </div>
        ))}
      </div>
    </div>
  );
};

export default DetailedReport;
EOF

# 15. pages/GaitAnalysis.tsx 생성
cat > src/pages/GaitAnalysis.tsx << 'EOF'
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Bell, Settings } from 'lucide-react';
import BackButton from '../components/common/BackButton';
import GaitScoreCard from '../components/gait/GaitScoreCard';
import TabSelector from '../components/gait/TabSelector';
import AIGaitAnalysis from '../components/gait/AIGaitAnalysis';
import DiseaseRiskCard from '../components/gait/DiseaseRiskCard';
import DetailedReport from '../components/gait/DetailedReport';
import { GaitAnalysisData } from '../types/gait';

const mockGaitData: GaitAnalysisData = {
  totalScore: 46,
  riskLevel: '평웨어 매우 안정적',
  metrics: [
    {
      id: '1',
      title: '보폭 시간',
      value: '1.12초',
      status: 'normal',
      description: '한쪽 발이 땅에 닿은 후, 같은 발이 다시 땅을 때까지 걸리는 시간입니다. 걸음 템포를 확인할 수 있어요.',
      interpretation: '분석 결과 정상입니다!',
    },
    {
      id: '2',
      title: '양발 지지 비율',
      value: '28.4%',
      status: 'danger',
      description: '두 발이 동시에 땅에 닿아 있는 시간의 비율이에요. 보행 균형이 불안할수록 높아집니다.',
      interpretation: '분석 결과 위험입니다!',
    },
    {
      id: '3',
      title: '양발 보폭 차이',
      value: '0.06m',
      status: 'normal',
      description: '왼발과 오른발의 걸음 길이가 얼마나 다른지를 보여줍니다. 좌우 균형 상태를 파악할 수 있어요.',
      interpretation: '분석 결과 정상입니다!',
    },
    {
      id: '4',
      title: '평균 보행 속도',
      value: '0.9m/s',
      status: 'warning',
      description: '단위 시간 동안 이동한 거리를 나타내는 지표입니다. 전체 활동성과 운동 능력을 확인할 수 있어요.',
      interpretation: '분석 결과 주의입니다!',
    },
  ],
  diseaseRisks: [
    {
      name: '파킨슨병',
      probability: -0.55,
      status: 'low',
      description: '관찰 위치'
    },
    {
      name: '뇌졸중',
      probability: 6.00,
      status: 'medium',
      description: '주의 필요'
    }
  ],
  detailedReport: {
    riskStage: '중등도 위험 단계',
    analysis: [
      '보행 안정성이 낮은 상태이며 낙상 주의가 필요합니다. 최근 속도 저하와 균형 흔들림이 관찰되었습니다. 전문가 상담 또는 보행 교정 프로그램 참여를 추천드립니다.',
      '보행 안정성이 낮은 상태이며 낙상 주의가 필요합니다. 최근 속도 저하와 균형 흔들림이 관찰되었습니다. 전문가 상담 또는 보행 교정 프로그램 참여를 추천드립니다.'
    ]
  }
};

const GaitAnalysis: React.FC = () => {
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState<'health' | 'stats'>('health');

  return (
    <div className="min-h-screen gradient-bg">
      <div className="mobile-container">
        <div className="p-4 space-y-6">
          <div className="flex items-center justify-between pt-8">
            <BackButton onClick={() => navigate(-1)} />
            <h1 className="text-xl font-bold text-blue-600">보행 분석</h1>
            <div className="flex space-x-2">
              <Bell size={20} className="text-blue-600" />
              <Settings size={20} className="text-blue-600" />
            </div>
          </div>

          <GaitScoreCard 
            score={mockGaitData.totalScore} 
            riskLevel={mockGaitData.riskLevel} 
          />

          <TabSelector 
            activeTab={activeTab} 
            onTabChange={setActiveTab} 
          />

          <div className="pb-20">
            {activeTab === 'health' && (
              <AIGaitAnalysis metrics={mockGaitData.metrics} />
            )}

            {activeTab === 'stats' && (
              <div className="space-y-6">
                <div className="space-y-4">
                  <h3 className="text-lg font-semibold text-gray-800">질병 예측 분석</h3>
                  {mockGaitData.diseaseRisks.map((disease, index) => (
                    <DiseaseRiskCard key={index} disease={disease} />
                  ))}
                </div>

                <DetailedReport 
                  riskStage={mockGaitData.detailedReport.riskStage}
                  analysis={mockGaitData.detailedReport.analysis}
                />
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default GaitAnalysis;
EOF

# 16. pages/Home.tsx 생성 (데모용)
cat > src/pages/Home.tsx << 'EOF'
import React from 'react';
import { useNavigate } from 'react-router-dom';

const Home: React.FC = () => {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen gradient-bg flex items-center justify-center">
      <div className="mobile-container p-8">
        <div className="text-center space-y-8">
          <div>
            <h1 className="text-3xl font-bold text-blue-600 mb-2">BODYFENCE</h1>
            <p className="text-gray-600">Walk Safe, Live Smart</p>
          </div>
          
          <button
            onClick={() => navigate('/gait-analysis')}
            className="w-full bg-blue-500 hover:bg-blue-600 text-white font-semibold py-4 rounded-2xl transition-colors shadow-lg"
          >
            보행 분석 보기
          </button>
        </div>
      </div>
    </div>
  );
};

export default Home;
EOF

# 17. App.tsx 업데이트
cat > src/App.tsx << 'EOF'
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Home from './pages/Home';
import GaitAnalysis from './pages/GaitAnalysis';

function App() {
  return (
    <Router>
      <div className="App">
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/gait-analysis" element={<GaitAnalysis />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
EOF

# 18. index.html 업데이트
cat > index.html << 'EOF'
<!doctype html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>BODYFENCE - 보행 분석 앱</title>
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=League+Spartan:wght@100;200;300;400;500;600;700;800;900&family=Lilita+One&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/gh/sunn-us/SUIT/fonts/variable/woff2/SUIT-Variable.css" rel="stylesheet">
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
EOF

# 19. package.json 스크립트 업데이트
echo "📝 package.json 스크립트를 업데이트 중..."
npm pkg set scripts.dev="vite --host"
npm pkg set scripts.build="tsc && vite build"
npm pkg set scripts.preview="vite preview"

echo ""
echo "✅ 보행 분석 앱 설정이 완료되었습니다!"
echo ""
echo "📂 프로젝트 폴더: $PROJECT_NAME"
echo ""
echo "🚀 다음 명령어로 개발 서버를 시작하세요:"
echo "   cd $PROJECT_NAME"
echo "   npm run dev"
echo ""
echo "🌐 브라우저에서 http://localhost:5173 을 열어 확인하세요"
echo ""
echo "📱 주요 기능:"
echo "   - 홈 화면: 보행 분석 진입"
echo "   - 보행 분석: AI 지표 분석 + 상세 통계"
echo "   - 아코디언: 각 지표 클릭으로 상세 정보 확인"
echo "   - 탭 전환: 건강 정보 ↔ 상세 통계"
echo ""

# 20. 자동 실행 여부 묻기
read -p "🤔 지금 바로 개발 서버를 실행하시겠습니까? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🚀 개발 서버를 시작합니다..."
    npm run dev
else
    echo "👋 설정이 완료되었습니다. 나중에 'cd $PROJECT_NAME && npm run dev'로 실행하세요!"
fi