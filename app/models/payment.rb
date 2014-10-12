class Payment < ActiveRecord::Base
  attr_accessible :amount, :subscriber_id, :payment_id, :payment_ref, :agent_id, :created_by, :updated_by, :collected_on, :for_cycle
  belongs_to :subscriber
  belongs_to :agent, class_name: User
  
  
  def self.all_payments_of_subscriber(subscriber)
    payments = Payment.where(:subscriber_id => subscriber.id).order('id DESC')
    return payments
  end
  
  def self.get_overdue_list
    overdues = []
    Subscriber.where(:status => true).each do |s|
      p = s.payments.last
      if p.nil?
        overdues.push({s: s, p: nil})
      else
        overdues.push({s: s, p: p}) if s.cycle_starts_on < Date.today.day && p.for_cycle + 30.days < Date.today
      end
    end
    return overdues
  end
  
  def self.generate_payment_ref
    ref = ""
    ref = "#{ref}d#{Time.now.strftime("%Y%m%d")}"
    ref = "#{ref}i#{Payment.last.id.to_i+1}"
  end
end
