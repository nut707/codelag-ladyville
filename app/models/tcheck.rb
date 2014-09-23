class Tcheck < ActiveRecord::Base
	validates :name, presence:  { message: "Необходимо ввести ваше имя"}
	validates :date_buy, presence:  { message: "Необходимо выбрать дату покупки"}
	validates :phone_number, presence:  { message: "Необходимо ввести номер телефона"}
	validates :phone_number, length: { minimum: 10, message: "Необходимо ввести федеральный(полный) номер телефона"}
	validates :number_check, presence:  { message: "Необходимо ввести номер чека"}
	validates :buy_point, presence: true, uniqueness: { scope: :number_check,
	  message: "Такой номер чека был уже зарегистрирован" }
	validate :checkValidate
	attr_accessor :end_date, :start_date
	
	def self.search(params)
		tcheck = Tcheck.all
		unless (buy_point = params[:buy_point]).blank?
			tcheck = tcheck.where(buy_point: buy_point)
		end
		if !((date = params[:date_buy]).blank?)
			date = DateTime.parse(date)
			date = date.in_time_zone(ActiveSupport::TimeZone.new('Vladivostok'))
			tcheck = tcheck.where(created_at: date.beginning_of_day..date.end_of_day)
		else
			date = DateTime.now
			date = date.in_time_zone(ActiveSupport::TimeZone.new('Vladivostok'))
			tcheck = tcheck.where(created_at: date.prev_day(7).beginning_of_day..date.end_of_day)
		end
		tcheck
	end

	def self.searchDates(params)
		tcheck = Tcheck.all
		buy_point = params[:buy_point]
		tcheck = tcheck.where(buy_point: buy_point)
		start_date = DateTime.parse(params[:start_date]).in_time_zone(ActiveSupport::TimeZone.new('Vladivostok'))
		end_date = DateTime.parse(params[:end_date]).in_time_zone(ActiveSupport::TimeZone.new('Vladivostok'))
		tcheck = tcheck.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
		tcheck
	end


	def checkValidate
		if buy_point == "1"
			if number_check.to_i <= 13999
				errors.add(:number_check, "Неправильный номер чека")
			end
		elsif buy_point == "2"
			if number_check.to_i <= 12323
				errors.add(:number_check, "Неправильный номер чека")
			end
		elsif buy_point == "3"
			if number_check.to_i <= 21244
				errors.add(:number_check, "Неправильный номер чека")
			end
		elsif buy_point == "4"
			if number_check.to_i <= 3411
				errors.add(:number_check, "Неправильный номер чека")
			end
		elsif buy_point == "5"
			if number_check.to_i <= 9341
				errors.add(:number_check, "Неправильный номер чека")
			end
		elsif buy_point == "6"
			if number_check.to_i <= 14476
				errors.add(:number_check, "Неправильный номер чека")
			end
		elsif buy_point == "7"
			if number_check.to_i <= 35614
				errors.add(:number_check, "Неправильный номер чека")
			end
		elsif buy_point == "8"
			if number_check.to_i <= 13594
				errors.add(:number_check, "Неправильный номер чека")
			end
		elsif buy_point == "9"
			if number_check.to_i <= 689
				errors.add(:number_check, "Неправильный номер чека")
			end
		end
	end
end

