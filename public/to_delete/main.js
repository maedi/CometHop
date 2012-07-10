require(

  ["three.js/Three.js", "three.js/Detector.js", "three.js/Stats.js"],
  
  function($) {
    //the jquery.alpha.js and jquery.beta.js plugins have been loaded.
    $(function() {
        $('body').alpha().beta();
    });
});