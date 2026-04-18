import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.updateActiveLink()
  }

  updateActiveLink() {
    const path = window.location.pathname
    this.element.querySelectorAll(".nav-link").forEach((link) => {
      const href = new URL(link.href, window.location.origin).pathname
      if (href !== "/" && path.startsWith(href)) {
        link.classList.add("active")
      } else {
        link.classList.remove("active")
      }
    })
  }
}
