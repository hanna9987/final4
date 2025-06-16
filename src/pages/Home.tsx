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