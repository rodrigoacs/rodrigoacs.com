let counter;

function rgbOn() {
  let hueValue = 0
  clearInterval(counter)
  counter = setInterval(() => {
    document.body.style.setProperty('--color', `hsl(${hueValue},100%,50%)`)
    hueValue++
    if (hueValue == 360) hueValue = 0
  }, 5);
}
