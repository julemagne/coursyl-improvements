module LessonsHelper

  def level_color(depth)
    ["#006699",
     "#1774A2",
     "#2E82AC",
     "#4690B5",
     "#5D9EBE",
     "#74ACC7",
     "#8BB9D1",
     "#A2C7DA",
     "#B9D5E3",
     "#D1E3EC",
     "#E8F1F6"][[depth, 9].min]
  end
end
