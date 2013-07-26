// Predicate Functions
function existy(x) { return x != null };
function truthy(x) { return (x !== false) && existy(x) };

// Load Underscore
var e = document.createElement('script');   
  e.setAttribute('src', 'http://underscorejs.org/underscore-min.js');                    
  document.body.appendChild(e);  

//Load the CSS
var css = document.getElementById('sm-css');
if (css) {
  css.parentNode.removeChild(css);
}
var link = document.createElement("link");
link.type = "text/css";
link.rel = "stylesheet";
link.href = "https://soonmine.herokuapp.com/bookmarklet.css";
link.id = 'sm-css';
document.getElementsByTagName("head")[0].appendChild(link);
 
 

// Load the Scraper
var e = document.createElement('script');   
  e.setAttribute('src', 'https://soonmine.herokuapp.com/default_scraper.js');                    
  document.body.appendChild(e);  


// Load the UI

 /*jshint multistr: true */
var interfaceContent = "<form >\
  Name: <input type='textfield' id='product[name]'></input>\
  <br/>\
  Price: <input type='textfield' id='product[price]'></input>\
  <br/>\
  Image: <img src='http://placehold.it/50x50' id='product[image]'/>\
  <br/><br/>\
  <input type='button' value='Submit' onClick='setInputValues()'></input>\
  </form>";

/*Begin Execution*/
var interfaceContainer = document.createElement("div");
interfaceContainer.id = "sm-bookmarklet";
interfaceContainer.innerHTML = interfaceContent;
document.getElementsByTagName("body")[0].appendChild(interfaceContainer);





  
