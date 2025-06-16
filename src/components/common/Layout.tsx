import React from 'react';
import { Outlet } from 'react-router-dom';
import BottomNav from './BottomNav';

const Layout: React.FC = () => {
  return (
    <div className="min-h-screen gradient-bg">
      <div className="mobile-container">
        <main className="pb-20">
          <Outlet />
        </main>
        <BottomNav />
      </div>
    </div>
  );
};

export default Layout; 