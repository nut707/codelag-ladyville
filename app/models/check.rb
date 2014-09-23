class Check < ActiveRecord::Base
	validates :name, presence: true
	validates :date_buy, presence:  true
	validates :phone_number, presence:  true
	validates :number_check, presence:  true
	validates :buy_point, presence: true, uniqueness: { scope: :number_check,
	  message: "Такой номер чека был уже зарегистрирован" }
	
	def self.search(params)
		check = Check.all.order("part_number")
		if ((winner = params[:winner]) == true)
			check = check.where.not(winner: "")
		end
		check
	end

	def self.numirate
		i = 1
		Check.all.order("reg_date").each do |check|
			check.part_number = i
			i = i + 1
			check.save
		end
	end

	def self.call_winner
		Check.all.order("part_number").each do |check|
			if ((check.part_number % 2014) == 0)
				check.update(winner: "2014")
			elsif ((check.part_number % 1000) == 0)
				check.update(winner: "1000")
			elsif ((check.part_number % 500) == 0)
				check.update(winner: "500")
			elsif ((check.part_number % 100) == 0)
				check.update(winner: "100")
			elsif ((check.part_number % 50) == 0)
				check.update(winner: "50")
			end
			check.save
		end
	end						
end