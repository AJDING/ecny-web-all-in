# App-wide settings read from ENV so nothing church-specific is hard-coded.
module AllIn
  SETTINGS = {
    church_name:          ENV.fetch("CHURCH_NAME", "Encounter Church"),
    church_email:         ENV.fetch("CHURCH_EMAIL", "Connect@EncounterNY.com"),
    scheduling_url:       ENV.fetch("SCHEDULING_URL", ""),
    all_in_gathering_url: ENV.fetch("ALL_IN_GATHERING_URL", ""),
    church_site:          "https://encounterny.com"
  }.freeze
end
