// Mobile Menu Toggle
const menuToggle = document.getElementById("menuToggle")
const navMenu = document.getElementById("navMenu")

if (menuToggle) {
  menuToggle.addEventListener("click", () => {
    menuToggle.classList.toggle("active")
    navMenu.classList.toggle("active")
  })
}

// Dropdown Toggle for Mobile
const dropdowns = document.querySelectorAll(".dropdown > a")
dropdowns.forEach((dropdown) => {
  dropdown.addEventListener("click", (e) => {
    if (window.innerWidth <= 968) {
      e.preventDefault()
      const parent = dropdown.parentElement
      parent.classList.toggle("active")
    }
  })
})

// Sticky Header
const header = document.getElementById("header")
let lastScroll = 0

window.addEventListener("scroll", () => {
  const currentScroll = window.pageYOffset

  if (currentScroll > 100) {
    header.querySelector(".navbar").classList.add("scrolled")
  } else {
    header.querySelector(".navbar").classList.remove("scrolled")
  }

  lastScroll = currentScroll
})

// Scroll Animation Observer
const observerOptions = {
  threshold: 0.1,
  rootMargin: "0px 0px -50px 0px",
}

const observer = new IntersectionObserver((entries) => {
  entries.forEach((entry) => {
    if (entry.isIntersecting) {
      entry.target.classList.add("animated")
    }
  })
}, observerOptions)

document.addEventListener("DOMContentLoaded", () => {
  // Observe all elements with animate-on-scroll class
  const animatedElements = document.querySelectorAll(".animate-on-scroll")
  animatedElements.forEach((el) => observer.observe(el))

  // Counter Animation
  const counters = document.querySelectorAll(".stat-number, .achievement-number")

  const animateCounter = (counter) => {
    const target = Number.parseInt(counter.getAttribute("data-target"))
    const duration = 2000
    const increment = target / (duration / 16)
    let current = 0

    const updateCounter = () => {
      current += increment
      if (current < target) {
        counter.textContent = Math.floor(current).toLocaleString()
        requestAnimationFrame(updateCounter)
      } else {
        counter.textContent = target.toLocaleString()
      }
    }

    updateCounter()
  }

  const counterObserver = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting && !entry.target.classList.contains("counted")) {
        animateCounter(entry.target)
        entry.target.classList.add("counted")
      }
    })
  }, observerOptions)

  counters.forEach((counter) => counterObserver.observe(counter))

  // Form Submission Handler
  const forms = document.querySelectorAll("form")
  forms.forEach((form) => {
    form.addEventListener("submit", (e) => {
      e.preventDefault()

      // Show success message
      alert("¡Gracias por contactarnos! Nos pondremos en contacto con usted pronto.")

      // Reset form
      form.reset()
    })
  })

  // Smooth Scroll for anchor links
  document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
    anchor.addEventListener("click", function (e) {
      e.preventDefault()
      const target = document.querySelector(this.getAttribute("href"))
      if (target) {
        target.scrollIntoView({
          behavior: "smooth",
          block: "start",
        })
      }
    })
  })

  // Navbar Scroll Effect
  let lastScroll = 0
  const navbar = document.querySelector(".navbar")

  window.addEventListener("scroll", () => {
    const currentScroll = window.pageYOffset

    if (currentScroll > 100) {
      navbar.style.boxShadow = "0 4px 20px rgba(0,0,0,0.15)"
    } else {
      navbar.style.boxShadow = "0 2px 10px rgba(0,0,0,0.1)"
    }

    lastScroll = currentScroll
  })

  // Auto-close mobile menu on link click
  const navLinks = document.querySelectorAll(".nav-link")
  const navbarCollapse = document.querySelector(".navbar-collapse")

  navLinks.forEach((link) => {
    link.addEventListener("click", () => {
      if (navbarCollapse && navbarCollapse.classList.contains("show")) {
        navbarCollapse.classList.remove("show")
      }
    })
  })

  // Initialize Bootstrap Carousels with auto-play
  const carousels = document.querySelectorAll(".carousel")
  carousels.forEach((carousel) => {
    new window.bootstrap.Carousel(carousel, {
      interval: 5000,
      wrap: true,
      ride: "carousel",
    })
  })
})

// Parallax effect for hero sections (optional enhancement)
window.addEventListener("scroll", () => {
  const scrolled = window.pageYOffset
  const hero = document.querySelector(".hero, .page-hero")

  if (hero && scrolled < hero.offsetHeight) {
    hero.style.transform = `translateY(${scrolled * 0.3}px)`
  }
})
