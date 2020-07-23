import React, { useEffect, useState } from 'react';
import Map from './Map';
import List from './List';

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
        <div className={'pure-g'}>
          <div className={'pure-u-1'}>
            <h1>Store Locator</h1>
          </div>
          <Map dealers={dealers}/>
          <List dealers={dealers}/>
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
