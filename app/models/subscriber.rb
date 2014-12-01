class Subscriber < ActiveRecord::Base
  attr_accessible :address, :channels, :cycle_starts_on, :name, :packages, :smartcard_number, :status, :subscription_amount
  has_many :payments
  serialize :packages, Array
  serialize :channels, Array
  
  before_save :correct_data_types
  
  ACTIVE = 1
  INACTIVE = 0
  
  def get_last_payment
    payment = Payment.where(:subscriber_id => self.id).order('id DESC').first
    return payment
  end
  
  def has_package?(package)
    return self.packages.include?(package.id)
  end

  def get_packages
    Package.where(id: self.packages)
  end
  
  def set_packages=(packages=[])
    self.packages = packages.collect(&:id)
  end

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
    self.packages = self.packages.map{|a| a.to_i}
    self.channels = self.channels.map{|a| a.to_i}
  end
  

end
