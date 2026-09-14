# All In — Encounter Church NY

A replica of the Mercy Culture "Connect" new-member pathway, rebuilt for Encounter Church with a black / dark-blue theme.

**Stack (matches what powers Mercy Culture's app):** Ruby on Rails 7.2 · PostgreSQL · Devise (register / sign in / profile) · Active Storage for thumbnails (Cloudflare R2 in production) · Vimeo Player for video · Cloudflare in front · Tailwind CSS · Hotwire (Turbo + Stimulus). Optional: Planning Center handoff, any scheduling tool for Step Three.

**What a person experiences (same shape as Connect):**

| Screen | Path | What it does |
|---|---|---|
| My Next Step | `/` | One card: the current step + Continue |
| My Progress | `/my_progress` | Three steps. Lessons unlock in order; assessments unlock after Step One; appointment unlocks after all three assessments |
| Lesson | `/lessons/:slug` | Vimeo embed; **Next** enables only when the video ends (or a text lesson is read) |
| Assessment | `/assessments/:slug` | 1–5 scale questions, scored by category |
| Results / Plan | `/assessments/:slug/results`, `/my_plan` | Top categories with descriptions and where they fit at Encounter |
| Appointment | `/appointment` | Opens your scheduler, then the person confirms they've booked |
| FAQ, Account | `/faq`, `/users/edit` | |
| Admin | `/admin` | People + progress, edit lessons / Vimeo IDs / thumbnails, appointments |

> ⚠️ This codebase was written without being booted (no Ruby in the authoring environment). Expect to fix a handful of small things on first run — Part 1 below walks you through it. Everything is standard Rails, so errors will be ordinary and Googleable.

---

## Part 1 — Run it on your laptop (30–45 min)

### 1.1 Install Ruby and Postgres

**macOS**
```bash
brew install rbenv ruby-build postgresql@16 libvips
rbenv install 3.3.6 && rbenv global 3.3.6
brew services start postgresql@16
```
**Ubuntu / WSL**
```bash
sudo apt install -y git curl libssl-dev libreadline-dev zlib1g-dev libyaml-dev libpq-dev postgresql libvips
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash   # then follow its PATH instructions
rbenv install 3.3.6 && rbenv global 3.3.6
sudo -u postgres createuser -s $USER
```
Check: `ruby -v` → 3.3.6, `psql --version`.

### 1.2 Install gems and generate the two files Rails must create itself
```bash
cd all-in
gem install bundler
bundle install
bin/rails active_storage:install     # creates the Active Storage migration (thumbnails)
```
If `bundle install` complains about `tailwindcss-ruby`, run `bundle update tailwindcss-rails tailwindcss-ruby`.

### 1.3 Create the database, load content, start
```bash
cp .env.example .env               # edit later; defaults work locally
bin/rails db:create db:migrate
bin/rails db:seed                  # steps, 8 lessons, 3 assessments (91 questions), admin user
bin/dev                            # runs Rails + Tailwind watcher (installs foreman if needed)
```
Open http://localhost:3000. Sign in as **admin@encounterny.com / changeme-now**, then go to Account and change the password.

### 1.4 Things that commonly need a nudge on first boot
- **`Missing tailwind.css`** → run `bin/rails tailwindcss:build` once.
- **Stimulus controllers not loading / `bin/importmap` missing** → run `bin/rails importmap:install` (it only adds the `bin/importmap` helper; `config/importmap.rb` is already set up).
- **`SECRET_KEY_BASE` error in development** → `bin/rails secret` and put it in `.env` as `SECRET_KEY_BASE=...` (Rails normally generates `tmp/local_secret.txt` for you).
- **Thumbnail variants failing** → `libvips` isn't installed (see 1.1). Thumbnails are optional; the UI falls back to a blue gradient.
- **Video says "coming soon"** → expected until you add Vimeo IDs (Part 3).

### 1.5 Test the whole journey in 5 minutes
1. Create a normal account at `/users/sign_up` (use a different email than the admin).
2. Lessons without a video yet show **Next** immediately, so you can click through Step One.
3. Take the three assessments; watch Step Three unlock; confirm the appointment.
4. `bin/rails all_in:reset[that@email.com]` resets that person so you can test again.

---

## Part 2 — Accounts you need to create (do these before Part 3)

| # | Service | What for | Cost |
|---|---|---|---|
| 1 | **Vimeo** (Plus or Pro) | Hosting the lesson videos privately, embedded only on your domain | Plus ~$12/mo, Pro ~$20/mo — Free tier won't allow domain-restricted embeds |
| 2 | **Cloudflare** (Free) | DNS for `allin.encounterny.com`, TLS, caching, bot protection | Free |
| 3 | **Cloudflare R2** | Storage for lesson thumbnails (S3-compatible) | Free tier is plenty |
| 4 | **Render** (or Fly.io / Railway) | Hosting the Rails app + Postgres | ~$7–15/mo each for web + DB |
| 5 | **Email sender** — Resend (recommended), Postmark, or SendGrid | Password-reset emails | Free tier |
| 6 | **Scheduler for Step Three** — Calendly (free) *or* Planning Center Calendar / Church Center | Booking the All In appointment | Free |
| 7 | *(Optional)* Planning Center Personal Access Token | Push finished people into a PCO Workflow | Included in your PCO plan |

You already have: encounterny.com DNS (Clover) and Planning Center (ecny.churchcenter.com).

---

## Part 3 — Vimeo (your two 2 GB videos)

1. Create the Vimeo account and, in **Settings → Videos → Privacy**, set the default to **Private** with **Embed: Specific domains**.
2. Add these domains to the embed allow-list: `allin.encounterny.com`, `localhost:3000`, and (optionally) an ngrok domain for testing on your phone.
3. Upload the two videos (web uploader handles 2 GB; use a wired connection). Suggested mapping:
   - Video A → **Welcome to All In** (lesson slug `welcome`)
   - Video B → **Our Story | Pastors Zack & Rachelle** (lesson slug `our-story`)
   If your two videos are something else, use `docs/CONTENT_GUIDE.md` to decide which lesson each belongs to.
4. On each video page, the URL looks like `https://vimeo.com/123456789` → **123456789** is the Vimeo ID.
   If the privacy setting is **Unlisted**, the URL has an extra `/abcdef1234` or `?h=abcdef1234` — that's the **vimeo_hash**.
5. In the app: sign in as admin → **Admin → Lessons → Edit** → paste the Vimeo ID (and hash if unlisted) → **Save**.
   Also upload a 16:9 JPG thumbnail there (a still from the video works).
6. Set video titles/descriptions in Vimeo to "Do not show" and turn off the Vimeo end-screen ("Show Vimeo logo / related videos") so the player looks clean.
7. For the remaining five video lessons, record using the speaker notes in **Admin → Lessons** (also in `docs/CONTENT_GUIDE.md`). Until a video is added, that lesson shows "Video coming soon" and Next is enabled so people aren't blocked. If you'd rather hide an unfinished lesson entirely, untick **Published**.

---

## Part 4 — Deploy to Render + Cloudflare (60–90 min)

### 4.1 Push the code
```bash
git init && git add . && git commit -m "All In"
gh repo create encounter-all-in --private --source=. --push    # or push to any GitHub repo
```

### 4.2 Render
1. Render dashboard → **New → Blueprint** → pick the repo. `render.yaml` creates the web service + Postgres.
2. Fill in the env vars marked `sync: false` (values from Parts 2, 3, 5, 6). Set `ADMIN_EMAIL` to your email and `ADMIN_PASSWORD` to something strong — the first deploy seeds the admin account with it.
3. Deploy. The `release` step in `Procfile` runs migrations and seeds automatically.
4. Test at the `*.onrender.com` URL. (Vimeo embeds won't play yet because that domain isn't allow-listed — that's fine.)

### 4.3 Cloudflare
1. If encounterny.com's DNS isn't already on Cloudflare: add the site in Cloudflare (Free), import DNS, and change nameservers at your registrar. **Do not remove the existing records** — Clover keeps serving `encounterny.com` exactly as before; you're only adding a subdomain.
   If you'd rather not move DNS, add a **CNAME `allin` → `<your-app>.onrender.com`** at your current DNS host and skip the rest of 4.3 (you'll lose Cloudflare's proxy features but everything works).
2. **DNS** → add `CNAME allin → <your-app>.onrender.com`, proxy status **Proxied** (orange cloud).
3. **SSL/TLS** → mode **Full (strict)**. Render issues the origin certificate automatically once you add the custom domain in Render (**Settings → Custom domains → allin.encounterny.com**).
4. **SSL/TLS → Edge Certificates** → turn on **Always Use HTTPS**.
5. **Security → Bots** → turn on Bot Fight Mode (free). Optional: a WAF rule to block `/admin*` from outside the US.
6. **Caching → Configuration** → leave standard. Rails sends `Cache-Control: private` on logged-in pages so nothing personal is cached.

### 4.4 Cloudflare R2 (thumbnails)
1. Cloudflare → **R2 → Create bucket** `all-in-media` (location: automatic).
2. **R2 → Manage R2 API Tokens → Create API token** → permission **Object Read & Write**, scoped to that bucket. Copy Access Key ID, Secret Access Key, and your Account ID.
3. Put them in Render env: `R2_ACCOUNT_ID`, `R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY`, `R2_BUCKET`.

---

## Part 5 — Email (password resets)

1. Resend → **Domains → Add** `encounterny.com` (or a subdomain like `mail.encounterny.com`) → add the DNS records it shows in Cloudflare.
2. **API Keys → Create** → use as `SMTP_PASSWORD`; `SMTP_USERNAME=resend`, `SMTP_ADDRESS=smtp.resend.com`, `SMTP_PORT=587`.
3. `MAIL_FROM=All In <allin@encounterny.com>`.
4. Test: `/users/password/new` → enter your email → you should get a reset link.

---

## Part 6 — Step Three scheduling handoff

**Option A — Calendly (fastest).** Create a free Calendly account for the All In team → new event type "All In Appointment" (30 min) → add each connector's availability (round-robin needs a paid plan; a single shared calendar is free) → copy the booking link → set `SCHEDULING_URL`.

**Option B — Planning Center.** Create a Church Center **Registrations** event with time slots ("All In Appointment"), copy its public link, set `SCHEDULING_URL`. Set `ALL_IN_GATHERING_URL` to your monthly **All In gathering** registration link so the appointment page also offers the group option.

The app doesn't need an API from the scheduler: the person books there, comes back, and taps **I've scheduled my appointment**. Your team sees it under **Admin → Appointments**.

### Optional: automatic Planning Center handoff
When someone confirms their appointment, the app can create/match them in **People** and drop a card in a **Workflow** so your follow-up runs in PCO:
1. Planning Center → People → **Workflows → New** "All In follow-up" with steps like *Assign connector → Appointment held → Invite to All In gathering → Connected to a group*. Note the ID in the URL.
2. https://api.planningcenteronline.com/oauth/applications → **Personal Access Tokens → Create** (People scope). Copy App ID + Secret.
3. Set `PCO_APP_ID`, `PCO_SECRET`, `PCO_WORKFLOW_ID` in Render. Done — `app/services/planning_center.rb` does the rest.

---

## Part 7 — Editing content

- **Lessons** (titles, order, descriptions, text bodies, Vimeo IDs, thumbnails, speaker notes): **Admin → Lessons**. Formatting in text bodies: blank line = paragraph, `## Heading`, `- bullet`, `**bold**`, `> quote`.
- **Steps' titles/descriptions, assessment questions and category write-ups**: edit `db/seeds.rb` and run `bin/rails db:seed` again (locally, or `render ssh` → `bin/rails db:seed`). Seeds are idempotent — they update existing records by slug/position and never delete people's answers.
- **FAQ, Terms, Privacy**: `app/views/pages/*.html.erb`.
- **Theme**: `config/tailwind.config.js` (colors) and `app/assets/stylesheets/application.tailwind.css`.
- **Church name / email / links**: env vars (`CHURCH_NAME`, `CHURCH_EMAIL`, `SCHEDULING_URL`, `ALL_IN_GATHERING_URL`).

Make someone an admin: `bin/rails "all_in:admin[their@email.com]"`.

---

## Part 8 — Launch checklist (maps to your roadmap Phase 7)

- [ ] All 8 lessons reviewed by pastors; Five C's wording finalized
- [ ] Vimeo IDs on all video lessons (`bin/rails all_in:status` shows gaps) or unfinished ones unpublished
- [ ] Thumbnails uploaded
- [ ] Assessment category write-ups reviewed; serve-team names match your real teams
- [ ] `SCHEDULING_URL` live and tested end-to-end by a team member
- [ ] Password-reset email received on a real inbox
- [ ] Terms & Privacy replaced with reviewed text
- [ ] Pilot: 5–10 people from one Encounter Group go through it on their phones; fix gaps
- [ ] Add "Start the All In pathway → allin.encounterny.com" to the Clover site menu and the Sunday connect card
- [ ] Train connectors on **Admin → People** (they can see results before the appointment)

---

## Project layout
```
app/services/pathway.rb          gating logic: what's locked, current, complete; "My Next Step"
app/services/planning_center.rb  optional PCO handoff
app/controllers/                 dashboard (next step), progress, lessons, assessments, appointments, admin/*
app/views/                       all screens; devise/ = auth; admin/ = team tools
app/javascript/controllers/      vimeo_controller.js (marks complete on "ended"), assessment_controller.js
db/seeds.rb                      ALL content: steps, lessons + speaker notes, 3 assessments
docs/CONTENT_GUIDE.md            video plan, scripts outline, how the lessons map to the All In roadmap
```
