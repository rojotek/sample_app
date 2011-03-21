# lib/password_validator.rb
class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    @regexes = [/[A-Z]/,/[a-z]/,/[0-9]/]
    @regexes.each do |regex|
      unless value =~ regex
        record.errors[attribute] << (options[:message] || "is not valid") 
      end
    end
  end
end
