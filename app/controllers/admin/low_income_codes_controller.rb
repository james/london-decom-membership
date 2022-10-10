class Admin::LowIncomeCodesController < AdminController
  def index
    respond_to do |f|
      f.html
      f.csv do
        require 'csv'
        send_data LowIncomeCode.all.collect(&:code).join("\n"),
                  filename: "Decom-low-income-codes-#{Time.zone.today}.csv"
      end
    end
  end

  def create
    params[:number].to_i.times do
      LowIncomeCode.create!
    end
    redirect_to action: :index
  end
end
