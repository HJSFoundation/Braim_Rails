$("#testModal").modal('hide');
$("#songTest").html("<%= j render partial: 'recommendations/song_test', locals: {song: @song}%>");
$(".starrr").starrr();
$('#stars').on('starrr:change', function(e, value) {
  var song_id;
  song_id = $("#song-info").data("song-id");
  return $.ajax({
    url: '/songs/rate',
    type: 'post',
    dataType: 'json',
    success: function(data) {
      console.log("success");
      console.log(data.rating);
      $('#count').html(value);
    },
    data: {
      song_id: song_id,
      rating: value
    }
  });
});