// Create a new Tau Prolog session
const session = pl.create();

// Load knowledge base from external file
fetch("./knowledge.pl")
  .then(response => response.text())
  .then(prologCode => {
    session.consult(prologCode);
  });

// Function to query Prolog
function getRecommendation() {
  const budget = Number(document.getElementById("budget").value);
  const eco = document.getElementById("eco").value;
  const space = document.getElementById("space").value;
  const speed = document.getElementById("speed").value;

  if (!budget) {
    alert("Please enter a budget.");
    return;
  }

  const query = `recommends(Car, ${budget}, ${eco}, ${space}, ${speed}).`;

  session.query(query);

  let results = new Set();

  function formatCarName(name) {
    return name.replace(/_/g, " ").replace(/\b\w/g, l => l.toUpperCase());
  }

  function callback(answer) {
    if (answer === false) {
      if (results.size > 0) {
        const display = Array.from(results).map(formatCarName);
        document.getElementById("result").innerText =
          "Recommended Car(s): " + display.join(", ");
      } else {
        document.getElementById("result").innerText =
          "No suitable car found.";
      }
    } else {
      const formatted = pl.format_answer(answer);
      const carName = formatted.split("=")[1].trim();
      results.add(carName);
      session.answer(callback);
    }
  }

  session.answer(callback);
}
