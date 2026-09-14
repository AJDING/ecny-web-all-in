# Optional: when someone finishes All In, make sure they exist in Planning Center People
# and drop a card into a Workflow so your team follows up. Needs PCO_APP_ID / PCO_SECRET / PCO_WORKFLOW_ID.
# PCO API docs: https://developer.planning.center/docs/#/apps/people
class PlanningCenterHandoffJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    PlanningCenter.new.handoff(user)
  rescue => e
    Rails.logger.error("[PCO handoff] #{e.class}: #{e.message}")
  end
end
