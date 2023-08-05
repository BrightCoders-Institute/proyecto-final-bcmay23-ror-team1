import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["image", "submit"]

  update(event) {
    // Update the avatar image
    const file = event.target.files[0]
    if (file) {
      const reader = new FileReader()
      reader.onload = (e) => {
        this.imageTarget.src = e.target.result
      }
      reader.readAsDataURL(file)
    }

    //Update the text of the submit button
    this.submitTarget.value = 'Next'
  }

}
