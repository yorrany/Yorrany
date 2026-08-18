import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "copyButton", "copyIcon", "checkIcon", "copyText",
    "form", "successMessage", "errorMessage", "errorText",
    "nameInput", "emailInput", "messageInput", "honeypotInput",
    "submitButton", "submitButtonText", "spinner"
  ]

  copyEmail(event) {
    event.preventDefault()
    const email = "falecom@yorrany.com.br"
    navigator.clipboard.writeText(email).then(() => {
      if (this.hasCopyIconTarget) this.copyIconTarget.classList.add("hidden")
      if (this.hasCheckIconTarget) this.checkIconTarget.classList.remove("hidden")
      if (this.hasCopyTextTarget) {
        const oldText = this.copyTextTarget.innerText
        this.copyTextTarget.innerText = "Copiado!"

        setTimeout(() => {
          if (this.hasCopyIconTarget) this.copyIconTarget.classList.remove("hidden")
          if (this.hasCheckIconTarget) this.checkIconTarget.classList.add("hidden")
          if (this.hasCopyTextTarget) this.copyTextTarget.innerText = oldText
        }, 2500)
      }
    })
  }

  async submit(event) {
    event.preventDefault()

    const name = this.hasNameInputTarget ? this.nameInputTarget.value.trim() : ""
    const email = this.hasEmailInputTarget ? this.emailInputTarget.value.trim() : ""
    const message = this.hasMessageInputTarget ? this.messageInputTarget.value.trim() : ""
    const nickname = this.hasHoneypotInputTarget ? this.honeypotInputTarget.value.trim() : ""

    if (!name || !email || !message) {
      this.showError("Por favor, preencha todos os campos.")
      return
    }

    this.setLoading(true)
    this.hideError()

    try {
      const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content || ""

      const response = await fetch("/contact", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "X-CSRF-Token": csrfToken
        },
        body: JSON.stringify({
          name: name,
          email: email,
          message: message,
          nickname: nickname
        })
      })

      const data = await response.json()

      if (response.ok && data.success) {
        this.formTarget.classList.add("hidden")
        if (this.hasSuccessMessageTarget) this.successMessageTarget.classList.remove("hidden")
        this.formTarget.reset()
      } else {
        this.showError(data.error || "Ocorreu um erro ao enviar sua mensagem. Tente novamente.")
      }
    } catch (err) {
      console.error("[ContactForm] Erro ao enviar:", err)
      this.showError("Falha de conexão ao enviar a mensagem. Verifique sua internet e tente novamente.")
    } finally {
      this.setLoading(false)
    }
  }

  setLoading(isLoading) {
    if (!this.hasSubmitButtonTarget) return

    this.submitButtonTarget.disabled = isLoading

    if (this.hasSpinnerTarget) {
      if (isLoading) {
        this.spinnerTarget.classList.remove("hidden")
      } else {
        this.spinnerTarget.classList.add("hidden")
      }
    }

    if (this.hasSubmitButtonTextTarget) {
      if (isLoading) {
        this.submitButtonTextTarget.dataset.originalText = this.submitButtonTextTarget.innerText
        this.submitButtonTextTarget.innerText = "Transmitindo..."
      } else if (this.submitButtonTextTarget.dataset.originalText) {
        this.submitButtonTextTarget.innerText = this.submitButtonTextTarget.dataset.originalText
      }
    }
  }

  showError(msg) {
    if (this.hasErrorMessageTarget) {
      if (this.hasErrorTextTarget) this.errorTextTarget.innerText = msg
      this.errorMessageTarget.classList.remove("hidden")
    } else {
      alert(msg)
    }
  }

  hideError() {
    if (this.hasErrorMessageTarget) {
      this.errorMessageTarget.classList.add("hidden")
    }
  }
}
