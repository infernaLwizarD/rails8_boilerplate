import { Controller } from "@hotwired/stimulus"

// Сворачивает sidebar на мобильных при Turbo Drive навигации
export default class extends Controller {
  connect() {
    this.handleNavigation = this.collapseSidebarOnMobile.bind(this)
    document.addEventListener('turbo:visit', this.handleNavigation)
  }

  disconnect() {
    document.removeEventListener('turbo:visit', this.handleNavigation)
  }

  collapseSidebarOnMobile() {
    if (window.innerWidth >= 992) return

    const sidebarToggle = document.querySelector('[data-lte-toggle="sidebar"]')
    if (sidebarToggle) sidebarToggle.click()
  }
}
