import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["largemenu","smallmenu"]
  myTarget = null;

  connect() {
    if (window.matchMedia('(max-width: 768px)').matches){
    // When the screen is medium and samll 
    this.myTarget = this.smallmenuTarget
    this.myTarget.classList.add("absolute")
    }else{
    // When the screen is large than medium  
    this.myTarget = this.largemenuTarget
    }
  }

  toggleMenu() {
    this.myTarget.classList.toggle("hidden")
  }
  outsideClick(event) {
    // Ignore event if clicked within element
    if(this.element === event.target || this.element.contains(event.target)) return;

    // prevent any event when dropdown is open
    if(!this.myTarget.classList.contains("hidden")) event.preventDefault();
    
    // close the menu on clicking outside
    this.closeMenu()
  }
  closeMenu(){
    this.myTarget.classList.add("hidden")
  }
}
  
  
