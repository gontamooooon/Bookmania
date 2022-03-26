class ContactMailer < ApplicationMailer
  default from: ENV['KEY']
  def contact_mail(contact)
    @contact = contact
    mail to: ENV['KEY'], subject: '【お問い合わせ】'
  end
end
