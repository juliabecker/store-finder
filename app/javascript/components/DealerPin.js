import React from "react";
import PropTypes from "prop-types";

const DealerPin = (props) => {
  const pinStyle = {
    color: 'blue',
    height: '10px',
    width: '10px'
  };

  return (
    <div style={pinStyle}
      lat={props.lat}
      lng={props.lng}
      text={props.name}
    ></div>
  );
};

DealerPin.propTypes = {
  lat: PropTypes.number,
  lng: PropTypes.number,
  name: PropTypes.string,
}

export default DealerPin
