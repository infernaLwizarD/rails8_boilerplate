import { Controller } from "@hotwired/stimulus"

// Stimulus + Turbo Streams: серверный счётчик
// Демонстрирует: чтение состояния из DOM, передачу в hidden-поля перед отправкой формы
export default class extends Controller {
  static targets = ["display", "currentField"]

  updateFields() {
    const currentValue = parseInt(this.displayTarget.textContent) || 0
    this.currentFieldTargets.forEach(field => {
      field.value = currentValue
    })
  }
}
