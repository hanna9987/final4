export interface HealthData {
  id: string;
  label: string;
  value: string;
  status: 'normal' | 'warning' | 'danger';
  icon: string;
  timestamp: Date;
}

export interface TestResult {
  id: string;
  type: 'fall_risk' | 'cognitive';
  score: number;
  date: Date;
  details: {
    reaction_time?: number;
    balance_score?: number;
    memory_score?: number;
  };
}

export interface WalkingData {
  timestamp: Date;
  steps: number;
  stability: number;
  location: {
    lat: number;
    lng: number;
  };
}

export interface User {
  id: string;
  name: string;
  age: number;
  emergency_contacts: Array<{
    name: string;
    phone: string;
    relation: string;
  }>;
} 