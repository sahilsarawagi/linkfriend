import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'toggle', 'btn' ]

  toggle(event) {
    const targetIndex = event.target.dataset.index;
    this.toggleTargets.forEach((target, index) => {
      if (index == targetIndex) {
        target.classList.remove('hidden');
      } else {
        target.classList.add('hidden');
      }
    });
  }

  btntoggle(event) {
    const targetIndex = event.target.dataset.index;
    this.btnTargets.forEach((target, index) => {
      if (index == targetIndex) {
        target.classList.remove('transition-colors', 'duration-300', 'dark:text-blue-400', 'dark:hover:text-white', 'focus:outline-none', 'hover:bg-blue-600', 'hover:text-white');
        target.classList.add('text-white', 'bg-blue-600');
      } else {
        target.classList.add('transition-colors', 'duration-300', 'dark:text-blue-400', 'dark:hover:text-white', 'focus:outline-none', 'hover:bg-blue-600', 'hover:text-white');
        target.classList.remove('text-white','bg-blue-600');
      }
    });
  }
}
