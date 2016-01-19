$(window).load(function(){
  //*****start emotiv config
  var EdkDll;
  setupEdk();
  function ELSPlugin()
  {
    return document.getElementById('plugin0');
  }
  init();

});

window.onbeforeunload = function(event) {
  EdkDll.IEE_EngineDisconnect();
}