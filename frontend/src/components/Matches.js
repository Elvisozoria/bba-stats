// src/components/Matches.js
import React, { useState, useEffect } from 'react';
import axiosInstance from './../api/axiosInstance';
import { Link } from 'react-router-dom';

const Matches = () => {
  const [matches, setMatches] = useState([]);
  const [teams, setTeams] = useState([]);
  const [users, setUsers] = useState([]);
  const [formData, setFormData] = useState({
    home_team_id: '',
    away_team_id: '',
    date: '',
    youtube_link: '',
    technical_manager_id: '',
    anotador_id: '',
  });

  useEffect(() => {
    fetchMatches();
    fetchTeams();
    fetchUsers();
  }, []);

  const fetchMatches = async () => {
    try {
      const response = await axiosInstance.get('/matches');
      setMatches(response.data);
    } catch (error) {
      console.error('Error al obtener partidos', error);
    }
  };

  const fetchTeams = async () => {
    try {
      const response = await axiosInstance.get('/teams');
      setTeams(response.data);
    } catch (error) {
      console.error('Error al obtener equipos', error);
    }
  };

  const fetchUsers = async () => {
    try {
      const response = await axiosInstance.get('/users');
      setUsers(response.data);
    } catch (error) {
      console.error('Error al obtener usuarios', error);
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await axiosInstance.post('/matches', formData);
      setFormData({
        home_team_id: '',
        away_team_id: '',
        date: '',
        youtube_link: '',
        technical_manager_id: '',
        anotador_id: '',
      });
      fetchMatches();
    } catch (error) {
      console.error('Error al crear partido', error);
    }
  };

  return (
    <div className="matches-container">
      <h2>Partidos</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label>Equipo Local:</label>
          <select
            name="home_team_id"
            value={formData.home_team_id}
            onChange={handleChange}
            required
          >
            <option value="">Selecciona un equipo</option>
            {teams.map((team) => (
              <option key={team.id} value={team.id}>
                {team.name}
              </option>
            ))}
          </select>
        </div>
        <div>
          <label>Equipo Visitante:</label>
          <select
            name="away_team_id"
            value={formData.away_team_id}
            onChange={handleChange}
            required
          >
            <option value="">Selecciona un equipo</option>
            {teams.map((team) => (
              <option key={team.id} value={team.id}>
                {team.name}
              </option>
            ))}
          </select>
        </div>
        <div>
          <label>Fecha y Hora:</label>
          <input
            type="datetime-local"
            name="date"
            value={formData.date}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label>Enlace de YouTube del Partido:</label>
          <input
            type="url"
            name="youtube_link"
            value={formData.youtube_link}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label>Encargado de Mesa Técnica:</label>
          <select
            name="technical_manager_id"
            value={formData.technical_manager_id}
            onChange={handleChange}
            required
          >
            <option value="">Selecciona un usuario</option>
            {users
              .filter((user) => user.role === 'supervisor' || user.role === 'admin')
              .map((user) => (
                <option key={user.id} value={user.id}>
                  {user.name}
                </option>
              ))}
          </select>
        </div>
        <div>
          <label>Anotador Asignado:</label>
          <select
            name="anotador_id"
            value={formData.anotador_id}
            onChange={handleChange}
            required
          >
            <option value="">Selecciona un anotador</option>
            {users
              .map((user) => (
                <option key={user.id} value={user.id}>
                  {user.name}
                </option>
              ))}
          </select>
        </div>
        <button type="submit">Crear Partido</button>
      </form>
      <div className="matches-list">
        {matches.map((match) => (
          <div key={match.id} className="match-card">
            <h3>
              {match.home_team.name} vs {match.away_team.name}
            </h3>
            <p>Fecha y Hora: {new Date(match.date).toLocaleString()}</p>
            <p>
              Video: <a href={match.youtube_link} target="_blank" rel="noopener noreferrer">Ver en YouTube</a>
            </p>
            <p>Encargado Técnico: {match.technical_manager.name}</p>
            <p>Anotador: {match.anotador.name}</p>
            <Link to={`/matches/${match.id}`}>Ver Partido</Link>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Matches;
