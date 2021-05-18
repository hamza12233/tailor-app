class BiddingMailer < ApplicationMailer
  def notify_customer_bidding_approved(proposal)
    @proposal = proposal
    @customer = @proposal.user

    mail(to: @customer.email, subject: 'Received a bidding response')
  end

  def notify_customer_bidding_rejected(proposal)
    @proposal = proposal
    @customer = @proposal.user

    mail(to: @customer.email, subject: 'Received a bidding response')
  end

  def notify_tailor_bidding_revoked(tailor, proposal)
    @proposal = proposal
    @tailor = tailor

    mail(to: @tailor.email, subject: 'Customer Revoked Bidding')
  end

  def notify_tailor_bidding_rejected(tailor, proposal)
    @proposal = proposal
    @tailor = tailor
    mail(to: @tailor.email, subject: 'Received a bidding response')
  end

  def notify_tailor_bidding_approved(tailor, proposal)
    @proposal = proposal
    @tailor = tailor
    mail(to: @tailor.email, subject: 'Customer approve Bidding')
  end
end
