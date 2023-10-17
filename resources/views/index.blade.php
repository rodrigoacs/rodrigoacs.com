<!DOCTYPE html>
<html lang="pt-BR">

<head>
  @vite(['resources/css/style.css'])
  @vite(['resources/js/script.js'])
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>RodrigoACS</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link
    href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
    rel="stylesheet">
  <link rel="shortcut icon" href="./favicon.ico" type="image/x-icon">
</head>

<body>
  <nav class="navbar">
    <div>
      <a class="active link" href="home">home</a>
      <a class="link" href="blog">blog</a>
      <a class="link" href="cv">cv</a>
    </div>
    <a id="change-language"></a>
  </nav>
  <main class="ajax">
  </main>

  <footer>
    icons by <a href="https://icons8.com">Icons8</a>
  </footer>
</body>

<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>

</html>