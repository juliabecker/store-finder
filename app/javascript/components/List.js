import React from 'react'
import PropTypes from 'prop-types'

import ListItem from './ListItem'

const List = (props) => {

  const renderListItems = () => {
    let allListItems = []

    props.dealers.forEach((dealer, index) => {
      allListItems.push(
        <ListItem dealer={dealer} key={index}/>
      )
    })

    return allListItems;
  };

    return (
      <div className={'pure-u-1 pure-u-md-1-3'}>
        <ul className='list'>
          {renderListItems()}
        </ul>
      </div>
    );
  }

List.propTypes = {
  dealers: PropTypes.array,
}

export default List
