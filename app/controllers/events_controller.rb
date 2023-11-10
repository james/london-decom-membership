class EventsController < ApplicationController
  def clear_discount_from_cache
    Rails.cache.delete("eventbrite:event:#{params[:eventbrite_id]}:discounts:#{params[:code]}")
  end
end
