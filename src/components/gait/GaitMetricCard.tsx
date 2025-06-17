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