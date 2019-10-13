// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function CaptainSelect(currentCaptainId) {
  this.currentCaptainId = currentCaptainId;
  this.competitons = $('select');
  this.pickIds = [];

  this.setInitialOptions();
  this.listenForSelectionChanges();
  this.listendForCurrentCaptainSelection();
}

CaptainSelect.prototype.setInitialOptions = function() {
  this.pickIds = this.getCurrentPickIds();
  this.postData(pickIds, this.currentCaptainId);
},

CaptainSelect.prototype.listenForSelectionChanges = function() {
  var self = this;
  self.competitons.each(function() {
    $(this).change(function() {
      self.updateOptions();
    });
  });
},

CaptainSelect.prototype.listendForCurrentCaptainSelection = function() {
  var self = this;
  $('#team_captain_id').change(function() {
    self.currentCaptainId = self.getCurrentCaptainId();
    self.pickIds = self.getCurrentPickIds();
    self.postData(self.pickIds, self.currentCaptainId);
  });
},

CaptainSelect.prototype.getCurrentCaptainId = function() {
  return $('#team_captain_id :selected').val();
},

CaptainSelect.prototype.getCurrentPickIds = function() {
  var self = this;
  pickIds = []
  self.competitons.each(function() {
    pickIds.push($(this).val())
  });
  return pickIds;
},

CaptainSelect.prototype.updateOptions = function() {
  var prevPickIds = this.pickIds;
  pickIds = this.getCurrentPickIds()
  this.currentCaptainId = this.getCurrentCaptainId();
  // if user replaces their current captain selecion, replace with replacement selection
  if (!pickIds.includes(this.currentCaptainId) && prevPickIds.length > 0) {
    prevCaptainIndex = prevPickIds.indexOf(this.currentCaptainId)
    this.currentCaptainId = pickIds[prevCaptainIndex]
  }
  this.postData(pickIds, this.currentCaptainId);
},

CaptainSelect.prototype.postData = function(pickIds, currentCaptainId) {
  $.post("/set_captain_options", {data: {captainOptions : pickIds, currentCaptainId : currentCaptainId}}, function(data, status) {
    if (status != "success") {
      alert('Woah, we couldn"t update the captain choices. Please try again or contact us if the problem persists.');
    }
  });
  return true;
}

  // var competitons = $('select') // we don't want to select the captain dropdown
  // var pickIds = []
  // var currentCaptainId;

  // function initialize() {
  //   setInitialOptions();
  //   listenForSelectionChanges();
  //   listendForCurrentCaptainSelection();
  // };

  // function setInitialOptions() {
  //   pickIds = getCurrentPickIds();
  //   currentCaptainId = '<%= @current_captain.id %>';
  //   postData(pickIds, currentCaptainId);
  // };

  // function listenForSelectionChanges() {
  //   competitons.each(function() {
  //     $(this).change(function() {
  //       updateOptions();
  //     });
  //   });
  // };

  // function listendForCurrentCaptainSelection() {
  //   $('#team_captain_id').change(function() {
  //     currentCaptainId = getCurrentCaptainId();
  //     pickIds = getCurrentPickIds();
  //     postData(pickIds, currentCaptainId);
  //   });
  // }

  // function getCurrentCaptainId() {
  //   return $('#team_captain_id :selected').val();
  // }

  // function getCurrentPickIds() {
  //   pickIds = []
  //   competitons.each(function() {
  //     pickIds.push($(this).val())
  //   });
  //   return pickIds;
  // };

  // function updateOptions() {
  //   var prevPickIds = pickIds;
  //   pickIds = getCurrentPickIds()
  //   currentCaptainId = getCurrentCaptainId();
  //   // if user replaces their current captain selecion, replace with replacement selection
  //   if (!pickIds.includes(currentCaptainId) && prevPickIds.length > 0) {
  //     prevCaptainIndex = prevPickIds.indexOf(currentCaptainId)
  //     currentCaptainId = pickIds[prevCaptainIndex]
  //   }
  //   postData(pickIds, currentCaptainId);
  // };

  // function postData(pickIds, currentCaptainId) {
  //   console.log(pickIds, currentCaptainId)
  //   $.post("/set_captain_options", {data: {captainOptions : pickIds, currentCaptainId : currentCaptainId}}, function(data, status) {
  //     if (status != "success") {
  //       alert('Woah, we couldn"t update the captain choices. Please try again or contact us if the problem persists.');
  //     }
  //   });
  //   return true;
  // };

  // initialize();
