$(function() {
  $('#song_spy_url').val('');
  $('#song_spy_url').on('input', get_song_info);
  $('.vote').on('click','button', cast_vote);
  var date = moment('20130315', 'YYYYMMDD').fromNow();
  $('#duedate').append(date);
  $('#contest_start_date, #contest_end_date').datepicker();
  $('#contest_start_time, #contest_end_time').timepicker();
  $('.loader').hide();
});


function get_song_info()
{
  $('.loader').show();
  $('#song_spy_url').hide();
  $('.title').text('');
  $('.artist').text('');
  var url = $('#song_spy_url').val();
  var pattern = /[0-9A-Za-z]*$/;
  var spy_id = url.match(pattern);
  fetch_data(spy_id);
}

function fetch_data(spy_id)
{
    $.ajax({
    dataType: 'json',
    type: "get",
    url: "/search/" + spy_id
  }).done(show_song);

  return false;
}

function show_song(data)
{
  $('.loader').hide();
  var title = data.title;
  var artist = data.artist;
  var album_art = data.album_art;
  var spy_id = data.spy_id;
  $('.title').append(title);
  $('.artist').append(artist);
  $('.album_art').append().html("<img src=" + album_art + " />");
  $('#song_box').slideDown(1000);
  $('#song_spy_url').show().val('');
  $('#add_song_button').show();

  song["title"] = title;
  song["artist"] = artist;
  song["spy_id"] = spy_id;

  $('#selected_song').attr('value', song['spy_id']);
  $('.draganddrop').hide();
  $('.sweet_track').show();

}

function cast_vote()
{
  // this is shit. will use .find() or .closest() when i have time to refactor
  var song_id = $(this).parent().parent().parent().children(':nth-child(2)').text();
  var selected = $(this).parent().parent().children(':nth-child(2)');

  $('.vote .button').hide();
  selected.removeClass('hide');

    $.ajax({
      dataType: 'json',
      type: "post",
      url: "/contests/" + contest_id + "/songs/" + song_id + "/vote"
    }).done(confirm_fe);


  return false;

}

function confirm_fe()
{
  console.log("vote cast");
}