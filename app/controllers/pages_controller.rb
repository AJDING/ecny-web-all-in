class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def faq; end
  def terms; end
  def privacy; end
end
