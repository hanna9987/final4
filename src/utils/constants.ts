export const HEALTH_STATUS = {
  NORMAL: 'normal',
  WARNING: 'warning', 
  DANGER: 'danger'
} as const;

export const TEST_TYPES = {
  FALL_RISK_1: 'fall_risk_1',
  FALL_RISK_2: 'fall_risk_2',
  COGNITIVE: 'cognitive'
} as const;

export const ROUTES = {
  HOME: '/',
  HEALTH: '/health',
  TEST: '/test',
  TEST_RESULTS: '/test/results',
  WALKING: '/walking'
} as const;

export const COLORS = {
  PRIMARY: '#3b82f6',
  SUCCESS: '#10b981',
  WARNING: '#f59e0b',
  DANGER: '#ef4444',
  GRAY: '#6b7280'
} as const; 