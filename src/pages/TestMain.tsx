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