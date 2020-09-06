function fetchData() {
  fetch("http://localhost:3000/api/v1/jobs/2")
  .then(response => {
    if (!response.ok) {
      throw Error("An error occurred. Please try again.")
    }
    return response.json()
  }).then(data => {

    var position = data.position;
    var clocked_out = data.shifts[0].clock_out !== '—';

    document.querySelector('#position').innerHTML = `<h1>${position}</h1>`;

    var firstName = data.shifts.map(data => {
      return `
      <h2>${data.user.first_name}</h2>
      `
    })

    document.querySelector("#first_name").innerHTML = firstName;

    var timeClock = data.shifts.map(shift => {
      return `
      <div>
        <h2>Clock in</h2>
        <p>${shift.clock_in}</p>
      </div>
      <div>
        <h2>Clock out</h2>
        <p>${shift.clock_out}</p>
      </div>
      `
    })

    document.querySelector("#time_clock").innerHTML = timeClock;

    var timeClockButton = document.querySelector('#time_clock_btn')

    if (clocked_out) {
      timeClockButton.innerText = 'Clock in';
    } else {
      timeClockButton.innerText = 'Clock out';
    }
  }).catch(error => {
    console.log(error)
  });
}

fetchData()

function createNewTimeEntry() {
  fetch("http://localhost:3000/api/v1/jobs/2/new-time-entry", {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
      'X-User-Email': 'mike@brown.com',
      'X-User-Token': 'ZxFkx33i9eqsZZZ-jKEp'
    }
  })
  .then(response => {
    if (!response.ok) {
      throw Error("An error occurred. Please try again.")
    }
    return response;
  })
}

function assignHandlers() {
  var timeClockButton = document.querySelector('#time_clock_btn')

  timeClockButton.addEventListener('click',
    async function (event) {
      await createNewTimeEntry()
      fetchData()
  })
}

assignHandlers()
