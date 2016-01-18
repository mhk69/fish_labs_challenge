class TypeChecker
	ALL_TYPES_BY_INDEX = {}
	ALL_TYPES_BY_STRING = {}

	def self.register_type(symbol, index, string)
		TypeChecker.const_set(symbol, string)
		ALL_TYPES_BY_INDEX[index] = string
		ALL_TYPES_BY_STRING[string] = index
	end

	TypeChecker.register_type(:FIRE, 1, 'fire')
	TypeChecker.register_type(:WATER, 2, 'water')
	TypeChecker.register_type(:EARTH, 3, 'earth')
	TypeChecker.register_type(:ELECTRIC, 4, 'electric')
	TypeChecker.register_type(:WIND, 5, 'wind')

	def self.convert_to_index(string)
		ALL_TYPES_BY_STRING[string]
	end

	def self.convert_to_string(index)
		ALL_TYPES_BY_INDEX[index]
	end
end