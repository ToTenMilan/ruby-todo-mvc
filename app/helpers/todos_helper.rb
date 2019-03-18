module TodosHelper
	def humanize(bool)
		check = "\u2713".green
		cross = "\u274C".red
		bool ? check : cross
	end
end