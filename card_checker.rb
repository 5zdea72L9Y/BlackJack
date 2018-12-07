# check card points
module CardChecker
  def self.included(base)
    base.include InstanceMethods
  end

  # instance methods
  module InstanceMethods
    # toggle points
    @@points = 0
    def toggle(points)
      if points.zero?
        point = 1
        @@points = 1
        @@points += points - 1
      else
        @@points += points
      end
    end

    # check card points
    def check_card_point(card)
      # check if card has a number value
      if card.to_i > 0
        points = card.to_i
        @@points = points
      elsif %w[J Q K].include?(card)
        # check ace or (Q, J, K)
        points = 10
        @@points = points
      else
        # check points of ace
        card_points = toggle(0)
        points = 1 if card_points.to_i + 11 > 21
        points = 11 if card_points.to_i + 11 < 21
        @@points = points
      end
    end
  end
end
