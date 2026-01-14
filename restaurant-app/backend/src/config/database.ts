import { Pool, PoolConfig } from 'pg';
import * as dotenv from 'dotenv';

dotenv.config();

const dbConfig: PoolConfig = {
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432'),
  database: process.env.DB_NAME || 'restaurant_db',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || '7777',
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
};

export const pool = new Pool(dbConfig);

pool.on('connect', () => {
  console.log('Connected to PostgreSQL database');
});

pool.on('error', (err) => {
  console.error('Unexpected error on idle client', err);
  process.exit(-1);
});

export const initDatabase = async (): Promise<void> => {
  try {
    await pool.query(`
      CREATE TABLE IF NOT EXISTS cities (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL UNIQUE
      );
    `);

    await pool.query(`
      CREATE TABLE IF NOT EXISTS restaurants (
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        description TEXT,
        address VARCHAR(500) NOT NULL,
        phone VARCHAR(20),
        email VARCHAR(255),
        opening_hours JSONB,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        city_id INTEGER REFERENCES cities(id) ON DELETE SET NULL,
        latitude DOUBLE PRECISION,
        longitude DOUBLE PRECISION
      );
    `);

    await pool.query(`
      CREATE TABLE IF NOT EXISTS menu_items (
        id SERIAL PRIMARY KEY,
        restaurant_id INTEGER REFERENCES restaurants(id) ON DELETE CASCADE,
        name VARCHAR(255) NOT NULL,
        price DECIMAL(10, 2) NOT NULL
      );
    `);

    await pool.query(`
      CREATE TABLE IF NOT EXISTS tables (
        id SERIAL PRIMARY KEY,
        restaurant_id INTEGER REFERENCES restaurants(id) ON DELETE CASCADE,
        table_number INTEGER NOT NULL,
        capacity INTEGER NOT NULL,
        is_available BOOLEAN DEFAULT true,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE(restaurant_id, table_number)
      );
    `);

    await pool.query(`
      CREATE TABLE IF NOT EXISTS customers (
        id SERIAL PRIMARY KEY,
        first_name VARCHAR(100) NOT NULL,
        last_name VARCHAR(100) NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL,
        phone VARCHAR(20),
        password_hash VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);

    await pool.query(`
      CREATE TABLE IF NOT EXISTS reservations (
        id SERIAL PRIMARY KEY,
        customer_id INTEGER REFERENCES customers(id) ON DELETE CASCADE,
        restaurant_id INTEGER REFERENCES restaurants(id) ON DELETE CASCADE,
        table_id INTEGER REFERENCES tables(id) ON DELETE CASCADE,
        guest_first_name VARCHAR(100),
        guest_last_name VARCHAR(100),
        guest_email VARCHAR(255),
        guest_phone VARCHAR(20),
        reservation_date DATE NOT NULL,
        reservation_time TIME NOT NULL,
        party_size INTEGER NOT NULL,
        status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'cancelled', 'completed')),
        special_requests TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);

    await pool.query(`CREATE INDEX IF NOT EXISTS idx_reservations_date_time ON reservations(reservation_date, reservation_time);`);
    await pool.query(`CREATE INDEX IF NOT EXISTS idx_reservations_restaurant ON reservations(restaurant_id);`);
    await pool.query(`CREATE INDEX IF NOT EXISTS idx_tables_restaurant ON tables(restaurant_id);`);

    await pool.query(`
      INSERT INTO cities (name)
      VALUES ('Warszawa'), ('Kraków'), ('Poznań'), ('Gdańsk'), ('Toruń')
      ON CONFLICT (name) DO NOTHING;
    `);

    await pool.query(`
      INSERT INTO restaurants (name, description, address, phone, email, opening_hours, city_id) 
      VALUES
        ('Stół Polski', 'Nowoczesna kuchnia polska w sercu stolicy.', 'ul. Marszałkowska 10, 00-590 Warszawa', '+48 22 123 45 67', 'kontakt@stolpolski.pl', '{"mon-fri": "12:00-22:00", "sat-sun": "13:00-23:00"}', (SELECT id FROM cities WHERE name='Warszawa')),
        ('VegeMiasto', 'Wegetariańska oaza smaków przy Placu Bankowym.', 'ul. Solidarności 60, 00-240 Warszawa', '+48 22 890 12 34', 'biuro@vegemiasto.pl', '{"mon-sun": "11:00-21:00"}', (SELECT id FROM cities WHERE name='Warszawa')),
        ('Sakana Sushi', 'Ekskluzywne sushi z najwyższej jakości składników.', 'ul. Moliera 4, 00-076 Warszawa', '+48 22 450 00 55', 'warszawa@sakana.pl', '{"mon-sat": "12:00-22:00", "sun": "12:00-20:00"}', (SELECT id FROM cities WHERE name='Warszawa')),
        ('Pod Wawelem', 'Tradycyjna kuchnia galicyjska tuż pod Wawelem.', 'ul. Św. Gertrudy 26-29, 31-048 Kraków', '+48 12 422 32 50', 'kontakt@podwawelem.eu', '{"mon-sun": "11:00-23:00"}', (SELECT id FROM cities WHERE name='Kraków')),
        ('Zielone Tarasy', 'Restauracja z widokiem na Wisłę i dania wegańskie.', 'ul. Tyniecka 10, 30-319 Kraków', '+48 12 340 56 78', 'info@zielonetarasy.pl', '{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}', (SELECT id FROM cities WHERE name='Kraków')),
        ('Nolio', 'Pizza neapolitańska wypiekana w piecu opalanym drewnem.', 'ul. Krakowska 27, 31-062 Kraków', '+48 12 356 23 44', 'rezerwacje@nolio.pl', '{"mon-sun": "12:00-23:00"}', (SELECT id FROM cities WHERE name='Kraków')),
        ('Muga', 'Fine dining z polskim twistem.', 'ul. Krysiewicza 5, 61-825 Poznań', '+48 61 678 90 12', 'kontakt@muga.pl', '{"mon-sat": "13:00-22:00"}', (SELECT id FROM cities WHERE name='Poznań')),
        ('Frontiera', 'Włoska kuchnia z nowoczesnym podejściem.', 'ul. Garbary 54, 61-758 Poznań', '+48 61 123 45 67', 'info@frontiera.pl', '{"mon-sun": "12:00-23:00"}', (SELECT id FROM cities WHERE name='Poznań')),
        ('Pierogarnia Stary Młyn', 'Pierogi jak u babci w sercu Poznania.', 'Stary Rynek 100, 61-773 Poznań', '+48 61 888 77 66', 'rezerwacje@starymlyn.pl', '{"mon-sun": "11:00-21:00"}', (SELECT id FROM cities WHERE name='Poznań')),
        ('Gvara', 'Wyjątkowa kuchnia europejska i lokalna.', 'ul. Długa 81/83, 80-831 Gdańsk', '+48 58 305 30 50', 'biuro@gvara.pl', '{"mon-sun": "12:00-22:00"}', (SELECT id FROM cities WHERE name='Gdańsk')),
        ('Billy’s American Restaurant', 'Amerykańskie burgery i steki.', 'ul. Tkacka 21/22, 80-836 Gdańsk', '+48 58 320 12 13', 'kontakt@billys.pl', '{"mon-sun": "13:00-23:00"}', (SELECT id FROM cities WHERE name='Gdańsk')),
        ('Mandu', 'Najlepsze pierogi w Trójmieście.', 'ul. Elżbietańska 4/8, 80-894 Gdańsk', '+48 58 573 20 70', 'info@mandu.pl', '{"mon-sun": "12:00-22:00"}', (SELECT id FROM cities WHERE name='Gdańsk')),
        ('Chleb i Wino', 'Restauracja i winiarnia z klimatem.', 'ul. Rynek Staromiejski 22, 87-100 Toruń', '+48 56 477 60 10', 'rezerwacje@chlebiwino.pl', '{"mon-sun": "12:00-22:00"}', (SELECT id FROM cities WHERE name='Toruń')),
        ('Jan Olbracht', 'Browar restauracyjny z własnym piwem.', 'ul. Szczytna 15, 87-100 Toruń', '+48 56 622 40 99', 'kontakt@olbracht.pl', '{"mon-sun": "12:00-23:00"}', (SELECT id FROM cities WHERE name='Toruń')),
        ('Manekin', 'Naleśnikarnia z bogatym menu.', 'ul. Rynek Staromiejski 16, 87-100 Toruń', '+48 56 623 45 12', 'biuro@manekin.pl', '{"mon-sun": "10:00-22:00"}', (SELECT id FROM cities WHERE name='Toruń'))
      ON CONFLICT DO NOTHING;
    `);

    await pool.query(`
      INSERT INTO menu_items (restaurant_id, name, price)
      SELECT id, 'Specjał Szefa Kuchni', 49.00 FROM restaurants
      ON CONFLICT DO NOTHING;
    `);

    console.log('Database tables initialized successfully');
  } catch (error) {
    console.error('Error initializing database:', error);
    throw error;
  }
};