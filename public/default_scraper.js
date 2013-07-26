var findName = function(){
  return document.getElementsByTagName("h1")[0].textContent.trim()
};

var findPrice = function(){
  var textNodes = [];

  var filterNodeByText = function(node){
      if (node.textContent.trim().match(/[$][0-9]+(\.)?[0-9]?[0-9]?/) && node.textContent != "") {
          return NodeFilter.FILTER_ACCEPT
      }else{
          return NodeFilter.FILTER_SKIP
      }
  }

  function nativeTreeWalker() {
      var walker = document.createTreeWalker(
          document.body, 
          NodeFilter.SHOW_ELEMENT, 
          filterNodeByText, 
          false
      );

      var node;

      while(node = walker.nextNode()) {
          textNodes.push(node);
      }
  }

  var grabFontSize = function(a){
      return getComputedStyle(a).getPropertyValue("font-size");
  }

  nativeTreeWalker();

  resTextWithSize = {}
  _.each(textNodes,function(a){ resTextWithSize[parseFloat(grabFontSize(a))] = a.textContent.trim().match("[$][0-9]+(\.)?[0-9]?[0-9]?")})

  var keys = _.keys(resTextWithSize)
  function itemgetter(key) { return resTextWithSize[key]}
  var maxKey = _.max(keys, itemgetter)
  var maxkey;

  _.each(resTextWithSize, function(value, key) {
     if (maxkey == null || parseFloat(key) > maxkey) { maxkey = key; }
  });

  var maxvalue = resTextWithSize[maxkey];

  return maxvalue;
};

var findImage = function(){
  // Algorithm for Finding Image
  images =  document.getElementsByTagName("img")

  imagesWithSizes = {}

  _.each(images, function(a){
    imagesWithSizes[a.src] = (a.width * a.height)
  })

  var keys = _.keys(imagesWithSizes)
  function itemgetter(key) { return imagesWithSizes[key]}
  var maxKey = _.max(keys, itemgetter)

  return maxKey;
};



window.setInputValues = function(){
  document.getElementById("product[name]").value = findName();
  document.getElementById("product[price]").value = findPrice();
  document.getElementById("product[image]").src = findImage();
};
