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
      placeholder: 'Држава/Регион/Град',
      types: "country,region,place"
    })
    this.geocoder.addTo(this.element)
    this.geocoder.setInput(this.addressTarget.value)
    this.geocoder.on("loading", () =>console.log("on load event") )
    this.geocoder.on("results", (res, e) => {
      console.log("on results event")
      console.log(res)
      console.log(e)
    })
    this.geocoder.on("result", event => {
      this.#setInputValue(event)
      console.log('result event test  ');
    })
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
