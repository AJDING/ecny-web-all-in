# Roadmap: from All In to a classes platform

The engine already generalizes: a **Step** groups **Lessons** (video/text) and **Assessments** (statements → scored categories); people get **completions**, **results**, and **growth interests**. All In is just the first track.

## What the profile does today
- **Strengths** = top-N categories per completed assessment (`User#strengths`).
- **Growth areas** = categories the person ticked "learn more" on (`User#growth_areas`, table `growth_interests`).
- Both show on `/my_profile`, on Admin → People, and Admin → Assessments shows demand per category ("12 want to learn more about Intercession") — use that to decide which class to run next.

## Adding future classes (e.g. "Prayer & Intercession 101", "Foundations", "Serve Team Basics")
Minimal path, in order:
1. **Tracks** — add `tracks` table (`slug`, `title`, `description`, `published`, `position`) and `track_id` on `steps`. Seed All In as track `all-in`. Gate `Pathway` by track. Estimated: 1 migration, ~40 lines in `Pathway`, one index page listing tracks.
2. **Enrollment** — `enrollments` (`user_id`, `track_id`, `completed_at`). "Start class" creates one; My Progress gets a track switcher.
3. **Recommendations** — on `/my_profile`, list published tracks whose `categories` overlap the person's growth areas ("You said you'd like to learn more about Intercession — the Prayer class starts Oct 12"). Tracks get a `categories` array column mapped to assessment category names.
4. **Re-assess** — allow retakes per track; keep history (`assessment_results` gains `track_id`, drop the unique index) so a profile shows growth over time.
5. **Admin** — a Tracks page mirroring Admin → Lessons, so pastors can publish a class without a deploy.

Keep the constraint that made Mercy Culture's Connect work: every track is a handful of short videos, a light assessment, and one in-person moment. Don't turn it into an LMS.
