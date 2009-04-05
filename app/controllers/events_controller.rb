class EventsController < ApplicationController
  before_filter :find_subscription, :only => %w(new create)
  before_filter :find_event, :except => %w(new create)

  def show
  end

  def edit
  end

  def new
    @event = subscription.events.prepare(params)
  end

  def create
    @event = subscription.events.create(params[:event].merge(:user_id => user.id))
  end

  def update
    event.update_attributes(params[:event].merge(:user_id => event.user_id))
  end

  def destroy
    event.destroy
  end

  protected

    attr_reader :event
    helper_method :event

    def find_subscription
      @subscription = user.subscriptions.find(params[:subscription_id])
    end

    def find_event
      @event = Event.find(params[:id])
      @subscription = user.subscriptions.find(@event.subscription_id)
    end
end
