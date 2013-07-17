(function() {
  //Load the CSS
  var css = document.getElementById('_sm_css');
  if (css) {
    css.parentNode.removeChild(css);
  }
  var link = document.createElement("link");
  link.type = "text/css";
  link.rel = "stylesheet";
  link.href = "https://soonmine.herokuapp.com/bookmarklet.css";
  link.id = '_ww_css';
  document.getElementsByTagName("head")[0].appendChild(link);

  //Load and display the interface

  var interfaceContent = "<div>This is the interface</div>"
  var interfaceContainer = document.createElement("div")
  interfaceContainer.id = "_sm_bookmarklet";
  newDiv.innerHTML = interfaceContent;
  document.getElementsByTagName("body")[0].appendChild(newDiv);

})