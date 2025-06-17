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