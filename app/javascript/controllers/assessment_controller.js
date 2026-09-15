// Shows "answered X of N" and keeps the submit button honest.
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["counter", "submit"]
  static values  = { total: Number }

  connect() { this.update() }

  update() {
    const answered = new Set([...this.element.querySelectorAll("input[type=radio]:checked")].map(i => i.name)).size
    if (this.hasCounterTarget) this.counterTarget.textContent = `${answered} of ${this.totalValue} answered`
    if (this.hasSubmitTarget)  this.submitTarget.disabled = answered < this.totalValue
  }
}
