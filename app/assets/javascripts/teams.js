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
  this.pickIds = this.getCurrentPickIds()
  this.currentCaptainId = this.getCurrentCaptainId();
  if (!this.pickIds.includes(this.currentCaptainId) && prevPickIds !== undefined) {
    prevCaptainIndex = prevPickIds.indexOf(this.currentCaptainId)
    this.currentCaptainId = this.pickIds[prevCaptainIndex]
  }
  this.postData(this.pickIds, this.currentCaptainId);
},

CaptainSelect.prototype.postData = function(pickIds, currentCaptainId) {
  $.post("/set_captain_options", {data: {captainOptions : pickIds, currentCaptainId : currentCaptainId}}, function(data, status) {
    if (status != "success") {
      alert('Woah, we couldn"t update the captain choices. Please try again or contact us if the problem persists.');
    }
  });
  return true;
}
