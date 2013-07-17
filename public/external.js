var newDivContent = "<div style='width: 100px; height: 100px; background: #298DFF;'>Hello World</div>"
var newDiv = document.createElement("div")
newDiv.innerHTML = newDivContent;
document.getElementsByTagName("body")[0].appendChild(newDiv);
