class LeadsMailer < ApplicationMailer
  def new_volunteer(volunteer)
    @volunteer = volunteer
    mail(
      to: volunteer.volunteer_role.lead_emails,
      from: 'volunteers@londondecom.org',
      subject: 'New Decom volunteer'
    )
  end
end
