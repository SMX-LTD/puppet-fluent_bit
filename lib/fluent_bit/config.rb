# Generates Fluent-bit configuration from a Hash.
#
# @note This file must be compatible with Ruby 1.8.7 in order to work on EL6.

module FluentBitConfig
  class << self
    # Generates Fluent-bit configuration from a Hash.
    #
    # @param config [Hash] the configuration
    # @return [String] the Fluentd configuration
    def generate(config)
      config.map { |_, c| render(c) }.join
    end

    private

    def render(c)
      "[#{c["service"].upcase}]\n" + \
      c.select{ |e| e !="service" }
       .map { |k, v|
          key = k.strip.downcase
          padding = 15 - key.length
          padding = padding < 1 ? 1 : padding
          if v.kind_of?(Array)
            mapped = v.map { |vv|
              "  " << key << " "*padding << vv
            }.join("\n")
          else
            mapped = "  " << key << " "*padding << v
          end
          mapped
       }
       .join("\n")
       .concat("\n")
    end
  end
end
