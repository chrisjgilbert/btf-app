// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  var competitons = $('select');
  var pickIds = []
  var currentCaptainId;

  function initialize() {
    setInitialCaptaincyOptions();
    listenForSelectionChanges();
    listendForCurrentCaptainSelection();
  }

  function setInitialCaptaincyOptions() {
    competitons.each(function() {
      updateOptions(competitons);
    });
  };

  function listenForSelectionChanges() {
    competitons.each(function() {
      $(this).change(function() {
        updateOptions(competitons);
      });
    });
  };

  function listendForCurrentCaptainSelection() {
    $('#team_captain_id').change(function() {
      currentCaptainId = getCurrentCaptainId();
      var data = {captainOptions : pickIds, currentCaptainId : currentCaptainId}
      postData(data);
    });
  }

  function getCurrentCaptainId() {
    return $('#team_captain_id :selected').val();
  }

  function updateOptions(competitons) {
    currentCaptainId = getCurrentCaptainId();
    pickIds = []
    competitons.each(function() {
      pickIds.push($(this).val())
    })
    var data = {captainOptions : pickIds, currentCaptainId : currentCaptainId}
    postData(data);
  };

  function postData(data) {
    $.post("/set_captain_options", { data: data } , function(data, status) {
      if (status != "success") {
        alert('Woah, we couldn"t update the captain choices. Please try again or contact us if the problem persists.');
      }
    });
    return true;
  };

  initialize();
});