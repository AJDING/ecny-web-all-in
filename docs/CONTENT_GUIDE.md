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

## Step One lineup (five videos, as uploaded to Vimeo Sep 2026)

| # | Lesson | Vimeo ID / hash | Speaker | Length |
|---|---|---|---|---|
| 1 | Welcome to All In | 1227203543 / 493c66b86f | Silvana | 2:31 |
| 2 | Our Story · Pastors Zack & Rachelle | 1227128030 / 349cc61341 | Zack & Rachelle | 5:56 |
| 3 | The Five C's of Membership | 1227203541 / e05f0d4d05 | Pastor Rachelle | 7:17 |
| 4 | Healthy Transitions | 1227203542 / f8a57caa7f | Amanda | 6:51 |
| 5 | Your Next Step: The All In Gathering | 1227128029 / 6d9903f330 | Mikey & David | 3:00 |

Summaries under each video in `db/seeds.rb` were written from Vimeo's AI transcripts. Note: the auto-captions spell the pastors' name "Wexler"; the site uses "Wechsler" — fix the caption in Vimeo → video → Languages → English if you want the on-screen subtitles to match.

The Five C's as taught in video 3: **Culture · Core Values · Community · Covenant · Cultivation**. Step Three is the monthly **All In Sunday Gathering** (videos 1 and 5 both tell people to finish all five, then RSVP).

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
