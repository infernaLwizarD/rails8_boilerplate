import { Controller } from "@hotwired/stimulus"

// Stimulus: автоматическое обновление Turbo Frame по таймеру
// Демонстрирует: values, connect/disconnect lifecycle, интеграция с Turbo Frames
export default class extends Controller {
  static values = {
    interval: { type: Number, default: 5000 },
    running: { type: Boolean, default: false }
  }
  static targets = ["status"]

  connect() {
    this.#updateStatus()
  }

  disconnect() {
    this.#stop()
  }

  toggleAutoRefresh() {
    this.runningValue ? this.#stop() : this.#start()
  }

  #start() {
    this.runningValue = true
    this.timer = setInterval(() => {
      const frame = this.element.querySelector("turbo-frame")
      if (frame) frame.reload()
    }, this.intervalValue)
    this.#updateStatus()
  }

  #stop() {
    this.runningValue = false
    if (this.timer) clearInterval(this.timer)
    this.#updateStatus()
  }

  #updateStatus() {
    if (!this.hasStatusTarget) return
    this.statusTarget.textContent = this.runningValue ? "Активно" : "Остановлено"
    this.statusTarget.className = this.runningValue
      ? "badge bg-success"
      : "badge bg-secondary"
  }
}
