/* eslint-disable @typescript-eslint/no-explicit-any */
import React, { useEffect, useState } from 'react';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import './nui_style.css';
import Sidebar from '../components/sidebar/sidebar';
import Loading from '../components/loading/loading';
import { fetchSellingCars } from '../services/list_car';
import CarProp from '../types/cards';
import Card from '../components/cards/card_stock';
import Navbar from '../components/nav_car_category';

const App: React.FC = () => {
  const [selectedCategory, setSelectedCategory] = useState<string>("All");
  const [selectedIndex, setSelectedIndex] = useState(0);
  const [carsData, setcarsData] = useState<CarProp[]>([]);
  const [loading, setLoading] = useState(true);

  const getUniqueCategories = (data: CarProp[]) => {
    return [...new Set(data.map((car) => car.category))];
  };

  const categories = ["All", ...getUniqueCategories(carsData)];

  useEffect(() => {
    const loadCars = async () => {
      setLoading(true);
      const data = await fetchSellingCars();
      setcarsData(data);
      setLoading(false);
    };

    loadCars();
  }, []);

  if (loading) {
    return <Loading />;
  }

  // Conteúdo baseado na seleção
  const renderContent = () => {
    switch (selectedIndex) {
      case 0:
        return (
          <Container>
              <Row>
                <Navbar setCategory={setSelectedCategory} categories={categories} />
              </Row>
              <Row className='g-cards'>
                {carsData
                  .filter((car) => selectedCategory === "All" || car.category === selectedCategory)
                  .map((car, index) => (
                    <Col style={{ padding: '10px' }} xs>
                      <Card key={index} {...car} />
                    </Col>
                  ))
                }
              </Row>
            </Container>
        );
      case 1:
        return <Container className="content">💰 Finance Content</Container>;
      case 2:
        return <Container className="content">👥 Employeers Content</Container>;
      default:
        return <Container className="content">Welcome! Select an option.</Container>;
    }
  };

  return (
    <div className='dash-container'>
      <Sidebar onSelect={(index) => setSelectedIndex(index)} />
      <div className="dash-content">
        {renderContent()}
      </div>
    </div>
  );
};

export default App;