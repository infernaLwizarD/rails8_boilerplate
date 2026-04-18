import { Controller } from "@hotwired/stimulus"

// Stimulus: подсчёт символов в реальном времени
// Демонстрирует: input events, targets, values
export default class extends Controller {
  static targets = ["input", "count"]
  static values = { max: { type: Number, default: 140 } }

  connect() {
    this.#update()
  }

  #update() {
    const length = this.inputTarget.value.length
    const remaining = this.maxValue - length
    this.countTarget.textContent = remaining
    this.countTarget.className = remaining < 0
      ? "text-danger fw-bold"
      : remaining < 20
        ? "text-warning"
        : "text-muted"
  }

  input() {
    this.#update()
  }
}
