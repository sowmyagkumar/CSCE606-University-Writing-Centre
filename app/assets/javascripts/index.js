var ready = function(){
  if ($("#task_measure").val() != "Custom") {
    $('#task_custom_measure').parent().hide()
  }
  $("#task_measure").change(function(){
    console.log("Inside");
    if ($("#task_measure").val()=='Custom') {
      $('#task_custom_measure').parent().show("slow");
    } else {
      $('#task_custom_measure').parent().hide("slow");
    }
  });
};
$(document).ready(ready)
$(document).on('turbolinks:load',ready)
