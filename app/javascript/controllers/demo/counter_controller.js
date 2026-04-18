import { Controller } from "@hotwired/stimulus"

// Stimulus: реактивное управление состоянием на клиенте
// Демонстрирует: targets, values, actions, CSS classes
export default class extends Controller {
  static targets = ["count"]
  static values = { count: { type: Number, default: 0 } }

  increment() {
    this.countValue++
    this.#render()
  }

  decrement() {
    this.countValue--
    this.#render()
  }

  reset() {
    this.countValue = 0
    this.#render()
  }

  #render() {
    this.countTarget.textContent = this.countValue
    this.countTarget.classList.toggle("text-danger", this.countValue < 0)
    this.countTarget.classList.toggle("text-success", this.countValue > 0)
  }
}
