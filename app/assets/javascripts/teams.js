// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  var competitons = $('select');
  competitons.each(function() {
    $(this).change(function() {
      updateCaptainOptions(competitons);
    });
  });

  function updateCaptainOptions(competitons) {
    var pickIds = []
    competitons.each(function() {
      pickIds.push($(this).val())
    })
    postOptions(pickIds);
  }

  function postOptions(pickIds) {
    $.post("update_captain_choices", {captainOptions : pickIds}, function(data, status) {
      if (status != "success") {
        alert('Woah, we couldn"t update the captain choices. Please try again or contact us if the problem persists.');
      }
    });
    return true;
  }
})
