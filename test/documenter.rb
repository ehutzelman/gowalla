class Documenter
  @output = 'examples.md'
  File.delete(@output) if File.exist?(@output)

  File.open(@output, 'w') do |f|
    f.puts "# Gowalla Method Examples"
  end

  def self.generate_doc(method_sig, result)
    File.open(@output, 'a') do |f|
      f.puts "### " + method_sig, "    " + result.to_s, "\n\n"
    end
  end
end

module Gowalla
  class Client
    alias :original_missing :method_missing
    def method_missing(symbol, *arguments)
      result = original_missing(symbol, *arguments)
      method_sig = "@client.#{symbol}(#{arguments.join(', ')})"
      Documenter.generate_doc method_sig, result.is_a?(Array) ? result.first : result
      result
    end
  end
end

