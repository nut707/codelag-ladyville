class ReportsController < ApplicationController
	include SessionsHelper
	before_filter :signed_in_user

	def index
	  @check_import = CheckImport.new
	  @tcheck_export = Tcheck.new
	  @check_1 = Tcheck.search({:buy_point => "1"})
	  @check_2 = Tcheck.search({:buy_point => "2"})
	  @check_3 = Tcheck.search({:buy_point => "3"})
	  @check_4 = Tcheck.search({:buy_point => "4"})
	  @check_5 = Tcheck.search({:buy_point => "5"})
	  @check_6 = Tcheck.search({:buy_point => "6"})
	  @check_7 = Tcheck.search({:buy_point => "7"})
	  @check_8 = Tcheck.search({:buy_point => "8"})
	  @check_9 = Tcheck.search({:buy_point => "9"})
	  @points = ['Владивосток, бизнес-центр "Фреш-Плаза", Океанский пр-т, 17', 'Владивосток, Торговый дом "Игнат", Комсомольская, 13', 'Владивосток, Остановка "Постышева", пр-т 100 лет Владивостоку, 68а', 'Уссурийск, ул. Горького, 67', 'Уссурийск, ул. Суханова, 55', 'Находка, пр-т Мира, 18', 'Находка, Торговый дом Купеческий, ул. Сидоренко, 1, стр 12', 'Находка, Стадион "Приморец", ул. Спортивная, 2', 'Спасск-Дальний, ул. Надреченская, 27']
	end

	def export
	   @tcheck_export = Tcheck.searchDates(export_params)
	   if !@tcheck_export.blank?
	   	  respond_to do |format|
	   	   format.xls {
	   	 	  filename = "check-#{Time.now.strftime("%Y%m%d")}.xls"
	   	 	  send_data(@tcheck_export.to_xls(:except => [:id, :date_registration, :created_at, :updated_at], :header_columns => ["Дата покупки","Имя Фамилия","Точка покупки","Телефонный номер", "Номер чека"]), :type =>"application/excel; charset=utf-8; header=present", :filename => filename)
	   	  }
	      end
	  else
	  	flash.clear
	  	flash[:error] = 'Записи не обнаружены'
	  	redirect_to reports_path
	   end
	end

	def import
	  @check_import = CheckImport.new(post_params)
	  if @check_import.save
	  	flash.clear
	  	flash[:error] = 'Импорт выполнен'
		redirect_to reports_path
	  end
	end

	private
	def export_params
		params.require(:tcheck).permit(:buy_point,:start_date,:end_date)
	end
   	def post_params
   		params.require(:check_import).permit(:file)
  	end
end
