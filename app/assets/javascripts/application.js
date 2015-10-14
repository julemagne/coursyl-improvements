// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require d3
//= require_tree .

// function disableClick() {
//   document.getElementsByName("commit")[0].disabled = true;
// }
//
// function superTimeout() {
//   window.setTimeout(disableClick, 500) //Not putting a semicolon made it work WHYYYYYYY
// }

function disableClick(){
  $(event.target).closest('form').submit();
  $(event.target).prop("disabled", true);
  //event.target.disabled=true;
  //event.target.form.submit();//You have to have form submit bc button action happens AFTER js runs.
}

function noMoreUpdateCourseClicks() {
  $(".input[type=submit]").on("click", disableClick);
}

$(noMoreUpdateCourseClicks);

//to toggle with the +Add Grade Threshold button (not used)
function showHide(){
  var last=$(".association.container").last();
  if(last.css("display")=="none"){
    last.css("display", "block");
  }else{
    last.css("display", "none");
  }
}

function hideRow() {
  last = $(".association.container").last(); //this checks to see if the thing you want is on the page
  if(last) {
    last.hide();
  }
  // $(".association.container").last().hide(); //doesn't happen at page load (has a flash)
  // $(".association.container").last().css("display", "none");
  // document.getElementsByClassName("associations")[0].lastElementChild.style.display = 'none';
}

$(hideRow);

function showRow() {
  last = $(".association.container").last().show();
  if(last) {
    last.show();
  }
  // $(".association.container").last().css("display", "none");
  // document.getElementsByClassName("associations")[0].lastElementChild.style.display = 'block';
}

function clickRow(){
  $(".new-association").on("click", showRow);// ".new-association" is the class on the button that is clicked
}

$(clickRow);

function deleteButton() {
  $(event.target).closest(".association.container").hide();
  $(event.target).siblings("input[type=checkbox]").prop("checked", true);
  // event.target.parentElement.parentElement.parentElement.style.display = "none"; //"association container"
  // event.target.parentElement.lastElementChild.checked = true; //hidden checkbox
}

function clickDelete() {
  $(".btn-danger").on("click", deleteButton);
}

$(clickDelete);

document.addEventListener("DOMContentLoaded", function() {
  "use strict"

  var links = document.querySelectorAll("a.scroll")
  var i = links.length
  var root = /firefox|trident/i.test(navigator.userAgent) ? document.documentElement : document.body
  var easeInOutCubic = function(t, b, c, d) {
    if ((t/=d/2) < 1) return c/2*t*t*t + b
    return c/2*((t-=2)*t*t + 2) + b
  }

  while (i--)
    links.item(i).addEventListener("click", function(e) {
      var startTime
      var startPos = root.scrollTop
      var endPos = document.getElementById(/[^#]+$/.exec(this.href)[0]).getBoundingClientRect().top
      var maxScroll = root.scrollHeight - window.innerHeight
      var scrollEndValue = startPos + endPos < maxScroll ? endPos : maxScroll - startPos
      var duration = 800
      var scroll = function(timestamp) {
        startTime = startTime || timestamp
        var elapsed = timestamp - startTime
        var progress = easeInOutCubic(elapsed, startPos, scrollEndValue, duration)
        root.scrollTop = progress
        elapsed < duration && requestAnimationFrame(scroll)
      }
      requestAnimationFrame(scroll)
      e.preventDefault()
    })
})
