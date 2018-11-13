class SeasonUserValues

  UserValue = Struct.new(:value, :shares) do
  end

  ShareValue = Struct.new(:value, :name, :amount) do
  end

  Delta = Struct.new(:d0, :d1) do
  end

  attr_reader :values

  def self.create_from_season(season)
    season_user_values = SeasonUserValues.new
    UserSeason.where(season: season).find_each do |user_season|
      season_user_values.values[user_season.id] = self.create_user_value_from_user_season(user_season)
    end
    season_user_values
  end

  def initialize
    @values = {}
  end

  def diff(initial_values)
    delta_user_values = {}
    initial_values.values.each do |user_season_id, initial_user_value|
      delta_user_values[user_season_id] = Delta.new(initial_user_value, @values[user_season_id])
    end
    delta_user_values.select do |user_season_id, delta|
      delta.d0.value != delta.d1.value
    end
  end

  private

  def self.create_user_value_from_user_season(user_season)
    shares = {}
    user_season.shares.each do |share|
      shares[share.id] = ShareValue.new(share.get_current_value, share.player.name, share.amount)
    end
    UserValue.new(user_season.get_total_value, shares)
  end

end
