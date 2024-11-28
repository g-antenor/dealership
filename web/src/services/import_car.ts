import CarImportProp from "../types/postData";

export const ImportCar = async ({dealerId, name, mark, model, price, amount, data: { speed, persons, trunk }}: CarImportProp) => {
    try {
      const response = await fetch("https://dealership/importVehicle", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ dealerId, name, mark, model, price, amount, speed, persons, trunk }),
      });
  
      if (!response.ok) {
        throw new Error("Erro ao buscar os carros.");
      }
  
      const respFormatted = await response.json();
      return respFormatted; // Retorna os dados da API
    } catch (error) {
      console.error("Erro na requisição:", error);
      return []; // Retorna um array vazio em caso de erro
    }
  };
  