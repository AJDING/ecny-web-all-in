# ---------------------------------------------------------------------------
# All In seed content for Encounter Church NY.
# Safe to re-run: records are matched by slug/position and updated in place.
# Assessment answers already given are kept (questions are matched by position).
# ---------------------------------------------------------------------------

puts "Seeding steps…"
learn  = Step.find_or_initialize_by(slug: "learn").tap  { |s| s.update!(position: 1, title: "Learn About Encounter",
           description: "Five short videos from our pastors and team: our story, our values, the Five C's of membership, and how to join well.") }
assess = Step.find_or_initialize_by(slug: "assess").tap { |s| s.update!(position: 2, title: "Discover Your Design",
           description: "Three short assessments that show how you connect with God, how you're gifted, and how you're wired — and where you'd like to grow.") }
meet   = Step.find_or_initialize_by(slug: "meet").tap   { |s| s.update!(position: 3, title: "The All In Sunday Gathering",
           description: "Once a month on a Sunday we move from information to relationship: meet our pastors and leaders, ask questions, receive prayer, and take your next steps into the life of Encounter.") }

puts "Seeding lessons…"
# Vimeo IDs and unlisted hashes come from the church's Vimeo library (Sep 2026 uploads).
lessons = [
  {
    slug: "welcome", position: 1, kind: "video", vimeo_id: "1227203543", vimeo_hash: "493c66b86f",
    title: "Welcome to All In",
    description: "Silvana explains what All In is and what the next steps look like. (2:31)",
    body: <<~BODY
      We never want church to feel like a place where you come in on a Sunday, attend a service, and leave. All In is our way of helping you take the next steps toward belonging — to be known, to grow, and to become part of the life of the church.

      ## What to expect

      - Five short videos, including this one, each giving you more of the heart of Encounter.
      - Move at your own pace; your progress is saved.
      - When you've finished all five, you'll be able to RSVP for the next All In Sunday Gathering, held once a month.

      ## The gathering

      That in-person time is where we get to actually connect with you: hear your story, introduce you to some of our leaders, answer your questions, and help you see what your next steps could look like — community, a place to serve, or simply growing in your relationship with Jesus.

      > Please complete all five videos before you RSVP. They're designed to work together and give you important context before we're all in the room together.
    BODY
  },
  {
    slug: "our-story", position: 2, kind: "video", vimeo_id: "1227128030", vimeo_hash: "349cc61341",
    title: "Our Story | Pastors Zack & Rachelle Wechsler",
    description: "From a Las Vegas church plant to a dream, an unfinished building, and a yes to Rochester. (5:56)",
    body: <<~BODY
      Pastors Zack and Rachelle are from Las Vegas, Nevada — five kids, one grandbaby, and a lifetime in ministry. In 2009 they planted Encounter Church Las Vegas.

      ## The dream

      In 2019, on their 20th anniversary, Pastor Zack had a vivid dream: flying over a church building, then inside it, with a teaching pastor he knew from Canada, being appointed senior pastor of a church in transition. He messaged that pastor, who had just been standing in an empty, unfinished church building in Rochester whose leaders were looking for a new senior pastor.

      ## The confirmation

      They flew out. The building had sat unfinished for 22 years — concrete and dirt — but it matched the dream in every detail. While they prayed, a guest speaker said, "Joseph hinged his entire destiny on one dream." Then the history: Charles Finney, the worship leader turned revivalist of the Second Great Awakening, moved from Henderson, New York to Rochester; the Wechslers were moving from Henderson, Nevada to Rochester — and Finney shares Pastor Zack's birthday.

      ## What God has done since

      They said yes and began pastoring in 2020, right as COVID hit. The church was renamed Encounter Church New York, the building campaign was relaunched, and in May 2024 the building was finished. Since then: hundreds baptized, over 550 salvations in two years, healing, freedom, and a growing community of saints.

      > "We welcome you to Encounter Church, and we welcome you to be all in here with us."
    BODY
  },
  {
    slug: "five-cs", position: 3, kind: "video", vimeo_id: "1227203541", vimeo_hash: "e05f0d4d05",
    title: "The Five C's of Membership",
    description: "Pastor Rachelle on what being All In means: culture, core values, community, covenant, and cultivation. (7:17)",
    body: <<~BODY
      Membership at Encounter isn't your name on a list or attending consistently. Being All In means saying, "This is a community I'm choosing to belong to — a house I want to grow in, serve in, build relationships in, and contribute to."

      ## 1. Culture

      How we do life and ministry together — the tone, heart, and atmosphere of Encounter. Our vision is to see personal, regional, and global expansion of God's kingdom through His manifest presence. Our first ministry is to God: worship, prayer, His presence, and our relationship with Him are central, not add-ons. Salvation brings freedom and a new way of living, and every believer is called to participate in the work of Jesus — loving, praying, serving, sharing the gospel, and carrying His presence into everyday life.

      ## 2. Core values

      - Encounter God's manifest presence — everything flows from relationship with Him.
      - Encounter authentic Christian community — following Jesus was never meant to happen alone.
      - Encounter your identity in Christ — living as sons and daughters, not from shame or fear.
      - Encounter your world with the love of God — homes, workplaces, schools, and neighborhoods impacted because we're there.

      ## 3. Community

      Church is family, and family requires relationship. EC Kids and YTH for families, the young adults community, serve teams (shoulder to shoulder is one of the fastest ways to build relationships), groups and gatherings through the year. We don't want you to simply attend — we want you to be known.

      ## 4. Covenant

      Where membership becomes personal: the commitment we make to one another as a church family, and sharing in the foundational beliefs of the historic faith — Father, Son, and Spirit, one God; Jesus Christ is Lord; Scripture as our foundation; part of the church Jesus has built throughout history. "These are my people. I'm committed to walking with them, serving with them, growing with them, and carrying the mission God has given this church."

      ## 5. Cultivation

      Membership isn't the goal — becoming a disciple of Jesus is. An environment where your relationship with God keeps growing: Scripture, prayer, worship, community, serving, groups, men's and women's ministries, family discipleship. We equip and send people to carry the works of Jesus.

      > Being All In is choosing to belong, to participate, to grow, and to take ownership of the community God has planted you in.
    BODY
  },
  {
    slug: "healthy-transitions", position: 4, kind: "video", vimeo_id: "1227203542", vimeo_hash: "f8a57caa7f",
    title: "Healthy Transitions",
    description: "Amanda on closing one season with honor before stepping into the next. (6:51)",
    body: <<~BODY
      "There is a time for everything, and a season for every activity under the heavens." (Ecclesiastes 3:1) Whenever we enter a new season, we're usually closing another one — and how we move between them matters.

      ## If Encounter is your first church home

      Welcome. The early church devoted themselves to teaching, fellowship, breaking bread, and prayer (Acts 2:42); that kind of shared life develops over time. Give yourself time to build it.

      ## If you're coming from another church

      Whatever the story — a genuine sense of God's leading, changed circumstances, or disappointment and hurt — whenever possible, close the chapter with honor before opening the next. "If it is possible, as far as it depends on you, live at peace with everyone." (Romans 12:18)

      - Let your previous leadership know what you're sensing, honestly and respectfully.
      - The goal isn't to unload or accuse. It sounds like: "I wanted to let you know where I am because I value our relationship," or "I'm grateful for what God has done in my life here, and I want to close this season well."
      - That creates space for clarity, questions, apology, forgiveness, and sometimes reconciliation. "A gentle answer turns away wrath." (Proverbs 15:1)
      - There's a difference between leaving with peace and leaving in avoidance. Unprocessed hurt quietly follows us into the next season — guarded, suspicious, expecting the past to repeat. "Forgive as the Lord has forgiven you." (Colossians 3:13)

      ## How we'll treat you

      If disappointment or confusion ever appears here, give us the chance to listen and have a conversation rather than quietly carrying it away. And if God leads you into a new season, we want to honor you, pray with you, celebrate you, and send you off well. Healthy church family celebrates people coming in and honors them when God leads them out. (Ephesians 4:2–3)
    BODY
  },
  {
    slug: "your-next-step", position: 5, kind: "video", vimeo_id: "1227128029", vimeo_hash: "6d9903f330",
    title: "Your Next Step: The All In Gathering",
    description: "Mikey and David wrap up the videos and point you to the monthly Sunday gathering. (3:00)",
    body: <<~BODY
      You are loved, you belong, and there is a place for you here. At Encounter we believe church is family — we want you to be more than someone who attends on Sundays. We want you known, connected, cared for, and growing alongside others.

      ## What happens next

      - Finish Step Two: three short assessments that show how you're designed. Your results (and the areas you'd like to grow in) become your profile and come with you to the gathering.
      - RSVP for the next All In Sunday Gathering, held once a month.

      ## At the gathering

      We move from information to relationship. You'll meet some of our pastors and leaders, connect with others taking this step, ask questions, and get clarity on your next steps — community, serving, and growing your relationship with Jesus. We take time to pray with you and over you as you become part of the Encounter family and come under its spiritual covering.

      > "You are no longer foreigners and strangers, but fellow citizens with God's people and also members of His household." (Ephesians 2:19) Not a visitor, not an outsider — family.
    BODY
  }
]

