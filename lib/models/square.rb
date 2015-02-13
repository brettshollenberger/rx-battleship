require_relative "./concerns/mass_insertable"

class Square < ActiveRecord::Base
  include MassInsertable

  belongs_to :board
  belongs_to :ship

  def location
    "#{x}#{y}"
  end

  def empty?
    ship_id.nil?
  end
end
