import React from 'react';
import GoogleMapReact from 'google-map-react';

import DealerPin from './DealerPin';

const Map = (props) => {
  // to-do: add prop-types
  const defaultProps = {
    center: {
      lat: 52.5200,
      lng: 13.4050   
    },
    zoom: 11
  };

  const renderPins = () => {
    let allPins = []

    props.dealers.map((dealer, index) => {
      allPins.push(
        <DealerPin
          key={parseInt(dealer.id)}
          lat={parseFloat(dealer.latitude)}
          lng={parseFloat(dealer.longitude)}
          name={dealer.name}
        />
      )
    })

    return allPins;
  }

  return (
    <div style={{ height: '100vh', width: '100%' }}>
      <GoogleMapReact
        defaultCenter={defaultProps.center}
        defaultZoom={defaultProps.zoom}
      >
     {renderPins()}
      </GoogleMapReact>
    </div>
  )
}

export default Map
