class Ship < ActiveRecord::Base
  belongs_to :board

  class << self
    def names
      %w(carrier battleship submarine destroyer patrol_boat)
    end
  end
end
