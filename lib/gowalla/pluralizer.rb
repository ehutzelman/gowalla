if !String.method_defined?(:pluralize)

  class String
    puts 'defining pluralize'
    def pluralize
      case self[self.length - 1]
        when 'y' then self[0..self.length - 2] + 'ies'
        when 's' then self
        else self + 's'
      end
    end
  end

end
