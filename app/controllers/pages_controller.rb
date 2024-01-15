class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:account, :contact]
  def cgv
  end

  def legal
  end

  def account
  end

  def quartz_agency
  end

  def contact
  end
end
