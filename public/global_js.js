$(document).ready(function(){
  // Check for the correct pages in the url. This limits the script to only run for pages
  
  if($('#Ccampus169_2_xA0_Image').length == 1){
  	$('#main').css('max-width', 'none');
    $('#main').css('width', '100%');
    if($('#kthavatar').text() == "" ){
    	alert("Please select an avatar!");
    	window.location = "/profile/settings";
  	}
  }

  if(window.location.href.split('/').indexOf('library')!==-1){ 
      $('#header').css('background-image', 'url("https://dl.dropboxusercontent.com/u/5164106/banclibrary.png")');
      $('#header').css('background-color', '#e9d6ea');
      if($('#kthavatar').text() == "" ){
    	alert("Please select an avatar!");
    	window.location = "/profile/settings";
  	}
  }
  
   if(window.location.href.split('/').indexOf('discussion_topics')!==-1){ 
      $('#header').css('background-image', 'url("https://dl.dropboxusercontent.com/u/5164106/banmessagewall.png")');
      $('#header').css('background-color', '#fff69b');
      if($('#kthavatar').text() == "" ){
    	alert("Please select an avatar!");
    	window.location = "/profile/settings";
  	}
  }
  
  if(window.location.href.split('/').indexOf('users')!==-1){ 
      $('#header').css('background-image', 'url("https://dl.dropboxusercontent.com/u/5164106/banmeetgreet.png")');
      $('#header').css('background-color', '#b1d398');
      if($('#kthavatar').text() == "" ){
    	alert("Please select an avatar!");
    	window.location = "/profile/settings";
  	}
  }
  
   if(window.location.href.split('/').indexOf('assignments')!==-1){ 
      $('#header').css('background-image', 'url("https://dl.dropboxusercontent.com/u/5164106/banpeerreview.png")');
      $('#header').css('background-color', '#9fe1fb');
      if($('#kthavatar').text() == "" ){
    	alert("Please select an avatar!");
    	window.location = "/profile/settings";
  	}
  }
  
  if(window.location.href.split('/').indexOf('groups')!==-1){ 
      $('#header').css('background-image', 'url("https://dl.dropboxusercontent.com/u/5164106/bancreativelearning.png")');
      $('#header').css('background-color', '#ee6f22');
      $('#left-side').show();
      $('#right-side-wrapper').show();
      $('section-tabs-header-subtitle').hide();
      if($('#kthavatar').text() == "" ){
    	alert("Please select an avatar!");
    	window.location = "/profile/settings";
  	}
  }
  
   if(window.location.href.split('/').indexOf('external_tools')!==-1){ 
      $('#header').css('background-image', 'url("https://dl.dropboxusercontent.com/u/5164106/banclounge.png")');
      $('#header').css('background-color', '#f099be');
      if($('#kthavatar').text() == "" ){
    	alert("Please select an avatar!");
    	window.location = "/profile/settings";
  	}
  }
  
   if(window.location.href.split('/').indexOf('overview')!==-1){ 
      $('#header').css('background-image', 'url("https://dl.dropboxusercontent.com/u/5164106/bancourseoverview.png")');
      $('#header').css('background-color', '#c9a372');
      if($('#kthavatar').text() == "" ){
    	alert("Please select an avatar!");
    	window.location = "/profile/settings";
  	}
  }
});

