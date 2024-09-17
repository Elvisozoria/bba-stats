// src/components/Teams.js
import React, { useState, useEffect } from 'react';
import axiosInstance from './../api/axiosInstance';


const Teams = () => {
  const [teams, setTeams] = useState([]);
  const [name, setName] = useState('');
  const [logo, setLogo] = useState(null);

  useEffect(() => {
    fetchTeams();
  }, []);

  const fetchTeams = async () => {
    try {
      const response = await axiosInstance.get('/teams');
      setTeams(response.data);
    } catch (error) {
      console.error('Error al obtener equipos', error);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const formData = new FormData();
    formData.append('team[name]', name);
    if (logo) {
      formData.append('team[logo]', logo);
    }

    try {
      await axiosInstance.post('/teams', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
      setName('');
      setLogo(null);
      fetchTeams();
    } catch (error) {
      console.error('Error al crear equipo', error);
    }
  };

  return (
    <div className="teams-container">
      <h2>Equipos</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label>Nombre del Equipo:</label>
          <input
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
            required
          />
        </div>
        <div>
          <label>Logo del Equipo:</label>
          <input
            type="file"
            accept="image/*"
            onChange={(e) => setLogo(e.target.files[0])}
          />
        </div>
        <button type="submit">Agregar Equipo</button>
      </form>
      <div className="teams-list">
        {teams.map((team) => (
          <div key={team.id} className="team-card">
            {team.logo_url && <img src={team.logo_url} alt={team.name} width="100" />}
            <h3>{team.name}</h3>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Teams;
