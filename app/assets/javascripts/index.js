var ready = function(){
  if ($("#task_measure").val() != "Custom") {
    $('#task_custom_measure').parent().hide()
  }
  $("#task_measure").change(function(){
    if ($("#task_measure").val()=='Custom') {
      $('#task_custom_measure').parent().show("slow");
    } else {
      $('#task_custom_measure').parent().hide("slow");
    }
  });
};
$("#admin_add").click(function(){
  $.post(
    "/admin/update",
    {"email": $("#email_admin").val(), "func":"add"},
    function(data,status) {
      if (status == "success"){
        alert("successfully Added Admin");
        location.reload();
      } else {
        alert(data);
      }
    }
  );
  });
  $("#admin_Remove").click(function(){
    $.post(
      "/admin/update",
      {"email": $("#email_admin").val(), "func":"remove"},
      function(data,status) {
        if (status == "success"){
          alert("successfully Removed Admin");
          location.reload();
        } else {
          alert(data);
        }
      }
    );
  });
$(document).ready(ready)
$(document).on('turbolinks:load',ready)
