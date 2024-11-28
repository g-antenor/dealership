export default interface CarImportProp {
    dealerId: number;
    name: string;
    model: string;
    mark: string;
    category: string;
    price: number;
    amount: number;
    data: {
        speed: number;
        persons: number;
        trunk: number;
    },
}