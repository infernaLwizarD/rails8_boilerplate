import { Controller } from "@hotwired/stimulus"

// Stimulus: взаимодействие с Clipboard API
// Демонстрирует: targets, async actions, UI feedback
export default class extends Controller {
  static targets = ["source", "button"]

  async copy() {
    const text = this.sourceTarget.value || this.sourceTarget.textContent
    await navigator.clipboard.writeText(text)

    const original = this.buttonTarget.innerHTML
    this.buttonTarget.innerHTML = '<i class="fas fa-check"></i> Скопировано!'
    this.buttonTarget.classList.replace("btn-outline-secondary", "btn-success")

    setTimeout(() => {
      this.buttonTarget.innerHTML = original
      this.buttonTarget.classList.replace("btn-success", "btn-outline-secondary")
    }, 2000)
  }
}
