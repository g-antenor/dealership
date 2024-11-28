import React, { useState } from "react";
import "./Sidebar.css";

interface SidebarProps {
  onSelect: (index: number) => void;
}

const Sidebar: React.FC<SidebarProps> = ({ onSelect }) => {
  const [activeIndex, setActiveIndex] = useState(0);

  const menuItems = ["Stock", "Finance", "Employeers"];

  const handleClick = (index: number) => {
    setActiveIndex(index);
    onSelect(index);
  };

  return (
    <div className="sidebar-container">
      <h2 className="sidebar-title">Menu</h2>
      <ul className="sidebar-menu">
        {menuItems.map((item, index) => (
          <li
            key={index}
            className={`sidebar-item ${activeIndex === index ? "active" : ""}`}
            onClick={() => handleClick(index)}
          >
            {item}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default Sidebar;
