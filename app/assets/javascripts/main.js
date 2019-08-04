$(function() {
  console.log("Loading..!")
  if (window.location.pathname === "/companies") {
    listeningCompaniesLoad()
  } else if (window.location.pathname.includes("/users")) {
    clickChecklistBtn();
  } else if (window.location.pathname.includes("/companies") && /\d/.test(window.location.pathname) && !window.location.pathname.includes("/positions")) {
    //displayCompanyShow();
  } else if (window.location.pathname.includes("/companies") && /\d/.test(window.location.pathname) && window.location.pathname.includes("/positions")) {
    clickToPosition();
  } else if (window.location.pathname.includes("/companies") && /\d/.test(window.location.pathname) && window.location.pathname.includes("/positions") && /\d/.test(window.location.pathname)) {
    displayPositionShow()
  }
})

class Company {
  constructor(data) {
    this.id = data.id;
    this.name = data.name;
    this.url = data.url;
    this.description = data.description;
  };
  indexHTML() {
    return `
    <div class="card-body">
    <h2 class="card-title">${this.name}</h2>
    <a href="${this.url}" class="card-text" target="_blank"><i class="fas fa-globe"></i> Website</a>
    <p class="card-text js-description-${this.id}">${this.description.substring(0, 20)}...</p>
    <button class="js-read-more btn btn-info btn-sm" data-id="${this.id}"> Read More </button>
    <button class="js-positions btn btn-info btn-sm" data-id="${this.id}">Check Positions</button>
    <hr style="margin: 30px;">
    <div class="append-positions-${this.id}" style="display:none;"></div>
    </div>
    `
  }
}
// <a href="/companies/${this.id}" class="js-positions btn btn-info btn-sm" data-id="${this.id}">Check Positions</a>

class Position {
  constructor(data) {
    this.id = data.id;
    this.title = data.title;
    this.description = data.description;
    this.salary = data.salary;
    this.fullTime = data.full_time;
    this.created = data.created_at;
    this.updated = data.updated_at;
    this.companyId = data.company_id;
  }
  positionFormatHTML() {
    return `
      <div id="position-wrapper-${this.id}">
        <h2>${this.title}</h2>
        <p>${this.description.substring(0, 20)}...</p>
        <p>Salary: ${this.salary} a year</p>
        <button class="js-position btn btn-info btn-sm" data-id="${this.id}" data-companyid="${this.companyId}">More info</button>
      </div>
    `
  }

  //href="/companies/${this.companyId}/positions/${this.id}"
  positionDetailsHTML() {
    return `
      <h2>${this.title}</h2>
      <p>Description: ${this.description}</p>
      <p>Full Time: ${this.fullTime}</p>
      <p>Position Created: ${this.created}</p>
      <p>Updated: ${this.updated}</p>
      <a href="/companies/${this.companyId}/positions" class="js-add-checklist btn btn-outline-info btn-sm" data-id="${this.id}" data-companyid="${this.companyId}">Go to List</a>
    `
  }
}


function listeningCompaniesLoad() {
  $.get("/companies" + ".json", function(res) {
    const wrapper = document.getElementById("companies-wrapper");
    res.forEach(function(companyData) {
      const company = new Company(companyData)
      wrapper.innerHTML += company.indexHTML();
      clickReadMore();
      displayPositions();
    })
  })
}

function clickReadMore() {
  $(".js-read-more").on("click", function(e) {
    e.preventDefault();
    const id = this.dataset.id;
    $.get("/companies/" + id + ".json", function(res) {
      const company = new Company(res)
      const descriptionDiv = document.querySelector(`.js-description-${company.id}`);
      descriptionDiv.innerText = company.description
    })
  })
}

//Display positions in index page
function displayPositions() {
  $(".js-positions").on("click", function(e) {
    e.preventDefault();
    const companyId = this.dataset.id;
    $.get("/companies/" + companyId + ".json", function(res) {
      let positions = res.positions.map(function(position) {
        return new Position(position).positionFormatHTML()
      }).join("")
      const div = document.querySelector(`.append-positions-${companyId}`)
      div.innerHTML = positions
      if (div.style.display === "none") {
        div.style.display = "block"
      } else {
        div.style.display = "none"
      }
      positionDetails()
    })
  })
}

// Display position Details
function positionDetails() {
  $(".js-position").on("click", function(e) {
    e.preventDefault();
    console.log("clicked!")
    const positionId = this.dataset.id;
    const companyId = this.dataset.companyid;
    $.get("/companies/" + companyId + "/positions/" + positionId + ".json", function(res) {
      console.log(res)
        const position = new Position(res)
        const positionDiv = document.getElementById(`position-wrapper-${positionId}`)
        positionDiv.innerHTML = position.positionDetailsHTML();
      })
  })
}

// Company Show Page
// function displayCompanyShow() {
//     console.log("Now show")
//     let positionsWrapper = document.getElementById("positions-wrapper")
//     const id = positionsWrapper.dataset.id;
//     $.get("/companies/" + id + ".json", function(res) {
//       const company = new Company(res)
//       res.positions.forEach(function(positionData) {
//         let position = new Position(positionData)
//         positionsWrapper.innerHTML += position.positionFormatHTML();
//         positionDetails();
//       })
//   })
// }




// Not sure where
function clickToPosition() {
  $(".js-to-position").on("click", function(e) {
    e.preventDefault();
    const positionId = this.dataset.positionid;
    const companyId = this.dataset.companyid;
    $.get("/companies/" + companyId + "/positions/" + positionId + ".json", function(res) {
      window.location.replace(`/companies/${companyId}/positions/${positionId}`);
    })
  })
}
