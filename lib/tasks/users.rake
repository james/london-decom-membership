namespace :users do
  desc "Purge users who haven't been confirmed in a year"
  task purge_old_users: :environment do
    purged_users = 0
    User.unconfirmed.order(created_at: :asc).each do |user|
      unconfirmed_duration = Time.now - user.confirmation_sent_at.to_time
      one_year_in_seconds = 31556952
      next unless unconfirmed_duration >= one_year_in_seconds

      Rollbar.debug('Removing stale user account', email: user.email)
      user.destroy
      purged_users += 1
    end

    Rollbar.info("Executed rake task 'users:purge_old_users'", outcome: "Removed #{purged_users} from the database")
  rescue StandardError => e
    Rollbar.error(e)
  end
end
