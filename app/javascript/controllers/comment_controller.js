import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["commentBox"]

  clearComment(event) {
    if (event.detail.success) {
      this.commentBoxTarget.value = ""
    }
  }
}
