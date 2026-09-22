# All In — Encounter Church NY · Go-live guide

Status as of Sep 22, 2026: the app is **built, deployed, and running** at https://all-in-wvrx.onrender.com with Postgres on Render, all five videos on Vimeo, admin working. This README is only what's left to make it live at `allin.encounterny.com` and fully operational. Do the sections in order; each says who can do it and how long it takes.

Stack recap: Rails 7.2 · Postgres (Render) · Devise auth · Active Storage thumbnails (Cloudflare R2) · Vimeo · Tailwind/Hotwire · Docker on Render.

---

## 0. Apply this update (you, 10 min)

This release changes content and adds the profile feature. From the repo root:

```bash
# copy the updated files from all-in-update.zip over your repo (it only contains changed/new files)
unzip -o ~/Downloads/all-in-update.zip -d .
git add -A
git commit -m "Five-video pathway, gathering RSVP, profile + learn-more"
git push origin main
```

Render auto-deploys. The pre-deploy command (`bin/rails db:prepare db:seed`) runs the new `growth_interests` migration and re-seeds:

- Lessons become the **five real videos** (IDs + unlisted hashes already in `db/seeds.rb`); old lessons 6–8 are deleted.
- Step Three is now **RSVP for the All In Sunday Gathering** (monthly), matching what the videos say.
- Results pages get **"Want to grow in any of these?"** checkboxes; **My Profile** (`/my_profile`) shows strengths + growth areas; Admin → People shows them too; Admin → Assessments shows "learn more" demand per category.

