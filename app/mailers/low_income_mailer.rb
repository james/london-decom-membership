class LowIncomeMailer < ApplicationMailer
  def approved_request(low_income_request)
    @low_income_request = low_income_request
    mail(
      to: low_income_request.user.email,
      from: 'tickets@londondecom.org',
      subject: 'Low Income Request approved'
    )
  end

  def rejected_request(low_income_request)
    @low_income_request = low_income_request
    mail(
      to: low_income_request.user.email,
      from: 'tickets@londondecom.org',
      subject: 'Low Income Request rejected'
    )
  end
end
