class VotesController < ApplicationController
  load_and_authorize_resource
  #   before_filter :one_vote, :only => [:vote]
  # before filter needs to know that this contest is open for voting

  def vote
    song = Song.find(params[:id])
    render :json => Vote.create.add_vote(current_user, song)
  end


end