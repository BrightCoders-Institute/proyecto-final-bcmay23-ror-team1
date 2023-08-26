import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  scrollToThis() {
    console.log("done");
    this.element.scrollIntoView({ behavior: "smooth" });
  }
}
