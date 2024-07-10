import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["notification", "usermenu", "burgermenu"]

  connect() {
    // Bind the outsideClick method to `this` context
    this.boundOutsideClick = this.outsideClick.bind(this)
    document.addEventListener("click", this.boundOutsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this.boundOutsideClick)
  }

  toggleUserMenu() {
    this.usermenuTarget.classList.toggle("hidden")
    this.notificationTarget.classList.add("hidden")
    this.burgermenuTarget.classList.add("hidden")
  }

  toggleBurgerMenu() {
    this.burgermenuTarget.classList.toggle("hidden")
    this.usermenuTarget.classList.add("hidden")
    this.notificationTarget.classList.add("hidden")
  }

  toggleNotificationMenu() {
    this.notificationTarget.classList.toggle("hidden")
    this.usermenuTarget.classList.add("hidden")
    this.burgermenuTarget.classList.add("hidden")
  }

  outsideClick(event) {
    if (this.element.contains(event.target)) return
    if(!this.burgermenuTarget.classList.contains("hidden") ||
       !this.usermenuTarget.classList.contains("hidden") ||
       !this.notificationTarget.classList.contains("hidden")) event.preventDefault();

    this.closeMenu()
  }

  closeMenu() {
    this.usermenuTarget.classList.add("hidden")
    this.notificationTarget.classList.add("hidden")
    this.burgermenuTarget.classList.add("hidden")
  }
}
