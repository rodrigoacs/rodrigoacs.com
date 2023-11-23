<!DOCTYPE html>
<html lang="pt-BR">

<head>
  @vite(['resources/css/style.css'])
  @vite(['resources/js/script.js'])
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>rodrigoacs.com</title>
  <link rel="shortcut icon" href="./favicon.ico" type="image/x-icon">
</head>

<body>
  <nav class="navbar">
    <div>
      <a class="active link" href="home">home</a>
      <a class="link" href="blog">blog</a>
      <a class="link" href="cv">cv</a>
    </div>
    <div>
      <a id="change-language"></a>
      <a id="change-theme"><img src="./assets/new_moon_3d.png" alt="" id="change-theme-img" style="width: 1.5rem;"></a>
    </div>
  </nav>
  <main class="ajax">
  </main>

  <footer>
    icons by <a href="https://icons8.com">Icons8</a>
  </footer>
</body>

<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>

</html>