import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  destroyButton(event) {
    this.element.remove()
  }
}
