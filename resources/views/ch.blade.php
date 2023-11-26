<!DOCTYPE html>
<html lang="pt-BR">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  @vite(['resources/css/ch.css'])
  @vite(['resources/js/ch.js'])
  <link
    href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap"
    rel="stylesheet">
  <title>calculadora de intervalos de tempo</title>
</head>

<body>
  <div class="inside">
    <div class="menu">
      <button id="change-theme" style="width: auto;">🌙/☀️</button>
      <div>
        <button id="previousDate">&lt;</button>
        <input type="date" id="currentDate"></input>
        <button id="nextDate">&gt;</button>
      </div>
      <span id="result">00:00</span>
    </div>

    <div class="interval">
      <button disabled></button>
      <input type="time">
      <input type="time">
      <input type="text">
      <input type="time" readonly></input>
    </div>
  </div>
  <button id="add" style="width: 100%;">+</button>
</body>

</html>