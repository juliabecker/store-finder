import React, { useEffect, useState } from 'react';
import Map from "./Map"

const App = () => {
  const [hasError, setErrors] = useState(false);
  const [dealers, setDealers] = useState([]);

  async function fetchDealers() {
    const url = "/dealers/index"
    const response = await fetch(url)

    response
      .json()
      .then(response => setDealers(response))
      .catch(err => setErrors(err));
  }

  useEffect(() => {
    fetchDealers();
  }, [] );

  const renderPage = () => {
    // to-do: check if necessary
    if (dealers.length) {
      return (
        <div>
          <h1>Store Locator</h1>
          <Map dealers={dealers}/>
        </div>
      )
    } else {
      return <span>Loading ... </span>
    }
  }

  return (
    renderPage()
  )
}

export default App
