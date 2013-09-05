$(document).ready(function(){
  $("#add-another-contact").click(function(e){
    e.preventDefault()
    $("#manual-contact-fieldsets").append(" \
        <div class='large-6 columns'> \
          <input  name='contact[][firstname]' type='text' placeholder='Name' /> \
        </div> \
        <div class='large-6 columns'> \
          <input  name='contact[][email]' type='text' placeholder='Email'/> \
        </div>")
  });
});