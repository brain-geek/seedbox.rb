$(function(){
  $('#parcel_asset').bind('change', function(){
    $(this).parents('form').each(function(index){
      $(this).submit();
    });
  });
});