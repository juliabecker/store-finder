import React from 'react';
import PropTypes from 'prop-types';
import GoogleMapReact from 'google-map-react';

import DealerPin from './DealerPin';

const defaultProps = {
  center: {
    lat: 40.730610,
    lng: -73.935242   
  },
  zoom: 5
};

const Map = (props) => {

  const renderPins = () => {
    let allPins = []

    props.dealers.map((dealer, index) => {
      allPins.push(
        <DealerPin
          key={index}
          id={dealer.id}
          lat={parseFloat(dealer.latitude)}
          lng={parseFloat(dealer.longitude)}
          name={dealer.name}
        />
      )
    })

    return allPins;
  }

  return (
    <div className={'pure-u-1 pure-u-md-2-3'} style={{ height: '100vh' }}>
      <GoogleMapReact
        defaultCenter={defaultProps.center}
        defaultZoom={defaultProps.zoom}
      >
       {renderPins()}
      </GoogleMapReact>
    </div>
  )
}

Map.propTypes = {
  dealers: PropTypes.array,
}

export default Map
