# All In content guide

## How the app maps to the All In Project Roadmap

| Roadmap phase | Where it lives in this build |
|---|---|
| 1 Platform + Design | This Rails app; theme in `config/tailwind.config.js`; tracking = `lesson_completions`, `assessment_results`, `appointments` |
| 2 Content | `db/seeds.rb` lessons 1–8 + speaker notes (Admin → Lessons). Five C's + culture = lessons 3 & 5. Healthy Transitions = lesson 6 |
| 3 Discovery tools | Three assessments: Connection with God (27), Spiritual Gifts (48), Personal Design (16). Results → Personal Ministry Plan (`/my_plan`), each category lists where it fits at Encounter |
| 4 Production | Record from the speaker notes → Vimeo → paste IDs in Admin |
| 5 Build + Integrate | Done here; follow-up via Admin → Appointments and optional PCO Workflow handoff |
| 6 All In experience | Step Three: 1:1 appointment (replica of Connect) + link to the monthly All In gathering (`ALL_IN_GATHERING_URL`) |
| 7 Test + Launch | README Part 8 checklist |

## Step One lineup (mirrors Mercy Culture's Step One, re-written for Encounter)

| # | Lesson | Type | Needs | Source material |
|---|---|---|---|---|
| 1 | Welcome to All In | video | **Video A** | — |
| 2 | Our Story · Pastors Zack & Rachelle | video | **Video B** | encounterny.com/about-us/lead-pastors, /encounter-movement-network |
| 3 | The Five C's of All In | video | record | Draft C's in seeds — pastors to finalize |
| 4 | What We Believe | text | done | encounterny.com/about-us/we-believe (Apostles' Creed + distinctives) |
| 5 | Our Vision & Culture | video | record | encounterny.com/about-us/vision-values (vision sentence + 4 core values) |
| 6 | Healthy Transitions | video | record | Pastoral |
| 7 | Welcome to Encounter Church NY | text | done | Sundays 9 & 11, Serve Team, Encounter Groups, Grow Nights, Kids, YTH, Give |
| 8 | Before You Begin Step Two | text | done | — |

## Pulling from the sermon archive (youtube.com/@EncounterChurchNY)

The lessons are intentionally light — this is an intro, not a course. Use sermons as *b-roll and quotes*, not as the lesson:

- **Lesson 5 (Vision & Culture):** open with 30–60 s from a Sunday message on the manifest presence / revival. Cut to the pastor on camera explaining the four core values.
- **Lesson 3 (Five C's):** a short clip per C works well — e.g. a moment on identity in Christ ("we are saints, sons and daughters") for *Christ*, a Grow Night or Encounter Group clip for *Community*, a sending/commissioning moment for *Commission*.
- **Lesson 1 (Welcome):** the "One encounter with Jesus will change your life forever" line is already your tagline; open on it.

Keep every video under 8 minutes. Mercy Culture's are conversational, seated, one or two people, no slides.

## Recording checklist
- 16:9, 1080p, clean audio (lav mics), warm light, the café or the prayer chapel as a set.
- Burned-in or Vimeo captions (Vimeo auto-captions; review them).
- Export a 1920×1080 JPG still for each lesson's thumbnail.
- Upload → Private → Embed only on allin.encounterny.com → copy the ID → Admin → Lessons.

## Assessment design notes
- All three use a 1–5 scale; scores are normalized to 0–100 per category so categories with different question counts compare fairly.
- **Connection with God** (9 pathways × 3 q) — your "connection-with-God tool" from the roadmap.
- **Spiritual Gifts** (16 gifts × 3 q) — your "gifting tool".
- **Personal Design** (4 types × 4 q; shows top 2) — your "personal design tool".
- Each category has a `serve:` list in `db/seeds.rb`. Edit these to match your actual Serve Team names so results point people at real teams.
