class ProposalMailer < ApplicationMailer
  def send_bidding_email(tailor, user)
    @tailor = tailor
    @user = user

    mail(to: @tailor.email, subject: "New order request.")
  end
end
