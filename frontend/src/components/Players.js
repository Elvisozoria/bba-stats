// src/components/Players.js
import React, { useState, useEffect } from 'react';
import axiosInstance from './../api/axiosInstance';


const Players = () => {
  const [players, setPlayers] = useState([]);
  const [teams, setTeams] = useState([]);
  const [formData, setFormData] = useState({
    name: '',
    team_id: '',
    position: '',
    number: '',
    height: '',
    weight: '',
    wingspan: '',
    vertical_jump: '',
    image: null,
  });

  useEffect(() => {
    fetchPlayers();
    fetchTeams();
  }, []);

  const fetchPlayers = async () => {
    try {
      const response = await axiosInstance.get('/players');
      setPlayers(response.data);
    } catch (error) {
      console.error('Error al obtener jugadores', error);
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

  const handleChange = (e) => {
    const { name, value, files } = e.target;
    if (name === 'image') {
      setFormData({ ...formData, image: files[0] });
    } else {
      setFormData({ ...formData, [name]: value });
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const data = new FormData();
    Object.keys(formData).forEach((key) => {
      if (formData[key]) {
        data.append(`player[${key}]`, formData[key]);
      }
    });

    try {
      await axiosInstance.post('/players', data, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
      setFormData({
        name: '',
        team_id: '',
        position: '',
        number: '',
        height: '',
        weight: '',
        wingspan: '',
        vertical_jump: '',
        image: null,
      });
      fetchPlayers();
    } catch (error) {
      console.error('Error al crear jugador', error);
    }
  };

  return (
    <div className="players-container">
      <h2>Jugadores</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label>Nombre del Jugador:</label>
          <input
            type="text"
            name="name"
            value={formData.name}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label>Equipo:</label>
          <select name="team_id" value={formData.team_id} onChange={handleChange} required>
            <option value="">Selecciona un equipo</option>
            {teams.map((team) => (
              <option key={team.id} value={team.id}>
                {team.name}
              </option>
            ))}
          </select>
        </div>
        <div>
          <label>Posición:</label>
          <input
            type="text"
            name="position"
            value={formData.position}
            onChange={handleChange}
          />
        </div>
        <div>
          <label>Número:</label>
          <input
            type="number"
            name="number"
            value={formData.number}
            onChange={handleChange}
          />
        </div>
        <div>
          <label>Estatura (m):</label>
          <input
            type="number"
            step="0.01"
            name="height"
            value={formData.height}
            onChange={handleChange}
          />
        </div>
        <div>
          <label>Peso (kg):</label>
          <input
            type="number"
            step="0.1"
            name="weight"
            value={formData.weight}
            onChange={handleChange}
          />
        </div>
        <div>
          <label>Alcance de Alas (cm):</label>
          <input
            type="number"
            step="0.1"
            name="wingspan"
            value={formData.wingspan}
            onChange={handleChange}
          />
        </div>
        <div>
          <label>Salto Vertical (cm):</label>
          <input
            type="number"
            step="0.1"
            name="vertical_jump"
            value={formData.vertical_jump}
            onChange={handleChange}
          />
        </div>
        <div>
          <label>Imagen del Jugador:</label>
          <input
            type="file"
            name="image"
            accept="image/*"
            onChange={handleChange}
          />
        </div>
        <button type="submit">Agregar Jugador</button>
      </form>
      <div className="players-list">
        {players.map((player) => (
          <div key={player.id} className="player-card">
            {player.image_url && <img src={player.image_url} alt={player.name} width="100" />}
            <h3>{player.name}</h3>
            <p>Equipo: {player.team.name}</p>
            <p>Posición: {player.position}</p>
            <p>Número: {player.number}</p>
            <p>Estatura: {player.height} m</p>
            <p>Peso: {player.weight} kg</p>
            <p>Alcance de Alas: {player.wingspan} cm</p>
            <p>Salto Vertical: {player.vertical_jump} cm</p>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Players;
