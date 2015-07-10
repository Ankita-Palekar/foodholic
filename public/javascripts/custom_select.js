$(document).ready(function() {
  var ingredients_db = Array();
  var ingredients_db_id = Array();
  var ingredients_user=Array();
  var ingredients = Array(); // added to multiselect

  function object_to_array (object) {
    return _.map(object,function(component){return component["ingredient"]["name"]})
  }

  function make_array_multiselect (array) {
    return _.map(array,function(item){return {label: item, value: val}})
  }

  function make_array_selected_multiselect (array) {
     return _.map(array,function(item){return {label: item, value: val, selected:true}})
  }

  function make_key_value(array){
    return _.object(_.map(array,function(a){return a["ingredient"]["id"]})
        ,_.map(array,function(a){return a["ingredient"]["name"]}))
  }

    // TODO later convert it to mustache
  function make_option_template (array) {
    var option_string = "";
    for (var i = array.length - 1; i >= 0; i--) {
      option_string = option_string + "<option " + "value='" + array[i]+"' selected='true'>"+ array[i] +"</option>"
    };
    return option_string
  }

    $.ajax({
      method: "GET",
      url: "/ingredients"
    }).done(function(json) {
        ingredients_object = $.parseJSON(json)
        ingredients_db = object_to_array(ingredients_object)
        ingredients_array  = $.map(ingredients_object,function(item){
           val = item["ingredient"]["name"]
          return {label: val, value: val}
        }); 
        // assign db ingredients to the hidden variable
         ingredients_db_id = make_key_value(ingredients_object)
        $('input#db-ingredients').val(JSON.stringify(ingredients_db_id));
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
    var append_array = _.difference(ingredients_user,ingredients_db)
    var append_string = make_option_template(append_array)
    $('#select-ingredients').prepend(append_string);
    $('#select-ingredients').multiselect('rebuild');
    $('.add-ingredients').tagsinput('removeAll');
  })    
});