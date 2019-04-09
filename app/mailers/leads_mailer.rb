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

  def new_lead(volunteer)
    @volunteer = volunteer
    mail(
      to: volunteer.user.email,
      from: 'volunteers@londondecom.org',
      subject: "You've been made a lead of #{@volunteer.volunteer_role.name} for London Decom"
    )
  end
end
