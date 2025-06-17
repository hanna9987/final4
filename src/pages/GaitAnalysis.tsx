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