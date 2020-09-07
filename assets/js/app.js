// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"

//set default degree (360*5)
var degree = 1800;
//number of clicks = 0
var clicks = 0;
var lastPositionSoundAt;
const SPIN_DURATION = 6 * 1000;

$(document).ready(function(){
  /*WHEEL SPIN FUNCTION*/
  let innerWheelEl = $('#inner-wheel')[0];
  let innerSpinEl = $('#inner-spin')[0];
  let $wheel = $('#wheel');
  let choiceCount = innerWheelEl.querySelectorAll('.sec').length;
  let choiceColors = window.spinColors.slice(0,choiceCount).reverse();
	$('#spin').click(function(){
    if (!$wheel.hasClass('spinnable')) {
      return;
    }
      
		//add 1 every click
		clicks ++;
		
		/*multiply the degree by number of clicks
	  generate random number between 1 - 360, 
    then add to the new degree*/
		var newDegree = degree*clicks;
		var extraDegree = window.spinDegreeTarget || (Math.floor(Math.random() * (360 - 1 + 1)) + 1);
		var totalDegree = newDegree+extraDegree;
		
		/*let's make the spin btn to tilt every
		time the edge of the section hits 
		the indicator*/    
    var c = 0;
    var n = 700;
    var interval = setInterval(function () {
      c++;				
      if (c === n) { 
        clearInterval(interval);
      }	

      let currentRotation = getCurrentRotation(innerWheelEl) - (360/choiceCount/2);
      let sectionStart = Math.round(currentRotation / (360/choiceCount));
      console.log(sectionStart);
      let distancePastSectionStart = currentRotation % (360/choiceCount);
      // console.log({ '360/choiceCount': 360/choiceCount, currentRotation, distancePastSectionStart });
      if (distancePastSectionStart > 0 && distancePastSectionStart < 4) {
        // console.log('==========');
        if (lastPositionSoundAt !== sectionStart) {
          wheelClickSound();
          let color = choiceColors[Math.abs(sectionStart)];
          innerSpinEl.style.setProperty('--logo-filter', `drop-shadow(1px 2px 3px ${color})`);
          lastPositionSoundAt = sectionStart;
        }
        $('#spin').addClass('spin');
        setTimeout(function () { 
          $('#spin').removeClass('spin');
        }, 100);	
      }
    }, 10);
    
    $wheel.removeClass('spinnable');
    $('#inner-wheel').css({
      'transform' : 'rotate(' + totalDegree + 'deg)'			
    });
    setTimeout(function() {
      if (window.spinComplete) {
        window.spinComplete();
      }
    }, SPIN_DURATION);
	});
});

function getCurrentRotation(el){
  var st = window.getComputedStyle(el, null);
  var tm = st.getPropertyValue("transform");
  if (tm) {
    var values = tm.split('(')[1].split(')')[0].split(',');
    var angle = Math.round(Math.atan2(values[1],values[0]) * (180/Math.PI));
    return (angle < 0 ? angle + 360 : angle); //adding 360 degrees here when angle < 0 is equivalent to adding (2 * Math.PI) radians before
  }
  return 0;
}

function wheelClickSound() {
  soundEffect(
    170,       //frequency
    0.03,         //attack
    0.004,          //decay
    "square",       //waveform
    1.5,            //volume
    0.3,          //pan
    0,            //wait before playing
    0.01,          //pitch bend amount
    false,         //reverse
    2,          //random pitch range
    0.001,            //dissonance
    null,//[0.005,0.025,0.48],    //echo array: [delay, feedback, filter]
    null     //reverb array: [duration, decay, reverse?]
  );
}
