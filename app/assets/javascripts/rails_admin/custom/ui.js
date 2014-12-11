// rails_admin loads this file

$(window).ready(admin_rtg_events);
$(document).on('pjax:complete', admin_rtg_events);

function admin_rtg_events() {
  // clicking on list tds triggers Edit link
  $('#bulk_form tr:gt(0)').find('td:gt(0)').not('.last').css('cursor', 'pointer').click(function() {
    location.href = $(this).parents('tr:first').find('li[title=Edit] a').attr('href');
  });

  // Make draggable, sortable nested items
  // see: https://github.com/firebelly/firebellydev/wiki/Rails-Admin
  var sortable_models       = ['reason_reason_images', 'page_page_images'];
  var sortable_input_field  = 'input[name*="position"]';
  var sortable_items        = 'ul.nav-tabs li';
  $.each(sortable_models, function() {
    var sortable_target = '#' + this + '_attributes_field';
    $(sortable_target).sortable({
      items: sortable_items,
      placeholder: 'ui-state-highlight',
      forcePlaceholderSize: true,
      forceHelperSize: true,
      tolerance: 'pointer',
      update: function(e, ui) {
        $.each($(sortable_target).find(sortable_items), function(n, obj) {
          var href = $(obj).find('a').attr('href');
          $(href).find(sortable_input_field).val(n)
        });
      }
    });
  });
}