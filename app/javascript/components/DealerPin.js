import React from 'react'
import PropTypes from 'prop-types'
import useGlobal from '../store'

const DealerPin = (props) => {
  const [globalState, globalActions] = useGlobal()

  const selectIfSelected = (id) => {
    return globalState.selectedDealer == id ? ' selected' : ''
  }

  return (
    <div
      className={'pin' + selectIfSelected(props.id)}
      lat={props.lat}
      lng={props.lng}
      text={props.name}
      onClick={() => globalActions.selectDealer(props.id)}
    ></div>
  )
}

DealerPin.propTypes = {
  id: PropTypes.number,
  lat: PropTypes.number,
  lng: PropTypes.number,
  name: PropTypes.string,
}

export default DealerPin
