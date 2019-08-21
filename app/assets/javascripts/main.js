$(function() {
  console.log("Loading..!")
  if (window.location.pathname === "/companies") {
    listeningCompaniesLoad()
  } else if (window.location.pathname === "/positions"){
    sortPositions()
  } else if (window.location.pathname.includes("/positions") && /\d/.test(window.location.pathname) && window.location.pathname.includes("/edit")){
    toggleCompanyForm()
  } else if (window.location.pathname.includes("/positions/new") || (window.location.pathname.includes("/positions") && /\d/.test(window.location.pathname) && window.location.pathname.includes("/edit"))){
    toggleCompanyForm()
    postCompanyandPosition()
  } else if (window.location.pathname.includes("/companies") && /\d/.test(window.location.pathname) && !window.location.pathname.includes("/positions")) {
    displayCompanyShow();
  } else if (window.location.pathname.includes("/companies") && /\d/.test(window.location.pathname) && window.location.pathname.includes("/positions") || window.location.pathname.includes("/positions")) {
    diplayWholeDescription();
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
    <a href="/companies/${this.id}/edit" class="btn btn-outline-warning btn-sm">Edit this company</a>
    <hr style="margin: 30px;">
    <div class="append-positions-${this.id}" style="display:none;"></div>
    </div>
    `
  }
  showHTML() {
    return `
    <a href="${this.url}" target="_blank"><i class="fas fa-globe"></i> Website</a>
    <p class="js-description-${this.id} my-4">${this.description}</p>
    <a href="/companies/${this.id}/edit" class="btn btn-outline-warning">Edit company's information</a>
    `
  }
}

class Position {
  constructor(data) {
    this.id = data.id;
    this.title = data.title;
    this.description = data.description;
    this.salary = data.salary === 0 ? "n/a" : `$${data.salary}`;
    this.fullTime = data.full_time === true ? "Yes" : "n/a" ;
    this.created = data.created_at.slice(0,10);
    this.updated = data.updated_at.slice(0,10);
    this.companyId = data.company_id;
    this.companyName = data.company.name
  }
  positionFormatHTML() {
    return `
    <div class="card">
      <div id="position-wrapper-${this.id}" class="card-body">
        <h5 class="card-title">${this.title}</h5>
        <p class="card-text">${this.description.substring(0, 20)}...</p>
        <p class="card-text">Salary: ${this.salary} a year
          <button class="js-position btn btn-outline-info btn-sm d-inline" data-id="${this.id}" data-companyid="${this.companyId}">More info</button>
        </p>
      </div>
    </div>
    `
  }
  positionDetailsHTML() {
    return `
      <h2>${this.title}</h2>
      <p>Description: ${this.description}</p>
      <p>Salary: ${this.salary} a year</p>
      <p>Full Time: ${this.fullTime}</p>
      <p>Position Created: ${this.created}</p>
      <p>Updated: ${this.updated}</p>
      <a href="/companies/${this.companyId}/positions" class="js-add-checklist btn btn-outline-info btn-sm" data-id="${this.id}" data-companyid="${this.companyId}">Go to List</a>
      <a href="/companies/${this.companyId}/positions/${this.id}/edit" class="btn btn-outline-warning btn-sm">Edit this position</a>
    `
  }
  tableHTML() {
    return `
    <tr data-id="${this.id}">
    <td class="js-position-title"><a href="/companies/${this.companyId}/positions/${this.id}">${this.title}</a></td>
    <td id="js-add-company"><a href="companies/${this.companyId}">${this.companyName}</a></td>
    <td><a href="#" class="js-truncate link-${this.id}" data-id="${this.id}" data-companyid="${this.companyId}">${this.description.substring(0,27)}..</a></td>
    <td>${this.salary} / year</td>
    <td>${this.fullTime}</td>
    <td><a data-companyid="${this.companyId}" data-positionid="${this.id}" class="js-add-checklist btn btn-success btn-sm sm-font text-white">Add to my checklist</a></td>
    </tr>
    `
  }
}

//Company index page
function listeningCompaniesLoad() {
  const wrapper = document.getElementById("companies-wrapper");
  fetch("/companies.json")
  .then(resp => resp.json())
  .then(jsonData =>
    jsonData.forEach((companyData) => {
      const company = new Company(companyData)
      wrapper.innerHTML += company.indexHTML();
      clickReadMore();
      displayPositions();
    })
  )
}

function clickReadMore() {
  $(".js-read-more").on("click", function(e) {
    e.preventDefault();
    const id = this.dataset.id;
    fetch("/companies/" + id + ".json")
    .then(resp => resp.json())
    .then(jsonData => {
      const company = new Company(jsonData)
      const descriptionDiv = document.querySelector(`.js-description-${company.id}`);
      descriptionDiv.innerText = company.description
    })
  })
}

//Display positions in company's index page
function displayPositions() {
  $(".js-positions").on("click", function(e) {
    e.preventDefault();
    const companyId = this.dataset.id;
    fetch("/positions" + ".json")
    .then(resp => resp.json())
    .then(jsonData => {
      const positions = jsonData.map((position) => {
        if (position.company_id === parseInt(companyId)) {
          return new Position(position).positionFormatHTML()
        }
      }).join("")
      const div = document.querySelector(`.append-positions-${companyId}`)
        div.innerHTML = positions;

        div.style.display === "none" ? div.style.display = "block" : div.style.display = "none";

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

    fetch("/companies/" + companyId + "/positions/" + positionId + ".json")
    .then(resp => resp.json())
    .then(jsonData => {
      const position = new Position(jsonData)
      const positionDiv = document.getElementById(`position-wrapper-${positionId}`)
      positionDiv.innerHTML = position.positionDetailsHTML();
    })
  })
}

// Company Show Page
function displayCompanyShow() {
  console.log("Now company show")
  const companyWrapper = document.getElementById("company-wrapper");
  if (companyWrapper !== null) {
    const positionsWrapper = document.getElementById("positions-wrapper");
    const id = positionsWrapper.dataset.id;
    fetch("/companies/" + id + ".json")
    .then(resp => resp.json())
    .then(jsonData => {
      const company = new Company(jsonData)
      companyWrapper.innerHTML += company.showHTML();

      jsonData.positions.forEach((positionData) => {
        //// HACK: position
        /// need to assign company name. constructor has company_name
        positionData.company = {name: company.name};
        const position = new Position(positionData)
        positionsWrapper.innerHTML += position.positionFormatHTML();
        positionDetails();
      })
    })
  } else {
    return;
    //this prevent other companies/id routes access this function
  }
}

//Company New page
function toggleCompanyForm() {
  console.log("want to display company form?")
  document.getElementById("js-create-company-btn").addEventListener("click", function(e) {
    e.preventDefault();
    const div = document.getElementById("js-new-company")

    div.style.display === "none" ? div.style.display = "block" : div.style.display = "none";
  })
}

//Company New page. Post data.
function postCompanyandPosition() {
  console.log("posting")
  $("form").submit(function(e) {
    e.preventDefault();
    const values = $(this).serialize();
    console.log(values)

    // Rials.ajax works
    Rails.ajax({
        url: "/positions.json",
        type: "POST",
        data: values,
        success: function(data) {
          console.log(data)
          window.location.replace(`/companies/${data.company.id}/positions/${data.id}`)
          alert("Successfuly created!")
        }
    })

    // $.post jquery also works
    //  $.post('/positions.json', values)
    // .done((data) => {
    //    console.log(data)
    //   window.location.replace(`/companies/${data.company.id}/positions/${data.id}`)
    //   alert("Successfuly created!")
    // })

    // fetch - got error
    // fetch("/positions.json", {
      //       method: "post",
      //       body: values,
      //       headers: {
        //           "Content-Type": "application/json",
        //           "Accept": "application/json"
        //         }
        //       }).then(res => console.log(res.json()))
  })
}

//Position index and all_index page
function diplayWholeDescription() {
  console.log("change description")
  $(".js-truncate").on("click", function(e) {
    e.preventDefault();
    let positionId = this.dataset.id;
    let companyId = this.dataset.companyid;
    fetch("/companies/" + companyId + "/positions/" + positionId + ".json")
    .then(resp => resp.json())
    .then(jsonData => {
      let link = document.getElementsByClassName(`link-${positionId}`)[0];
      link.innerText = new Position(jsonData).description;
    })
  })
}

function sortPositions() {
  $("#js-sort").on("click", function(e) {
    e.preventDefault();
    const value = document.getElementById("js-value").value;
    const userId = document.getElementById("js-sort").dataset.userid;
    fetch("/positions" + ".json")
    .then(resp => resp.json())
    .then(jsonData => {

       const sortedPositions = jsonData.filter(function(position) {
       return position.title.toLocaleLowerCase().includes(value)
      })

      $("#sorted-table tr").remove()
      const table = document.getElementById("sorted-table")

       sortedPositions.forEach((position) => {
         table.innerHTML += new Position(position).tableHTML()
       })
       diplayWholeDescription()
       addToChecklist(userId)
    })
  })
}

function addToChecklist(userId) {
  const user = userId;
  $(".js-add-checklist").on("click", (e) => {
    console.log("hitting!")
    e.preventDefault();
    const positionId = e.currentTarget.dataset.positionid;
    const companyId = e.currentTarget.dataset.companyid;
    console.log(positionId, companyId, user)

    const values = {checklist: {company_id: companyId,  position_id: positionId},user_id: user}
    alert("Do you want to add this position to your list?")

    $.post(`/users/${user}/checklists.json`, values)
    .done((data) => {
      console.log(data)
      window.location.replace(`/users/${user}/checklists`)
    })
  })
}
