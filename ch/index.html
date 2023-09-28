<!DOCTYPE html>
<html lang="pt-BR">

<head>
  <link rel="apple-touch-icon" sizes="180x180" href="./assets/apple-touch-icon.png">
  <link rel="icon" type="image/png" sizes="32x32" href="./assets/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="./assets/favicon-16x16.png">
  <link rel="manifest" href="./assets/site.webmanifest">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/water.css@2/out/dark.css">
  <style>
    :root {
      --background-body: #1f1f1f;
      --background: #f0f0f0;
      --background-alt: #1a242f;
      --selection: #1c76c5;
      --text-main: #f0f0f0;
      --text-bright: #070707;
      --text-muted: #a9b1ba;
      --links: #41adff;
      --focus: #0096bfab;
      --border: #f0f0f0;
      --code: #ffbe85;
      --animation-duration: 0.1s;
      --button-base: #f0f0f0;
      --button-hover: #dadada;
      --scrollbar-thumb: var(--button-hover);
      --scrollbar-thumb-hover: rgb(0, 0, 0);
      --form-placeholder: #a9a9a9;
      --form-text: #070707;
      --variable: #d941e2;
      --highlight: #efdb43;
    }

    div {
      display: flex;
      justify-content: center;
    }

    input {
      display: inline-block;
    }

    footer {
      width: 100%;
      position: absolute;
      bottom: 0;
      left: 0;
    }
  </style>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="workedHours.js"></script>
  <title>calculadora de intervalos de tempo</title>
</head>

<body class="times">
  <div>
    <button onclick="addActivity()">+</button>
    <button onclick="calculateAll()" id="calculate">calcular</button>
  </div>
  <div>
    <p>&nbsp;</p>
    <p id="result"></p>
  </div>
  <div class="interval">
    <input type="time">
    <input type="time">
    <input type="text">
    <input type="text" readonly></input>
  </div>

  <footer>&nbsp;calculadora de intervalos de tempo v1.2</footer>
</body>

<script>
  function calculateIndividual(initial, final) {
    initial = new Date(`01/01/2023 ${initial}:00`).getTime()
    final = new Date(`01/01/2023 ${final}:00`).getTime()

    return (final - initial) / 60000
  }

  function calculateAll() {
    let intervals = document.getElementsByClassName("interval")
    let spentTime = 0
    let formatedTime = []
    for (let i = 0; i < intervals.length; i++) {
      let initial = intervals[i].children[0].value
      let final = intervals[i].children[1].value

      if (!initial | !final) {
        break
      }

      let spentIndividual = calculateIndividual(initial, final)
      formatedTime = formatTime(spentIndividual)
      intervals[i].children[3].value = `${formatedTime[0]} hora(s) e ${formatedTime[1]} minuto(s)`
      spentTime += spentIndividual
    }

    formatedTime = formatTime(spentTime)
    document.getElementById("result").innerText = `${formatedTime[0]} hora(s) e ${formatedTime[1]} minuto(s)`
  }

  function formatTime(time) {
    let hours = parseInt(time / 60)
    let minutes = time - hours * 60
    return [hours, minutes]
  }

  function addActivity() {
    let times = document.getElementsByClassName("times")
    let div = document.createElement("div")
    div.classList = "interval"
    let inputTime = document.createElement("input")
    inputTime.type = "time"
    let inputTime2 = document.createElement("input")
    inputTime2.type = "time"
    let inputText = document.createElement("input")
    inputText.type = "text"
    let individualTime = document.createElement("input")
    individualTime.type = "text"
    individualTime.readOnly = true

    div.appendChild(inputTime)
    div.appendChild(inputTime2)
    div.appendChild(inputText)
    div.appendChild(individualTime)

    times[times.length - 1].appendChild(div)
  }
</script>

</html>