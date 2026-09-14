# ---------------------------------------------------------------------------
# All In seed content for Encounter Church NY.
# Safe to re-run: records are matched by slug/position and updated in place.
# Assessment answers already given are kept (questions are matched by position).
# ---------------------------------------------------------------------------

puts "Seeding steps…"
learn  = Step.find_or_initialize_by(slug: "learn").tap  { |s| s.update!(position: 1, title: "Learn About Encounter",
           description: "Hear our story, what we believe, and how we do church — through a few short videos and readings.") }
assess = Step.find_or_initialize_by(slug: "assess").tap { |s| s.update!(position: 2, title: "Discover Your Design",
           description: "Three short assessments that help you discover how you connect with God and how you're built to serve.") }
meet   = Step.find_or_initialize_by(slug: "meet").tap   { |s| s.update!(position: 3, title: "Your All In Appointment",
           description: "Meet one-on-one with someone from our team to go over your results, pray together, and find your place at Encounter.") }

puts "Seeding lessons…"
lessons = [
  {
    slug: "welcome", position: 1, kind: "video",
    title: "Welcome to All In",
    description: "What All In is and what the next three steps look like.",
    body: "All In has three steps: learn about Encounter, discover how you're designed, and meet with our team. You can pause and come back any time — your progress is saved.",
    speaker_notes: <<~NOTES
      TARGET LENGTH: 2–3 min. Host: a pastor or All In team lead, warm and direct.
      - "One encounter with Jesus will change your life forever." Say it, then own it: that's why this church exists.
      - What All In is: not a class, not a hoop. It's how we make sure nobody stays a stranger.
      - The three steps (show them on screen): Learn · Discover · Meet.
      - What they'll get at the end: a Personal Ministry Plan and a real person who knows their name.
      - Practical: 7 short items, ~30 min of assessments, one appointment. Do it on your phone.
      - Close: "We're glad you're here. Let's go all in."
    NOTES
  },
  {
    slug: "our-story", position: 2, kind: "video",
    title: "Our Story | Pastors Zack & Rachelle Wechsler",
    description: "How God led Zack and Rachelle from a Las Vegas coffee house to Rochester.",
    body: "In 2009, Zack and Rachelle Wechsler planted Encounter Church Las Vegas in a small coffee house. In the spring of 2020 they answered the call to lead what was then New Hope Community Church in North Chili — now Encounter Church New York.",
    speaker_notes: <<~NOTES
      TARGET LENGTH: 6–9 min. Pastors Zack & Rachelle, conversational, seated (like the Mercy Culture pastor-story videos).
      - 2009: a coffee house in Las Vegas. What was the prompt from God? What did the first year feel like?
      - The people who came: "prostitutes, pimps, drug dealers, the religious, and prodigals" — tell one story (with permission).
      - The declaration: "What happens in Vegas will not stay in Vegas but will shake the nations."
      - Spring 2020: the call to Rochester. Leaving after 11 years. What confirmed it?
      - New Hope becomes Encounter Church NY. The 20,000 sq ft addition — not a building story, a "God makes room" story.
      - Close with a word to the new person watching: why you're glad they're here.
    NOTES
  },
  {
    slug: "five-cs", position: 3, kind: "video",
    title: "The Five C's of All In",
    description: "What it means to belong here, and how you can be part of it.",
    body: <<~BODY,
      ## The Five C's

      - **Christ** — one encounter with Jesus changes everything. Belonging starts with Him, not with us.
      - **Community** — you were never meant to do this alone. Encounter Groups are where Sunday becomes family.
      - **Culture** — presence, authentic community, identity in Christ, and love for our world. It's how we act when we're at our best.
      - **Commitment** — members attend, serve, and give. Not because we need you to, but because that's what family does.
      - **Commission** — we equip and send. You are a supernatural minister of the gospel, and your world is waiting.

      > Draft for pastoral review. Edit the five words and their one-liners in Admin → Lessons until they sound like Encounter.
    BODY
    speaker_notes: <<~NOTES
      TARGET LENGTH: 5–7 min. Teaching pastor. Whiteboard or on-screen text for each C.
      - Frame: "Membership isn't a database status. It's a family posture." Then the five C's, one at a time.
      - Christ / Community / Culture / Commitment / Commission — for each: what it is, what it looks like on a Tuesday, one scripture.
      - Commitment is the honest one: say plainly that members attend, serve, and tithe, and why that's freedom not pressure.
      - Close: "Step Two is where we help you see how God built you — take it honestly."
    NOTES
  },
  {
    slug: "we-believe", position: 4, kind: "text",
    title: "What We Believe",
    description: "Our foundational beliefs and the historic faith we stand in.",
    body: <<~BODY
      ## The historic Christian faith

      Along with the historic Christian faith, we affirm the Apostles' Creed: one God, Father, Son, and Holy Spirit; Jesus Christ, born of the Virgin Mary, crucified, risen, ascended, and coming again; the forgiveness of sins, the resurrection of the body, and life everlasting.

      ## What shapes us

      - The Bible is the inspired, authoritative Word of God.
      - Salvation is by grace through faith in Jesus alone, and it frees us from the power of the devil — sin, lies, sickness, and torment.
      - The Holy Spirit is active today. Every believer is a supernatural minister of the gospel of power whom signs and wonders should follow.
      - We embrace the biblical church government of apostles, prophets, evangelists, pastors, and teachers.
      - Christ is returning for a glorious, overcoming bride — His Church. We are more than "sinners saved by grace"; we are saints, sons and daughters of the King.

      ## Want to go deeper?

      Our We Believe page on encounterny.com includes a pastoral paper on speaking in tongues and more. Bring any questions to your All In appointment — nothing is off the table.
    BODY
  },
  {
    slug: "vision-and-culture", position: 5, kind: "video",
    title: "Our Vision & Culture",
    description: "Personal, regional, and global expansion of God's kingdom through His manifest presence.",
    body: <<~BODY,
      ## Our vision

      To see personal, regional, and global expansion of God's kingdom through His manifest presence.

      ## Our four core values

      - Encounter God's manifest presence
      - Encounter authentic Christian community
      - Encounter your identity in Christ
      - Encounter your world with the love of God

      Our first ministry is to God, so we worship with extravagant joy and gratitude. All ministry flows from the prayer, "Thy kingdom come, on earth as it is in heaven." We pastor a city, not just a church.
    BODY
    speaker_notes: <<~NOTES
      TARGET LENGTH: 5–7 min. Pastor Zack (or a pastor on staff). Pull the strongest 60 seconds from a recent Sunday message on presence/revival and let it set the tone.
      - The vision sentence, slowly, twice. Explain each phrase: personal → regional → global; "manifest presence."
      - Four core values as four encounters: presence, community, identity, world. One story for each.
      - "Our first ministry is to God" — why worship is loud and long here, and why that's not for show.
      - "We pastor a city, not just a church" — what that means for how a member lives Monday–Saturday.
    NOTES
  },
  {
    slug: "healthy-transitions", position: 6, kind: "video",
    title: "Healthy Transitions",
    description: "Joining well: our heart for how people come to Encounter and how they're sent from it.",
    body: "If you're coming from another church, we want you to come well — with honor, without secrets, and blessed by the leaders who cared for you before us.",
    speaker_notes: <<~NOTES
      TARGET LENGTH: 4–6 min. A pastor with a gentle touch. This one prevents years of relational mess.
      - Why we ask: most people arrive from somewhere, and how you leave shapes how you'll land.
      - If you're leaving a healthy church: have the conversation, say thank you, don't take people with you.
      - If you're leaving a painful situation: you're safe here; we'll walk with you toward forgiveness, not gossip.
      - If you're already committed elsewhere: stay planted, serve and give there, and keep enjoying us online.
      - How we send people out (missions, church plants, moves): with blessing. Same standard in both directions.
    NOTES
  },
  {
    slug: "welcome-to-encounter", position: 7, kind: "text",
    title: "Welcome to Encounter Church NY",
    description: "As a member we ask you to attend, serve, and give. Here's where you can plug in.",
    body: <<~BODY
      ## Attend

      Sundays at 9am and 11am, 3355 Union St, North Chili. Pre-service prayer happens before each service — you're welcome to join. Can't make it in person? Watch the Sunday stream.

      ## Serve

      Our Serve Team makes Sunday happen: hospitality and café, Encounter Kids, Encounter YTH, worship, media and live stream, prayer, parking and safety, and more. Your Step Two results will point you toward a fit, and your All In appointment is where you'll sign up.

      ## Grow

      Encounter Groups meet across the region — that's where you'll find your people. Grow Nights are our midweek gatherings for teaching and equipping.

      ## Give

      We honor God with the first of what we have. Members give consistently through pushpay.com/g/encounterchurchnynorthchili or in person on Sunday.

      ## Stay connected

      Subscribe to Encounter Church NY on YouTube, follow us on social, and use the Connect form on encounterny.com any time you have a need or a question.
    BODY
  },
  {
    slug: "before-step-two", position: 8, kind: "text",
    title: "Before You Begin Step Two",
    description: "A word about the assessments and how we'll use your results.",
    body: <<~BODY
      You're about to take three short assessments:

      - **Connection with God** — the ways you most naturally meet with Him (27 questions).
      - **Spiritual Gifts** — how the Holy Spirit has equipped you to serve (48 questions).
      - **Personal Design** — your wiring, and how you work best with others (16 questions).

      Answer for who you actually are today, not who you think a mature Christian should be. There are no wrong answers and no scores to beat. Your results become your Personal Ministry Plan, which we'll walk through together at your All In appointment.

      > "We are saints — sons and daughters of the King."
    BODY
  }
]

lessons.each do |attrs|
  Lesson.find_or_initialize_by(slug: attrs[:slug]).tap do |l|
    l.assign_attributes(attrs.merge(step: learn))
    l.save!
  end
end

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
