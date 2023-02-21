// app/javascript/controllers/address_autocomplete_controller.js
import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["address"]

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      placeholder: 'Држава,регион или место',
      types: "country,region,place",
      language: 'en'
    })
    this.geocoder.addTo(this.element)
    this.geocoder.setInput(this.addressTarget.value)
    this.geocoder.on("result", event => { this.#setInputValue(event)})
    this.geocoder.on("clear", () => this.#clearInputValue())
  }

  disconnect() {
    this.geocoder.onRemove()
  }

  #setInputValue(event) {
    const selectedPlace = event.result.place_name
    this.addressTarget.value = selectedPlace
  }

  #clearInputValue() {
    this.addressTarget.value = ""
  }
}
