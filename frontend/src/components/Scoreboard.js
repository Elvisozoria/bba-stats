import axiosInstance from './../api/axiosInstance';
import React, { useState, useEffect } from 'react';

const Scoreboard = (match_id) => {
  const [home_team_score, setHomeScore] = useState([]);
  const [away_team_score, setAwayScore] = useState([]);

  useEffect(() => {
    fetchScore();
  }, []);

  const fetchScore = async () => {
    try {
      const response = await axiosInstance.get(`/matches/${match_id.match_id}/score`);
      setHomeScore(response.data.home_team_score)
      setAwayScore(response.data.away_team_score)
    } catch(error){
      console.error('Error al obtener la puntuacion', error);
    }
  }

  return(
    <div className="scoreboard-container">
      <p> casa: {home_team_score} </p>
      <p> visitante: {away_team_score} </p>
    </div>

  );
}

export default Scoreboard
