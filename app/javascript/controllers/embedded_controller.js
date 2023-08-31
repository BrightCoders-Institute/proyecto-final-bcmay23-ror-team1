import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["frameContainer"]

  connect() {
    this.frameLoaded = false;
  }

  showEmbedded() {
    if (!this.frameLoaded) {
      const embeddedFrame = this.frameContainerTarget.querySelector('turbo-frame');
      embeddedFrame.addEventListener('turbo:load', () => {
        this.frameContainerTarget.style.display = 'block';
        this.frameLoaded = true;
      });

      embeddedFrame.dispatchEvent(new Event('turbo:load'));
    } else {
      this.frameContainerTarget.style.display = 'block';
    }
  }
}
