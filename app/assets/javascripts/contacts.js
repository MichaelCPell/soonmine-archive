$(document).ready(function(){
  $("#add-another-contact").click(function(e){
    e.preventDefault()
    $("#manual-contact-fieldsets").append(" \
        <div class='large-6 columns'> \
          Name: <input  name='contact[][firstname]' type='text' /> \
        </div> \
        <div class='large-6 columns'> \
          Email: <input  name='contact[][email]' type='text' /> \
        </div>")
  });
});