require "pdf/writer"
require 'pdf/simpletable'

class HomeController < ApplicationController
  
  before_filter :supplier_required
  
  def search
    
  end
  
  def do_search
    unless params[:supplier].blank? || params[:supplier][:id].blank?
      @suppliers = current_user.addresses.suppliers.find(params[:supplier][:id])
    else
      flash[:error] = "You havn't selected any suppliers. Please select suppliers first."
      redirect_to :action => "search"
    end
  end
  
  def certification
    
  end
  
  def get_parts_list
    if params[:primary_supplier].blank? || params[:primary_supplier][:id].blank?
      flash[:error] = "You havn't selected primary supplier. Please select your primary supplier."
      redirect_to :action => "certification"
    elsif params[:primary_importer].blank? || params[:primary_importer][:id].blank?
      flash[:error] = "You havn't selected primary importer. Please select your primary importer."
      redirect_to :action => "certification"
    elsif params[:request_type].blank?
      flash[:error] = "Unable to determine your request type. Please select the proper request type"
      redirect_to :action => "certification"
    elsif (params[:request_type] == "balnket" && params[:from_date].blank?)
      flash[:error] = "Please select blanket from date"
      redirect_to :action => "certification"
    elsif (params[:request_type] == "balnket" && params[:end_date].blank?)
      flash[:error] = "Please select blanket end date"
      redirect_to :action => "certification"
    elsif (params[:request_type] == "reference" && params[:reference_code].blank?)
      flash[:error] = "Please enter reference code"
      redirect_to :action => "certification"
    elsif (params[:request_type] == "reference" && params[:reference_number].blank?)
      flash[:error] = "Please enter reference value"
      redirect_to :action => "certification"
    elsif params[:supplier].blank? || params[:supplier][:id].blank?
      flash[:error] = "You havn't selected any suppliers. Please select suppliers first."
      redirect_to :action => "certification"
    else
      @suppliers = current_user.addresses.suppliers.find(params[:supplier][:id])
    end
  end
  
  def confirm_certificate
    #@parts = PartDetail.find(params[:part_id])
  end
  
  def generate_report
    @primary_supplier = Address.find(params[:primary_supplier][:id])
    @primary_importer = Address.find(params[:primary_importer][:id])
    @request_type = params[:request_type]
    @from_date = params[:from_date]
    @end_date = params[:end_date]
    @reference_code = params[:reference_code]
    @reference_number = params[:reference_number]
    @parts = PartDetail.find(params[:part_id])
    send_data get_report, :filename => "certificate.pdf", :type => "application/pdf"
  end
  
  private
  def get_report
    pdf = PDF::Writer.new
    pdf.select_font "Times-Roman" 
    pdf.top_margin = 0
    pdf.bottom_margin = 0
    pdf.font_size = 10
    mid_point = (pdf.absolute_right_margin + pdf.absolute_left_margin)/2

    x = pdf.absolute_left_margin
    y = pdf.absolute_top_margin - 35
    pdf.move_pointer(-10)
    pdf.text "U.S. DEPARTMENT OF HOMELAND SECURITY", :justification => :center
    pdf.add_text (pdf.absolute_right_margin-90, y, "OMB No. 1651-0098", 7)
    
    pdf.text "Bureau of Customs and Border Protection", :font_size=> 12, :justification => :center
    output = "See back of form for Paper- work Reduction Act Notice."
    until output.blank? do
      y -= 12
      output = pdf.add_text_wrap (pdf.absolute_right_margin-120, y, 100, output, 7, :right)
    end
    
    pdf.text "<b>NORTH AMERICAN FREE TRADE AGREEMENT</b>", :font_size=> 14, :justification => :center
    pdf.text "<b>CERTIFICATE OF ORIGIN</b>", :font_size=> 14, :justification => :center
    
    pdf.text "<i>Please print or type</i>", :font_size=> 10, :justification => :left
    
    pdf.text "19 CFR 181.11, 181.22", :font_size=> 11, :justification => :center
    ref_no = (@request_type == "reference")? @reference_number: ""
    pdf.add_text (pdf.absolute_right_margin-175, y-=47, "Bill of Lading / Air Waybill No. :#{ref_no}", 9)
    
    y-=2
    #Exporter Nam & Blanket Period
    pdf.line(pdf.absolute_left_margin, y, pdf.absolute_right_margin, y)
    pdf.add_text(pdf.absolute_left_margin, y-8, "1. EXPORTER NAME AND ADDRESS", 8)
    pdf.add_text(pdf.absolute_left_margin, y-18, @primary_supplier.name, 10)
    output = @primary_supplier.full_address
    counter = y-18
    until output.blank? do
      counter -= 10
      output = pdf.add_text_wrap(pdf.absolute_left_margin, counter, 275, output, 10, :left)
    end
    pdf.add_text(mid_point + 2, y-7, "2. BLANKET PERIOD", 8)
    pdf.line(mid_point, y-20, pdf.absolute_right_margin, y-20)
    pdf.add_text(mid_point+2, y-28, "FROM", 8)
    pdf.add_text(mid_point+2, y-38, (@request_type == "blanket")? @from_date: "", 10)
    pdf.line(mid_point, y-40, pdf.absolute_right_margin, y-40)
    pdf.add_text(mid_point+2, y-48, "TO", 8)
    pdf.add_text(mid_point+2, y-58, (@request_type == "blanket")? @end_date: "", 10)
    pdf.add_text(pdf.absolute_left_margin, y-55, "TAX IDENTIFICATION NUMBER:", 8)
    pdf.add_text(pdf.absolute_left_margin+130, y-55, @primary_supplier.tax_id, 8)
    
    #Producer Name and Importer Name with Tax ID stuff
    pdf.line(pdf.absolute_left_margin, y-60, pdf.absolute_right_margin, y-60)
    pdf.add_text(pdf.absolute_left_margin, y-70, "3. PRODUCER NAME AND ADDRESS", 8)
    pdf.add_text(pdf.absolute_left_margin, y-80, @primary_supplier.name, 10)
    output = @primary_supplier.full_address
    counter = y-80
    until output.blank? do
      counter -= 10
      output = pdf.add_text_wrap(pdf.absolute_left_margin, counter, 275, output, 10, :left)
    end
    pdf.add_text(mid_point+2, y-70, "4. IMPORTER NAME AND ADDRESS", 8)
    pdf.add_text(mid_point+2, y-80, @primary_importer.name, 10)
    output = @primary_importer.full_address
    counter = y-80
    until output.blank? do
      counter -= 10
      output = pdf.add_text_wrap(mid_point+2, counter, 275, output, 10, :left)
    end
    pdf.add_text(pdf.absolute_left_margin, y-130, "TAX IDENTIFICATION NUMBER:", 8)
    pdf.add_text(pdf.absolute_left_margin+132, y-130, @primary_supplier.tax_id, 10)
    pdf.add_text(mid_point+2, y-130, "TAX IDENTIFICATION NUMBER:", 8)
    pdf.add_text(mid_point+132, y-130, @primary_importer.tax_id, 10)
    pdf.line(pdf.absolute_left_margin, y-140, pdf.absolute_right_margin, y-140)
    #End line of producer name box
    
    #Middle line for both the above boxes
    pdf.line(mid_point, y, mid_point, y-140)
    
    #Start of part details box
    
    #Heading section
    pdf.line(pdf.absolute_left_margin, y-142, pdf.absolute_right_margin, y-142)
    pdf.add_text(mid_point-130, y-150, "5.", 8)
    pdf.add_text(mid_point-180, y-160, "DESCRIPTION OF GOOD(S)", 8)
    pdf.add_text(mid_point+60, y-150, "6.", 8)
    pdf.add_text(mid_point+43, y-160, "HS TARIFF", 8)
    pdf.add_text(mid_point+33, y-170, "CLASSIFICATION", 8)
    pdf.add_text(mid_point+52, y-180, "NUMBER", 8)
    pdf.add_text(mid_point+122.5, y-150, "7.", 8)
    pdf.add_text(mid_point+101, y-160, "PREFERENCE", 7)
    pdf.add_text(mid_point+102, y-170, "CRITERION", 8)
    pdf.add_text(mid_point+165.5, y-150, "8.", 8)
    pdf.add_text(mid_point+146, y-160, "PRODUCER", 8)
    pdf.add_text(mid_point+205.5, y-150, "9.", 8)
    pdf.add_text(mid_point+192, y-160, "NET COST", 8)
    pdf.add_text(mid_point+245.5, y-150, "10.", 8)
    pdf.add_text(mid_point+236, y-160, "COUNTRY", 8)
    pdf.add_text(mid_point+236, y-170, "OF ORIGIN", 8)
    
    #Details section
    pdf.line(pdf.absolute_left_margin, y-182, pdf.absolute_right_margin, y-182)
    counter = y-190
    @parts.each do |part|
      counter -= 20
      pdf.add_text(pdf.absolute_left_margin, counter, part.item_description, 10)
      pdf.add_text(mid_point+35, counter, part.hs_tariff_code, 10)
      pdf.add_text(mid_point+105, counter, part.pref_criteria, 10)
      pdf.add_text(mid_point+150, counter, part.producer, 10)
      pdf.add_text(mid_point+195, counter, part.net_cost, 10)
      pdf.add_text(mid_point+240, counter, part.nafta_coo, 10)
    end
    
    
    #Vertical lines in the detaisl box
    pdf.line(mid_point+30, y-142, mid_point+30, y-432)
    pdf.line(mid_point+100, y-142, mid_point+100, y-432)
    pdf.line(mid_point+145, y-142, mid_point+145, y-432)
    pdf.line(mid_point+190, y-142, mid_point+190, y-432)
    pdf.line(mid_point+235, y-142, mid_point+235, y-432)
    
    #Footer for the detials box
    pdf.line(pdf.absolute_left_margin, y-432, pdf.absolute_right_margin, y-432)
    pdf.stroke
    pdf.move_pointer(435)
    pdf.text "I CERTIFY THAT:", :font_size=> 10, :justification => :left
    pdf.text "<C:bullet />THE INFORMATION ON THIS DOCUMENT IS TRUE AND ACCURATE AND I ASSUME THE RESPONSIBILITY FOR PROVING SUCH REPRESENTATIONS.  I UNDERSTAND THAT I AM LIABLE FOR ANY FALSE STATEMENTS OR MATERIAL OMISSIONS MADE ON OR IN CONNECTION WITH THIS DOCUMENT;", :font_size=> 10, :justification => :left
    pdf.text "<C:bullet />I AGREE TO MAINTAIN AND PRESENT UPON REQUEST,  DOCUMENTATION NECESSARY TO SUPPORT THIS CERTIFICATE, AND TO INFORM, IN WRITING, ALL PERSONS OR VALIDITY OF THIS CERTIFICATE;", :font_size=> 10, :justification => :left
    pdf.text "<C:bullet />THE GOODS ORIGINATED IN THE TERRITORY OF ONE OR MORE OF THE PARTIES, AND COMPLY WITH THE ORIGIN REQUIREMENTS SPECIFIED FOR THOSE GOODS IN THE NORTH AMERICAN FREE TRADE AGREEMENT AND UNLESS SPECIFICALLY EXEMPTED IN ARTICLE 411 OR ANNEX PARTIES; AND", :font_size=> 10, :justification => :left
    pdf.text "<C:bullet />THIS CERTIFICATE CONSISTS OF                 PAGES, INCLUDING ALL ATTACHMENTS.", :font_size=> 9, :justification => :left
    pdf.move_pointer(5)
    pdf.line(mid_point, pdf.y-3, mid_point, pdf.y-78)#Vertical Line
    pdf.line(pdf.absolute_left_margin+20, pdf.y-3, pdf.absolute_left_margin+20, pdf.y-78)#Vertical Line
    
    
    pdf.add_text(pdf.absolute_left_margin+5, pdf.y-40, "11.", 8)
    
    pdf.line(pdf.absolute_left_margin, pdf.y-3, pdf.absolute_right_margin, pdf.y-3)
    pdf.add_text(pdf.absolute_left_margin+22, pdf.y-10, "11a.  AUTHORIZED SIGNATURE", 8)
    pdf.add_text(pdf.absolute_left_margin+22, pdf.y-20, current_user.first_name, 10)
    pdf.add_text(mid_point+2, pdf.y-10, "11b. COMPANY", 8)
    pdf.add_text(mid_point+2, pdf.y-20, current_user.company, 10)
    pdf.move_pointer(25)
    pdf.line(pdf.absolute_left_margin+20, pdf.y-3, pdf.absolute_right_margin, pdf.y-3)
    pdf.add_text(pdf.absolute_left_margin+22, pdf.y-10, "11c. NAME (Print or Type)", 8)
    pdf.add_text(pdf.absolute_left_margin+22, pdf.y-20, current_user.full_name, 10)
    pdf.add_text(mid_point+2, pdf.y-10, "11d. TITLE", 8)
    pdf.add_text(mid_point+2, pdf.y-20, current_user.title, 10)
    pdf.move_pointer(25)
    pdf.line(pdf.absolute_left_margin+20, pdf.y-28, pdf.absolute_right_margin, pdf.y-28)
    pdf.line(pdf.absolute_left_margin+20, pdf.y-3, pdf.absolute_right_margin, pdf.y-3)
    pdf.add_text(pdf.absolute_left_margin+22, pdf.y-10, "11e. DATE (MM/DD/YYYY)", 8)
    pdf.add_text(pdf.absolute_left_margin+22, pdf.y-20, "#{Date.today.month}/#{Date.today.day}/#{Date.today.year}", 10)
    pdf.line(mid_point-42, pdf.y-3, mid_point-42, pdf.y-28)#Vertical Line
    pdf.add_text(mid_point-30, pdf.y-10, "11f.", 7)
    pdf.add_text(mid_point-41, pdf.y-18, "TELEPHONE", 7)
    pdf.add_text(mid_point-35, pdf.y-27, "NUMBER", 7)
    pdf.add_text(mid_point+2, pdf.y-10, "<i>(Voice)</i>", 8)
    pdf.add_text(mid_point+2, pdf.y-20, current_user.phone, 10)
    pdf.line(10+(mid_point+pdf.absolute_right_margin)/2, pdf.y-3, 10+(mid_point+pdf.absolute_right_margin)/2, pdf.y-28)#Vertical Line
    pdf.add_text(10+(mid_point+pdf.absolute_right_margin)/2, pdf.y-10, "<i>(Facsimile)</i>", 8)
    pdf.add_text(10+(mid_point+pdf.absolute_right_margin)/2, pdf.y-20, current_user.fax, 10)
    pdf.move_pointer(25)
    pdf.line(pdf.absolute_left_margin, pdf.y-3, pdf.absolute_right_margin, pdf.y-3)
        
    pdf.stroke
    pdf.text "<b>CBP Form 434 (04/97)</b>", :font_size=> 10, :justification => :right
    
    #pdf.start_new_page
    #str = pdf.render
    #puts <<-EOS
     # Content-Type: application/pdf
     # Size: #{str.size}
    #EOS
    #puts str
    pdf.render
  end
  
end