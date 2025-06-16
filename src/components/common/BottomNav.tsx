import React from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { Home, User, Calendar, MessageCircle } from 'lucide-react';
import { ROUTES } from '../../utils/constants';

const BottomNav: React.FC = () => {
  const navigate = useNavigate();
  const location = useLocation();

  const navItems = [
    { path: ROUTES.HOME, icon: Home, label: '홈' },
    { path: ROUTES.WALKING, icon: MessageCircle, label: '분석' },
    { path: ROUTES.HEALTH, icon: User, label: '건강' },
    { path: ROUTES.TEST, icon: Calendar, label: '테스트' },
  ];

  return (
    <nav className="fixed bottom-0 left-1/2 transform -translate-x-1/2 w-full max-w-mobile bg-white border-t border-gray-200 z-50">
      <div className="flex justify-around items-center py-2">
        {navItems.map((item) => {
          const Icon = item.icon;
          const isActive = location.pathname === item.path;
          
          return (
            <button
              key={item.path}
              onClick={() => navigate(item.path)}
              className={`flex flex-col items-center p-2 rounded-lg transition-colors ${
                isActive 
                  ? 'text-blue-500 bg-blue-50' 
                  : 'text-gray-500 hover:text-blue-400'
              }`}
            >
              <Icon size={24} />
              <span className="text-xs mt-1">{item.label}</span>
            </button>
          );
        })}
      </div>
    </nav>
  );
};

export default BottomNav; 