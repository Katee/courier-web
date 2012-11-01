module MarkerHelper
  def marker_icon(i = 0, has_package = false)
    if i.nil?
      "https://chart.googleapis.com/chart?chst=d_map_pin_icon&chld=stare|ffffff"
    else
      char = 65 + i
      if has_package
        "https://chart.googleapis.com/chart?chst=d_map_xpin_letter&chld=pin_star|#{char.chr}|000000|ffffff|eeeeee"
      else
        "https://chart.googleapis.com/chart?chst=d_map_pin_letter&chld=#{char.chr}|000000|ffffff"
      end
    end
  end
end
