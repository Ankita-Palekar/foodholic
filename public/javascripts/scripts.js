$(document).ready(function(){
	$('.bootstrap-tagsinput').addClass('input-block-level')
	$('#create-category').on("click",function(){
		 console.log($('input#category-list').tagsinput('items')) 
	})
})