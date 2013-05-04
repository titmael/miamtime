# encoding: utf-8
class VotesController < ApplicationController
  def create
    nbminutes = Rails.application.config.can_vote_after_x_minutes
    diffdate = Time.zone.now - nbminutes.minutes
    already_voted = !Vote.where("username = ? AND created_at >= ?", session[:session_id], diffdate).empty?;

    if !already_voted
      @vote = Vote.new()
      @vote.username = session[:session_id]

      option = Option.find(params[:option])
      @vote.option = option

      if @vote.save
        nbminutes = Rails.application.config.can_vote_after_x_minutes
        cookies["#{params[:hash_url]}"] = {:value => "voted", :expires => Time.zone.now + nbminutes.minutes}
      end
    end
    redirect_to show_survey_path(:hash_url => params[:hash_url])
  end
end
