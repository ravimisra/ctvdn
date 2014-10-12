class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation, :status, :roles
  serialize :roles, Array
  validates :name, presence: true, uniqueness: true
  has_secure_password
  
  has_many :payments, class_name: Payment, foreign_key: :agent_id, inverse_of: :agent
    
  CAN_LIST_USERS          = 1001
  CAN_ADD_USERS           = 1002
  CAN_DELETE_USERS        = 1003
  CAN_MODIFY_USERS        = 1004

  CAN_LIST_SUBSCRIBERS    = 2001
  CAN_ADD_SUBSCRIBERS     = 2002
  CAN_DELETE_SUBSCRIBERS  = 2003
  CAN_MODIFY_SUBSCRIBERS  = 2004

  CAN_LIST_PAYMENTS       = 3001
  CAN_ADD_PAYMENTS        = 3002
  CAN_DELETE_PAYMENTS     = 3003
  CAN_MODIFY_PAYMENTS     = 3004

  CAN_LIST_AGENTS         = 4001
  CAN_ADD_AGENTS          = 4002
  CAN_DELETE_AGENTS       = 4003
  CAN_MODIFY_AGENTS       = 4004
  
  CAN_LIST                = 1
  CAN_ADD                 = 2
  CAN_DESTROY             = 3
  CAN_EDIT                = 4
  
  USERS                   = 1000
  SUBSCRIBERS             = 2000
  PAYMENTS                = 3000
  PACKAGES                = 4000
  CHANNELS                 = 5000
  
  IS_AN_AGENT             = 6000
  IS_AN_ADMIN             = 9000
  
  def self.role_type_to_i role
    case role
    when 'users'
      USERS
    when 'subscribers'
      SUBSCRIBERS
    when 'payments'
      PAYMENTS
    else
      0
    end
  end
  
  def self.all_agents
    agents = User.all.reject{|u| !u.has_role?(IS_AN_AGENT)}
  end
  
  def has_role? role
    return self.roles.include?(role.to_s) #||  self.roles.reject{|a| a.to_i < role.to_i}.count > 0
  end
end
