// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  var competitons = $('select');

  function initializeInitialState() {
    competitons.each(function() {
      updateCaptainOptions(competitons);
    })
  }

  function listenForChanges() {
    competitons.each(function() {
      $(this).change(function() {
        updateCaptainOptions(competitons);
      });
    });
  };

  function updateCaptainOptions(competitons) {
    var pickIds = []
    competitons.each(function() {
      pickIds.push($(this).val())
    })
    var data = {captainOptions : pickIds}
    postOptions(data);
  };

  function postOptions(data) {
    $.post("/set_captain_options", { data: data } , function(data, status) {
      if (status != "success") {
        alert('Woah, we couldn"t update the captain choices. Please try again or contact us if the problem persists.');
      }
    });
    return true;
  };

  initializeInitialState();
  listenForChanges();
})
