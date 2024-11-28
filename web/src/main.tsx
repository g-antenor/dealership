/* eslint-disable @typescript-eslint/no-explicit-any */
import React, { useState } from 'react'
import ReactDOM from 'react-dom/client'
import Dashboard from './page/nui_dashboard.tsx'
import Selling from './page/nui_selling.tsx'
import './index.css'

const RootComponent = ()=>{
  const [visible,setVisible] = useState(false)
  const [typeContent ,setType] = useState('')
  
  const handleNuiCallback=(event:any)=>
  {
    console.log(event.data.action)
    if (event.data.action === 'open') {
      setVisible(true)
      setType(event.data.type)

    }
  }

  const keyHandler = (e: KeyboardEvent)=>{
    if(["Backspace","Escape"].includes(e.code)){
      fetch('https://dealership/hide', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      }
    }).then((response)=>{
      if(response.ok){
        setVisible(false)
      }
    })
    }
  }

  window.addEventListener('message',handleNuiCallback)
  window.addEventListener("keydown", keyHandler)
  return(
    <React.StrictMode>
      {visible && (
        typeContent === 'admin' ? (
          <Dashboard />
        ) : typeContent === 'catalog' ? (
          <Selling />
        ) : (
          <></>
        )
      )}
    </React.StrictMode>
  )
}

ReactDOM.createRoot(document.getElementById('root')!).render(<RootComponent/>)