lessons.each do |attrs|
  Lesson.find_or_initialize_by(slug: attrs[:slug]).tap do |l|
    l.assign_attributes(attrs.merge(step: learn, published: true))
    l.save!
  end
end
# Retire lessons that are no longer part of the five-video pathway (removes their completions too).
Lesson.where.not(slug: lessons.map { |l| l[:slug] }).destroy_all

# ---------------------------------------------------------------------------
puts "Seeding assessments…"

def seed_assessment(step:, slug:, position:, title:, description:, intro:, categories:, questions:, top_n: 3)
  a = Assessment.find_or_initialize_by(slug: slug)
  a.update!(step: step, position: position, title: title, description: description, intro: intro, categories: categories, top_n: top_n)
  questions.each_with_index do |(category, text), i|
    q = a.questions.find_or_initialize_by(position: i + 1)
    q.update!(category: category, text: text)
  end
  a.questions.where("position > ?", questions.size).destroy_all
  a
end

# ---- 1. Connection with God (27) ------------------------------------------
seed_assessment(
  step: assess, slug: "connection-with-god", position: 1,
  title: "Connection with God",
  description: "Discover the ways you most naturally connect with God.",
  intro: "There is one way to God — through Jesus — but in Jesus there are many ways to connect with Him. This shows you yours, so your daily encounters can be personal, not borrowed.",
  categories: {
    "Worship" => { summary: "You meet God most in adoration — singing, lifting your hands, lingering in a worship set long after the band has stopped. Presence is your language.", serve: ["Worship team", "Pre-service prayer", "Sunday atmosphere"] },
    "The Word" => { summary: "Scripture is where God speaks to you clearly. Reading, memorizing, and sitting with a passage brings you alive.", serve: ["Encounter Group leader", "Grow Nights", "Encounter Kids teaching"] },
    "Prayer & Intercession" => { summary: "You connect with God by talking with Him — and by standing in the gap for others. Prayer isn't a task for you; it's home.", serve: ["Prayer team", "Pre-service prayer", "Altar ministry"] },
    "Solitude & Stillness" => { summary: "You hear God best when everything else is quiet. Silence, sabbath, and unhurried time restore you.", serve: ["Prayer chapel", "Care & follow-up", "Behind-the-scenes serving"] },
    "Creation" => { summary: "God feels near to you outdoors — a trail, a sunrise, the lake. His world preaches to you.", serve: ["Outreach & events", "Facilities & grounds", "Men's/women's outdoor gatherings"] },
    "Serving" => { summary: "You encounter God while doing something for someone — setting up chairs, cooking, driving. Serving is your worship.", serve: ["Hospitality & café", "Setup & tear-down", "Parking & safety"] },
    "Creative Expression" => { summary: "Making things — art, music, writing, design, video — is where you and God create together.", serve: ["Media & live stream", "Creative & design", "Worship team"] },
    "Community & Conversation" => { summary: "You meet God around a table. Honest conversation, shared meals, and being known draw you closer to Him.", serve: ["Encounter Groups", "Connect & hospitality", "All In team"] },
    "Justice & Compassion" => { summary: "You feel God's heart most when you're with the overlooked — the poor, the sick, the stranger. Mercy moves you.", serve: ["Outreach", "Benevolence & care", "Missions"] }
  },
  questions: [
    ["Worship", "I lose track of time during worship."],
    ["Worship", "Singing to God is the quickest way for me to feel close to Him."],
    ["Worship", "A great worship set stays with me for days."],
    ["The Word", "I feel most connected to God after reading the Bible."],
    ["The Word", "I underline, memorize, or write out scriptures."],
    ["The Word", "A single verse can change my whole day."],
    ["Prayer & Intercession", "Talking with God feels as natural as talking with a friend."],
    ["Prayer & Intercession", "I find myself praying for people I've just met."],
    ["Prayer & Intercession", "I'd rather pray about a problem than talk about it."],
    ["Solitude & Stillness", "I need quiet to hear God clearly."],
    ["Solitude & Stillness", "I feel God's presence most when I'm alone and unhurried."],
    ["Solitude & Stillness", "Too much noise and activity drains my spiritual life."],
    ["Creation", "Being outdoors makes me want to worship."],
    ["Creation", "I sense God more on a walk than in a building."],
    ["Creation", "Sunsets, storms, and stars remind me how big God is."],
    ["Serving", "I feel closest to God when I'm helping someone."],
    ["Serving", "Practical work for the church feels like worship to me."],
    ["Serving", "I'd rather show love by doing than by saying."],
    ["Creative Expression", "I connect with God through making things — art, music, writing, or design."],
    ["Creative Expression", "Creativity feels like a conversation with God."],
    ["Creative Expression", "I process what God is saying by creating something."],
    ["Community & Conversation", "I hear God most in honest conversation with other believers."],
    ["Community & Conversation", "A meal with friends can feel as spiritual as a church service."],
    ["Community & Conversation", "I grow faster with people than on my own."],
    ["Justice & Compassion", "I feel God's heart most when I'm with people who are hurting."],
    ["Justice & Compassion", "Injustice makes me want to act, not just pray."],
    ["Justice & Compassion", "I sense God's presence in hospitals, shelters, and hard places."]
  ]
)

