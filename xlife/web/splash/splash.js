function removeSplashFromWeb() {
  elem = document.getElementById("splash");
  if (elem) {
    elem.remove();
  }
  document.body.style.background = "transparent";
}
