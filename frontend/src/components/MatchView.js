// src/components/MatchView.js
import React, { useState, useEffect, useRef } from 'react';
import { useParams } from 'react-router-dom';
import axiosInstance from './../api/axiosInstance';
import YouTube from 'react-youtube';
import { DndProvider } from 'react-dnd';
import { HTML5Backend } from 'react-dnd-html5-backend';
import DraggablePlayer from './DraggablePlayer';
import Court from './Court';
import Play from './Play';
import Scoreboard from './Scoreboard';

const MatchView = () => {
  const { id } = useParams();
  const [match, setMatch] = useState(null);
  const [actions, setActions] = useState([]);
  const [selectedAction, setSelectedAction] = useState(null);
  const [popupData, setPopupData] = useState({
    action_type: '',
    assisted_by_player_id: '',
    fouled_player_id: '',
  });
  const playerRef = useRef(null);
  const [player, setPlayer] = useState(null);
  const [homePlayers, setHomePlayers] = useState([]);
  const [awayPlayers, setAwayPlayers] = useState([]);
  const [players, setPlayers] = useState([]); // Lista combinada de jugadores
  const [plays, setPlays] = useState([])

  useEffect(() => {
    if (id) {
      fetchMatch();
    }
  }, [id]);

  const fetchMatch = async () => {
    try {
      const response = await axiosInstance.get(`/matches/${id}`);
      setMatch(response.data);
      setActions(response.data.actions || []);
      setPlays(response.data.actions);
      // Una vez que tenemos el match, fetch los jugadores
      await fetchPlayers(response.data.home_team.id, response.data.away_team.id);
    } catch (error) {
      console.error('Error al obtener partido', error);
    }
  };

  async function fetchPlayers(homeTeamId, awayTeamId) {
    try {
      const [homeResponse, awayResponse] = await Promise.all([
        axiosInstance.get(`/teams/${homeTeamId}`),
        axiosInstance.get(`/teams/${awayTeamId}`),
      ]);
      setHomePlayers(homeResponse.data.players);
      setAwayPlayers(awayResponse.data.players);
      // Combinar los jugadores de ambos equipos si es necesario
      setPlayers([...homeResponse.data.players, ...awayResponse.data.players]);
    } catch (error) {
      console.error('Error al obtener jugadores', error);
    }
  }

  const fetchPlays = async () => {
    setPlays(match.actions)
  }

  const handleVideoReady = (event) => {
    setPlayer(event.target);
    playerRef.current = event.target;
  };

  const handleVideoStateChange = (event) => {
    if (event.data === 2) { // Paused
      const currentTime = event.target.getCurrentTime();
      setSelectedActionTime(currentTime);
      console.log("Tiempo actual:", currentTime);
    }
  };

  const [selectedActionTime, setSelectedActionTime] = useState(0);

  const handleDragDrop = (player) => {
    // Pausar el video y mostrar el popup para registrar acción
    if (player && playerRef.current) {
      playerRef.current.pauseVideo();
      setSelectedAction(player);
    }
  };

  const [updateKey, setUpdateKey] = useState(0);

  const handlePopupSubmit = async () => {
    const data = {
      match_id: match.id,
      player_id: selectedAction.id,
      action_type: popupData.action_type,
      timestamp: new Date(selectedActionTime * 1000).toISOString().substr(11, 8),
      section: selectedAction.section || 'triple_centro', // Usar la sección asignada
      quarter: 1, // TODO: Implementa lógica para determinar el cuarto
      assisted_by_player_id: popupData.assisted_by_player_id || null,
      fouled_player_id: popupData.fouled_player_id || null,
    };
  
    try {
      const response = await axiosInstance.post('/actions', { play: data });
      
      // Añadir la nueva acción a los estados de actions y plays
      const newAction = response.data; // Suponiendo que la respuesta del servidor devuelve la acción creada
      setActions((prevActions) => [newAction, ...prevActions]);
      setPlays((prevPlays) => [newAction, ...prevPlays]);
      console.log(response.data);
  
      setUpdateKey((prevKey) => prevKey + 1);

      // Limpiar popup y restablecer los datos
      setPopupData({
        action_type: '',
        assisted_by_player_id: '',
        fouled_player_id: '',
      });
      setSelectedAction(null);
  
    } catch (error) {
      console.error('Error al registrar acción', error);
      alert('Hubo un error al registrar la acción. Por favor, intenta nuevamente.');
    }
  };
  

  if (!match) return <div>Cargando partido...</div>;



  return (
    <div className="match-view-container">
      <h2>
        {match.home_team.name} vs {match.away_team.name}
      </h2>
      <YouTube
        videoId={extractYouTubeID(match.youtube_link)}
        opts={{ width: '100%', height: '390' }}
        onReady={handleVideoReady}
        onStateChange={handleVideoStateChange}
      />


      <div className="court-and-controls">
        <DndProvider backend={HTML5Backend}>
          <div className="players-available home-team">
            <h3>Jugadores {match.home_team.name}</h3>
            {homePlayers.map((player) => (
              <DraggablePlayer key={player.id} player={player} />
            ))}
          </div>
          <div className ="middle-column" key={updateKey}>
            <Scoreboard match_id={match.id}></Scoreboard>
            <Court players={players} onPlayerDrop={handleDragDrop} playersOnCourt={actions.map(action => action.player)
            } />
          </div>
          <div className="players-available away-team">
            <h3>Jugadores {match.away_team.name}</h3>
            {awayPlayers.map((player) => (
              <DraggablePlayer key={player.id} player={player} />
            ))}
          </div>
        </DndProvider>
      </div>

      <div className="match-plays" key={updateKey}>
        {plays.map((play) => (
          <Play play_id = {play.id}>

          </Play>
          ))}
      </div>
      {selectedAction && (
        <div className="popup">
          <h3>Registrar Acción para {selectedAction.name}</h3>
          <div>
            <label>Tipo de Acción:</label>
            <select
              value={popupData.action_type}
              onChange={(e) => setPopupData({ ...popupData, action_type: e.target.value })}
              required
            >
              <option value="">Selecciona una acción</option>
              <option value="tiro_encestado">Tiro Encestado</option>
              <option value="tiro_fallado">Tiro Fallado</option>
              <option value="falta_personal">Falta Personal</option>
              <option value="asistencia">Asistencia</option>
              <option value="perdida_de_balon">Pérdida de Balón</option>
            </select>
          </div>
          {popupData.action_type === 'asistencia' && (
            <div>
              <label>Jugador que Asistió:</label>
              <select
                value={popupData.assisted_by_player_id}
                onChange={(e) => setPopupData({ ...popupData, assisted_by_player_id: e.target.value })}
                required
              >
                <option value="">Selecciona un jugador</option>
                {players.map((player) => (
                  <option key={player.id} value={player.id}>
                    {player.name}
                  </option>
                ))}
              </select>
            </div>
          )}
          {popupData.action_type === 'falta_personal' && (
            <div>
              <label>Jugador que Recibió la Falta:</label>
              <select
                value={popupData.fouled_player_id}
                onChange={(e) => setPopupData({ ...popupData, fouled_player_id: e.target.value })}
                required
              >
                <option value="">Selecciona un jugador</option>
                {players.map((player) => (
                  <option key={player.id} value={player.id}>
                    {player.name}
                  </option>
                ))}
              </select>
            </div>
          )}
          <button onClick={handlePopupSubmit}>Registrar</button>
          <button onClick={() => setSelectedAction(null)}>Cancelar</button>
        </div>
      )}
    </div>
  );
};

const extractYouTubeID = (url) => {
  const regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
  const match = url.match(regExp);
  return match && match[2].length === 11 ? match[2] : null;
};

export default MatchView;
