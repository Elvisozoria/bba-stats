// src/components/DraggablePlayer.js
import React from 'react';
import { useDrag } from 'react-dnd';

const DraggablePlayer = ({ player }) => {
  const [{ isDragging }, drag] = useDrag({
    type: 'player',
    item: { player },
    collect: (monitor) => ({
      isDragging: !!monitor.isDragging(),
    }),
  });

  const style = {
    opacity: isDragging ? 0.5 : 1,
    cursor: 'move',
    padding: '8px',
    margin: '4px',
    backgroundColor: '#f4f4f4',
    border: '1px solid #ddd',
    borderRadius: '4px',
  };

  return (
    <div ref={drag} style={style} className="draggable-player">
      {player.name}
    </div>
  );
};

export default DraggablePlayer;