# ---- 2. Spiritual Gifts (48) ---------------------------------------------
seed_assessment(
  step: assess, slug: "spiritual-gifts", position: 2,
  title: "Spiritual Gifts",
  description: "How the Holy Spirit has equipped you to build up the Church.",
  intro: "Every believer is a supernatural minister of the gospel. These questions surface the gifts already at work in you — rate how true each statement is, not how much you'd like it to be true.",
  categories: {
    "Administration" => { summary: "You bring order to chaos — plans, systems, timelines. Vision needs you to become reality.", serve: ["Serve Team coordination", "Events", "Office & admin"] },
    "Apostleship" => { summary: "You pioneer. Starting things, breaking new ground, and sending others energizes you.", serve: ["Church planting & missions", "New ministry launches", "Encounter Movement"] },
    "Discernment" => { summary: "You sense what's really going on — in people, rooms, and situations — and what's from God.", serve: ["Prayer team", "Altar ministry", "Leadership support"] },
    "Evangelism" => { summary: "You share Jesus naturally, and people respond. You can't stay quiet about Him.", serve: ["Outreach", "Connect team", "Sunday greeting"] },
    "Exhortation" => { summary: "You call people up. Encouragement, coaching, and timely challenge flow out of you.", serve: ["Encounter Group leader", "All In team", "Mentoring"] },
    "Faith" => { summary: "You believe God for the impossible and hold steady when others waver.", serve: ["Prayer team", "Building & vision initiatives", "Testimony"] },
    "Giving" => { summary: "You give generously and joyfully, and you spot needs before they're announced.", serve: ["Benevolence", "Missions support", "Stewardship"] },
    "Healing" => { summary: "You expect God to heal, and you're willing to pray for it — in church and out.", serve: ["Altar ministry", "Prayer team", "Hospital & home visits"] },
    "Helps" => { summary: "You see the practical need and meet it without being asked. Nothing is beneath you.", serve: ["Setup & tear-down", "Parking & safety", "Facilities"] },
    "Hospitality" => { summary: "You make people feel at home — welcomed, fed, and seen.", serve: ["Café & hospitality", "Greeters", "Encounter Groups host"] },
    "Intercession" => { summary: "You carry people and situations in prayer for long stretches, and you see answers.", serve: ["Pre-service prayer", "Prayer chapel", "Intercession team"] },
    "Leadership" => { summary: "People follow you. You cast vision, make decisions, and take responsibility.", serve: ["Team lead", "Encounter Group leader", "Ministry leadership"] },
    "Mercy" => { summary: "You feel what others feel and move toward the hurting with tenderness.", serve: ["Care & follow-up", "Benevolence", "Hospital visits"] },
    "Prophecy" => { summary: "God gives you words, pictures, and impressions for people and the church — and you share them with love.", serve: ["Prophetic team", "Altar ministry", "Prayer team"] },
    "Shepherding" => { summary: "You nurture people over time — protecting, feeding, and walking with them.", serve: ["Encounter Group leader", "Encounter Kids / YTH", "Care team"] },
    "Teaching" => { summary: "You make truth clear. Explaining scripture so people understand and change is your joy.", serve: ["Grow Nights", "Encounter Kids / YTH teaching", "Encounter Group teaching"] }
  },
  questions: [
    ["Administration", "I enjoy organizing people, tasks, and details so a goal actually gets reached."],
    ["Administration", "I naturally create plans, schedules, and checklists."],
    ["Administration", "Others rely on me to keep things running smoothly."],
    ["Apostleship", "I love starting new things from scratch."],
    ["Apostleship", "I'm drawn to places and people the church hasn't reached yet."],
    ["Apostleship", "I'd rather pioneer than maintain."],
    ["Discernment", "I can usually tell when something is off before anyone says so."],
    ["Discernment", "I sense whether a teaching or idea is truly from God."],
    ["Discernment", "People ask me for my read on situations."],
    ["Evangelism", "I look for openings to talk about Jesus with people who don't know Him."],
    ["Evangelism", "Sharing my faith feels natural, not forced."],
    ["Evangelism", "I've seen people come to Christ through conversations with me."],
    ["Exhortation", "I love encouraging people toward their next step."],
    ["Exhortation", "People leave conversations with me feeling motivated."],
    ["Exhortation", "I'm comfortable challenging a friend in love when they need it."],
    ["Faith", "I believe God for things others consider impossible."],
    ["Faith", "I stay confident in God's promises during hard seasons."],
    ["Faith", "My faith often strengthens the people around me."],
    ["Giving", "I give generously, often beyond what's expected."],
    ["Giving", "I get real joy from meeting a financial need."],
    ["Giving", "I manage money well so I can give more."],
    ["Healing", "I regularly pray for the sick and expect God to heal."],
    ["Healing", "I've seen God heal someone after prayer."],
    ["Healing", "I feel compassion and boldness when I meet someone who is sick."],
    ["Helps", "I notice practical needs and quietly meet them."],
    ["Helps", "I'm happy doing behind-the-scenes work that no one sees."],
    ["Helps", "Supporting a leader so they can do their job well fulfills me."],
    ["Hospitality", "I love hosting people in my home."],
    ["Hospitality", "I go out of my way to make newcomers feel welcome."],
    ["Hospitality", "Food, a warm room, and good conversation are my ministry."],
    ["Intercession", "I can pray for a long time without losing focus."],
    ["Intercession", "I feel a burden to pray for specific people and situations."],
    ["Intercession", "I've seen answers to prayers I've carried for months."],
    ["Leadership", "People naturally look to me for direction."],
    ["Leadership", "I'm comfortable making decisions and owning the outcome."],
    ["Leadership", "I can see where a team needs to go and get them there."],
    ["Mercy", "I'm drawn to people who are hurting or overlooked."],
    ["Mercy", "I feel others' pain deeply and want to relieve it."],
    ["Mercy", "I'm patient with people who are struggling."],
    ["Prophecy", "God often gives me a word, picture, or impression for someone."],
    ["Prophecy", "When I share what I sense from God, it lands with people."],
    ["Prophecy", "I feel responsible to speak truth from God even when it's uncomfortable."],
    ["Shepherding", "I enjoy walking with the same people over a long time."],
    ["Shepherding", "I feel protective of the people God has put in my care."],
    ["Shepherding", "I'd rather go deep with a few than wide with many."],
    ["Teaching", "I enjoy studying scripture so I can explain it to others."],
    ["Teaching", "People tell me they understand things better after I explain them."],
    ["Teaching", "I pay attention to how a truth is communicated, not just what it is."]
  ]
)

