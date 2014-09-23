class CheckImport
	extend ActiveModel::Model
	include ActiveModel::Conversion
	include ActiveModel::Validations

	attr_accessor :file

	def initialize(attributes = {})
		attributes.each {|name, value| send("#{name}=",value)}
	end

	def persisted?
		false
	end

	def save
		imported_checks.each do |check|
			if check.valid?
				tcheck = Tcheck.all
				tcheck = tcheck.where(buy_point: check.buy_point)
				tcheck = tcheck.where(number_check: check.number_check)
				unless tcheck.last == nil
					check.reg_date = tcheck.last.created_at
					check.save
				end
			end
		end
		true
	end

	def imported_checks
		@imported_checks ||= load_imported_checks
	end

	def load_imported_checks
		sheet = open_spreadsheet
		checks = []
		header = ['date_buy','name','buy_point','phone_number','number_check']
		(2..sheet.last_row).each do |i|
			row = Hash[[header, sheet.row(i)].transpose]
			parameters = ActionController::Parameters.new(row)
			check = Check.new(parameters.permit(:name, :buy_point, :date_buy, :phone_number, :number_check))
			checks << check
		end
		checks
	end

	def open_spreadsheet
	  filename = rename_uploaded_file file
	  case File.extname(file.original_filename)
	    when ".xls" then Roo::Excel.new(filename, nil, :ignore)
	    when ".xlsx" then Roo::Excelx.new(filename, nil, :ignore)
	    else raise "Unknown file type: #{file.original_filename}"
	  end
	end

	private

	def rename_uploaded_file(file)
	  begin
	    new_file = File.join File.dirname(file.path), file.original_filename
	    File.rename file.path, new_file
	  rescue SystemCallError => error
	    return error.to_s
	  end
	  return new_file
	end
end