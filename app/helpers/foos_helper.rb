module FoosHelper
  def get_division_title(player)
    player.division_title ? player.division_title : "Division #{player.division}"
  end
end
