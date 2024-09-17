const FormatTimestamp = (timestamp) => {
  // Convertimos el timestamp en un objeto Date
  const date = new Date(timestamp);

  // Extraemos horas, minutos y segundos
  const hours = String(date.getUTCHours()).padStart(2, '0');
  const minutes = String(date.getUTCMinutes()).padStart(2, '0');
  const seconds = String(date.getUTCSeconds()).padStart(2, '0');

  // Devolvemos el tiempo formateado como "HH:MM:SS"
  return `${hours}:${minutes}:${seconds}`;
};

export default FormatTimestamp
