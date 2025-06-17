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