import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["images", "textarea", "submit"]

  connect() {
    this.textareaTarget.style.height = this.textareaTarget.scrollHeight + 'px'
  }

  onInputTextarea() {
    // Auto resizes the text area based on the content
    this.textareaTarget.style.height = 'auto'
    this.textareaTarget.style.height = this.textareaTarget.scrollHeight + 'px'

    // Allows to post if not empty
    this.submitTarget.disabled = this.textareaTarget.value.trim() == ""
  }

  previewImages(event) {
    const files = event.target.files

    if (files.length > 0) {

      // Clean the previous images list
      const previousImages = this.imagesTarget.querySelectorAll(".image-preview")
      for (const prevImg of previousImages) {
        prevImg.remove()
      } 

      // Create and show the new images list
      for (const file of files) {
        const reader = new FileReader()
        reader.onload = (e) => {
        
          let newImage = this.imagesTarget.querySelector(".image-preview-hidden").cloneNode()
          newImage.classList.remove("image-preview-hidden")
          newImage.classList.add("image-preview")
          newImage.src = e.target.result 
          this.imagesTarget.appendChild(newImage)

        }
        reader.readAsDataURL(file)
      } 

    }

  }

}
