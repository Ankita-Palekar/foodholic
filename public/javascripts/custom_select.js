$(document).ready(function() { 
    var ingredients_db = Array();
    var ingredients_user=Array();
    var ingredients = Array(); // added to multiselect

    function object_to_array (object) {
      return _.map(object,function(component){return component["ingredient"]["name"]})
    }

    $.ajax({
      method: "GET",
      url: "/ingredients"
    })
    .done(function(json) {
        ingredients_object = $.parseJSON(json)
        ingredients_db = object_to_array(ingredients_object)
        ingredients_array  = $.map(ingredients_object,function(a){
          val = a["ingredient"]["name"]
          return {label: val, value: val}
        }); 
        $('#select-ingredients').multiselect('dataprovider', ingredients_array)
        $('#select-ingredients').multiselect('rebuild');
      });

   $('#select-ingredients').multiselect({
        includeSelectAllOption: true,
       enableFiltering: true,
       filterBehavior: 'value',
       onChange: function(option, checked, select){
          var ingredients  = $('#select-ingredients option:selected');
          var selected_ingredients = [];
          $(ingredients).each(function(index,ingredient){
            selected_ingredients.push($(this).val())
          })
       }
   });

  $('#add-ingredients').on("click",function(e){
    e.preventDefault();
    ingredients_user = $('.add-ingredients').tagsinput('items');
    var append_array =_.difference(ingredients_user,ingredients_db)


  })    
 


   $('#clickme').on("click",function(e){
      e.preventDefault();
      $('#select-ingredients').multiselect('rebuild');
   });



});