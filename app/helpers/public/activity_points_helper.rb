module Public::ActivityPointsHelper
  def sort_order(column, created_at, hash_param = {})
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to created_at, { sort: column, direction: direction }.merge(hash_param), class: "sort_header #{css_class}"
  end
end
