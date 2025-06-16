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