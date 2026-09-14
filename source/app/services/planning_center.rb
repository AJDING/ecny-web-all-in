require "net/http"
require "json"

class PlanningCenter
  BASE = "https://api.planningcenteronline.com/people/v2"

  def initialize(app_id: ENV["PCO_APP_ID"], secret: ENV["PCO_SECRET"], workflow_id: ENV["PCO_WORKFLOW_ID"])
    @app_id, @secret, @workflow_id = app_id, secret, workflow_id
  end

  def handoff(user)
    person_id = find_person(user.email) || create_person(user)
    add_workflow_card(person_id) if @workflow_id.present?
    person_id
  end

  private

  def find_person(email)
    res = get("/people?where[search_name_or_email]=#{CGI.escape(email)}")
    res.dig("data", 0, "id")
  end

  def create_person(user)
    body = { data: { type: "Person", attributes: { first_name: user.first_name, last_name: user.last_name } } }
    person = post("/people", body)
    pid = person.dig("data", "id")
    post("/people/#{pid}/emails", { data: { type: "Email", attributes: { address: user.email, location: "Home", primary: true } } })
    post("/people/#{pid}/phone_numbers", { data: { type: "PhoneNumber", attributes: { number: user.phone, location: "Mobile" } } }) if user.phone.present?
    pid
  end

  def add_workflow_card(person_id)
    post("/people/#{person_id}/workflow_cards", { data: { type: "WorkflowCard", attributes: {}, relationships: { workflow: { data: { type: "Workflow", id: @workflow_id } } } } })
  end

  def get(path)  = request(Net::HTTP::Get.new(URI(BASE + path)))
  def post(path, body)
    req = Net::HTTP::Post.new(URI(BASE + path), "Content-Type" => "application/json")
    req.body = body.to_json
    request(req)
  end

  def request(req)
    req.basic_auth(@app_id, @secret)
    uri = req.uri
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request(req) }
    raise "PCO #{res.code}: #{res.body}" unless res.is_a?(Net::HTTPSuccess)
    JSON.parse(res.body)
  end
end
