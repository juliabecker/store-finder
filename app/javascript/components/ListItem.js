import React from 'react'
import PropTypes from 'prop-types';
import useGlobal from '../store'

const ListItem = (props) => {
  const [globalState, globalActions] = useGlobal();

  const selectIfSelected = (id) => {
    return globalState.selectedDealer == id ? ' selected' : ''
  }

  return (
    <li
      className={'list-item' + selectIfSelected(props.dealer.id)}
      onClick={() => globalActions.selectDealer(props.dealer.id)}
    >
      <h4>{props.dealer.name}</h4>
        <p>
          {props.dealer.street}
          <br/>
          {props.dealer.city}, {props.dealer.state}, {props.dealer.country}
          <br/>
          {props.dealer.phone}
        </p>
    </li>
  );
};

ListItem.propTypes = {
  dealer: PropTypes.object,
}

export default ListItem
