
jQuery(document).ready(function(e){
  // Textarea Autogrow
  var dateToday = new Date();


    $('input#datetimepickerStart').datetimepicker({
     format: 'MM/DD/YYYY',
     defaultDate: new Date(),
     extraFormats: ['MM/DD/YY'],
     minDate: new Date(),
     maxDate: '12/31/2059'
    });

    $('input#datetimepickerEnd').datetimepicker({
     format: 'MM/DD/YYYY',
     defaultDate: new Date(),
     extraFormats: ['MM/DD/YY'],
     minDate: new Date(),
     maxDate: '12/31/2059'
    });


    $('input#hiddendate').datetimepicker({
     format: 'MM/DD/YYYY',
     extraFormats: ['MM/DD/YY'],
     maxDate: '12/31/2059'
    });



    $("#datetimepickerStart, #datetimepickerStartIcon").on("dp.change", function (e) {
      $('#datetimepickerEnd').data("DateTimePicker").minDate(e.date);
    });
    $("#datetimepickerEnd, #datetimepickerEndIcon").on( "dp.change", function (e) {
      $('#datetimepickerStart').data("DateTimePicker").maxDate(e.date);
    });

      $("#hiddendate ").on("dp.change", function (e) {
      $('#datetimepickerEnd').data("DateTimePicker").minDate(e.date);
    });
      $("#first_event ").on("dp.change", function (e) {
      $('#datetimepickerEnd').data("DateTimePicker").minDate(e.date);
    });


  $('#timepickerStart').timepicker({
    showInputs: false,
    disableFocus: true,
       minTime: '05:00:00',
      maxTime: '22:00:00',
       defaultTime: false
  });
  $('#timepickerEnd').timepicker({
    showInputs: false,
    disableFocus: true,
      minTime: '05:00:00',
      maxTime: '22:00:00',
      defaultTime: false
  });
});




