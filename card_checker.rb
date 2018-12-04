# check card points
module CardChecker
  def self.included(base)
    base.include InstanceMethods
  end

  # instance methods
  module InstanceMethods
    # check card point
    def check_card_point(card)
      # check if card has a number value
      if card.to_i > 0
        points = card.to_i
        count_points(points)
      elsif %w[J Q K].include?(card)
        # check ace or (Q, J, K)
        points = 10
        count_points(points)
      else
        # check points of ace
        card_points = @card_points
        points = 1 if card_points.to_i + 11 > 21
        points = 11 if card_points.to_i + 11 < 21
        count_points(points)
      end
    end

    def valid?
      validate_card_points!
      true
    rescue StandardError
      false
    end

    private

    def validate_card_points!
      raise @card_points.zero?
    end

    # set toggle points
    def count_points(points)
      toggle_points = nil.to_i
      toggle_points += points
      @card_points += toggle_points
    end
  end
end
