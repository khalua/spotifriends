class SongsController < ApplicationController
  load_and_authorize_resource

  before_filter :get_contest, :except => [:get_song_info]
  before_filter :one_song, :only => [:new, :create]


  def index
    @songs = @contest.songs
  end

  def new
    @song = Song.new
    @song = @contest.songs.build
  end

  def create
    @song = Song.create(params[:song])
    @song.users << current_user
    @contest.songs << @song
    redirect_to(@contest)
  end

  def get_song_info
    s1 = Song.new
    song = s1.get_song_info(params['spy_id'])
    begin
      render :json => {title:song['title'], artist:song['artist'], album_art:song['album_art'], spy_id:song['spy_id']}
    rescue
      render :json => {title: 'oh oh. Spotify is busted!'}
    end

  end

  private
  def get_contest
    @contest = Contest.find(params[:contest_id])
  end

  def one_song
    redirect_to(@contest) if current_user.in?(@contest.entries)
  end

end