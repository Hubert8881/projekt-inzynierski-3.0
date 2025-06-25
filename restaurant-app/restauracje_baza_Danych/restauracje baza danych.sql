--
-- PostgreSQL database cluster dump
--

-- Started on 2025-06-25 18:42:54

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:KqMUOqC+4gmEKlt7ma7SXA==$3kcDlfaR5OjJVw9bOLoA8L3j2N4vfKuB39yP+YaJvlE=:tDfRqdLwl5TPtdFqha8oUZi3TPc1JZ9Gi+boIxpF0xQ=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-06-25 18:42:54

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2025-06-25 18:42:54

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-06-25 18:42:54

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2025-06-25 18:42:54

--
-- PostgreSQL database dump complete
--

--
-- Database "restaurant_db" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-06-25 18:42:54

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4863 (class 1262 OID 16388)
-- Name: restaurant_db; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE restaurant_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Polish_Poland.1250';


ALTER DATABASE restaurant_db OWNER TO postgres;

\connect restaurant_db

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 16462)
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16461)
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_id_seq OWNER TO postgres;

--
-- TOC entry 4864 (class 0 OID 0)
-- Dependencies: 225
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- TOC entry 222 (class 1259 OID 16418)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20),
    password_hash character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16417)
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_id_seq OWNER TO postgres;

--
-- TOC entry 4865 (class 0 OID 0)
-- Dependencies: 221
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- TOC entry 224 (class 1259 OID 16431)
-- Name: reservations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservations (
    id integer NOT NULL,
    customer_id integer,
    restaurant_id integer,
    table_id integer,
    reservation_date date NOT NULL,
    reservation_time time without time zone NOT NULL,
    party_size integer NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying,
    special_requests text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reservations_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'confirmed'::character varying, 'cancelled'::character varying, 'completed'::character varying])::text[])))
);


ALTER TABLE public.reservations OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16430)
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reservations_id_seq OWNER TO postgres;

--
-- TOC entry 4866 (class 0 OID 0)
-- Dependencies: 223
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservations_id_seq OWNED BY public.reservations.id;


--
-- TOC entry 218 (class 1259 OID 16390)
-- Name: restaurants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.restaurants (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    address character varying(500) NOT NULL,
    phone character varying(20),
    email character varying(255),
    opening_hours jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    city_id integer,
    city character varying(100),
    latitude numeric,
    longitude numeric
);


ALTER TABLE public.restaurants OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16389)
-- Name: restaurants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.restaurants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.restaurants_id_seq OWNER TO postgres;

--
-- TOC entry 4867 (class 0 OID 0)
-- Dependencies: 217
-- Name: restaurants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.restaurants_id_seq OWNED BY public.restaurants.id;


--
-- TOC entry 220 (class 1259 OID 16401)
-- Name: tables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tables (
    id integer NOT NULL,
    restaurant_id integer,
    table_number integer NOT NULL,
    capacity integer NOT NULL,
    is_available boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tables OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16400)
-- Name: tables_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tables_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tables_id_seq OWNER TO postgres;

--
-- TOC entry 4868 (class 0 OID 0)
-- Dependencies: 219
-- Name: tables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tables_id_seq OWNED BY public.tables.id;


--
-- TOC entry 4675 (class 2604 OID 16465)
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- TOC entry 4668 (class 2604 OID 16421)
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- TOC entry 4671 (class 2604 OID 16434)
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations ALTER COLUMN id SET DEFAULT nextval('public.reservations_id_seq'::regclass);


--
-- TOC entry 4661 (class 2604 OID 16393)
-- Name: restaurants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurants ALTER COLUMN id SET DEFAULT nextval('public.restaurants_id_seq'::regclass);


--
-- TOC entry 4664 (class 2604 OID 16404)
-- Name: tables id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables ALTER COLUMN id SET DEFAULT nextval('public.tables_id_seq'::regclass);


--
-- TOC entry 4857 (class 0 OID 16462)
-- Dependencies: 226
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cities (id, name) FROM stdin;
1	Warszawa
2	Kraków
3	Poznań
4	Gdańsk
5	Toruń
\.


--
-- TOC entry 4853 (class 0 OID 16418)
-- Dependencies: 222
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, first_name, last_name, email, phone, password_hash, created_at, updated_at) FROM stdin;
1	Jan	Kowalski	jan.kowalski@example.com	123456789	\N	2025-06-15 15:56:13.389399	2025-06-15 15:56:13.389399
2	test11	test22	test@test.com	\N	\N	2025-06-15 16:33:59.315029	2025-06-15 16:33:59.315029
3	Piotr	Nowak	testtesttttt@at.pcc	900121212	\N	2025-06-15 17:02:41.968691	2025-06-15 17:02:41.968691
4	Kasia	Kowalska	kasia.kowalska11111@wp.pl	+48 299212291	\N	2025-06-15 17:07:40.343602	2025-06-15 17:07:40.343602
5	Hubert Dominik Bartek	Nazwisko Nazwisko1 Nazwisko2	mailtest@asss.pl	990922131	\N	2025-06-17 16:37:12.341303	2025-06-17 16:37:12.341303
6	hubert	test	hubrwurbw@sd.pl	+48895834958	\N	2025-06-17 16:51:14.731158	2025-06-17 16:51:14.731158
7	Mateusz	testowy	matixpompa@wp.pl	+48222943293	\N	2025-06-17 16:53:34.47386	2025-06-17 16:53:34.47386
27	hubert	testowy	hubert43334@gfe.sd	+48222923923	\N	2025-06-17 20:47:40.869545	2025-06-17 20:47:40.869545
29	43	432	432@2.sp	+48432543534	\N	2025-06-18 00:01:02.354906	2025-06-18 00:01:02.354906
31	piotr	testowy	email2@a.pl	+48834834253	\N	2025-06-18 01:33:35.181891	2025-06-18 01:33:35.181891
32	piotr	kowalskji	jidfsd@3.pl	+48435353454	\N	2025-06-18 01:49:20.921441	2025-06-18 01:49:20.921441
33	adam	malysz	adammalysz72@1.pl	+48948484848	\N	2025-06-18 01:55:34.959922	2025-06-18 01:55:34.959922
34	Kornelia	Testowa	Korneliatest@12.pl	+48483489573	\N	2025-06-18 12:37:34.314355	2025-06-18 12:37:34.314355
35	test	test	tset123@21.pl	+48543534534	\N	2025-06-18 12:58:10.598238	2025-06-18 12:58:10.598238
\.


--
-- TOC entry 4855 (class 0 OID 16431)
-- Dependencies: 224
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservations (id, customer_id, restaurant_id, table_id, reservation_date, reservation_time, party_size, status, special_requests, created_at, updated_at) FROM stdin;
11	27	29	263	2025-06-19	19:00:00	2	pending	\N	2025-06-17 20:47:40.869545	2025-06-17 20:47:40.869545
12	27	29	264	2025-06-19	19:00:00	2	pending	\N	2025-06-17 20:47:44.434152	2025-06-17 20:47:44.434152
13	29	20	181	2026-12-24	20:00:00	10	pending	\N	2025-06-18 00:01:02.354906	2025-06-18 00:01:02.354906
14	31	26	232	2026-05-26	19:00:00	1	pending	\N	2025-06-18 01:33:35.181891	2025-06-18 01:33:35.181891
15	32	27	243	2026-06-20	20:00:00	2	pending	\N	2025-06-18 01:49:20.921441	2025-06-18 01:49:20.921441
16	33	27	244	2026-06-20	20:00:00	2	pending	\N	2025-06-18 01:55:34.959922	2025-06-18 01:55:34.959922
17	34	31	283	2025-06-20	20:00:00	2	pending	\N	2025-06-18 12:37:34.314355	2025-06-18 12:37:34.314355
18	35	26	234	2026-06-20	20:00:00	3	pending	\N	2025-06-18 12:58:10.598238	2025-06-18 12:58:10.598238
\.


