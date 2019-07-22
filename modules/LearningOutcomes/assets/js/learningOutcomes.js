(function ($) {
  $(function () {

  	$('#learningOutcomesSection #addSectionItemBtn').on('click', function (e) {
  		e.stopPropagation();
  		e.preventDefault();

  		var $itemToClone = $(this).parents('#learningOutcomesSection').find('.sort-item').last();
  		var i = parseInt($itemToClone.attr('id').substring(11)) + 1;
      var $clone = $itemToClone.clone();
  		// console.log(i);
      var sortOrder = parseInt($itemToClone.find(`input[name='section[real][new-${i-1}][sortOrder]']`).val());
      $clone.attr('id', 'newSortItem'+i);
      $clone.find('.sort-order-value').attr('name',`section[real][new-${i}][sortOrder]`).val(sortOrder+1);
      $clone.find('.row-label').text(`Row #${i+1}`);
     
      var rowSize = '4em'; 
      var $textarea = $clone.find('.learning-outcome-row .column1').find('textarea');
      if ($textarea.attr('rows'))
      {
        var rows = parseInt($textarea.attr('rows'));
        rowSize = (rows * 2) + 'em';
      }
      var config = {
        customConfig: '../ckeditor_custom/ckeditor_config_basic.js',
        height:rowSize,
        autoGrow_minHeight: rowSize
      };

      $textarea.attr('name',`section[real][new-${i}][column1]`).val('').text('').attr('id', `ckeditor-${i}-1`);
      $textarea.next('.cke').remove();
      $textarea.ckeditor(config);
      
      $textarea = $clone.find('.learning-outcome-row .column2').find('textarea');
      $textarea.attr('name',`section[real][new-${i}][column2]`).val('').text('').attr('id', `ckeditor-${i}-2`);
      $textarea.next('.cke').remove();
      $textarea.ckeditor(config);

      $textarea = $clone.find('.learning-outcome-row .column3').find('textarea');
      $textarea.attr('name',`section[real][new-${i}][column3]`).val('').text('').attr('id', `ckeditor-${i}-3`);
      $textarea.next('.cke').remove();
      $textarea.ckeditor(config);

      $itemToClone.after($clone);
  	});


    $('#learningOutcomesSection', '[id^="toggleEditViewTab"] a').on('click', function (e) {
      e.preventDefault();
      $(this).tab('show');
    });

    $('#learningOutcomesSection [name^="command[deletesectionitem]"]').on('click', function (e) {
      e.preventDefault();
      var container = $('#learningOutcomesSection').find('#learningOutcomeContainer' + $(this).attr('id'));
      container.css({"background-color": "#f8d7da"}).fadeTo(250, 0.1).slideUp(250, function () {
        container.detach();
      });
    });

  });
})(jQuery);