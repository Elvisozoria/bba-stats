import React, { useState, useEffect } from 'react';

const TopMenu = () =>{

  return(
    <div className="menu-container">
      <h1> BBA Estadisticas  </h1>
      <nav>
        <ul>
          <li><a href="/teams"> Equipos</a></li>
          <li><a href="/players"> Jugadores</a></li>
          <li><a href="/matches"> Partidos</a></li>
          <li><a href="/matches"> configuracion</a></li>
        </ul>
        </nav>
    </div>
  );
};

export default TopMenu
