class NotificationsWorker
  include Sidekiq::Worker

  attr_accessor :mailer_class

  def perform(*args)
    mailer_class.vote(*args).deliver
  end

  def mailer_class
    @mailer_class ||= UserMailer
  end
end
