var newDivContent = "<div id='_sm_bookmarklet'>Hello World</div>"
var newDiv = document.createElement("div")
newDiv.innerHTML = newDivContent;
document.getElementsByTagName("body")[0].appendChild(newDiv);
