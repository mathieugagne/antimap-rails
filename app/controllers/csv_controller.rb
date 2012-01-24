class CsvController < ApplicationController
  
  require 'csv'
  
  def import
  end
  
  def upload
    data = params[:upload][:csv].read
    points = CSV.parse(data)
    
    log = Log.create(:filename => params[:upload][:csv].original_filename, :points => points)
    
    redirect_to log_path(log)
  end
end
