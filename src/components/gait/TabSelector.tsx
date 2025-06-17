import React from 'react';

interface TabSelectorProps {
  activeTab: 'health' | 'stats';
  onTabChange: (tab: 'health' | 'stats') => void;
}

const TabSelector: React.FC<TabSelectorProps> = ({ activeTab, onTabChange }) => {
  return (
    <div className="flex bg-gray-100 rounded-xl p-1 mb-6">
      <button
        onClick={() => onTabChange('health')}
        className={`flex-1 py-3 px-4 rounded-lg text-sm font-medium transition-all ${
          activeTab === 'health'
            ? 'bg-white text-gray-700 shadow-sm'
            : 'text-gray-500 hover:text-gray-700'
        }`}
      >
        건강 정보
      </button>
      <button
        onClick={() => onTabChange('stats')}
        className={`flex-1 py-3 px-4 rounded-lg text-sm font-medium transition-all ${
          activeTab === 'stats'
            ? 'bg-blue-500 text-white shadow-sm'
            : 'text-gray-500 hover:text-gray-700'
        }`}
      >
        상세 통계
      </button>
    </div>
  );
};

export default TabSelector; 