module LessonsHelper

  def level_opacity(depth)
    [1.0-depth.to_f/15, 0.2].max
  end
end
