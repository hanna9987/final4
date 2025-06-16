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