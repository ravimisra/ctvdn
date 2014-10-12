class Package < ActiveRecord::Base
  attr_accessible :channels, :name, :price
  serialize :channels, Array

  before_save :correct_data_types
  
  def has_channel?(channel)
    self.channels.include?(channel.id)
  end
  
  def get_channels
    Channel.where(id: self.channels)
  end
  
  def set_channels=(channels=[])
    self.channels = channels.collect(&:id)
  end
  
  
  def correct_data_types
    self.channels = self.channels.map{|a| a.to_i}
  end
  
end
