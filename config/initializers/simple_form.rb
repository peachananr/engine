# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|

  config.custom_inputs_namespaces << 'Locomotive'

  config.boolean_style = :nested

  config.label_text = lambda { |label, required, explicit_label| "#{} #{label}" }

  
end
