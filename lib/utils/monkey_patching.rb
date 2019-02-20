class Hash
  def symbolize_keys
    clone.tap do |hash|
      hash.keys.each do |key|
        hash[(key.to_sym rescue key) || key] = hash.delete(key) # rubocop:disable Style/RescueModifier
      end
    end
  end
end
