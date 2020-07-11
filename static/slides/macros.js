remark.macros.scale = function (percentage) {
  var url = this;
  return '<img src="' + url + '" style="width: ' + percentage + '" />';
};

(function() {
let tries = 0
function addLogo() {
  if (typeof slideshow === 'undefined') {
    ++tries < 10 ? setTimeout(addLogo, 100) : null
    return
  } else {
  	document.querySelectorAll('.remark-slide-content:not(.title-slide):not(.hide_logo)')
    	.forEach(el => el.innerHTML = '<div class="webcam-wrapper"> <img src= ""></div>' + el.innerHTML)
  }
}
document.addEventListener('DOMContentLoaded', addLogo)
})()