export interface Restaurant {
    id: number;
    name: string;
    description?: string;
    address: string;
    phone?: string;
    email?: string;
    opening_hours?: {
        [key: string]: {
            open: string;
            close: string;
            closed?: boolean;
        };
    };
    created_at: Date;
    updated_at: Date;
}
export interface Table {
    id: number;
    restaurant_id: number;
    table_number: number;
    capacity: number;
    is_available: boolean;
    created_at: Date;
    updated_at: Date;
}
export interface Customer {
    id: number;
    first_name: string;
    last_name: string;
    email: string;
    phone?: string;
    password_hash?: string;
    created_at: Date;
    updated_at: Date;
}
export interface Reservation {
    id: number;
    customer_id: number;
    restaurant_id: number;
    table_id: number;
    reservation_date: string;
    reservation_time: string;
    party_size: number;
    status: 'pending' | 'confirmed' | 'cancelled' | 'completed';
    special_requests?: string;
    created_at: Date;
    updated_at: Date;
}
export interface CreateReservationRequest {
    customer_email: string;
    customer_first_name: string;
    customer_last_name: string;
    customer_phone?: string;
    restaurant_id: number;
    reservation_date: string;
    reservation_time: string;
    party_size: number;
    special_requests?: string;
}
export interface AvailableTablesQuery {
    restaurant_id: number;
    date: string;
    time: string;
    party_size: number;
}
export interface TableAvailability {
    table_id: number;
    table_number: number;
    capacity: number;
    is_available: boolean;
}
//# sourceMappingURL=index.d.ts.map