import React, { useState, useEffect } from 'react';
import axiosInstance from './../api/axiosInstance';
import formatTimestamp from './../helpers/FormatedTimeStamp'





const Play = ({play_id}) => {
  const [playerName, setPlayerName] = useState([]);
  const [SecondaryPlayerName, setSecondaryPlayerName] = useState([]);
  const [playType, setPlayType] = useState([]);
  const [courtSection, setCourtSection] = useState([]);
  const [timestamp, setTimestamp] = useState([]);

  useEffect(() => {
    fetchPlay();
  }, []);



  const fetchPlay = async () => {
    try {
      const response = await axiosInstance.get(`/actions/${play_id}`);
      // console.log(response.data.player.id)
      fetchPlayerName(response.data.player.id);
      fetchSecondaryPlayerName(response.data.player.id);
      fetchPlayType(response.data.action_type);
      fetchCourtSection(response.data.section);
      fetchTimestamp(response.data.timestamp);
    } catch (error) {
      console.error('Error al obtener datos de la jugada', error);
    }
  };


  const fetchPlayerName = async( player_id ) =>{
    try{
      const response = await axiosInstance.get(`/players/${player_id}`);
      setPlayerName(response.data.name);
    } catch (error) {
      console.error('Error al obtener el nombre del jugador', error)
    }
  }

  const fetchSecondaryPlayerName = async( player_id ) =>{
    try{
      const response = await axiosInstance.get(`/players/${player_id}`);
      setSecondaryPlayerName(response.data.name);
    } catch (error) {
      console.error('Error al obtener el nombre del jugador secundario', error)
    }
  }

  const fetchPlayType = async(action_type) =>{
    try{
      // Quiza luego aqui haya una logica diferente para manejarlo 
      setPlayType(action_type);
    } catch (error) {
      console.error('Error al obtener el typo de jugada', error)
    }
  }


  const fetchCourtSection = async(courtSection) =>{
    try{
      // Quiza luego aqui haya una logica diferente para manejarlo 
      setCourtSection(courtSection);
    } catch (error) {
      console.error('Error al obtener la seccion de la cancha', error)
    }
  }

  const fetchTimestamp = async(timestamp) =>{
    try{
      // Quiza luego aqui haya una logica diferente para manejarlo 
      const formattedTime = formatTimestamp(timestamp);
      setTimestamp(formattedTime);
    } catch (error) {
      console.error('Error al obtener el tiempo de la jugada', error)
    }
  }

  return (
    <div className={"play-container"}>
      <p>{playerName} ha {playType} desde {courtSection} en el minuto {timestamp} </p>
    </div>
  );
};

export default Play;
