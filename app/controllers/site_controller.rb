class SiteController < ApplicationController
  include ApplicationHelper

  protect_from_forgery :except => :home

  def home
    if request.get?
      render plain: params['echostr'] if check_signature
    elsif request.post?
      render 'home', :formats => :xml if check_signature && params[:xml][:MsgType] == "text"
    end
  end

  def record
  end

  def struct
  end

  def display
  end

  private

  def check_signature()
    signature = params['signature'] or return false
    timestamp = params['timestamp'] or return false
    nonce = params['nonce'] or return false
    return signature == get_signature(Rails.application.config.weixin.token,
      timestamp, nonce) ? true : false
  end
end
