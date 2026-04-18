import { Controller } from "@hotwired/stimulus"

// Stimulus: автоматический сброс формы после успешной отправки через Turbo
// Демонстрирует: прослушивание событий Turbo, интеграция Stimulus + Turbo
export default class extends Controller {
  reset() {
    this.element.reset()
  }
}
