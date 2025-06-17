export interface GaitMetric {
  id: string;
  title: string;
  value: string;
  status: 'normal' | 'warning' | 'danger';
  description: string;
  interpretation: string;
  details?: string;
}

export interface DiseaseRisk {
  name: string;
  probability: number;
  status: 'low' | 'medium' | 'high';
  description: string;
}

export interface GaitAnalysisData {
  totalScore: number;
  riskLevel: string;
  metrics: GaitMetric[];
  diseaseRisks: DiseaseRisk[];
  detailedReport: {
    riskStage: string;
    analysis: string[];
  };
} 