# ---- 3. Personal Design (16) ---------------------------------------------
seed_assessment(
  step: assess, slug: "personal-design", position: 3,
  title: "Personal Design",
  description: "How you're wired, and how you work best with others.",
  intro: "God made you on purpose. These 16 questions describe your natural pace, focus, and way of relating — so we can place you where you'll thrive.",
  top_n: 2,
  categories: {
    "Pioneer" => { summary: "Fast, direct, results-driven. You take charge, make decisions quickly, and push through obstacles. You're at your best with a clear goal and room to move.", serve: ["Team lead", "Launching new initiatives", "Outreach"] },
    "Connector" => { summary: "Warm, energetic, people-first. You light up a room, build relationships instantly, and make others feel included. You're at your best out front with people.", serve: ["Greeters & Connect team", "Hospitality", "Encounter Groups"] },
    "Anchor" => { summary: "Steady, loyal, calm. You serve consistently, keep the peace, and stay when things get hard. You're at your best on a stable team with clear expectations.", serve: ["Encounter Kids", "Care & follow-up", "Setup & tear-down"] },
    "Architect" => { summary: "Careful, precise, thoughtful. You value accuracy, plan ahead, and get details right. You're at your best with time to think and quality to protect.", serve: ["Media & live stream", "Finance & admin", "Systems & planning"] }
  },
  questions: [
    ["Pioneer", "I make decisions quickly and act on them."],
    ["Pioneer", "I'd rather lead than follow."],
    ["Pioneer", "I get impatient with slow processes."],
    ["Pioneer", "Challenges energize me more than they worry me."],
    ["Connector", "I'm energized by being around lots of people."],
    ["Connector", "I make friends easily and quickly."],
    ["Connector", "I'm optimistic and expressive."],
    ["Connector", "I'd rather talk something through than think it through alone."],
    ["Anchor", "I'm loyal and stick with people and commitments."],
    ["Anchor", "I prefer stable routines over constant change."],
    ["Anchor", "I'm a calm presence when others are stressed."],
    ["Anchor", "I'd rather support a team than be the face of it."],
    ["Architect", "I like to have all the facts before I decide."],
    ["Architect", "I notice details other people miss."],
    ["Architect", "I follow through carefully and finish what I start."],
    ["Architect", "I prefer working from a clear plan or standard."]
  ]
)

# ---------------------------------------------------------------------------
puts "Seeding admin…"
admin_email = ENV.fetch("ADMIN_EMAIL", "admin@encounterny.com")
admin = User.find_or_initialize_by(email: admin_email)
if admin.new_record?
  password = ENV.fetch("ADMIN_PASSWORD") { Rails.env.production? ? SecureRandom.base58(16) : "changeme-now" }
  admin.assign_attributes(first_name: "All In", last_name: "Admin", password: password, admin: true)
  admin.save!
  puts "  Created admin #{admin_email} with password: #{password}  <-- change this after first sign-in"
else
  admin.update!(admin: true)
end

puts "Done. Lessons: #{Lesson.count}, questions: #{Question.count}, users: #{User.count}"
