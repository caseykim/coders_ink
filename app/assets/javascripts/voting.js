$(".upvote").on("click", function(event) {
  event.preventDefault();
  var reviewId = this.parentElement.parentElement.parentElement.id;
  var $t = $(this).parent().parent();
  $.ajax({
    method: "POST",
    url: ("/reviews/" + reviewId + "/upvote"),
    data: { review_id: reviewId },
    dataType: "json"
  })
  .done(function(data){
    $($t.siblings("#score")).text(data);
  })
});

$(".downvote").on("click", function(event) {
  event.preventDefault();
  var reviewId = this.parentElement.parentElement.parentElement.id;
  var $t = $(this).parent().parent();
  $.ajax({
    method: "POST",
    url: ("/reviews/" + reviewId + "/downvote"),
    data: { review_id: reviewId },
    dataType: "json"
  })
  .done(function(data){
    $($t.siblings("#score")).text(data);
  })
});
