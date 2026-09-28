// Tooltip + highlight for the capacity pie. Hover (or tap, on touch) a slice or a legend row.
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["svg", "tip", "swatch", "label", "share", "score"]

  show(event) {
    const el = event.currentTarget
    this.pinned = false
    this.render(el)
    this.move(event)
  }

  move(event) {
    if (this.tipTarget.classList.contains("hidden")) return
    const box = this.element.getBoundingClientRect()
    const tip = this.tipTarget
    let x = event.clientX - box.left + 14
    let y = event.clientY - box.top + 14
    if (x + tip.offsetWidth > box.width) x = event.clientX - box.left - tip.offsetWidth - 14
    if (y + tip.offsetHeight > box.height) y = event.clientY - box.top - tip.offsetHeight - 14
    tip.style.left = `${Math.max(0, x)}px`
    tip.style.top = `${Math.max(0, y)}px`
  }

  hide() {
    if (this.pinned) return
    this.tipTarget.classList.add("hidden")
    this.tipTarget.setAttribute("aria-hidden", "true")
    this.highlight(null)
  }

  // Touch devices have no hover: tap a slice to pin its card, tap again (or elsewhere) to close.
  toggle(event) {
    const el = event.currentTarget
    if (this.pinned && this.current === el.dataset.index) {
      this.pinned = false
      this.hide()
      return
    }
    this.render(el)
    this.move(event)
    this.pinned = true
  }

  render(el) {
    const { index, label, share, score } = el.dataset
    this.current = index
    const slice = this.svgTarget.querySelector(`.pie-slice[data-index="${index}"]`)
    this.swatchTarget.style.background = slice ? slice.getAttribute("fill") : "#3B6FE8"
    this.labelTarget.textContent = label
    this.shareTarget.textContent = `${share}%`
    this.scoreTarget.textContent = `${score}%`
    this.tipTarget.classList.remove("hidden")
    this.tipTarget.setAttribute("aria-hidden", "false")
    this.highlight(index)
  }

  highlight(index) {
    this.svgTarget.querySelectorAll(".pie-slice").forEach(s => {
      const on = s.dataset.index === index
      s.style.opacity = index === null || on ? "1" : "0.45"
      s.style.transform = on ? "scale(1.04)" : ""
      s.style.transformOrigin = "100px 100px"
      s.style.transition = "opacity .15s, transform .15s"
    })
    this.element.querySelectorAll(".pie-legend").forEach(l => {
      l.classList.toggle("bg-panel", l.dataset.index === index)
    })
  }

  disconnect() { this.pinned = false }
}
