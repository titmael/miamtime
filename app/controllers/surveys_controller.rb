# encoding: utf-8
class SurveysController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :not_foud

  def not_foud
    render file: "public/404.html", status: 404, layout: false
  end

  def new
  	@survey = Survey.new
    @survey.options.build
    render "new_edit"
  end

  def create
  	@survey = Survey.new(params[:survey])

    begin
      DateTime.parse(params[:survey][:when_date])
    rescue
      flash[:notice] = "La date du miam time n'est pas correcte"
      render :action => "new"
      return
    end
    begin
      DateTime.parse("#{params[:survey][:end_votes]} #{params[:survey][:end_text]}")
    rescue
      flash[:notice] = "La date/heure de fin de vote n'est pas correcte"
      render :action => "new"
      return
    end

    @survey.options.delete_if {|o| o.locality.empty?}

		if @survey.save
			redirect_to show_survey_path(:hash_url => @survey.hash_url)
		else
      if @survey.options.length == 0
        @survey.options.build
      end
			render :action => "new"
		end
  end


  def show
    @survey = Survey.where(hash_url: params[:hash_url]).first
    nbminutes = Rails.application.config.can_vote_after_x_minutes
    diffdate = Time.zone.now - nbminutes.minutes
    @already_voted = cookies["#{params[:hash_url]}"] != nil || !@survey.options.joins(:votes).where("votes.username = ? AND votes.created_at >= ?", session[:session_id], diffdate).empty?;
  end

  def edit
    if session[:logged_for] != nil && session[:logged_for].include?(params[:id])
      @survey = Survey.find(params[:id])
      render "new_edit"
    else
      @id = params[:id]
      render "edit_login"
    end
  end

  def edit_login
    survey = Survey.find(params[:id])
    if survey.password.to_s == params[:password].to_s
      if session[:logged_for] == nil
        session[:logged_for] = Array.new
      end
      session[:logged_for].push(params[:id])
    end
    redirect_to new_survey_path(:id => params[:id])
  end

  def update
    @survey = Survey.find(params[:id])

    all_destroy = true

    if params[:survey][:options_attributes] != nil
      params[:survey][:options_attributes].each do |o|
        opt = o.second
        if opt[:_destroy] != "1"
          all_destroy = false
        end
      end
    end
    if all_destroy
      flash[:notice] = "Vous devez avoir au moins une option non vide"
      render :action => "edit"
    else
      @survey.delete(:password) if @survey[:password].blank?
      @survey.delete(:hash_url) if @survey[:hash_url].blank?

      if @survey.update_attributes(params[:survey])
        params[:survey][:options_attributes].each do |o|
          opt = o.second
          if opt[:_destroy] == "1"
            option = Option.find(opt[:id])
            Vote.where(:option_id => option[:id]).destroy_all
            option.destroy
          end
        end
        redirect_to show_survey_path(:hash_url => @survey.hash_url)
      else
        if @survey.options.length == 0
          @survey.options.build
        end
        render :action => "edit"
      end
    end
  end

  def index
    @surveys = Survey.all
  end

  respond_to :json
  def search_cities
    if params[:search] != nil
      cities = Ville.limit(10).select("id, nom_ville, code_postal").where("lower(nom_ville) like lower(?)", "#{params[:search]}%").order("nom_ville ASC")
    else
      cities = Ville.limit(10, :select => 'id, nom_ville, code_postal').order("nom_ville ASC")
    end
    respond_with(cities)
  end
end
