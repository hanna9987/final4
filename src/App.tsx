import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Layout from './components/common/Layout';
import Home from './pages/Home';
import HealthInfo from './pages/HealthInfo';
import TestMain from './pages/TestMain';
import TestResults from './pages/TestResults';
import WalkingAnalysis from './pages/WalkingAnalysis';
import { ROUTES } from './utils/constants';

function App() {
  return (
    <Router>
      <div className="App">
        <Routes>
          <Route path="/" element={<Layout />}>
            <Route index element={<Home />} />
            <Route path={ROUTES.HEALTH} element={<HealthInfo />} />
            <Route path={ROUTES.TEST} element={<TestMain />} />
            <Route path={ROUTES.TEST_RESULTS} element={<TestResults />} />
            <Route path={ROUTES.WALKING} element={<WalkingAnalysis />} />
          </Route>
        </Routes>
      </div>
    </Router>
  );
}

export default App; 