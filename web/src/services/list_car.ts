export const fetchSellingCars = async () => {
    try {
      const response = await fetch("https://dealership/getVehiclesSelling", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
      });
  
      if (!response.ok) {
        throw new Error("Erro ao buscar os carros.");
      }
  
      const data = await response.json();
      return data; // Retorna os dados da API
    } catch (error) {
      console.error("Erro na requisição:", error);
      return []; // Retorna um array vazio em caso de erro
    }
  };
  