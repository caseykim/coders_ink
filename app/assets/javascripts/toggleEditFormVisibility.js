$(function(){
  $(".button-edit-form").on("click", function(){
    var $fieldset = $(this).closest(".content");
    var $form = $fieldset.find(".editform");
    $form.toggleClass("hide");
  });
});
