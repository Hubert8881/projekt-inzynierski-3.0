"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const database_1 = require("./config/database");
const restaurants = [
    { id: 17, name: 'Stół Polski', address: 'Marszałkowska 10, Warszawa, Polska' },
    { id: 18, name: 'VegeMiasto', address: 'Solidarności 60, Warszawa, Polska' },
    { id: 19, name: 'Sakana Sushi', address: 'Moliera 4, Warszawa, Polska' },
    { id: 20, name: 'Pod Wawelem', address: 'Św. Gertrudy 26-29, Kraków, Polska' },
    { id: 21, name: 'Zielone Tarasy', address: 'Tyniecka 10, Kraków, Polska' },
    { id: 22, name: 'Nolio', address: 'Krakowska 27, Kraków, Polska' },
    { id: 23, name: 'Muga', address: 'Krysiewicza 5, Poznań, Polska' },
    { id: 24, name: 'Frontiera', address: 'Garbary 54, Poznań, Polska' },
    { id: 25, name: 'Pierogarnia Stary Młyn', address: 'Stary Rynek 100, Poznań, Polska' },
    { id: 26, name: 'Gvara', address: 'Długa 81, Gdańsk, Polska' },
    { id: 27, name: 'Billy’s American Restaurant', address: 'Tkacka 21, Gdańsk, Polska' },
    { id: 28, name: 'Mandu', address: 'Elżbietańska 4, Gdańsk, Polska' },
    { id: 29, name: 'Chleb i Wino', address: 'Rynek Staromiejski 22, Toruń, Polska' },
    { id: 30, name: 'Jan Olbracht', address: 'Szczytna 15, Toruń, Polska' },
    { id: 31, name: 'Manekin', address: 'Rynek Staromiejski 16, Toruń, Polska' },
];
async function getCoordinates(address) {
    const attempts = [
        address,
        address.replace(/ul\.?/gi, '').replace(/\d+\/\d+/, '').trim(),
        address.split(',').slice(1).join(',').trim() || address,
    ];
    for (const query of attempts) {
        const url = `https://nominatim.openstreetmap.org/search?q=${encodeURIComponent(query)}&format=json&limit=1`;
        try {
            const response = await fetch(url, {
                headers: {
                    'User-Agent': 'restaurant-app/1.0 (projekt@inzynierski.pl)',
                },
            });
            const data = (await response.json());
            console.log(`Odpowiedź Nominatim dla "${query}":`, data);
            if (data.length > 0) {
                return {
                    lat: parseFloat(data[0].lat),
                    lon: parseFloat(data[0].lon),
                };
            }
        }
        catch (error) {
            console.error('Błąd fetch:', error);
        }
    }
    return null;
}
async function updateRestaurantsCoordinates() {
    console.log('Start aktualizacji współrzędnych...');
    for (const restaurant of restaurants) {
        const coords = await getCoordinates(restaurant.address);
        if (coords) {
            console.log(`Restauracja ${restaurant.name}: lat=${coords.lat}, lon=${coords.lon}`);
            await database_1.pool.query('UPDATE restaurants SET latitude = $1, longitude = $2 WHERE id = $3', [coords.lat, coords.lon, restaurant.id]);
        }
        else {
            console.log(`Nie znaleziono współrzędnych dla: ${restaurant.name}`);
        }
        await new Promise(r => setTimeout(r, 1000));
    }
    console.log('Aktualizacja współrzędnych zakończona.');
}
updateRestaurantsCoordinates().catch(console.error);
//# sourceMappingURL=updateCoordinates.js.map