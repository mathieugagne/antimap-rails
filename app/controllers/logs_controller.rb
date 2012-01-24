class LogsController < ApplicationController
      
  # GET /logs
  # GET /logs.json
  def index
    @logs = Log.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logs }
    end
  end
  
  # GET /logs/1
  # GET /logs/1.json
  def show
    @log = Log.find(params[:id])
    @path = [@log.path.to_polyline].to_json if @log.path
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @log }
    end
  end

  # GET /logs/new
  # GET /logs/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @log }
    end
  end

  # DELETE /logs/1
  # DELETE /logs/1.json
  def destroy
    @log = Log.find(params[:id])
    @log.destroy

    respond_to do |format|
      format.html { redirect_to logs_url }
      format.json { head :no_content }
    end
  end
end
