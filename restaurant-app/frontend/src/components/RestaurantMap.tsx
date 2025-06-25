import React from 'react';
import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';

interface Restaurant {
  id: number;
  name: string;
  address: string;
  latitude?: number;
  longitude?: number;
}

interface RestaurantMapProps {
  restaurants: Restaurant[];
}
const RestaurantMap: React.FC<RestaurantMapProps> = ({ restaurants }) => {
    const defaultPosition: [number, number] = [52.237049, 21.017532];
    return (
    <MapContainer
      center={defaultPosition}
      zoom={6}
      style={{ height: '400px', width: '100%' }}
    >
      <TileLayer
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        attribution='&copy; OpenStreetMap contributors'
      />
      {restaurants.map((restaurant) =>
        typeof restaurant.latitude === 'number' && typeof restaurant.longitude === 'number' ? (
          <Marker
            key={restaurant.id}
            position={[restaurant.latitude, restaurant.longitude]}
          >
            <Popup>
              <strong>{restaurant.name}</strong><br />
              {restaurant.address}
            </Popup>
          </Marker>
        ) : null
      )}
    </MapContainer>
  );
};

export default RestaurantMap;