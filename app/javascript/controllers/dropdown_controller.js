import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {

  }

  toggleMenu() {
    this.menuTarget.classList.toggle("hidden")
  }
}
  
  
