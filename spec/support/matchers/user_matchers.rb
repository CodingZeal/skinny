RSpec::Matchers.define :have_permission_to do |action, object|
  match do |subject|
    subject.permissions.detect do |set|
      set[0] == action and set[1] == object
    end
  end

  description do
    "have the permission to #{action} #{object.inspect}"
  end

  # failure_message_for_should do |subject|
  #   "expected #{subject.inspect} to have permission to #{action} #{object.inspect}"
  # end
end