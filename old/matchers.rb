#Custom mathers

Spec::Matchers.define :have_command do |command|
  match do |object|
    object.commands.include? command and object.methods.include? command.to_s
  end
end

Spec::Matchers.define :be_between do |from, to|
  match do |value|
    value >= from and value <= to
  end
end
