import React, { useEffect } from 'react';
import * as L from 'leaflet';
import 'leaflet/dist/leaflet.css';

type Restaurant = {
  name: string;
  lat: number;
  lon: number;
  imageUrl?: string;
  description?: string;
  hours?: string;
};

type MapProps = {
  restaurants: Restaurant[];
};

const Map: React.FC<MapProps> = ({ restaurants }) => {
  useEffect(() => {
    console.log('Map: Otrzymane restauracje:', restaurants);

    const map = L.map('map').setView([52.23, 21.01], 6);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© OpenStreetMap contributors',
    }).addTo(map);

    restaurants.forEach(({ name, lat, lon, imageUrl, description, hours }) => {
      const popupContent = `
        <div style="max-width: 200px;">
          <strong>${name}</strong><br/>
          ${description ? `<em>${description}</em><br/>` : ''}
          ${hours ? `<small>Godziny otwarcia: ${hours}</small><br/>` : ''}
          ${imageUrl ? `<img src="${imageUrl}" alt="${name}" style="width:100%; border-radius:8px; margin-top:5px;" />` : ''}
        </div>
      `;

      L.marker([lat, lon])
        .addTo(map)
        .bindPopup(popupContent);
    });

    if (restaurants.length > 0) {
      const group = new L.FeatureGroup(
        restaurants.map(({ lat, lon }) => L.marker([lat, lon]))
      );
      map.fitBounds(group.getBounds());
    }

    return () => {
      console.log('Map: czyszczenie mapy...');
      map.remove();
    };
  }, [restaurants]);

  return <div id="map" style={{ height: '400px', width: '100%' }} />;
};

export default Map;
