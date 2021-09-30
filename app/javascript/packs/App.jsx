import React from 'react'
import ReactDOM from 'react-dom'

import NavBar from './header/NavBar';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <NavBar />,
    document.body.appendChild(document.createElement('div')),
  )
})