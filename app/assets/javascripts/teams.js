// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  var competitons = $('select').slice(0, -1); // we don't want to select the captain dropdown
  var pickIds = []
  var currentCaptainId = getCurrentCaptainId();

  function initialize() {
    listenForSelectionChanges();
    listendForCurrentCaptainSelection();
  }

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
      pickIds = getCurrentPickIds();
      postData(pickIds, currentCaptainId);
    });
  }

  function getCurrentCaptainId() {
    return $('#team_captain_id :selected').val();
  }

  function getCurrentPickIds() {
    pickIds = []
    competitons.each(function() {
      pickIds.push($(this).val())
    });
    return pickIds;
  };

  function updateOptions(competitons) {
    var prevPickIds = pickIds;
    pickIds = getCurrentPickIds()
    currentCaptainId = getCurrentCaptainId();

    // if user replaces their current captain selecion, replace with replacement selection
    if (!pickIds.includes(currentCaptainId)) {
      prevCaptainIndex = prevPickIds.indexOf(currentCaptainId)
      currentCaptainId = pickIds[prevCaptainIndex]
    }

    postData(pickIds, currentCaptainId);
  };

  function postData(data) {
    $.post("/set_captain_options", { data: {captainOptions : pickIds, currentCaptainId : currentCaptainId} } , function(data, status) {
      if (status != "success") {
        alert('Woah, we couldn"t update the captain choices. Please try again or contact us if the problem persists.');
      }
    });
    return true;
  };

  initialize();
});