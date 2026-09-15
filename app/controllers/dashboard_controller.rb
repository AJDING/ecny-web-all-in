# "My Next Step" — the single-card landing page after sign in.
class DashboardController < ApplicationController
  def show
    return render plain: "Content not loaded yet. Run: bin/rails db:seed", status: :service_unavailable unless pathway.seeded?
    @next = pathway.next_step
  end
end
