// src/components/Court.js
import React from 'react';
import { useDrop } from 'react-dnd';

const Court = ({ onPlayerDrop, playersOnCourt }) => {
  return (
    <div className="court-container">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 489 459.75" width="500" height="470">
        <CourtSection
          id="section1"
          name="3 esquina izquierda"
          onPlayerDrop={onPlayerDrop}
          playersOnCourt={playersOnCourt}
        >
          <rect x="12" y="15" width="32" height="166" />
        </CourtSection>
        <CourtSection
          id="section2"
          name="2 esquina izquierda"
          onPlayerDrop={onPlayerDrop}
          playersOnCourt={playersOnCourt}
        >
          <rect x="44" y="15" width="122" height="124" />
        </CourtSection>
        <CourtSection
          id="section3"
          name="2 Bloque izquierda"
          onPlayerDrop={onPlayerDrop}
          playersOnCourt={playersOnCourt}
        >
          <polygon points="44 139 166 139 166 181 166 191 167.16 270.4 121.16 254.4 82 223 44 181 44 139" />
        </CourtSection>
        <CourtSection
          id="section4"
          name="2 codo derecha"
          onPlayerDrop={onPlayerDrop}
          playersOnCourt={playersOnCourt}
        >
          <polygon points="443.58 139 321.58 139 321.58 181 321.58 191 320.42 270.4 366.42 254.4 405.58 223 443.58 181 443.58 139" />
        </CourtSection>
        <CourtSection
          id="section5"
          name="2 Pintura"
          onPlayerDrop={onPlayerDrop}
          playersOnCourt={playersOnCourt}
        >
          <polygon points="166 15 321 15 321.58 181 166 181 166 15" />
        </CourtSection>
        <CourtSection
          id="section6"
          name="2 codo izquierdo"
          onPlayerDrop={onPlayerDrop}
          playersOnCourt={playersOnCourt}
        >
          <polygon points="44 139 166 139 166 181 166 191 167.16 270.4 121.16 254.4 82 223 44 181 44 139" />
        </CourtSection>
        <CourtSection
          id="section7"
          name="3 esquina derecha"
          onPlayerDrop={onPlayerDrop}
          playersOnCourt={playersOnCourt}
        >
          <polygon points="443 15 475 15 475 181 443.58 181 443 15" />
        </CourtSection>
        <CourtSection
          id="section8"
          name="3 central"
          onPlayerDrop={onPlayerDrop}
          playersOnCourt={playersOnCourt}
        >
          <path d="M175.47,277.03s22.64,16.97,67.14,14.97,70.92-14.97,70.92-14.97l9.56,43.97h-157.18s9.56-43.97,9.56-43.97h0" />
        </CourtSection>
        <CourtSection
          id="section9"
          name="2 tiro libre"
          onPlayerDrop={onPlayerDrop}
          playersOnCourt={playersOnCourt}
        >
          <path d="M166,181h155.58s-1.22,94-1.22,94l-13.36,6-15.83.9-39.17,5.1s-11-1-38,0-46.84-16.6-46.84-16.6l-1.16-89.4Z" />
        </CourtSection>
        <CourtSection
          id="section10"
          name="3 alejado"
          onPlayerDrop={onPlayerDrop}
          playersOnCourt={playersOnCourt}
        >
          <rect x="12.64" y="321" width="467.5" height="125" />
        </CourtSection>
        <CourtSection
          id="section11"
          name="2 esquina derecha"
          onPlayerDrop={onPlayerDrop}
          playersOnCourt={playersOnCourt}
        >
          <rect x="321" y="15" width="122" height="124" />
        </CourtSection>
        <CourtSection
          id="section12"
          name="3 codo izquierdo"
          onPlayerDrop={onPlayerDrop}
          playersOnCourt={playersOnCourt}
        >
          <path d="M12.64,181h32s29.01,50.53,70.42,68,62.3,28.03,62.3,28.03l-9.56,43.97H12.64v-140Z" />
        </CourtSection>
        <CourtSection
          id="section13"
          name="3 codo derecho"
          onPlayerDrop={onPlayerDrop}
          playersOnCourt={playersOnCourt}
        >
          <path d="M480.14,181h-32s-29.01,50.53-70.42,68c-41.41,17.47-62.3,28.03-62.3,28.03l9.56,43.97h155.16s0-140,0-140Z" />
        </CourtSection>
      </svg>
    </div>
  );
};

// Componente individual para cada sección de la cancha
const CourtSection = ({ id, name, onPlayerDrop, children, playersOnCourt }) => {
  const [{ isOver, canDrop }, drop] = useDrop({
    accept: 'player',
    drop: (item, monitor) => {
      console.log(`Jugador ${item.player.name} fue soltado en ${name}.`);
      onPlayerDrop({ ...item.player, section: id });
    },
    collect: (monitor) => ({
      isOver: !!monitor.isOver(),
      canDrop: !!monitor.canDrop(),
    }),
  });

  // Filtrar jugadores que están en esta sección y asegurar que p no es undefined
  const playersInSection = playersOnCourt.filter((p) => p && p.section === id);

  // Estilo para los jugadores en la sección
  const playerStyle = {
    fill: '#3498db',
    stroke: '#fff',
    strokeWidth: 2,
    cursor: 'pointer',
  };

  return (
    <g ref={drop} className="section" data-name={name}>
      {React.cloneElement(children, {
        style: {
          fill: isOver ? '#e0ffe0' : '#fff',
          stroke: isOver ? '#000' : '#667'
        },
      })}
      <text
        x={children.props.x ? children.props.x + 10 : 10}
        y={children.props.y ? children.props.y + 25 : 25}
        fontSize="12"
        fill="#fff"
      >
        {name}
      </text>
      {/* Mostrar jugadores en la sección */}
      {playersInSection.map((player, index) => (
        <circle
          key={player.id}
          cx={(children.props.x || 0) + 20 + index * 20}
          cy={(children.props.y || 0) + (children.props.height || 50) / 2}
          r="8"
          style={playerStyle}
        >
          <title>{player.name}</title>
        </circle>
      ))}
    </g>
  );
};

export default Court;
