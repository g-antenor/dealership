/* eslint-disable react-hooks/rules-of-hooks */
import { useState } from 'react';
import NavbarProps from '../types/nav'
import './component.css'

const nav_car_category = ({ setCategory, categories }: NavbarProps) => {
  const [activeIndex, setActiveIndex] = useState<number>(0);

  const handleCategoryChange = (index: number, category: string) => {
    setActiveIndex(index);
    setCategory(category);
  };
  return (
    <div className='nav-container'>
      <ul className="nav-menu">
        {categories.map((category, index) => (
          <li
            key={index}
            className={`nav-item ${index === activeIndex ? 'active' : ''}`}
            onClick={() => handleCategoryChange(index, category)}
          >
            {category}
          </li>
        ))}
      </ul>
    </div>
  )
}

export default nav_car_category