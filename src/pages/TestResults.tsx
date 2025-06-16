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