--
-- TOC entry 4849 (class 0 OID 16390)
-- Dependencies: 218
-- Data for Name: restaurants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.restaurants (id, name, description, address, phone, email, opening_hours, created_at, updated_at, city_id, city, latitude, longitude) FROM stdin;
1	Restauracja Toruńska	Klimatyczne miejsce z tradycyjną kuchnią	ul. Szeroka 10, Toruń	567890123	kontakt@restauracjatorunska.pl	{"mon-fri": "10:00-22:00", "sat-sun": "12:00-23:00"}	2025-06-15 15:12:34.50513	2025-06-15 15:12:34.50513	\N	Toruń	\N	\N
2	Pizzeria Bella	Najlepsza pizza w mieście	ul. Żeglarska 5, Toruń	512345678	pizza@bellatorun.pl	{"mon-sun": "11:00-23:00"}	2025-06-15 15:12:34.50513	2025-06-15 15:12:34.50513	\N	Toruń	\N	\N
29	Chleb i Wino	Restauracja i winiarnia z klimatem.	ul. Rynek Staromiejski 22, 87-100 Toruń	+48 56 477 60 10	rezerwacje@chlebiwino.pl	{"mon-sun": "12:00-22:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	5	Toruń	53.0110202	18.6038065
30	Jan Olbracht	Browar restauracyjny z własnym piwem.	ul. Szczytna 15, 87-100 Toruń	+48 56 622 40 99	kontakt@olbracht.pl	{"mon-sun": "12:00-23:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	5	Toruń	53.0110129	18.6056115
31	Manekin	Naleśnikarnia z bogatym menu.	ul. Rynek Staromiejski 16, 87-100 Toruń	+48 56 623 45 12	biuro@manekin.pl	{"mon-sun": "10:00-22:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	5	Toruń	53.0107142	18.6032042
95	Stół Polski	Nowoczesna kuchnia polska w sercu stolicy.	ul. Marszałkowska 10, 00-590 Warszawa	+48 22 123 45 67	kontakt@stolpolski.pl	{"mon-fri": "12:00-22:00", "sat-sun": "13:00-23:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	1	\N	\N	\N
96	VegeMiasto	Wegetariańska oaza smaków przy Placu Bankowym.	ul. Solidarności 60, 00-240 Warszawa	+48 22 890 12 34	biuro@vegemiasto.pl	{"mon-sun": "11:00-21:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	1	\N	\N	\N
97	Sakana Sushi	Ekskluzywne sushi z najwyższej jakości składników.	ul. Moliera 4, 00-076 Warszawa	+48 22 450 00 55	warszawa@sakana.pl	{"sun": "12:00-20:00", "mon-sat": "12:00-22:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	1	\N	\N	\N
98	Pod Wawelem	Tradycyjna kuchnia galicyjska tuż pod Wawelem.	ul. Św. Gertrudy 26-29, 31-048 Kraków	+48 12 422 32 50	kontakt@podwawelem.eu	{"mon-sun": "11:00-23:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	2	\N	\N	\N
99	Zielone Tarasy	Restauracja z widokiem na Wisłę i dania wegańskie.	ul. Tyniecka 10, 30-319 Kraków	+48 12 340 56 78	info@zielonetarasy.pl	{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	2	\N	\N	\N
100	Nolio	Pizza neapolitańska wypiekana w piecu opalanym drewnem.	ul. Krakowska 27, 31-062 Kraków	+48 12 356 23 44	rezerwacje@nolio.pl	{"mon-sun": "12:00-23:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	2	\N	\N	\N
101	Muga	Fine dining z polskim twistem.	ul. Krysiewicza 5, 61-825 Poznań	+48 61 678 90 12	kontakt@muga.pl	{"mon-sat": "13:00-22:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	3	\N	\N	\N
102	Frontiera	Włoska kuchnia z nowoczesnym podejściem.	ul. Garbary 54, 61-758 Poznań	+48 61 123 45 67	info@frontiera.pl	{"mon-sun": "12:00-23:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	3	\N	\N	\N
103	Pierogarnia Stary Młyn	Pierogi jak u babci w sercu Poznania.	Stary Rynek 100, 61-773 Poznań	+48 61 888 77 66	rezerwacje@starymlyn.pl	{"mon-sun": "11:00-21:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	3	\N	\N	\N
104	Gvara	Wyjątkowa kuchnia europejska i lokalna.	ul. Długa 81/83, 80-831 Gdańsk	+48 58 305 30 50	biuro@gvara.pl	{"mon-sun": "12:00-22:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	4	\N	\N	\N
105	Billy’s American Restaurant	Amerykańskie burgery i steki.	ul. Tkacka 21/22, 80-836 Gdańsk	+48 58 320 12 13	kontakt@billys.pl	{"mon-sun": "13:00-23:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	4	\N	\N	\N
17	Stół Polski	Nowoczesna kuchnia polska w sercu stolicy.	ul. Marszałkowska 10, 00-590 Warszawa	+48 22 123 45 67	kontakt@stolpolski.pl	{"mon-fri": "12:00-22:00", "sat-sun": "13:00-23:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	1	Warszawa	52.2154144	21.0205885
18	VegeMiasto	Wegetariańska oaza smaków przy Placu Bankowym.	ul. Solidarności 60, 00-240 Warszawa	+48 22 890 12 34	biuro@vegemiasto.pl	{"mon-sun": "11:00-21:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	1	Warszawa	52.2463696	21.0058193
19	Sakana Sushi	Ekskluzywne sushi z najwyższej jakości składników.	ul. Moliera 4, 00-076 Warszawa	+48 22 450 00 55	warszawa@sakana.pl	{"sun": "12:00-20:00", "mon-sat": "12:00-22:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	1	Warszawa	52.2438138	21.0119338
20	Pod Wawelem	Tradycyjna kuchnia galicyjska tuż pod Wawelem.	ul. Św. Gertrudy 26-29, 31-048 Kraków	+48 12 422 32 50	kontakt@podwawelem.eu	{"mon-sun": "11:00-23:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	2	Kraków	50.0546022	19.939342
21	Zielone Tarasy	Restauracja z widokiem na Wisłę i dania wegańskie.	ul. Tyniecka 10, 30-319 Kraków	+48 12 340 56 78	info@zielonetarasy.pl	{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	2	Kraków	50.0509253	19.9227223
22	Nolio	Pizza neapolitańska wypiekana w piecu opalanym drewnem.	ul. Krakowska 27, 31-062 Kraków	+48 12 356 23 44	rezerwacje@nolio.pl	{"mon-sun": "12:00-23:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	2	Kraków	50.0493698	19.9428644
23	Muga	Fine dining z polskim twistem.	ul. Krysiewicza 5, 61-825 Poznań	+48 61 678 90 12	kontakt@muga.pl	{"mon-sat": "13:00-22:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	3	Poznań	52.4039736	16.9290364
24	Frontiera	Włoska kuchnia z nowoczesnym podejściem.	ul. Garbary 54, 61-758 Poznań	+48 61 123 45 67	info@frontiera.pl	{"mon-sun": "12:00-23:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	3	Poznań	52.4073496	16.9380317
25	Pierogarnia Stary Młyn	Pierogi jak u babci w sercu Poznania.	Stary Rynek 100, 61-773 Poznań	+48 61 888 77 66	rezerwacje@starymlyn.pl	{"mon-sun": "11:00-21:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	3	Poznań	52.408827	16.934679
26	Gvara	Wyjątkowa kuchnia europejska i lokalna.	ul. Długa 81/83, 80-831 Gdańsk	+48 58 305 30 50	biuro@gvara.pl	{"mon-sun": "12:00-22:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	4	Gdańsk	54.3496753	18.6485301
27	Billy’s American Restaurant	Amerykańskie burgery i steki.	ul. Tkacka 21/22, 80-836 Gdańsk	+48 58 320 12 13	kontakt@billys.pl	{"mon-sun": "13:00-23:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	4	Gdańsk	54.3499121	18.6491786
28	Mandu	Najlepsze pierogi w Trójmieście.	ul. Elżbietańska 4/8, 80-894 Gdańsk	+48 58 573 20 70	info@mandu.pl	{"mon-sun": "12:00-22:00"}	2025-06-17 17:15:55.544939	2025-06-17 17:15:55.544939	4	Gdańsk	54.3536682	18.6468446
106	Mandu	Najlepsze pierogi w Trójmieście.	ul. Elżbietańska 4/8, 80-894 Gdańsk	+48 58 573 20 70	info@mandu.pl	{"mon-sun": "12:00-22:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	4	\N	\N	\N
107	Chleb i Wino	Restauracja i winiarnia z klimatem.	ul. Rynek Staromiejski 22, 87-100 Toruń	+48 56 477 60 10	rezerwacje@chlebiwino.pl	{"mon-sun": "12:00-22:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	5	\N	\N	\N
108	Jan Olbracht	Browar restauracyjny z własnym piwem.	ul. Szczytna 15, 87-100 Toruń	+48 56 622 40 99	kontakt@olbracht.pl	{"mon-sun": "12:00-23:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	5	\N	\N	\N
109	Manekin	Naleśnikarnia z bogatym menu.	ul. Rynek Staromiejski 16, 87-100 Toruń	+48 56 623 45 12	biuro@manekin.pl	{"mon-sun": "10:00-22:00"}	2025-06-17 23:59:57.575133	2025-06-17 23:59:57.575133	5	\N	\N	\N
110	Stół Polski	Nowoczesna kuchnia polska w sercu stolicy.	ul. Marszałkowska 10, 00-590 Warszawa	+48 22 123 45 67	kontakt@stolpolski.pl	{"mon-fri": "12:00-22:00", "sat-sun": "13:00-23:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	1	\N	\N	\N
111	VegeMiasto	Wegetariańska oaza smaków przy Placu Bankowym.	ul. Solidarności 60, 00-240 Warszawa	+48 22 890 12 34	biuro@vegemiasto.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	1	\N	\N	\N
112	Sakana Sushi	Ekskluzywne sushi z najwyższej jakości składników.	ul. Moliera 4, 00-076 Warszawa	+48 22 450 00 55	warszawa@sakana.pl	{"sun": "12:00-20:00", "mon-sat": "12:00-22:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	1	\N	\N	\N
113	Pod Wawelem	Tradycyjna kuchnia galicyjska tuż pod Wawelem.	ul. Św. Gertrudy 26-29, 31-048 Kraków	+48 12 422 32 50	kontakt@podwawelem.eu	{"mon-sun": "11:00-23:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	2	\N	\N	\N
114	Zielone Tarasy	Restauracja z widokiem na Wisłę i dania wegańskie.	ul. Tyniecka 10, 30-319 Kraków	+48 12 340 56 78	info@zielonetarasy.pl	{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	2	\N	\N	\N
115	Nolio	Pizza neapolitańska wypiekana w piecu opalanym drewnem.	ul. Krakowska 27, 31-062 Kraków	+48 12 356 23 44	rezerwacje@nolio.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	2	\N	\N	\N
116	Muga	Fine dining z polskim twistem.	ul. Krysiewicza 5, 61-825 Poznań	+48 61 678 90 12	kontakt@muga.pl	{"mon-sat": "13:00-22:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	3	\N	\N	\N
117	Frontiera	Włoska kuchnia z nowoczesnym podejściem.	ul. Garbary 54, 61-758 Poznań	+48 61 123 45 67	info@frontiera.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	3	\N	\N	\N
118	Pierogarnia Stary Młyn	Pierogi jak u babci w sercu Poznania.	Stary Rynek 100, 61-773 Poznań	+48 61 888 77 66	rezerwacje@starymlyn.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	3	\N	\N	\N
119	Gvara	Wyjątkowa kuchnia europejska i lokalna.	ul. Długa 81/83, 80-831 Gdańsk	+48 58 305 30 50	biuro@gvara.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	4	\N	\N	\N
120	Billy’s American Restaurant	Amerykańskie burgery i steki.	ul. Tkacka 21/22, 80-836 Gdańsk	+48 58 320 12 13	kontakt@billys.pl	{"mon-sun": "13:00-23:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	4	\N	\N	\N
121	Mandu	Najlepsze pierogi w Trójmieście.	ul. Elżbietańska 4/8, 80-894 Gdańsk	+48 58 573 20 70	info@mandu.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	4	\N	\N	\N
122	Chleb i Wino	Restauracja i winiarnia z klimatem.	ul. Rynek Staromiejski 22, 87-100 Toruń	+48 56 477 60 10	rezerwacje@chlebiwino.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	5	\N	\N	\N
123	Jan Olbracht	Browar restauracyjny z własnym piwem.	ul. Szczytna 15, 87-100 Toruń	+48 56 622 40 99	kontakt@olbracht.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	5	\N	\N	\N
124	Manekin	Naleśnikarnia z bogatym menu.	ul. Rynek Staromiejski 16, 87-100 Toruń	+48 56 623 45 12	biuro@manekin.pl	{"mon-sun": "10:00-22:00"}	2025-06-18 00:05:54.48764	2025-06-18 00:05:54.48764	5	\N	\N	\N
125	Stół Polski	Nowoczesna kuchnia polska w sercu stolicy.	ul. Marszałkowska 10, 00-590 Warszawa	+48 22 123 45 67	kontakt@stolpolski.pl	{"mon-fri": "12:00-22:00", "sat-sun": "13:00-23:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	1	\N	\N	\N
126	VegeMiasto	Wegetariańska oaza smaków przy Placu Bankowym.	ul. Solidarności 60, 00-240 Warszawa	+48 22 890 12 34	biuro@vegemiasto.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	1	\N	\N	\N
127	Sakana Sushi	Ekskluzywne sushi z najwyższej jakości składników.	ul. Moliera 4, 00-076 Warszawa	+48 22 450 00 55	warszawa@sakana.pl	{"sun": "12:00-20:00", "mon-sat": "12:00-22:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	1	\N	\N	\N
128	Pod Wawelem	Tradycyjna kuchnia galicyjska tuż pod Wawelem.	ul. Św. Gertrudy 26-29, 31-048 Kraków	+48 12 422 32 50	kontakt@podwawelem.eu	{"mon-sun": "11:00-23:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	2	\N	\N	\N
129	Zielone Tarasy	Restauracja z widokiem na Wisłę i dania wegańskie.	ul. Tyniecka 10, 30-319 Kraków	+48 12 340 56 78	info@zielonetarasy.pl	{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	2	\N	\N	\N
130	Nolio	Pizza neapolitańska wypiekana w piecu opalanym drewnem.	ul. Krakowska 27, 31-062 Kraków	+48 12 356 23 44	rezerwacje@nolio.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	2	\N	\N	\N
131	Muga	Fine dining z polskim twistem.	ul. Krysiewicza 5, 61-825 Poznań	+48 61 678 90 12	kontakt@muga.pl	{"mon-sat": "13:00-22:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	3	\N	\N	\N
132	Frontiera	Włoska kuchnia z nowoczesnym podejściem.	ul. Garbary 54, 61-758 Poznań	+48 61 123 45 67	info@frontiera.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	3	\N	\N	\N
133	Pierogarnia Stary Młyn	Pierogi jak u babci w sercu Poznania.	Stary Rynek 100, 61-773 Poznań	+48 61 888 77 66	rezerwacje@starymlyn.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	3	\N	\N	\N
134	Gvara	Wyjątkowa kuchnia europejska i lokalna.	ul. Długa 81/83, 80-831 Gdańsk	+48 58 305 30 50	biuro@gvara.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	4	\N	\N	\N
135	Billy’s American Restaurant	Amerykańskie burgery i steki.	ul. Tkacka 21/22, 80-836 Gdańsk	+48 58 320 12 13	kontakt@billys.pl	{"mon-sun": "13:00-23:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	4	\N	\N	\N
136	Mandu	Najlepsze pierogi w Trójmieście.	ul. Elżbietańska 4/8, 80-894 Gdańsk	+48 58 573 20 70	info@mandu.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	4	\N	\N	\N
137	Chleb i Wino	Restauracja i winiarnia z klimatem.	ul. Rynek Staromiejski 22, 87-100 Toruń	+48 56 477 60 10	rezerwacje@chlebiwino.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	5	\N	\N	\N
138	Jan Olbracht	Browar restauracyjny z własnym piwem.	ul. Szczytna 15, 87-100 Toruń	+48 56 622 40 99	kontakt@olbracht.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	5	\N	\N	\N
139	Manekin	Naleśnikarnia z bogatym menu.	ul. Rynek Staromiejski 16, 87-100 Toruń	+48 56 623 45 12	biuro@manekin.pl	{"mon-sun": "10:00-22:00"}	2025-06-18 00:13:21.838713	2025-06-18 00:13:21.838713	5	\N	\N	\N
140	Stół Polski	Nowoczesna kuchnia polska w sercu stolicy.	ul. Marszałkowska 10, 00-590 Warszawa	+48 22 123 45 67	kontakt@stolpolski.pl	{"mon-fri": "12:00-22:00", "sat-sun": "13:00-23:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	1	\N	\N	\N
141	VegeMiasto	Wegetariańska oaza smaków przy Placu Bankowym.	ul. Solidarności 60, 00-240 Warszawa	+48 22 890 12 34	biuro@vegemiasto.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	1	\N	\N	\N
142	Sakana Sushi	Ekskluzywne sushi z najwyższej jakości składników.	ul. Moliera 4, 00-076 Warszawa	+48 22 450 00 55	warszawa@sakana.pl	{"sun": "12:00-20:00", "mon-sat": "12:00-22:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	1	\N	\N	\N
143	Pod Wawelem	Tradycyjna kuchnia galicyjska tuż pod Wawelem.	ul. Św. Gertrudy 26-29, 31-048 Kraków	+48 12 422 32 50	kontakt@podwawelem.eu	{"mon-sun": "11:00-23:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	2	\N	\N	\N
144	Zielone Tarasy	Restauracja z widokiem na Wisłę i dania wegańskie.	ul. Tyniecka 10, 30-319 Kraków	+48 12 340 56 78	info@zielonetarasy.pl	{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	2	\N	\N	\N
145	Nolio	Pizza neapolitańska wypiekana w piecu opalanym drewnem.	ul. Krakowska 27, 31-062 Kraków	+48 12 356 23 44	rezerwacje@nolio.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	2	\N	\N	\N
146	Muga	Fine dining z polskim twistem.	ul. Krysiewicza 5, 61-825 Poznań	+48 61 678 90 12	kontakt@muga.pl	{"mon-sat": "13:00-22:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	3	\N	\N	\N
147	Frontiera	Włoska kuchnia z nowoczesnym podejściem.	ul. Garbary 54, 61-758 Poznań	+48 61 123 45 67	info@frontiera.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	3	\N	\N	\N
148	Pierogarnia Stary Młyn	Pierogi jak u babci w sercu Poznania.	Stary Rynek 100, 61-773 Poznań	+48 61 888 77 66	rezerwacje@starymlyn.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	3	\N	\N	\N
149	Gvara	Wyjątkowa kuchnia europejska i lokalna.	ul. Długa 81/83, 80-831 Gdańsk	+48 58 305 30 50	biuro@gvara.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	4	\N	\N	\N
150	Billy’s American Restaurant	Amerykańskie burgery i steki.	ul. Tkacka 21/22, 80-836 Gdańsk	+48 58 320 12 13	kontakt@billys.pl	{"mon-sun": "13:00-23:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	4	\N	\N	\N
151	Mandu	Najlepsze pierogi w Trójmieście.	ul. Elżbietańska 4/8, 80-894 Gdańsk	+48 58 573 20 70	info@mandu.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	4	\N	\N	\N
152	Chleb i Wino	Restauracja i winiarnia z klimatem.	ul. Rynek Staromiejski 22, 87-100 Toruń	+48 56 477 60 10	rezerwacje@chlebiwino.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	5	\N	\N	\N
153	Jan Olbracht	Browar restauracyjny z własnym piwem.	ul. Szczytna 15, 87-100 Toruń	+48 56 622 40 99	kontakt@olbracht.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	5	\N	\N	\N
154	Manekin	Naleśnikarnia z bogatym menu.	ul. Rynek Staromiejski 16, 87-100 Toruń	+48 56 623 45 12	biuro@manekin.pl	{"mon-sun": "10:00-22:00"}	2025-06-18 00:32:41.58783	2025-06-18 00:32:41.58783	5	\N	\N	\N
155	Stół Polski	Nowoczesna kuchnia polska w sercu stolicy.	ul. Marszałkowska 10, 00-590 Warszawa	+48 22 123 45 67	kontakt@stolpolski.pl	{"mon-fri": "12:00-22:00", "sat-sun": "13:00-23:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	1	\N	\N	\N
156	VegeMiasto	Wegetariańska oaza smaków przy Placu Bankowym.	ul. Solidarności 60, 00-240 Warszawa	+48 22 890 12 34	biuro@vegemiasto.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	1	\N	\N	\N
157	Sakana Sushi	Ekskluzywne sushi z najwyższej jakości składników.	ul. Moliera 4, 00-076 Warszawa	+48 22 450 00 55	warszawa@sakana.pl	{"sun": "12:00-20:00", "mon-sat": "12:00-22:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	1	\N	\N	\N
158	Pod Wawelem	Tradycyjna kuchnia galicyjska tuż pod Wawelem.	ul. Św. Gertrudy 26-29, 31-048 Kraków	+48 12 422 32 50	kontakt@podwawelem.eu	{"mon-sun": "11:00-23:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	2	\N	\N	\N
159	Zielone Tarasy	Restauracja z widokiem na Wisłę i dania wegańskie.	ul. Tyniecka 10, 30-319 Kraków	+48 12 340 56 78	info@zielonetarasy.pl	{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	2	\N	\N	\N
160	Nolio	Pizza neapolitańska wypiekana w piecu opalanym drewnem.	ul. Krakowska 27, 31-062 Kraków	+48 12 356 23 44	rezerwacje@nolio.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	2	\N	\N	\N
161	Muga	Fine dining z polskim twistem.	ul. Krysiewicza 5, 61-825 Poznań	+48 61 678 90 12	kontakt@muga.pl	{"mon-sat": "13:00-22:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	3	\N	\N	\N
162	Frontiera	Włoska kuchnia z nowoczesnym podejściem.	ul. Garbary 54, 61-758 Poznań	+48 61 123 45 67	info@frontiera.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	3	\N	\N	\N
163	Pierogarnia Stary Młyn	Pierogi jak u babci w sercu Poznania.	Stary Rynek 100, 61-773 Poznań	+48 61 888 77 66	rezerwacje@starymlyn.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	3	\N	\N	\N
164	Gvara	Wyjątkowa kuchnia europejska i lokalna.	ul. Długa 81/83, 80-831 Gdańsk	+48 58 305 30 50	biuro@gvara.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	4	\N	\N	\N
165	Billy’s American Restaurant	Amerykańskie burgery i steki.	ul. Tkacka 21/22, 80-836 Gdańsk	+48 58 320 12 13	kontakt@billys.pl	{"mon-sun": "13:00-23:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	4	\N	\N	\N
166	Mandu	Najlepsze pierogi w Trójmieście.	ul. Elżbietańska 4/8, 80-894 Gdańsk	+48 58 573 20 70	info@mandu.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	4	\N	\N	\N
167	Chleb i Wino	Restauracja i winiarnia z klimatem.	ul. Rynek Staromiejski 22, 87-100 Toruń	+48 56 477 60 10	rezerwacje@chlebiwino.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	5	\N	\N	\N
168	Jan Olbracht	Browar restauracyjny z własnym piwem.	ul. Szczytna 15, 87-100 Toruń	+48 56 622 40 99	kontakt@olbracht.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	5	\N	\N	\N
169	Manekin	Naleśnikarnia z bogatym menu.	ul. Rynek Staromiejski 16, 87-100 Toruń	+48 56 623 45 12	biuro@manekin.pl	{"mon-sun": "10:00-22:00"}	2025-06-18 01:13:18.973785	2025-06-18 01:13:18.973785	5	\N	\N	\N
170	Stół Polski	Nowoczesna kuchnia polska w sercu stolicy.	ul. Marszałkowska 10, 00-590 Warszawa	+48 22 123 45 67	kontakt@stolpolski.pl	{"mon-fri": "12:00-22:00", "sat-sun": "13:00-23:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	1	\N	\N	\N
171	VegeMiasto	Wegetariańska oaza smaków przy Placu Bankowym.	ul. Solidarności 60, 00-240 Warszawa	+48 22 890 12 34	biuro@vegemiasto.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	1	\N	\N	\N
172	Sakana Sushi	Ekskluzywne sushi z najwyższej jakości składników.	ul. Moliera 4, 00-076 Warszawa	+48 22 450 00 55	warszawa@sakana.pl	{"sun": "12:00-20:00", "mon-sat": "12:00-22:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	1	\N	\N	\N
173	Pod Wawelem	Tradycyjna kuchnia galicyjska tuż pod Wawelem.	ul. Św. Gertrudy 26-29, 31-048 Kraków	+48 12 422 32 50	kontakt@podwawelem.eu	{"mon-sun": "11:00-23:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	2	\N	\N	\N
174	Zielone Tarasy	Restauracja z widokiem na Wisłę i dania wegańskie.	ul. Tyniecka 10, 30-319 Kraków	+48 12 340 56 78	info@zielonetarasy.pl	{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	2	\N	\N	\N
175	Nolio	Pizza neapolitańska wypiekana w piecu opalanym drewnem.	ul. Krakowska 27, 31-062 Kraków	+48 12 356 23 44	rezerwacje@nolio.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	2	\N	\N	\N
176	Muga	Fine dining z polskim twistem.	ul. Krysiewicza 5, 61-825 Poznań	+48 61 678 90 12	kontakt@muga.pl	{"mon-sat": "13:00-22:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	3	\N	\N	\N
177	Frontiera	Włoska kuchnia z nowoczesnym podejściem.	ul. Garbary 54, 61-758 Poznań	+48 61 123 45 67	info@frontiera.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	3	\N	\N	\N
178	Pierogarnia Stary Młyn	Pierogi jak u babci w sercu Poznania.	Stary Rynek 100, 61-773 Poznań	+48 61 888 77 66	rezerwacje@starymlyn.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	3	\N	\N	\N
179	Gvara	Wyjątkowa kuchnia europejska i lokalna.	ul. Długa 81/83, 80-831 Gdańsk	+48 58 305 30 50	biuro@gvara.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	4	\N	\N	\N
180	Billy’s American Restaurant	Amerykańskie burgery i steki.	ul. Tkacka 21/22, 80-836 Gdańsk	+48 58 320 12 13	kontakt@billys.pl	{"mon-sun": "13:00-23:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	4	\N	\N	\N
181	Mandu	Najlepsze pierogi w Trójmieście.	ul. Elżbietańska 4/8, 80-894 Gdańsk	+48 58 573 20 70	info@mandu.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	4	\N	\N	\N
182	Chleb i Wino	Restauracja i winiarnia z klimatem.	ul. Rynek Staromiejski 22, 87-100 Toruń	+48 56 477 60 10	rezerwacje@chlebiwino.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	5	\N	\N	\N
183	Jan Olbracht	Browar restauracyjny z własnym piwem.	ul. Szczytna 15, 87-100 Toruń	+48 56 622 40 99	kontakt@olbracht.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	5	\N	\N	\N
184	Manekin	Naleśnikarnia z bogatym menu.	ul. Rynek Staromiejski 16, 87-100 Toruń	+48 56 623 45 12	biuro@manekin.pl	{"mon-sun": "10:00-22:00"}	2025-06-18 01:27:31.021882	2025-06-18 01:27:31.021882	5	\N	\N	\N
185	Stół Polski	Nowoczesna kuchnia polska w sercu stolicy.	ul. Marszałkowska 10, 00-590 Warszawa	+48 22 123 45 67	kontakt@stolpolski.pl	{"mon-fri": "12:00-22:00", "sat-sun": "13:00-23:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	1	\N	\N	\N
186	VegeMiasto	Wegetariańska oaza smaków przy Placu Bankowym.	ul. Solidarności 60, 00-240 Warszawa	+48 22 890 12 34	biuro@vegemiasto.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	1	\N	\N	\N
187	Sakana Sushi	Ekskluzywne sushi z najwyższej jakości składników.	ul. Moliera 4, 00-076 Warszawa	+48 22 450 00 55	warszawa@sakana.pl	{"sun": "12:00-20:00", "mon-sat": "12:00-22:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	1	\N	\N	\N
188	Pod Wawelem	Tradycyjna kuchnia galicyjska tuż pod Wawelem.	ul. Św. Gertrudy 26-29, 31-048 Kraków	+48 12 422 32 50	kontakt@podwawelem.eu	{"mon-sun": "11:00-23:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	2	\N	\N	\N
189	Zielone Tarasy	Restauracja z widokiem na Wisłę i dania wegańskie.	ul. Tyniecka 10, 30-319 Kraków	+48 12 340 56 78	info@zielonetarasy.pl	{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	2	\N	\N	\N
190	Nolio	Pizza neapolitańska wypiekana w piecu opalanym drewnem.	ul. Krakowska 27, 31-062 Kraków	+48 12 356 23 44	rezerwacje@nolio.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	2	\N	\N	\N
191	Muga	Fine dining z polskim twistem.	ul. Krysiewicza 5, 61-825 Poznań	+48 61 678 90 12	kontakt@muga.pl	{"mon-sat": "13:00-22:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	3	\N	\N	\N
192	Frontiera	Włoska kuchnia z nowoczesnym podejściem.	ul. Garbary 54, 61-758 Poznań	+48 61 123 45 67	info@frontiera.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	3	\N	\N	\N
193	Pierogarnia Stary Młyn	Pierogi jak u babci w sercu Poznania.	Stary Rynek 100, 61-773 Poznań	+48 61 888 77 66	rezerwacje@starymlyn.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	3	\N	\N	\N
194	Gvara	Wyjątkowa kuchnia europejska i lokalna.	ul. Długa 81/83, 80-831 Gdańsk	+48 58 305 30 50	biuro@gvara.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	4	\N	\N	\N
195	Billy’s American Restaurant	Amerykańskie burgery i steki.	ul. Tkacka 21/22, 80-836 Gdańsk	+48 58 320 12 13	kontakt@billys.pl	{"mon-sun": "13:00-23:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	4	\N	\N	\N
196	Mandu	Najlepsze pierogi w Trójmieście.	ul. Elżbietańska 4/8, 80-894 Gdańsk	+48 58 573 20 70	info@mandu.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	4	\N	\N	\N
197	Chleb i Wino	Restauracja i winiarnia z klimatem.	ul. Rynek Staromiejski 22, 87-100 Toruń	+48 56 477 60 10	rezerwacje@chlebiwino.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	5	\N	\N	\N
198	Jan Olbracht	Browar restauracyjny z własnym piwem.	ul. Szczytna 15, 87-100 Toruń	+48 56 622 40 99	kontakt@olbracht.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	5	\N	\N	\N
199	Manekin	Naleśnikarnia z bogatym menu.	ul. Rynek Staromiejski 16, 87-100 Toruń	+48 56 623 45 12	biuro@manekin.pl	{"mon-sun": "10:00-22:00"}	2025-06-18 01:32:31.01694	2025-06-18 01:32:31.01694	5	\N	\N	\N
200	Stół Polski	Nowoczesna kuchnia polska w sercu stolicy.	ul. Marszałkowska 10, 00-590 Warszawa	+48 22 123 45 67	kontakt@stolpolski.pl	{"mon-fri": "12:00-22:00", "sat-sun": "13:00-23:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	1	\N	\N	\N
201	VegeMiasto	Wegetariańska oaza smaków przy Placu Bankowym.	ul. Solidarności 60, 00-240 Warszawa	+48 22 890 12 34	biuro@vegemiasto.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	1	\N	\N	\N
202	Sakana Sushi	Ekskluzywne sushi z najwyższej jakości składników.	ul. Moliera 4, 00-076 Warszawa	+48 22 450 00 55	warszawa@sakana.pl	{"sun": "12:00-20:00", "mon-sat": "12:00-22:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	1	\N	\N	\N
203	Pod Wawelem	Tradycyjna kuchnia galicyjska tuż pod Wawelem.	ul. Św. Gertrudy 26-29, 31-048 Kraków	+48 12 422 32 50	kontakt@podwawelem.eu	{"mon-sun": "11:00-23:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	2	\N	\N	\N
204	Zielone Tarasy	Restauracja z widokiem na Wisłę i dania wegańskie.	ul. Tyniecka 10, 30-319 Kraków	+48 12 340 56 78	info@zielonetarasy.pl	{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	2	\N	\N	\N
205	Nolio	Pizza neapolitańska wypiekana w piecu opalanym drewnem.	ul. Krakowska 27, 31-062 Kraków	+48 12 356 23 44	rezerwacje@nolio.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	2	\N	\N	\N
206	Muga	Fine dining z polskim twistem.	ul. Krysiewicza 5, 61-825 Poznań	+48 61 678 90 12	kontakt@muga.pl	{"mon-sat": "13:00-22:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	3	\N	\N	\N
207	Frontiera	Włoska kuchnia z nowoczesnym podejściem.	ul. Garbary 54, 61-758 Poznań	+48 61 123 45 67	info@frontiera.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	3	\N	\N	\N
208	Pierogarnia Stary Młyn	Pierogi jak u babci w sercu Poznania.	Stary Rynek 100, 61-773 Poznań	+48 61 888 77 66	rezerwacje@starymlyn.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	3	\N	\N	\N
209	Gvara	Wyjątkowa kuchnia europejska i lokalna.	ul. Długa 81/83, 80-831 Gdańsk	+48 58 305 30 50	biuro@gvara.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	4	\N	\N	\N
210	Billy’s American Restaurant	Amerykańskie burgery i steki.	ul. Tkacka 21/22, 80-836 Gdańsk	+48 58 320 12 13	kontakt@billys.pl	{"mon-sun": "13:00-23:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	4	\N	\N	\N
211	Mandu	Najlepsze pierogi w Trójmieście.	ul. Elżbietańska 4/8, 80-894 Gdańsk	+48 58 573 20 70	info@mandu.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	4	\N	\N	\N
212	Chleb i Wino	Restauracja i winiarnia z klimatem.	ul. Rynek Staromiejski 22, 87-100 Toruń	+48 56 477 60 10	rezerwacje@chlebiwino.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	5	\N	\N	\N
213	Jan Olbracht	Browar restauracyjny z własnym piwem.	ul. Szczytna 15, 87-100 Toruń	+48 56 622 40 99	kontakt@olbracht.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	5	\N	\N	\N
214	Manekin	Naleśnikarnia z bogatym menu.	ul. Rynek Staromiejski 16, 87-100 Toruń	+48 56 623 45 12	biuro@manekin.pl	{"mon-sun": "10:00-22:00"}	2025-06-18 01:34:35.792073	2025-06-18 01:34:35.792073	5	\N	\N	\N
215	Stół Polski	Nowoczesna kuchnia polska w sercu stolicy.	ul. Marszałkowska 10, 00-590 Warszawa	+48 22 123 45 67	kontakt@stolpolski.pl	{"mon-fri": "12:00-22:00", "sat-sun": "13:00-23:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	1	\N	\N	\N
216	VegeMiasto	Wegetariańska oaza smaków przy Placu Bankowym.	ul. Solidarności 60, 00-240 Warszawa	+48 22 890 12 34	biuro@vegemiasto.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	1	\N	\N	\N
217	Sakana Sushi	Ekskluzywne sushi z najwyższej jakości składników.	ul. Moliera 4, 00-076 Warszawa	+48 22 450 00 55	warszawa@sakana.pl	{"sun": "12:00-20:00", "mon-sat": "12:00-22:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	1	\N	\N	\N
218	Pod Wawelem	Tradycyjna kuchnia galicyjska tuż pod Wawelem.	ul. Św. Gertrudy 26-29, 31-048 Kraków	+48 12 422 32 50	kontakt@podwawelem.eu	{"mon-sun": "11:00-23:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	2	\N	\N	\N
219	Zielone Tarasy	Restauracja z widokiem na Wisłę i dania wegańskie.	ul. Tyniecka 10, 30-319 Kraków	+48 12 340 56 78	info@zielonetarasy.pl	{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	2	\N	\N	\N
220	Nolio	Pizza neapolitańska wypiekana w piecu opalanym drewnem.	ul. Krakowska 27, 31-062 Kraków	+48 12 356 23 44	rezerwacje@nolio.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	2	\N	\N	\N
221	Muga	Fine dining z polskim twistem.	ul. Krysiewicza 5, 61-825 Poznań	+48 61 678 90 12	kontakt@muga.pl	{"mon-sat": "13:00-22:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	3	\N	\N	\N
222	Frontiera	Włoska kuchnia z nowoczesnym podejściem.	ul. Garbary 54, 61-758 Poznań	+48 61 123 45 67	info@frontiera.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	3	\N	\N	\N
223	Pierogarnia Stary Młyn	Pierogi jak u babci w sercu Poznania.	Stary Rynek 100, 61-773 Poznań	+48 61 888 77 66	rezerwacje@starymlyn.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	3	\N	\N	\N
224	Gvara	Wyjątkowa kuchnia europejska i lokalna.	ul. Długa 81/83, 80-831 Gdańsk	+48 58 305 30 50	biuro@gvara.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	4	\N	\N	\N
225	Billy’s American Restaurant	Amerykańskie burgery i steki.	ul. Tkacka 21/22, 80-836 Gdańsk	+48 58 320 12 13	kontakt@billys.pl	{"mon-sun": "13:00-23:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	4	\N	\N	\N
226	Mandu	Najlepsze pierogi w Trójmieście.	ul. Elżbietańska 4/8, 80-894 Gdańsk	+48 58 573 20 70	info@mandu.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	4	\N	\N	\N
227	Chleb i Wino	Restauracja i winiarnia z klimatem.	ul. Rynek Staromiejski 22, 87-100 Toruń	+48 56 477 60 10	rezerwacje@chlebiwino.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	5	\N	\N	\N
228	Jan Olbracht	Browar restauracyjny z własnym piwem.	ul. Szczytna 15, 87-100 Toruń	+48 56 622 40 99	kontakt@olbracht.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	5	\N	\N	\N
229	Manekin	Naleśnikarnia z bogatym menu.	ul. Rynek Staromiejski 16, 87-100 Toruń	+48 56 623 45 12	biuro@manekin.pl	{"mon-sun": "10:00-22:00"}	2025-06-18 12:36:17.964017	2025-06-18 12:36:17.964017	5	\N	\N	\N
230	Stół Polski	Nowoczesna kuchnia polska w sercu stolicy.	ul. Marszałkowska 10, 00-590 Warszawa	+48 22 123 45 67	kontakt@stolpolski.pl	{"mon-fri": "12:00-22:00", "sat-sun": "13:00-23:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	1	\N	\N	\N
231	VegeMiasto	Wegetariańska oaza smaków przy Placu Bankowym.	ul. Solidarności 60, 00-240 Warszawa	+48 22 890 12 34	biuro@vegemiasto.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	1	\N	\N	\N
232	Sakana Sushi	Ekskluzywne sushi z najwyższej jakości składników.	ul. Moliera 4, 00-076 Warszawa	+48 22 450 00 55	warszawa@sakana.pl	{"sun": "12:00-20:00", "mon-sat": "12:00-22:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	1	\N	\N	\N
233	Pod Wawelem	Tradycyjna kuchnia galicyjska tuż pod Wawelem.	ul. Św. Gertrudy 26-29, 31-048 Kraków	+48 12 422 32 50	kontakt@podwawelem.eu	{"mon-sun": "11:00-23:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	2	\N	\N	\N
234	Zielone Tarasy	Restauracja z widokiem na Wisłę i dania wegańskie.	ul. Tyniecka 10, 30-319 Kraków	+48 12 340 56 78	info@zielonetarasy.pl	{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	2	\N	\N	\N
235	Nolio	Pizza neapolitańska wypiekana w piecu opalanym drewnem.	ul. Krakowska 27, 31-062 Kraków	+48 12 356 23 44	rezerwacje@nolio.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	2	\N	\N	\N
236	Muga	Fine dining z polskim twistem.	ul. Krysiewicza 5, 61-825 Poznań	+48 61 678 90 12	kontakt@muga.pl	{"mon-sat": "13:00-22:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	3	\N	\N	\N
237	Frontiera	Włoska kuchnia z nowoczesnym podejściem.	ul. Garbary 54, 61-758 Poznań	+48 61 123 45 67	info@frontiera.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	3	\N	\N	\N
238	Pierogarnia Stary Młyn	Pierogi jak u babci w sercu Poznania.	Stary Rynek 100, 61-773 Poznań	+48 61 888 77 66	rezerwacje@starymlyn.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	3	\N	\N	\N
239	Gvara	Wyjątkowa kuchnia europejska i lokalna.	ul. Długa 81/83, 80-831 Gdańsk	+48 58 305 30 50	biuro@gvara.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	4	\N	\N	\N
240	Billy’s American Restaurant	Amerykańskie burgery i steki.	ul. Tkacka 21/22, 80-836 Gdańsk	+48 58 320 12 13	kontakt@billys.pl	{"mon-sun": "13:00-23:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	4	\N	\N	\N
241	Mandu	Najlepsze pierogi w Trójmieście.	ul. Elżbietańska 4/8, 80-894 Gdańsk	+48 58 573 20 70	info@mandu.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	4	\N	\N	\N
242	Chleb i Wino	Restauracja i winiarnia z klimatem.	ul. Rynek Staromiejski 22, 87-100 Toruń	+48 56 477 60 10	rezerwacje@chlebiwino.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	5	\N	\N	\N
243	Jan Olbracht	Browar restauracyjny z własnym piwem.	ul. Szczytna 15, 87-100 Toruń	+48 56 622 40 99	kontakt@olbracht.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	5	\N	\N	\N
244	Manekin	Naleśnikarnia z bogatym menu.	ul. Rynek Staromiejski 16, 87-100 Toruń	+48 56 623 45 12	biuro@manekin.pl	{"mon-sun": "10:00-22:00"}	2025-06-18 12:57:03.812316	2025-06-18 12:57:03.812316	5	\N	\N	\N
245	Stół Polski	Nowoczesna kuchnia polska w sercu stolicy.	ul. Marszałkowska 10, 00-590 Warszawa	+48 22 123 45 67	kontakt@stolpolski.pl	{"mon-fri": "12:00-22:00", "sat-sun": "13:00-23:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	1	\N	\N	\N
246	VegeMiasto	Wegetariańska oaza smaków przy Placu Bankowym.	ul. Solidarności 60, 00-240 Warszawa	+48 22 890 12 34	biuro@vegemiasto.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	1	\N	\N	\N
247	Sakana Sushi	Ekskluzywne sushi z najwyższej jakości składników.	ul. Moliera 4, 00-076 Warszawa	+48 22 450 00 55	warszawa@sakana.pl	{"sun": "12:00-20:00", "mon-sat": "12:00-22:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	1	\N	\N	\N
248	Pod Wawelem	Tradycyjna kuchnia galicyjska tuż pod Wawelem.	ul. Św. Gertrudy 26-29, 31-048 Kraków	+48 12 422 32 50	kontakt@podwawelem.eu	{"mon-sun": "11:00-23:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	2	\N	\N	\N
249	Zielone Tarasy	Restauracja z widokiem na Wisłę i dania wegańskie.	ul. Tyniecka 10, 30-319 Kraków	+48 12 340 56 78	info@zielonetarasy.pl	{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	2	\N	\N	\N
250	Nolio	Pizza neapolitańska wypiekana w piecu opalanym drewnem.	ul. Krakowska 27, 31-062 Kraków	+48 12 356 23 44	rezerwacje@nolio.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	2	\N	\N	\N
251	Muga	Fine dining z polskim twistem.	ul. Krysiewicza 5, 61-825 Poznań	+48 61 678 90 12	kontakt@muga.pl	{"mon-sat": "13:00-22:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	3	\N	\N	\N
252	Frontiera	Włoska kuchnia z nowoczesnym podejściem.	ul. Garbary 54, 61-758 Poznań	+48 61 123 45 67	info@frontiera.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	3	\N	\N	\N
253	Pierogarnia Stary Młyn	Pierogi jak u babci w sercu Poznania.	Stary Rynek 100, 61-773 Poznań	+48 61 888 77 66	rezerwacje@starymlyn.pl	{"mon-sun": "11:00-21:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	3	\N	\N	\N
254	Gvara	Wyjątkowa kuchnia europejska i lokalna.	ul. Długa 81/83, 80-831 Gdańsk	+48 58 305 30 50	biuro@gvara.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	4	\N	\N	\N
255	Billy’s American Restaurant	Amerykańskie burgery i steki.	ul. Tkacka 21/22, 80-836 Gdańsk	+48 58 320 12 13	kontakt@billys.pl	{"mon-sun": "13:00-23:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	4	\N	\N	\N
256	Mandu	Najlepsze pierogi w Trójmieście.	ul. Elżbietańska 4/8, 80-894 Gdańsk	+48 58 573 20 70	info@mandu.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	4	\N	\N	\N
257	Chleb i Wino	Restauracja i winiarnia z klimatem.	ul. Rynek Staromiejski 22, 87-100 Toruń	+48 56 477 60 10	rezerwacje@chlebiwino.pl	{"mon-sun": "12:00-22:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	5	\N	\N	\N
258	Jan Olbracht	Browar restauracyjny z własnym piwem.	ul. Szczytna 15, 87-100 Toruń	+48 56 622 40 99	kontakt@olbracht.pl	{"mon-sun": "12:00-23:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	5	\N	\N	\N
259	Manekin	Naleśnikarnia z bogatym menu.	ul. Rynek Staromiejski 16, 87-100 Toruń	+48 56 623 45 12	biuro@manekin.pl	{"mon-sun": "10:00-22:00"}	2025-06-18 20:05:20.489894	2025-06-18 20:05:20.489894	5	\N	\N	\N
260	Stół Polski	Nowoczesna kuchnia polska w sercu stolicy.	ul. Marszałkowska 10, 00-590 Warszawa	+48 22 123 45 67	kontakt@stolpolski.pl	{"mon-fri": "12:00-22:00", "sat-sun": "13:00-23:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	1	\N	\N	\N
261	VegeMiasto	Wegetariańska oaza smaków przy Placu Bankowym.	ul. Solidarności 60, 00-240 Warszawa	+48 22 890 12 34	biuro@vegemiasto.pl	{"mon-sun": "11:00-21:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	1	\N	\N	\N
262	Sakana Sushi	Ekskluzywne sushi z najwyższej jakości składników.	ul. Moliera 4, 00-076 Warszawa	+48 22 450 00 55	warszawa@sakana.pl	{"sun": "12:00-20:00", "mon-sat": "12:00-22:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	1	\N	\N	\N
263	Pod Wawelem	Tradycyjna kuchnia galicyjska tuż pod Wawelem.	ul. Św. Gertrudy 26-29, 31-048 Kraków	+48 12 422 32 50	kontakt@podwawelem.eu	{"mon-sun": "11:00-23:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	2	\N	\N	\N
264	Zielone Tarasy	Restauracja z widokiem na Wisłę i dania wegańskie.	ul. Tyniecka 10, 30-319 Kraków	+48 12 340 56 78	info@zielonetarasy.pl	{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	2	\N	\N	\N
265	Nolio	Pizza neapolitańska wypiekana w piecu opalanym drewnem.	ul. Krakowska 27, 31-062 Kraków	+48 12 356 23 44	rezerwacje@nolio.pl	{"mon-sun": "12:00-23:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	2	\N	\N	\N
266	Muga	Fine dining z polskim twistem.	ul. Krysiewicza 5, 61-825 Poznań	+48 61 678 90 12	kontakt@muga.pl	{"mon-sat": "13:00-22:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	3	\N	\N	\N
267	Frontiera	Włoska kuchnia z nowoczesnym podejściem.	ul. Garbary 54, 61-758 Poznań	+48 61 123 45 67	info@frontiera.pl	{"mon-sun": "12:00-23:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	3	\N	\N	\N
268	Pierogarnia Stary Młyn	Pierogi jak u babci w sercu Poznania.	Stary Rynek 100, 61-773 Poznań	+48 61 888 77 66	rezerwacje@starymlyn.pl	{"mon-sun": "11:00-21:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	3	\N	\N	\N
269	Gvara	Wyjątkowa kuchnia europejska i lokalna.	ul. Długa 81/83, 80-831 Gdańsk	+48 58 305 30 50	biuro@gvara.pl	{"mon-sun": "12:00-22:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	4	\N	\N	\N
270	Billy’s American Restaurant	Amerykańskie burgery i steki.	ul. Tkacka 21/22, 80-836 Gdańsk	+48 58 320 12 13	kontakt@billys.pl	{"mon-sun": "13:00-23:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	4	\N	\N	\N
271	Mandu	Najlepsze pierogi w Trójmieście.	ul. Elżbietańska 4/8, 80-894 Gdańsk	+48 58 573 20 70	info@mandu.pl	{"mon-sun": "12:00-22:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	4	\N	\N	\N
272	Chleb i Wino	Restauracja i winiarnia z klimatem.	ul. Rynek Staromiejski 22, 87-100 Toruń	+48 56 477 60 10	rezerwacje@chlebiwino.pl	{"mon-sun": "12:00-22:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	5	\N	\N	\N
273	Jan Olbracht	Browar restauracyjny z własnym piwem.	ul. Szczytna 15, 87-100 Toruń	+48 56 622 40 99	kontakt@olbracht.pl	{"mon-sun": "12:00-23:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	5	\N	\N	\N
274	Manekin	Naleśnikarnia z bogatym menu.	ul. Rynek Staromiejski 16, 87-100 Toruń	+48 56 623 45 12	biuro@manekin.pl	{"mon-sun": "10:00-22:00"}	2025-06-22 13:27:42.369981	2025-06-22 13:27:42.369981	5	\N	\N	\N
\.


--
-- TOC entry 4851 (class 0 OID 16401)
-- Dependencies: 220
-- Data for Name: tables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tables (id, restaurant_id, table_number, capacity, is_available, created_at, updated_at) FROM stdin;
142	17	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
143	17	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
144	17	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
145	17	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
72	1	1	10	t	2025-06-17 20:31:32.275642	2025-06-17 20:31:32.275642
73	1	2	10	t	2025-06-17 20:31:32.275642	2025-06-17 20:31:32.275642
74	1	3	10	t	2025-06-17 20:31:32.275642	2025-06-17 20:31:32.275642
75	1	4	10	t	2025-06-17 20:31:32.275642	2025-06-17 20:31:32.275642
76	1	5	10	t	2025-06-17 20:31:32.275642	2025-06-17 20:31:32.275642
77	1	6	10	t	2025-06-17 20:31:32.275642	2025-06-17 20:31:32.275642
78	1	7	10	t	2025-06-17 20:31:32.275642	2025-06-17 20:31:32.275642
79	1	8	10	t	2025-06-17 20:31:32.275642	2025-06-17 20:31:32.275642
80	1	9	10	t	2025-06-17 20:31:32.275642	2025-06-17 20:31:32.275642
81	1	10	10	t	2025-06-17 20:31:32.275642	2025-06-17 20:31:32.275642
82	2	1	10	t	2025-06-17 20:31:38.986918	2025-06-17 20:31:38.986918
83	2	2	10	t	2025-06-17 20:31:38.986918	2025-06-17 20:31:38.986918
84	2	3	10	t	2025-06-17 20:31:38.986918	2025-06-17 20:31:38.986918
85	2	4	10	t	2025-06-17 20:31:38.986918	2025-06-17 20:31:38.986918
86	2	5	10	t	2025-06-17 20:31:38.986918	2025-06-17 20:31:38.986918
87	2	6	10	t	2025-06-17 20:31:38.986918	2025-06-17 20:31:38.986918
88	2	7	10	t	2025-06-17 20:31:38.986918	2025-06-17 20:31:38.986918
89	2	8	10	t	2025-06-17 20:31:38.986918	2025-06-17 20:31:38.986918
90	2	9	10	t	2025-06-17 20:31:38.986918	2025-06-17 20:31:38.986918
91	2	10	10	t	2025-06-17 20:31:38.986918	2025-06-17 20:31:38.986918
146	17	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
147	17	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
148	17	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
149	17	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
150	17	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
151	17	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
152	18	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
153	18	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
154	18	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
155	18	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
156	18	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
157	18	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
158	18	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
159	18	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
160	18	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
161	18	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
162	19	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
163	19	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
164	19	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
165	19	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
166	19	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
167	19	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
168	19	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
169	19	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
170	19	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
171	19	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
172	20	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
173	20	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
174	20	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
175	20	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
176	20	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
177	20	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
178	20	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
179	20	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
180	20	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
181	20	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
182	21	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
183	21	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
184	21	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
185	21	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
186	21	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
187	21	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
188	21	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
189	21	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
190	21	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
191	21	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
192	22	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
193	22	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
194	22	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
195	22	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
196	22	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
197	22	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
198	22	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
199	22	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
200	22	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
201	22	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
202	23	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
203	23	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
204	23	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
205	23	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
206	23	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
207	23	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
208	23	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
209	23	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
210	23	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
211	23	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
212	24	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
213	24	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
214	24	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
215	24	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
216	24	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
217	24	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
218	24	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
219	24	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
220	24	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
221	24	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
222	25	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
223	25	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
224	25	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
225	25	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
226	25	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
227	25	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
228	25	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
229	25	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
230	25	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
231	25	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
232	26	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
233	26	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
234	26	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
235	26	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
236	26	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
237	26	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
238	26	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
239	26	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
240	26	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
241	26	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
242	27	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
243	27	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
244	27	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
245	27	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
246	27	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
247	27	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
248	27	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
249	27	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
250	27	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
251	27	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
252	28	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
253	28	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
254	28	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
255	28	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
256	28	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
257	28	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
258	28	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
259	28	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
260	28	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
261	28	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
262	29	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
263	29	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
264	29	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
265	29	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
266	29	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
267	29	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
268	29	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
269	29	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
270	29	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
271	29	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
272	30	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
273	30	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
274	30	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
275	30	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
276	30	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
277	30	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
278	30	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
279	30	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
280	30	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
281	30	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
282	31	1	1	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
283	31	2	2	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
284	31	3	3	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
285	31	4	4	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
286	31	5	5	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
287	31	6	6	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
288	31	7	7	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
289	31	8	8	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
290	31	9	9	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
291	31	10	10	t	2025-06-17 20:46:14.377663	2025-06-17 20:46:14.377663
\.


--
-- TOC entry 4869 (class 0 OID 0)
-- Dependencies: 225
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_id_seq', 65, true);


--
-- TOC entry 4870 (class 0 OID 0)
-- Dependencies: 221
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 35, true);


--
-- TOC entry 4871 (class 0 OID 0)
-- Dependencies: 223
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservations_id_seq', 18, true);


--
-- TOC entry 4872 (class 0 OID 0)
-- Dependencies: 217
-- Name: restaurants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.restaurants_id_seq', 274, true);


--
-- TOC entry 4873 (class 0 OID 0)
-- Dependencies: 219
-- Name: tables_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tables_id_seq', 291, true);


--
-- TOC entry 4695 (class 2606 OID 16469)
-- Name: cities cities_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_name_key UNIQUE (name);


--
-- TOC entry 4697 (class 2606 OID 16467)
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- TOC entry 4687 (class 2606 OID 16429)
-- Name: customers customers_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);


--
-- TOC entry 4689 (class 2606 OID 16427)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- TOC entry 4693 (class 2606 OID 16442)
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- TOC entry 4678 (class 2606 OID 16399)
-- Name: restaurants restaurants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT restaurants_pkey PRIMARY KEY (id);


--
-- TOC entry 4681 (class 2606 OID 16409)
-- Name: tables tables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_pkey PRIMARY KEY (id);


--
-- TOC entry 4683 (class 2606 OID 16411)
-- Name: tables tables_restaurant_id_table_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_restaurant_id_table_number_key UNIQUE (restaurant_id, table_number);


--
-- TOC entry 4685 (class 2606 OID 16476)
-- Name: tables unique_restaurant_table; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT unique_restaurant_table UNIQUE (restaurant_id, table_number);


--
-- TOC entry 4690 (class 1259 OID 16458)
-- Name: idx_reservations_date_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservations_date_time ON public.reservations USING btree (reservation_date, reservation_time);


--
-- TOC entry 4691 (class 1259 OID 16459)
-- Name: idx_reservations_restaurant; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservations_restaurant ON public.reservations USING btree (restaurant_id);


--
-- TOC entry 4679 (class 1259 OID 16460)
-- Name: idx_tables_restaurant; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tables_restaurant ON public.tables USING btree (restaurant_id);


--
-- TOC entry 4700 (class 2606 OID 16443)
-- Name: reservations reservations_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- TOC entry 4701 (class 2606 OID 16448)
-- Name: reservations reservations_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES public.restaurants(id) ON DELETE CASCADE;


--
-- TOC entry 4702 (class 2606 OID 16453)
-- Name: reservations reservations_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.tables(id) ON DELETE CASCADE;


--
-- TOC entry 4698 (class 2606 OID 16470)
-- Name: restaurants restaurants_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT restaurants_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE SET NULL;


--
-- TOC entry 4699 (class 2606 OID 16412)
-- Name: tables tables_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES public.restaurants(id) ON DELETE CASCADE;


-- Completed on 2025-06-25 18:42:55

--
-- PostgreSQL database dump complete
--

-- Completed on 2025-06-25 18:42:55

--
-- PostgreSQL database cluster dump complete
--

