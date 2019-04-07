class LeadsMailer < ApplicationMailer
  def new_volunteer(volunteer)
    @volunteer = volunteer
    mail(
      to: volunteer.volunteer_role.lead_emails,
      from: 'volunteers@londondecom.org',
      subject: 'New Decom volunteer'
    )
  end

  def cancelled_volunteer(volunteer)
    @volunteer = volunteer
    mail(
      to: volunteer.volunteer_role.lead_emails,
      from: 'volunteers@londondecom.org',
      subject: 'Decom volunteer cancellation'
    )
  end
end
