# frozen_string_literal: true

module Accessor
  def node_attr_reader(var)
    define_method var.to_s do
      instance_variable_get("@#{var}")
    end
    # define_method "#{var}=" do |val|
    #   instance_variable_set("@#{var}", val)
    # end
  end
end

class A
  extend Accessor

  node_attr_reader :name

  def initialize(name)
    self.name = name
  end

  def fom(var)
    self.name = var
  end
end

a = A.new("asd")
puts a.name
# a.fom(1)
# puts a.name
