// src/App.js
import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Login from './components/Login';
import Dashboard from './components/Dashboard';
import Teams from './components/Teams';
import Players from './components/Players';
import Matches from './components/Matches';
import MatchView from './components/MatchView';
import PrivateRoute from './components/PrivateRoute';
import TopMenu from './components/TopMenu';
import  './App.css'

function App() {
  return (
    <Router>
      <TopMenu> </TopMenu>
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route
          path="/"
          element={
            <PrivateRoute>
              <Dashboard />
            </PrivateRoute>
          }
        />
        <Route
          path="/teams"
          element={
            <PrivateRoute>
              <Teams />
            </PrivateRoute>
          }
        />
        <Route
          path="/players"
          element={
            <PrivateRoute>
              <Players />
            </PrivateRoute>
          }
        />
        <Route
          path="/matches"
          element={
            <PrivateRoute>
              <Matches />
            </PrivateRoute>
          }
        />
        <Route
          path="/matches/:id"
          element={
            <PrivateRoute>
              <MatchView />
            </PrivateRoute>
          }
        />
      </Routes>
    </Router>
  );
}

export default App;