Verify after deploy: sign in as admin → `/admin` shows 5 lessons, all with Vimeo IDs → open `/my_progress` → lesson 1 plays (Render domain is on Vimeo's allow-list).

Local dev (if you want it): `bin/rails db:migrate db:seed` then `bin/dev`.

---

## 1. Domain — `allin.encounterny.com` (church GoDaddy admin, 2 min) ← the only blocker

encounterny.com's DNS is at **GoDaddy** (nameservers `ns45/ns46.domaincontrol.com`). A subdomain can only be created inside that account; it can't be registered separately.

Ask the admin to do exactly this:

> GoDaddy → My Products → next to **encounterny.com** click **DNS** → **Add New Record**
> Type **CNAME** · Name **allin** · Value **all-in-wvrx.onrender.com** · TTL default → Save.
> Don't change any other record.

Better long-term: ask them to also add you as a **Delegate** (Account Settings → Delegate Access → invite your email, "Products, Domains & Purchase"). You'll need DNS again for email (section 4).

Then, you:
1. `nslookup allin.encounterny.com` → should answer `all-in-wvrx.onrender.com` (minutes to an hour).
2. Render → all-in → Settings → Custom Domains → the row flips to **Verified**, certificate issues automatically. (Already added; nothing to click except the refresh icon.)
3. Vimeo → Settings → Videos → Upload defaults → Privacy → **Where can your videos be embedded?** → confirm `allin.encounterny.com` is in the list (add if missing; keep `all-in-wvrx.onrender.com` until launch, then remove it).
4. Open https://allin.encounterny.com and play a lesson.

**Cloudflare (DNS/proxy) is not needed.** Only use it if the church later wants encounterny.com's nameservers moved to Cloudflare — separate decision, not required for launch.

**Stopgap if the admin is unreachable:** buy a domain you own (e.g. `encounterallin.com`, ~$12/yr) at any registrar, add the same CNAME there, add it in Render → Custom Domains and in Vimeo's allow-list, and set `APP_HOST` in Render → Environment to it. Switch to the real subdomain later.

---

## 2. Cloudflare R2 — lesson thumbnails (you, 10 min)

Domain-independent. Without it, thumbnails fall back to a blue gradient (fine for launch, but nicer with stills).

1. dash.cloudflare.com → **Storage & databases → R2 Object Storage** → **Create bucket** → `all-in-media`, location Automatic.
2. R2 overview → **Manage R2 API Tokens** (now lands on Account API tokens) → **Create Token** → Custom → name `all-in-render` → Permissions: **Workers R2 Storage → Edit** (or "Object Read & Write" if offered) → Account resources: your account → (bucket scope `all-in-media` if offered) → Create.
3. On the confirmation page copy the **S3 client credentials**: Access Key ID and Secret Access Key (shown once). If the page shows only an API token and no S3 credentials, the permissions were wrong — delete and redo.
4. **Account ID**: 32-char hex on the R2 overview page (also in the dashboard URL).
5. Render → all-in → **Environment** → `R2_ACCOUNT_ID`, `R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY`; `R2_BUCKET` = `all-in-media` → Save (auto-redeploy).
6. Test: Admin → Lessons → Edit → upload a 1920×1080 JPG still → Save → My Progress shows it.

---

## 3. Gathering RSVP link — Step Three (church office / you, 15 min)

Step Three sends people to `ALL_IN_GATHERING_URL`. Use Planning Center since the church already runs Church Center:

1. Planning Center **Registrations** (or Calendar) → New event **"All In Sunday Gathering"** → add the next date(s) → capacity as needed → publish to Church Center.
2. Copy the public Church Center link (looks like `https://ecny.churchcenter.com/registrations/events/…`). Tip: create a recurring or "next gathering" signup page so the link never changes.
3. Render → Environment → `ALL_IN_GATHERING_URL` = that link → Save.

Optional one-on-one fallback (shown on the RSVP page as "Can't make a Sunday?"): create a free **Calendly** event "All In conversation" and set `SCHEDULING_URL`. Leave blank to hide it.

---

## 4. Email — password resets (you + GoDaddy admin, 20 min)

Only affects "Forgot password". Everything else works without it.

1. resend.com → sign up (free) → **Domains → Add domain** `encounterny.com` (or `mail.encounterny.com` to keep it separate).
2. Resend shows 3 DNS records (SPF TXT, DKIM TXT, MX for bounces). **Send them to the GoDaddy admin in the same request as the CNAME** from section 1.
3. Resend → **API Keys → Create** → copy.
4. Render → Environment: `SMTP_ADDRESS=smtp.resend.com`, `SMTP_PORT=587`, `SMTP_USERNAME=resend`, `SMTP_PASSWORD=<api key>`, `MAIL_FROM=All In <allin@encounterny.com>` → Save.
5. Test: `/users/password/new` with your email.

Interim without DNS access: a church Google Workspace mailbox with an **app password** works — `SMTP_ADDRESS=smtp.gmail.com`, `SMTP_PORT=587`, `SMTP_USERNAME=<mailbox>`, `SMTP_PASSWORD=<app password>`, `MAIL_FROM=<mailbox>`.

---

## 5. Optional — Planning Center handoff (you, 15 min)

When someone confirms their RSVP, the app can create/match them in **People** and drop a card on a **Workflow** so follow-up runs where the team already works.

1. Planning Center People → **Workflows → New** "All In follow-up" with steps like *Attended gathering → Connected to group / serve team → Member*. Note the numeric ID in the URL.
2. https://api.planningcenteronline.com/oauth/applications → **Personal Access Tokens → Create** (People scope) → copy Application ID + Secret.
3. Render → Environment → `PCO_APP_ID`, `PCO_SECRET`, `PCO_WORKFLOW_ID` → Save. Code: `app/services/planning_center.rb`.

---

## 6. Content and copy review (pastors + you, 1 hour)

- **Lessons**: Admin → Lessons → read each summary under the video (written from the transcripts); fix anything that doesn't sound like Encounter. Upload a thumbnail still for each (section 2).
- **Assessments**: Admin → Assessments → review statements and category write-ups. Edit the `serve:` lists in `db/seeds.rb` to match real Serve Team names, then push (seeds re-run on deploy; answers are preserved).
- **FAQ / Terms / Privacy**: `app/views/pages/*.html.erb` — Terms and Privacy are placeholders and need pastoral sign-off.
- Church email is `Connect@EncounterNY.com` via `CHURCH_EMAIL`; change in Render → Environment if needed.

---

## 7. Launch checklist

- [ ] CNAME live, Render shows Verified, `https://allin.encounterny.com` plays a lesson
- [ ] Render domain removed from Vimeo's allow-list (after launch)
- [ ] `ALL_IN_GATHERING_URL` set and tested end-to-end (RSVP page opens the Church Center event)
- [ ] Thumbnails uploaded (R2 configured)
- [ ] Password-reset email received
- [ ] Terms & Privacy replaced
- [ ] Admin password rotated (Account page); at least one pastor/team member made admin: `bin/rails "all_in:admin[email]"` via Render → Shell, or ask them to sign up and run it
- [ ] Pilot: 5–10 people from one Encounter Group do the whole pathway on their phones (`bin/rails "all_in:reset[email]"` resets a tester)
- [ ] Clover site: add "All In → allin.encounterny.com" to the Connect menu; mention it in the Sunday announcement (the videos ask people to complete all five before they RSVP)
- [ ] Team trained on Admin → People (strengths + "wants to learn more" are on each person's page) and Admin → RSVPs

---

## Where things live

```
db/seeds.rb                          ALL content: 3 steps, 5 lessons (Vimeo IDs, summaries), 3 assessments
app/services/pathway.rb              gating: lessons → assessments → gathering RSVP
app/controllers/growth_interests_controller.rb   "learn more" opt-ins
app/views/assessments/plan.html.erb  My Profile
app/views/appointments/show.html.erb Step Three (gathering RSVP)
app/services/planning_center.rb      optional PCO handoff
docs/ROADMAP.md                      running future classes on this engine
docs/CONTENT_GUIDE.md                video/lesson mapping and transcript notes
```

Useful commands (Render → all-in → Shell): `bin/rails all_in:status` · `bin/rails "all_in:admin[email]"` · `bin/rails "all_in:reset[email]"` · `bin/rails db:seed`
