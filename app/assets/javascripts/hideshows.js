$(document).ready(function() {
   $("#addAppointmentForm").click(function(e) {
    e.preventDefault();
    $("#appointmentForm").toggleClass("hide");
    $("#removeAppointmentForm").toggleClass("hide");
    // $("#addObject").toggleClass("hide");
    // $("#addObjectContainer").toggleClass("hide");
    // $("#andSign").toggleClass("hide");
    // $("#secondObject").toggleClass("hide");
  });

  //  $("#cancelObject").click(function(e) {
  //   e.preventDefault();
  //   $("#newObject").toggleClass("hide");
  //   $("#cancelObject").toggleClass("hide");
  //   $("#addObject").toggleClass("hide");
  //    $("#addObject2").toggleClass("hide");
  //   $("#addObjectContainer").toggleClass("hide");
  //   $("#andSign").toggleClass("hide");
  //   $("#secondObject").toggleClass("hide");

  // });

  //     $("#addObject2").click(function(e) {
  //   e.preventDefault();
  //   $("#newObject2").toggleClass("hide");
  //   $("#cancelObject2").toggleClass("hide");
  //   $("#addObject2").toggleClass("hide");
  //   $("#addObjectContainer2").toggleClass("hide");
  //   $("#andSign2").toggleClass("hide");
  //   $("#secondObject2").toggleClass("hide");
  // });

  //  $("#cancelObject2").click(function(e) {
  //   e.preventDefault();
  //   $("#newObject2").toggleClass("hide");
  //   $("#cancelObject2").toggleClass("hide");
  //   $("#addObject2").toggleClass("hide");
  //    $("#addObject2").toggleClass("hide");
  //   $("#addObjectContainer2").toggleClass("hide");
  //   $("#andSign2").toggleClass("hide");
  //   $("#secondObject2").toggleClass("hide");

  // });
  //  $(document).on("click", "otherDate", function () {
  //   $("#dateSelect").toggleClass("hide");
  // });
  //  $("#addAddress").click(function(e) {
  //   e.preventDefault();
  //   $("#addButton").toggleClass("hide");
  // });

});

