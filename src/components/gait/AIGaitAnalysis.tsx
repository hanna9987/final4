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