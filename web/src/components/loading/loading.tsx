import './loading.css';

const Loading = () => {
  return (
    <div className="loading-container">
      <div className="loading-spinner">
        <div className="car-body">
          <div className="car-top" />
          <div className="car-bottom" />
          <div className="wheel wheel-front" />
          <div className="wheel wheel-back" />
        </div>
      </div>
      <p>Carregando concessionária...</p>
    </div>
  );
};

export default Loading;
