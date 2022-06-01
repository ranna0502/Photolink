class Batch::DataReset
  def self.data_reset
    @activity_points = ActivityPoint.all.where("date <= ?", Date.yesterday)
    @activity_points.delete_all
    p "前日の活動拠点を全て削除しました"
  end
end