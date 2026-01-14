export interface ApiResponse<T> {
  success: boolean;
  data: T;
  message?: string;
}

export interface Restaurant {
  id: number;
  name: string;
  description?: string;
  address?: string;
  phone?: string;
  email?: string;
  opening_hours?: string;
  city_id?: number;
  latitude?: number;
  longitude?: number;
}

export async function getAllRestaurants(): Promise<ApiResponse<Restaurant[]>> {
  try {
    const response = await fetch(`/api/restaurants`);
    if (!response.ok) {
      return { success: false, data: [], message: 'Network error' };
    }
    const data = await response.json();
    return data as ApiResponse<Restaurant[]>;
  } catch {
    return { success: false, data: [], message: 'Connection error' };
  }
}

export async function getRestaurantsByCity(cityId: number): Promise<ApiResponse<Restaurant[]>> {
  try {
    const response = await fetch(`/api/restaurants/by-city?city_id=${cityId}`);
    if (!response.ok) {
      return { success: false, data: [], message: 'Network error' };
    }
    const data = await response.json();
    return data as ApiResponse<Restaurant[]>;
  } catch {
    return { success: false, data: [], message: 'Connection error' };
  }
}