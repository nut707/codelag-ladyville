// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
$('.datepicker').datepicker({
	format: "dd/mm/yyyy",
	startDate: "30/11/2013",
    language: "ru",
    todayHighlight: true
});
} );