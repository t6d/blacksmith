RSpec::Matchers.define :have_property do |expected|
  match do |subject|
    subject.class.properties.has_key?(expected.to_sym)
  end

  description do
    "have property #{expected}"
  end

  failure_message_for_should do |subject|
    "expected a property named #{expected} but there is none"
  end

  failure_message_for_should_not do |subject|
    "expected no property named #{expected} but there is one"
  end
end