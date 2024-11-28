import { useEffect, useState } from 'react';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col'; 

import CarProp from '../types/cards';
import Card from '../components/cards/card_selling';
import Navbar from '../components/nav_car_category';

import './nui_style.css';
import Loading from '../components/loading/loading';

const Text: React.FC = () => {
  const [selectedCategory, setSelectedCategory] = useState<string>("All");
  const [carsData, setcarsData] = useState<CarProp[]>([]);
  const [loading, setLoading] = useState(true); // Estado de loading

  const getUniqueCategories = (data: CarProp[]) => {
    return [...new Set(data.map((car) => car.category))];
  };

  const categories = ["All", ...getUniqueCategories(carsData)];

  const handleSellingCars = async () => {
    try {
      const response = await fetch('https://dealership/getVehiclesSelling', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      if (response.ok) {
        const data = await response.json();
        setcarsData(data);
      } else {
        console.error('Erro ao buscar os carros.');
      }
    } catch (error) {
      console.error('Erro na requisição:', error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    handleSellingCars();
  }, []);

  // Tela de loading
  if (loading) {
    return <Loading />;
  }
  return (
    <div className='global-container'>
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
    </div>
  );
};

export default Text;