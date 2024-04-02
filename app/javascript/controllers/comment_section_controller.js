import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["commentForm","commentSection"]

  connect() {
  }

  toggleCommentForm() {
    this.commentFormTarget.classList.toggle("hidden")
  }

  toggleComments() {
    this.commentSectionTarget.classList.toggle("hidden")
  }

  outsideClick(event) {
    console.log("clicked")
    // Ignore event if clicked within element
    if(this.element === event.target || this.element.contains(event.target)) return;

    // close the menu on clicking outside
    this.closeMenu()
  }

  closeMenu(){
    this.commentFormTarget.classList.add("hidden")
  }
}
  
  
