// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function TeamSelection(currentCaptainId) {
  this.currentCaptainId = currentCaptainId;
  this.competitons = $('select');
  this.pickIds = this.getCurrentPickIds();

  this.setInitialOptions();
  this.listenForSelectionChanges();
  this.listendForCurrentTeamSelectionion();
}

TeamSelection.prototype.setInitialOptions = function() {
  this.pickIds = this.getCurrentPickIds();
  this.postData(pickIds, this.currentCaptainId);
},

TeamSelection.prototype.listenForSelectionChanges = function() {
  var self = this;
  self.competitons.each(function() {
    $(this).change(function() {
      self.updateOptions();
    });
  });
},

TeamSelection.prototype.listendForCurrentTeamSelectionion = function() {
  var self = this;
  $('#team_captain_id').change(function() {
    self.currentCaptainId = self.getCurrentCaptainId();
    self.pickIds = self.getCurrentPickIds();
    self.postData(self.pickIds, self.currentCaptainId);
  });
},

TeamSelection.prototype.getCurrentCaptainId = function() {
  return $('#team_captain_id :selected').val();
},

TeamSelection.prototype.getCurrentPickIds = function() {
  var self = this;
  pickIds = []
  self.competitons.each(function() {
    pickIds.push($(this).val())
  });
  return pickIds;
},

TeamSelection.prototype.updateOptions = function() {
  var prevPickIds = this.pickIds;
  this.pickIds = this.getCurrentPickIds()
  this.currentCaptainId = this.getCurrentCaptainId();
  if (!this.pickIds.includes(this.currentCaptainId) && prevPickIds !== undefined) {
    prevCaptainIndex = prevPickIds.indexOf(this.currentCaptainId)
    this.currentCaptainId = this.pickIds[prevCaptainIndex]
  }
  this.postData(this.pickIds, this.currentCaptainId);
},

TeamSelection.prototype.postData = function(pickIds, currentCaptainId) {
  $.post("/team_selection", {data: {currentSelection : pickIds, currentCaptainId : currentCaptainId}}, function(data, status) {
    if (status != "success") {
      alert('Woah, we couldn"t update the captain choices. Please try again or contact us if the problem persists.');
    }
  });
  return true;
}