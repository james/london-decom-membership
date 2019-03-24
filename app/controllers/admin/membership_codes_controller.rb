class Admin::MembershipCodesController < AdminController
  def index
    respond_to do |f|
      f.html
      f.csv do
        require 'csv'
        send_data MembershipCode.all.collect(&:code).to_csv, filename: "Decom-membership-codes-#{Time.zone.today}.csv"
      end
    end
  end

  def create
    params[:number].to_i.times do
      MembershipCode.create!
    end
    redirect_to action: :index
  end
end
