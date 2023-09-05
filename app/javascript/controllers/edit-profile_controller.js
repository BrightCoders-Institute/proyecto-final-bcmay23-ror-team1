import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["avatar", "banner"]

  refreshImage(event, imageTarget) {
    // Update the avatar image
    const file = event.target.files[0]
    if (file) {
      const reader = new FileReader()
      reader.onload = (e) => {
	imageTarget.src = e.target.result
      }
      reader.readAsDataURL(file)
    }
  }

  refreshBanner(event) {
    this.refreshImage(event, this.bannerTarget); 
  }
    
  refreshAvatar(event) {
    this.refreshImage(event, this.avatarTarget);
  }
  
}
