import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.hide();
    }, 4000)

    setTimeout(() => {
      this.remove();
    }, 5000)
  }

  hide() {
    this.element.classList.add("hide-animated");
  }

  remove(event) {
    this.element.remove();
  }
}
