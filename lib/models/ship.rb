class Ship < ActiveRecord::Base
  belongs_to :board

  class << self
    def types
      {
        :carrier     => 5,
        :battleship  => 4,
        :submarine   => 3,
        :destroyer   => 3,
        :patrol_boat => 2,
      }
    end

    def names
      types.keys
    end
  end

  def length
    Ship.types[name.to_sym]
  end
end
