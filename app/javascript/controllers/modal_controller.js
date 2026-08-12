import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["europassModal", "caseStudyModal", "certModal"]

  connect() {
    // Bind escape key to close modals
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape") this.closeAll()
    })

    // Check URL params for cert
    const urlParams = new URLSearchParams(window.location.search);
    const certId = urlParams.get('cert');
    if (certId) {
      const certBtn = document.querySelector(`[data-cert-id="${certId}"]`);
      if (certBtn) {
        setTimeout(() => {
          this.openCert({ currentTarget: certBtn, preventDefault: () => {} });
        }, 100); // slight delay to ensure UI is ready
      }
    }
  }

  closeOutside(event) {
    if (event.target === event.currentTarget) {
      this.closeAll()
    }
  }

  openEuropass(event) {
    event.preventDefault()
    this.europassModalTarget.classList.remove("hidden")
    document.body.style.overflow = "hidden"
  }

  closeEuropass(event) {
    if (event) event.preventDefault()
    this.europassModalTarget.classList.add("hidden")
    document.body.style.overflow = "auto"
  }

  openCase(event) {
    event.preventDefault()
    // For now, it opens the modal. In a full implementation, this could fetch
    // a specific case study via turbo frame or show a pre-rendered one based on data-id.
    // For this portfolio, we will just show the modal wrapper.
    const caseId = event.currentTarget.dataset.id
    this.caseStudyModalTarget.classList.remove("hidden")
    document.body.style.overflow = "hidden"
    
    // Select the right case study content
    const contents = this.caseStudyModalTarget.querySelectorAll('.case-study-content')
    contents.forEach(content => {
      if (content.dataset.id === caseId) {
        content.classList.remove('hidden')
      } else {
        content.classList.add('hidden')
      }
    })
  }

  closeCase(event) {
    if (event) event.preventDefault()
    this.caseStudyModalTarget.classList.add("hidden")
    document.body.style.overflow = "auto"
  }

  openCert(event) {
    event.preventDefault()
    let url = event.currentTarget.dataset.url
    
    if (window.innerWidth < 768) {
      const link = document.createElement('a');
      link.href = url;
      link.target = '_blank';
      // Força o navegador mobile a tentar o download ou preview nativo do arquivo ao invés de navegar via JS
      if (event.currentTarget.dataset.isImage !== 'true') {
        link.download = 'Documento';
      }
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      return
    }

    const title = event.currentTarget.dataset.title
    const isImage = event.currentTarget.dataset.isImage === 'true'
    const credCode = event.currentTarget.dataset.credentialCode
    const credUrl = event.currentTarget.dataset.credentialUrl

    this.certModalTarget.classList.remove("hidden")
    document.body.style.overflow = "hidden"
    
    this.certModalTarget.querySelector('#cert-modal-title').textContent = title

    // Credential UI Setup
    const credContainer = this.certModalTarget.querySelector('#cert-modal-credential-container')
    const codeWrapper = this.certModalTarget.querySelector('#cert-modal-code-wrapper')
    const codeEl = this.certModalTarget.querySelector('#cert-modal-credential-code')
    const urlEl = this.certModalTarget.querySelector('#cert-modal-credential-url')

    if (credCode || credUrl) {
      credContainer.classList.remove('hidden')
      credContainer.classList.add('flex')
      
      if (credCode) {
        codeWrapper.classList.remove('hidden')
        codeWrapper.classList.add('flex')
        codeEl.textContent = credCode
        codeWrapper.dataset.code = credCode
      } else {
        codeWrapper.classList.add('hidden')
        codeWrapper.classList.remove('flex')
      }

      if (credUrl) {
        urlEl.classList.remove('hidden')
        urlEl.classList.add('flex')
        urlEl.href = credUrl
      } else {
        urlEl.classList.add('hidden')
        urlEl.classList.remove('flex')
      }
    } else {
      credContainer.classList.add('hidden')
      credContainer.classList.remove('flex')
    }

    const contentContainer = this.certModalTarget.querySelector('#cert-modal-content')
    contentContainer.innerHTML = '' // clear

    if (isImage) {
      contentContainer.innerHTML = `<img src="${url}" class="max-w-full h-auto max-h-[85vh] object-contain rounded-lg" />`
    } else {
      const pdfUrl = url + '#toolbar=0&navpanes=0&scrollbar=0&view=FitH'
      contentContainer.innerHTML = `<iframe src="${pdfUrl}" class="max-w-full h-[70vh] md:h-[85vh] aspect-[4/3] rounded-lg bg-white" frameborder="0" scrolling="no"></iframe>`
    }
  }

  async copyCredential(event) {
    event.preventDefault()
    const btn = event.currentTarget
    const wrapper = btn.closest('#cert-modal-code-wrapper')
    const code = wrapper.dataset.code
    
    if (code) {
      try {
        await navigator.clipboard.writeText(code)
        const originalHtml = btn.innerHTML
        // Show checkmark
        btn.innerHTML = `<svg class="w-4 h-4 text-emerald-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>`
        setTimeout(() => {
          btn.innerHTML = originalHtml
        }, 2000)
      } catch (err) {
        console.error('Failed to copy', err)
      }
    }
  }

  closeCert(event) {
    if (event) event.preventDefault()
    this.certModalTarget.classList.add("hidden")
    document.body.style.overflow = "auto"
    this.certModalTarget.querySelector('#cert-modal-content').innerHTML = ''
  }

  closeAll() {
    this.closeEuropass()
    this.closeCase()
    this.closeCert()
  }

  printEuropass(event) {
    event.preventDefault()
    window.print()
  }
}
