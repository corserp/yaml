module Kinda
  module Core
    def inspect(*args)
      if %w[Bignum Class Complex Date DateTime FalseClass Fixnum Float
          Integer NilClass Numeric Range Rational Regexp String Symbol
          Time TrueClass].include?(self.class.name)
        super()
      else
        result = '#<'
        result += "#{self.class}:#{object_hexid}"
        items = args.map do |arg|
          "#{arg}=#{send(arg).inspect}" if respond_to?(arg)
        end.compact
        result += ' ' + items.join(', ') if !items.empty?
        result += '>'
        result
      end
    end
  end
end