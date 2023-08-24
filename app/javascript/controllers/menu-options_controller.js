import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["options"]
  show() {
    this.optionsTarget.classList.toggle("hidden");
  }

  close() {

  }
}