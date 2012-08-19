require 'active_model'
require 'pony'
require 'valid_email/email_validator'

class Letter
  include ActiveModel::Validations

  validates_presence_of :subject, :name, :message, :recipient

  validates :email, :presence => :true, :email => { :message => "invalid" }

  attr_accessor :subject, :email, :name, :message, :recipient

  def initialize(params)
    params.each do |k, v|
      self.send "#{k.to_s}=", v
    end
    Pony.options = {
      :via => :smtp,
      :via_options => {
        :address => 'smtp.sendgrid.net',
        :port => '587',
        :domain => 'heroku.com',
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :authentication => :plain,
        :enable_starttls_auto => true
      }
    }
  end

  def deliver
    return false unless self.valid?

    Pony.mail to: self.recipient,
            from: "#{self.name} <#{self.email}>",
         subject: self.subject,
         message: self.message
  end

  def deliver_to(email)
    self.recipient = email
    self.deliver
  end
end
