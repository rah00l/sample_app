class HomeController < ApplicationController

  def index

  	respond_to do |format|
      format.html
       format.pdf do
        	pdf = Prawn::Document.new
        	send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end


  end
end
