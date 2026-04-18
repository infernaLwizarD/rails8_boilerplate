import { Controller } from "@hotwired/stimulus"

// --- Sidebar state persistence ---
//
// Сохраняем состояние sidebar (скрыт/раскрыт) в localStorage и восстанавливаем
// при навигации через Turbo Drive. AdminLTE привязывает обработчики на toggle-кнопку
// при DOMContentLoaded — здесь мы только управляем CSS-классом и персистентностью.
//
// Особый случай: клик по ссылке внутри скрытого sidebar (раскрытого через hover).
// Без обработки sidebar резко скрывается и тут же раскрывается (курсор остаётся на месте).
// Решение: оставляем sidebar открытым после навигации, схлопываем при mouseleave.

const STORAGE_KEY = "sidebar_collapsed"
const SIDEBAR_SELECTOR = ".app-sidebar"
const TOGGLE_SELECTOR = '[data-lte-toggle="sidebar"]'
const COLLAPSE_CLASS = "sidebar-collapse"

// Флаг: навигация произошла по ссылке из скрытого sidebar
let navigatedFromSidebar = false

const isCollapsed = () => localStorage.getItem(STORAGE_KEY) === "true"
const saveState = () => localStorage.setItem(STORAGE_KEY, document.body.classList.contains(COLLAPSE_CLASS))
const collapse = () => document.body.classList.add(COLLAPSE_CLASS)

// Восстанавливаем состояние при загрузке модуля (выполняется до первого рендера)
if (isCollapsed()) collapse()

document.addEventListener("click", (e) => {
  // Клик по ссылке в sidebar — запоминаем, был ли sidebar скрыт
  if (e.target.closest(`${SIDEBAR_SELECTOR} a[href]`)) navigatedFromSidebar = isCollapsed()
  // Клик по toggle-кнопке — сохраняем новое состояние после того как AdminLTE переключит класс
  if (e.target.closest(TOGGLE_SELECTOR)) requestAnimationFrame(saveState)
})

// Turbo Drive: применяем состояние к новому body ДО вставки в DOM.
// Если навигация из sidebar — пропускаем, чтобы sidebar остался открытым.
document.addEventListener("turbo:before-render", (e) => {
  if (!navigatedFromSidebar && isCollapsed()) e.detail.newBody.classList.add(COLLAPSE_CLASS)
})

// После рендера новой страницы: если навигация была из sidebar —
// схлопываем sidebar при уходе курсора (once: true — сработает один раз)
document.addEventListener("turbo:load", () => {
  if (!navigatedFromSidebar) return
  navigatedFromSidebar = false

  document.querySelector(SIDEBAR_SELECTOR)
    ?.addEventListener("mouseleave", collapse, { once: true })
})

// --- Stimulus: подсветка активного пункта меню ---
//
// Sidebar помечен data-turbo-permanent — Turbo Drive не перерисовывает его.
// Active-класс обновляется клиентски при каждом connect() (Turbo Drive навигация).

export default class extends Controller {
  connect() {
    const path = window.location.pathname
    this.element.querySelectorAll(".nav-link").forEach((link) => {
      const href = new URL(link.href, window.location.origin).pathname
      link.classList.toggle("active", href !== "/" && path.startsWith(href))
    })
  }
}
