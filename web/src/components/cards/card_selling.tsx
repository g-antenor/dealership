import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faGauge, faUsers, faBox } from '@fortawesome/free-solid-svg-icons';
import CarProp from '../../types/cards'
import '../component.css'

const card_selling = ({name, model, mark, price}: CarProp) => {
  return (
    <div className='card-selling'>
        <img className='card-car-image' src={`https://docs.fivem.net/vehicles/${model}.webp`} alt={model} />
        <div className='card-selling-profile'>
            <h3>{name}</h3>
            <p>{mark}</p>
        </div>
        <span className='card-selling-price'>
            $ {price}
        </span>
        <div className='card-selling-info'>
            <ul>
                <li><FontAwesomeIcon icon={faGauge} />300 km</li>
                <li><FontAwesomeIcon icon={faUsers} />4 Person</li>
                <li><FontAwesomeIcon icon={faBox}   />54 L</li>
            </ul>
        </div>
        <div className='card-selling-buttons'>
            <button className='btn-buy'>Comprar</button>
            <button className='btn-driver'>Teste Driver</button>
        </div>
    </div>
  )
}

export default card_selling