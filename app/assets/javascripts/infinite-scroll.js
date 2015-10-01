var page = 1;
var admin = false;
$(function(){
  $.get('/tattoos.json', function(data){
    admin = data.admin;
  });
});

$(window).scroll(function() {
  var lastUrl = window.location.href.lastIndexOf("/");
  var location = window.location.href.substr(lastUrl);
  if (location == "/tattoos") {
    if($(window).scrollTop() + $(window).height() == $(document).height()) {
      page++;
      $.get('/tattoos.json?page=' + parseInt(page), function(data) {
        var tattoos = data.tattoos;
        tattoos.forEach(function(tattoo) {
          var $divContainer = $('<div>').addClass('large-4 medium-8 small-12 columns end');

          var $tattooBox = $('<div>').addClass('tattoo-box');
          var $imageLink = $('<a>').attr('href', "/tattoos/" + tattoo.id);
          var $tattooImage = $('<img>').attr('src',tattoo.url).addClass('fillwidth');
           $imageLink.append($tattooImage);
           $tattooBox.append($imageLink);

           var $tattooPanel = $('<div>').addClass('panel');
           var $tattooTitle = $('<h5>').addClass('tattoo-title text-center');
           var $textLink = $('<a>').attr('href', "/tattoos/" + tattoo.id);
           $tattooTitle.append($textLink.text(tattoo.title));
           $tattooPanel.append($tattooTitle);

           if (admin) {
             var $deleteLink = $('<a id="delete-' + tattoo.id +
              '" class="tiny button" rel="nofollow" data-method="delete" href="/tattoos/'
              + tattoo.id + '">Delete</a>')

             $tattooPanel.append($deleteLink);
           };

           $divContainer.append($tattooBox);
           $divContainer.append($tattooPanel);
           $('#content').append($divContainer);
         });
       });
     }
   }
});
