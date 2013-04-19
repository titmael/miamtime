# encoding: utf-8
class SurveysController < ApplicationController
  def new
  	@survey = Survey.new
    @survey.options.build
  end

  def create
  	@survey = Survey.new(params[:survey])

		if @survey.save
			redirect_to :action => "show", :id => @survey.id
		else
			render :action => "new"
		end
  end

  def show
  	@survey = Survey.find(params[:id])

  	respond_to do |format|
  		format.html # show.html.erb
  	end
  end
end
