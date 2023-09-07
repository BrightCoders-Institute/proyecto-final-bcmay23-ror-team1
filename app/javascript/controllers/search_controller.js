import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  change(event) {
    const form = document.querySelector('#form-search');
    form.requestSubmit();

    console.log('change');
  }
}