import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = { delay: { type: Number, default: 4444 } }

    connect() {
        this.timeout = setTimeout(() => {
            this.dismiss()
        }, this.delayValue)
    }

    disconnect() {
        clearTimeout(this.timeout)
    }

    dismiss() {
        this.element.remove()
    }
}
