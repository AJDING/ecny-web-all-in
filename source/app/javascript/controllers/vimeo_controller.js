// Marks a video lesson complete when Vimeo fires "ended", then enables Next.
// Uses the Vimeo Player SDK loaded in the layout (window.Vimeo).
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frame", "next", "status"]
  static values  = { completeUrl: String, completed: Boolean, nextUrl: String }

  connect() {
    if (!window.Vimeo || !this.hasFrameTarget) return
    this.player = new window.Vimeo.Player(this.frameTarget)
    if (!this.completedValue) {
      this.player.on("ended", () => this.markComplete())
      // Also count as complete once 95% has been watched (people close the end card early).
      this.player.on("timeupdate", (d) => { if (d.percent >= 0.95) this.markComplete() })
    }
  }

  disconnect() { this.player?.unload?.() }

  async markComplete() {
    if (this.completedValue) return
    this.completedValue = true
    const token = document.querySelector('meta[name="csrf-token"]')?.content
    const res = await fetch(this.completeUrlValue, {
      method: "POST", headers: { "X-CSRF-Token": token, "Accept": "application/json" }, credentials: "same-origin"
    })
    if (res.ok) {
      const data = await res.json()
      if (this.hasNextTarget) {
        this.nextTarget.removeAttribute("disabled")
        this.nextTarget.removeAttribute("aria-disabled")
        this.nextTarget.href = data.next_url || this.nextUrlValue
        this.nextTarget.classList.remove("pointer-events-none", "opacity-50")
      }
      if (this.hasStatusTarget) this.statusTarget.textContent = "Complete"
    }
  }
}
