--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2026-01-14 21:40:23

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
-- TOC entry 4879 (class 0 OID 0)
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
-- TOC entry 4880 (class 0 OID 0)
-- Dependencies: 221
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- TOC entry 228 (class 1259 OID 16515)
-- Name: menu_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu_items (
    id integer NOT NULL,
    restaurant_id integer,
    name character varying(255) NOT NULL,
    price numeric(10,2) NOT NULL
);


ALTER TABLE public.menu_items OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16514)
-- Name: menu_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menu_items_id_seq OWNER TO postgres;

--
-- TOC entry 4881 (class 0 OID 0)
-- Dependencies: 227
-- Name: menu_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_items_id_seq OWNED BY public.menu_items.id;


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
    guest_first_name character varying(100),
    guest_last_name character varying(100),
    guest_email character varying(255),
    guest_phone character varying(20),
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
-- TOC entry 4882 (class 0 OID 0)
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
    longitude numeric,
    total_tables integer DEFAULT 10
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
-- TOC entry 4883 (class 0 OID 0)
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
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 219
-- Name: tables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tables_id_seq OWNED BY public.tables.id;


--
-- TOC entry 4681 (class 2604 OID 16465)
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- TOC entry 4674 (class 2604 OID 16421)
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- TOC entry 4682 (class 2604 OID 16518)
-- Name: menu_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_items ALTER COLUMN id SET DEFAULT nextval('public.menu_items_id_seq'::regclass);


--
-- TOC entry 4677 (class 2604 OID 16434)
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations ALTER COLUMN id SET DEFAULT nextval('public.reservations_id_seq'::regclass);


--
-- TOC entry 4666 (class 2604 OID 16393)
-- Name: restaurants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurants ALTER COLUMN id SET DEFAULT nextval('public.restaurants_id_seq'::regclass);


--
-- TOC entry 4670 (class 2604 OID 16404)
-- Name: tables id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables ALTER COLUMN id SET DEFAULT nextval('public.tables_id_seq'::regclass);


--
-- TOC entry 4871 (class 0 OID 16462)
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
-- TOC entry 4867 (class 0 OID 16418)
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
36	asia	kowalska	asia044@as.pl	+48423743277	\N	2025-06-25 20:07:19.005275	2025-06-25 20:07:19.005275
37	piotr	kowalski	piotrkoaslkie2122222222@Wfdksf.pl	+48000000000	\N	2026-01-09 19:17:22.932567	2026-01-09 19:17:22.932567
38	1	1	1@sfdasdsdsdffdssdfdsfsdfdsfsdfdfs.ssssdsdsdf	+48190870878	\N	2026-01-09 20:36:21.935418	2026-01-09 20:36:21.935418
40	432432	432432	435243@das.fds	+48234242342	\N	2026-01-09 22:06:33.185363	2026-01-09 22:06:33.185363
41	sd	dfs	usddsfa@hfggf.gfd	+48543254345	\N	2026-01-09 22:42:04.72309	2026-01-09 22:42:04.72309
42	r33	R3	HDASK@432.ds	+48320490243	\N	2026-01-09 22:47:41.715074	2026-01-09 22:47:41.715074
43	23	r3w	fsfk@fsdfsd.pl	+48342423424	\N	2026-01-09 22:56:27.830999	2026-01-09 22:56:27.830999
48	fdsds	sdfsdf	uhuisfd@dfsjidf.pfsdfs	+48543534543	\N	2026-01-11 12:15:15.903972	2026-01-11 12:15:15.903972
49	jan	kowalski	jankowalski@jankowalski.jankowalski	+48999999999	\N	2026-01-11 12:16:01.32977	2026-01-11 12:16:01.32977
50	jan 	kowalski	jankowalski@1111.jankowalski	+48999999999	\N	2026-01-11 12:34:27.792263	2026-01-11 12:34:27.792263
51	jan	nowak	jannowak@jannowak.3434	+48999999999	\N	2026-01-11 12:34:54.132671	2026-01-11 12:34:54.132671
52	jan	kowalski	jankowalski@jankowalski.fsd	+48534543543	\N	2026-01-11 12:43:57.270597	2026-01-11 12:43:57.270597
53	dfsf	sfdsdf	fsdsdf@fds.fsdfds	+48534534534	\N	2026-01-11 12:53:08.404229	2026-01-11 12:53:08.404229
54	asjdhnas	jsdhfgndk	kslfksd@jdsnfsd.sfdjkgnsjsdf	+48932849274	\N	2026-01-14 18:58:24.598449	2026-01-14 18:58:24.598449
55	sada	asdasd	fsdfksdf@fdskf.fjds	+48544353453	\N	2026-01-14 19:30:43.177415	2026-01-14 19:30:43.177415
56	Adam 	Kowalski	AdamKowalskiAadm@Aadam.Kowalski	+48984032943	\N	2026-01-14 20:30:11.8847	2026-01-14 20:30:11.8847
57	piotr	nowak	piotrnowak@piotrnowak.piotrnowak	+48438975934	\N	2026-01-14 20:31:49.703218	2026-01-14 20:31:49.703218
\.


--
-- TOC entry 4873 (class 0 OID 16515)
-- Dependencies: 228
-- Data for Name: menu_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu_items (id, restaurant_id, name, price) FROM stdin;
1	1	Zupa szczawiowa z jajkiem	22.00
2	1	Kaczka pieczona z jabłkami	58.00
3	1	Kluski śląskie z sosem	28.00
4	1	Kompot z suszu	12.00
5	1	Racuchy z jabłkami	24.00
6	2	Stek z kalafiora	38.00
7	2	Curry z ciecierzycą	34.00
8	2	Pasztet z soczewicy	19.00
9	2	Sernik jaglany	22.00
10	2	Lemoniada bazyliowa	15.00
11	3	Ramen Tonkotsu	42.00
12	3	Hosomaki z ogórkiem	18.00
13	3	Uramaki Ebi Ten	36.00
14	3	Edamame z solą morską	16.00
15	3	Zielona herbata Matcha	14.00
16	4	Sznycel olbrzymi	65.00
17	4	Kiełbasa z ognia	32.00
18	4	Precel krakowski z dipem	14.00
19	4	Gulasz w chlebie	44.00
20	4	Piwo lane niefiltrowane	18.00
21	5	Kwaśnica na żeberku	26.00
22	5	Oscypek z żururawiną	19.00
23	5	Placek po zbójnicku	48.00
24	5	Pstrąg z potoku	52.00
25	5	Herbata z prądem	20.00
26	6	Hummus z pitą	24.00
27	6	Czulent wołowy	46.00
28	6	Gęsie żołądki	38.00
29	6	Sałatka izraelska	28.00
30	6	Pascha	22.00
31	7	Czernina poznańska	28.00
32	7	Pyry z gzikiem	24.00
33	7	Zraz wołowy	54.00
34	7	Modra kapusta	12.00
35	7	Rogal Świętomarciński	18.00
36	8	Stek z polędwicy	85.00
37	8	Burger Brovaria	42.00
38	8	Skrzydełka w miodzie	34.00
39	8	Frytki belgijskie	16.00
40	8	Degustacja piw (4x100ml)	28.00
41	9	Zupa pomidorowa	16.00
42	9	Mielony z ziemniakami	29.00
43	9	Naleśniki z serem	22.00
44	9	Mizeria	8.00
45	9	Kisiel owocowy	10.00
46	10	Zupa rybna z szafranem	38.00
47	10	Łosoś pieczony	62.00
48	10	Tatar z wołowiny premium	48.00
49	10	Krewetki w winie	54.00
50	10	Likier Goldwasser 40ml	25.00
51	11	Dorsz w cieście piwnym	46.00
52	11	Śledź w oleju lnianym	24.00
53	11	Półmisek gdański	88.00
54	11	Chleb ze smalcem	18.00
55	11	Jabłecznik na ciepło	22.00
56	12	Małże św. Jakuba	58.00
57	12	Halibut z puree	64.00
58	12	Policzki wołowe	56.00
59	12	Carpaccio z buraka	32.00
60	12	Panna Cotta	26.00
61	13	Naleśnik Meksykański	32.00
62	13	Naleśnik Carbonara	30.00
63	13	Naleśnik z Nutellą	26.00
64	13	Krem z pomidorów	18.00
65	13	Shake Waniliowy	16.00
66	14	Golonka w piwie	54.00
67	14	Pierogi z gęsiną	38.00
68	14	Deska rzemieślnicza	45.00
69	14	Zupa piwna	22.00
70	14	Smalec Olbrachta	16.00
71	15	Gumbo z owocami morza	48.00
72	15	Jambalaya	44.00
73	15	Kanapka Po-boy	36.00
74	15	Krewetki Creole	52.00
75	15	Banany Foster	28.00
76	1	Specjał Szefa Kuchni	49.00
77	2	Specjał Szefa Kuchni	49.00
78	3	Specjał Szefa Kuchni	49.00
79	4	Specjał Szefa Kuchni	49.00
80	5	Specjał Szefa Kuchni	49.00
81	6	Specjał Szefa Kuchni	49.00
82	7	Specjał Szefa Kuchni	49.00
83	8	Specjał Szefa Kuchni	49.00
84	9	Specjał Szefa Kuchni	49.00
85	10	Specjał Szefa Kuchni	49.00
86	11	Specjał Szefa Kuchni	49.00
87	12	Specjał Szefa Kuchni	49.00
88	13	Specjał Szefa Kuchni	49.00
89	14	Specjał Szefa Kuchni	49.00
90	15	Specjał Szefa Kuchni	49.00
91	20	Specjał Szefa Kuchni	49.00
92	21	Specjał Szefa Kuchni	49.00
93	22	Specjał Szefa Kuchni	49.00
94	23	Specjał Szefa Kuchni	49.00
95	24	Specjał Szefa Kuchni	49.00
96	25	Specjał Szefa Kuchni	49.00
97	26	Specjał Szefa Kuchni	49.00
98	27	Specjał Szefa Kuchni	49.00
99	28	Specjał Szefa Kuchni	49.00
100	1	Specjał Szefa Kuchni	49.00
101	2	Specjał Szefa Kuchni	49.00
102	3	Specjał Szefa Kuchni	49.00
103	4	Specjał Szefa Kuchni	49.00
104	5	Specjał Szefa Kuchni	49.00
105	6	Specjał Szefa Kuchni	49.00
106	7	Specjał Szefa Kuchni	49.00
107	8	Specjał Szefa Kuchni	49.00
108	9	Specjał Szefa Kuchni	49.00
109	10	Specjał Szefa Kuchni	49.00
110	11	Specjał Szefa Kuchni	49.00
111	12	Specjał Szefa Kuchni	49.00
112	13	Specjał Szefa Kuchni	49.00
113	14	Specjał Szefa Kuchni	49.00
114	15	Specjał Szefa Kuchni	49.00
115	20	Specjał Szefa Kuchni	49.00
116	21	Specjał Szefa Kuchni	49.00
117	22	Specjał Szefa Kuchni	49.00
118	23	Specjał Szefa Kuchni	49.00
119	24	Specjał Szefa Kuchni	49.00
120	25	Specjał Szefa Kuchni	49.00
121	26	Specjał Szefa Kuchni	49.00
122	27	Specjał Szefa Kuchni	49.00
123	28	Specjał Szefa Kuchni	49.00
124	1	Specjał Szefa Kuchni	49.00
125	2	Specjał Szefa Kuchni	49.00
126	3	Specjał Szefa Kuchni	49.00
127	4	Specjał Szefa Kuchni	49.00
128	5	Specjał Szefa Kuchni	49.00
129	6	Specjał Szefa Kuchni	49.00
130	7	Specjał Szefa Kuchni	49.00
131	8	Specjał Szefa Kuchni	49.00
132	9	Specjał Szefa Kuchni	49.00
133	10	Specjał Szefa Kuchni	49.00
134	11	Specjał Szefa Kuchni	49.00
135	12	Specjał Szefa Kuchni	49.00
136	13	Specjał Szefa Kuchni	49.00
137	14	Specjał Szefa Kuchni	49.00
138	15	Specjał Szefa Kuchni	49.00
139	20	Specjał Szefa Kuchni	49.00
140	21	Specjał Szefa Kuchni	49.00
141	22	Specjał Szefa Kuchni	49.00
142	23	Specjał Szefa Kuchni	49.00
143	24	Specjał Szefa Kuchni	49.00
144	25	Specjał Szefa Kuchni	49.00
145	26	Specjał Szefa Kuchni	49.00
146	27	Specjał Szefa Kuchni	49.00
147	28	Specjał Szefa Kuchni	49.00
148	1	Specjał Szefa Kuchni	49.00
149	2	Specjał Szefa Kuchni	49.00
150	3	Specjał Szefa Kuchni	49.00
151	4	Specjał Szefa Kuchni	49.00
152	5	Specjał Szefa Kuchni	49.00
153	6	Specjał Szefa Kuchni	49.00
154	7	Specjał Szefa Kuchni	49.00
155	8	Specjał Szefa Kuchni	49.00
156	9	Specjał Szefa Kuchni	49.00
157	10	Specjał Szefa Kuchni	49.00
158	11	Specjał Szefa Kuchni	49.00
159	12	Specjał Szefa Kuchni	49.00
160	13	Specjał Szefa Kuchni	49.00
161	14	Specjał Szefa Kuchni	49.00
162	15	Specjał Szefa Kuchni	49.00
163	20	Specjał Szefa Kuchni	49.00
164	21	Specjał Szefa Kuchni	49.00
165	22	Specjał Szefa Kuchni	49.00
166	23	Specjał Szefa Kuchni	49.00
167	24	Specjał Szefa Kuchni	49.00
168	25	Specjał Szefa Kuchni	49.00
169	26	Specjał Szefa Kuchni	49.00
170	27	Specjał Szefa Kuchni	49.00
171	28	Specjał Szefa Kuchni	49.00
172	1	Specjał Szefa Kuchni	49.00
173	2	Specjał Szefa Kuchni	49.00
174	3	Specjał Szefa Kuchni	49.00
175	4	Specjał Szefa Kuchni	49.00
176	5	Specjał Szefa Kuchni	49.00
177	6	Specjał Szefa Kuchni	49.00
178	7	Specjał Szefa Kuchni	49.00
179	8	Specjał Szefa Kuchni	49.00
180	9	Specjał Szefa Kuchni	49.00
181	10	Specjał Szefa Kuchni	49.00
182	11	Specjał Szefa Kuchni	49.00
183	12	Specjał Szefa Kuchni	49.00
184	13	Specjał Szefa Kuchni	49.00
185	14	Specjał Szefa Kuchni	49.00
186	15	Specjał Szefa Kuchni	49.00
187	20	Specjał Szefa Kuchni	49.00
188	21	Specjał Szefa Kuchni	49.00
189	22	Specjał Szefa Kuchni	49.00
190	23	Specjał Szefa Kuchni	49.00
191	24	Specjał Szefa Kuchni	49.00
192	25	Specjał Szefa Kuchni	49.00
193	26	Specjał Szefa Kuchni	49.00
194	27	Specjał Szefa Kuchni	49.00
195	28	Specjał Szefa Kuchni	49.00
196	1	Specjał Szefa Kuchni	49.00
197	2	Specjał Szefa Kuchni	49.00
198	3	Specjał Szefa Kuchni	49.00
199	4	Specjał Szefa Kuchni	49.00
200	5	Specjał Szefa Kuchni	49.00
201	6	Specjał Szefa Kuchni	49.00
202	7	Specjał Szefa Kuchni	49.00
203	8	Specjał Szefa Kuchni	49.00
204	9	Specjał Szefa Kuchni	49.00
205	10	Specjał Szefa Kuchni	49.00
206	11	Specjał Szefa Kuchni	49.00
207	12	Specjał Szefa Kuchni	49.00
208	13	Specjał Szefa Kuchni	49.00
209	14	Specjał Szefa Kuchni	49.00
210	15	Specjał Szefa Kuchni	49.00
211	20	Specjał Szefa Kuchni	49.00
212	21	Specjał Szefa Kuchni	49.00
213	22	Specjał Szefa Kuchni	49.00
214	23	Specjał Szefa Kuchni	49.00
215	24	Specjał Szefa Kuchni	49.00
216	25	Specjał Szefa Kuchni	49.00
217	26	Specjał Szefa Kuchni	49.00
218	27	Specjał Szefa Kuchni	49.00
219	28	Specjał Szefa Kuchni	49.00
220	1	Specjał Szefa Kuchni	49.00
221	2	Specjał Szefa Kuchni	49.00
222	3	Specjał Szefa Kuchni	49.00
223	4	Specjał Szefa Kuchni	49.00
224	5	Specjał Szefa Kuchni	49.00
225	6	Specjał Szefa Kuchni	49.00
226	7	Specjał Szefa Kuchni	49.00
227	8	Specjał Szefa Kuchni	49.00
228	9	Specjał Szefa Kuchni	49.00
229	10	Specjał Szefa Kuchni	49.00
230	11	Specjał Szefa Kuchni	49.00
231	12	Specjał Szefa Kuchni	49.00
232	13	Specjał Szefa Kuchni	49.00
233	14	Specjał Szefa Kuchni	49.00
234	15	Specjał Szefa Kuchni	49.00
235	20	Specjał Szefa Kuchni	49.00
236	21	Specjał Szefa Kuchni	49.00
237	22	Specjał Szefa Kuchni	49.00
238	23	Specjał Szefa Kuchni	49.00
239	24	Specjał Szefa Kuchni	49.00
240	25	Specjał Szefa Kuchni	49.00
241	26	Specjał Szefa Kuchni	49.00
242	27	Specjał Szefa Kuchni	49.00
243	28	Specjał Szefa Kuchni	49.00
244	1	Specjał Szefa Kuchni	49.00
245	2	Specjał Szefa Kuchni	49.00
246	3	Specjał Szefa Kuchni	49.00
247	4	Specjał Szefa Kuchni	49.00
248	5	Specjał Szefa Kuchni	49.00
249	6	Specjał Szefa Kuchni	49.00
250	7	Specjał Szefa Kuchni	49.00
251	8	Specjał Szefa Kuchni	49.00
252	9	Specjał Szefa Kuchni	49.00
253	10	Specjał Szefa Kuchni	49.00
254	11	Specjał Szefa Kuchni	49.00
255	12	Specjał Szefa Kuchni	49.00
256	13	Specjał Szefa Kuchni	49.00
257	14	Specjał Szefa Kuchni	49.00
258	15	Specjał Szefa Kuchni	49.00
259	20	Specjał Szefa Kuchni	49.00
260	21	Specjał Szefa Kuchni	49.00
261	22	Specjał Szefa Kuchni	49.00
262	23	Specjał Szefa Kuchni	49.00
263	24	Specjał Szefa Kuchni	49.00
264	25	Specjał Szefa Kuchni	49.00
265	26	Specjał Szefa Kuchni	49.00
266	27	Specjał Szefa Kuchni	49.00
267	28	Specjał Szefa Kuchni	49.00
268	1	Specjał Szefa Kuchni	49.00
269	2	Specjał Szefa Kuchni	49.00
270	3	Specjał Szefa Kuchni	49.00
271	4	Specjał Szefa Kuchni	49.00
272	5	Specjał Szefa Kuchni	49.00
273	6	Specjał Szefa Kuchni	49.00
274	7	Specjał Szefa Kuchni	49.00
275	8	Specjał Szefa Kuchni	49.00
276	9	Specjał Szefa Kuchni	49.00
277	10	Specjał Szefa Kuchni	49.00
278	11	Specjał Szefa Kuchni	49.00
279	12	Specjał Szefa Kuchni	49.00
280	13	Specjał Szefa Kuchni	49.00
281	14	Specjał Szefa Kuchni	49.00
282	15	Specjał Szefa Kuchni	49.00
283	20	Specjał Szefa Kuchni	49.00
284	21	Specjał Szefa Kuchni	49.00
285	22	Specjał Szefa Kuchni	49.00
286	23	Specjał Szefa Kuchni	49.00
287	24	Specjał Szefa Kuchni	49.00
288	25	Specjał Szefa Kuchni	49.00
289	26	Specjał Szefa Kuchni	49.00
290	27	Specjał Szefa Kuchni	49.00
291	28	Specjał Szefa Kuchni	49.00
292	1	Specjał Szefa Kuchni	49.00
293	2	Specjał Szefa Kuchni	49.00
294	3	Specjał Szefa Kuchni	49.00
295	4	Specjał Szefa Kuchni	49.00
296	5	Specjał Szefa Kuchni	49.00
297	6	Specjał Szefa Kuchni	49.00
298	7	Specjał Szefa Kuchni	49.00
299	8	Specjał Szefa Kuchni	49.00
300	9	Specjał Szefa Kuchni	49.00
301	10	Specjał Szefa Kuchni	49.00
302	11	Specjał Szefa Kuchni	49.00
303	12	Specjał Szefa Kuchni	49.00
304	13	Specjał Szefa Kuchni	49.00
305	14	Specjał Szefa Kuchni	49.00
306	15	Specjał Szefa Kuchni	49.00
307	20	Specjał Szefa Kuchni	49.00
308	21	Specjał Szefa Kuchni	49.00
309	22	Specjał Szefa Kuchni	49.00
310	23	Specjał Szefa Kuchni	49.00
311	24	Specjał Szefa Kuchni	49.00
312	25	Specjał Szefa Kuchni	49.00
313	26	Specjał Szefa Kuchni	49.00
314	27	Specjał Szefa Kuchni	49.00
315	28	Specjał Szefa Kuchni	49.00
\.


--
-- TOC entry 4869 (class 0 OID 16431)
-- Dependencies: 224
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservations (id, customer_id, restaurant_id, table_id, reservation_date, reservation_time, party_size, status, special_requests, created_at, updated_at, guest_first_name, guest_last_name, guest_email, guest_phone) FROM stdin;
2	\N	26	\N	2026-01-21	15:11:00	4	pending	\N	2026-01-11 12:08:13.893986	2026-01-11 12:08:13.893986	dfs	fdjg	dsfih@fsd.pl	+48832974324
15	56	10	\N	2026-01-20	23:33:00	3	confirmed	\N	2026-01-14 20:30:11.8847	2026-01-14 20:30:11.8847	\N	\N	\N	\N
16	57	26	\N	2026-01-14	21:30:00	2	confirmed	\N	2026-01-14 20:31:49.703218	2026-01-14 20:31:49.703218	\N	\N	\N	\N
17	57	26	\N	2026-01-14	21:30:00	2	confirmed	\N	2026-01-14 20:31:56.332376	2026-01-14 20:31:56.332376	\N	\N	\N	\N
\.


--
-- TOC entry 4863 (class 0 OID 16390)
-- Dependencies: 218
-- Data for Name: restaurants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.restaurants (id, name, description, address, phone, email, opening_hours, created_at, updated_at, city_id, city, latitude, longitude, total_tables) FROM stdin;
1	Stół Polski	Kuchnia polska	ul. Marszałkowska 1	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	1	\N	\N	\N	10
2	VegeMiasto	Kuchnia roślinna	ul. Solidarności 60	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	1	\N	\N	\N	10
3	Sakana Sushi	Sushi bar	ul. Moliera 4	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	1	\N	\N	\N	10
4	Pod Wawelem	Kuchnia galicyjska	ul. Św. Gertrudy 26	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	2	\N	\N	\N	10
5	Morskie Oko	Kuchnia góralska	Plac Szczepański 8	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	2	\N	\N	\N	10
6	Ariel	Kuchnia żydowska	ul. Szeroka 18	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	2	\N	\N	\N	10
7	Ratuszova	Tradycyjna	Stary Rynek 55	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	3	\N	\N	\N	10
8	Brovaria	Browar i kuchnia	Stary Rynek 73	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	3	\N	\N	\N	10
9	Pyszna Kuchnia	Domowe obiad	ul. Głogowska 10	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	3	\N	\N	\N	10
10	Goldwasser	Kuchnia gdańska	ul. Długie Pobrzeże 22	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	4	\N	\N	\N	10
11	Gdański Bowke	Tradycyjne smaki	ul. Długie Pobrzeże 11	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	4	\N	\N	\N	10
12	Szafarnia 10	Nowoczesna	ul. Szafarnia 10	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	4	\N	\N	\N	10
13	Manekin	Naleśnikarnia	ul. Wysoka 1	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	5	\N	\N	\N	10
14	Jan Olbracht	Browar staromiejski	ul. Szczytna 15	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	5	\N	\N	\N	10
15	Luizjana	Kuchnia kreolska	ul. Mostowa 10	\N	\N	\N	2026-01-10 20:17:46.904352	2026-01-10 20:17:46.904352	5	\N	\N	\N	10
20	Zielone Tarasy	Restauracja z widokiem na Wisłę i dania wegańskie.	ul. Tyniecka 10, 30-319 Kraków	+48 12 340 56 78	info@zielonetarasy.pl	{"mon-fri": "10:00-20:00", "sat-sun": "12:00-22:00"}	2026-01-11 11:40:29.103901	2026-01-11 11:40:29.103901	2	\N	\N	\N	10
21	Nolio	Pizza neapolitańska wypiekana w piecu opalanym drewnem.	ul. Krakowska 27, 31-062 Kraków	+48 12 356 23 44	rezerwacje@nolio.pl	{"mon-sun": "12:00-23:00"}	2026-01-11 11:40:29.103901	2026-01-11 11:40:29.103901	2	\N	\N	\N	10
22	Muga	Fine dining z polskim twistem.	ul. Krysiewicza 5, 61-825 Poznań	+48 61 678 90 12	kontakt@muga.pl	{"mon-sat": "13:00-22:00"}	2026-01-11 11:40:29.103901	2026-01-11 11:40:29.103901	3	\N	\N	\N	10
23	Frontiera	Włoska kuchnia z nowoczesnym podejściem.	ul. Garbary 54, 61-758 Poznań	+48 61 123 45 67	info@frontiera.pl	{"mon-sun": "12:00-23:00"}	2026-01-11 11:40:29.103901	2026-01-11 11:40:29.103901	3	\N	\N	\N	10
24	Pierogarnia Stary Młyn	Pierogi jak u babci w sercu Poznania.	Stary Rynek 100, 61-773 Poznań	+48 61 888 77 66	rezerwacje@starymlyn.pl	{"mon-sun": "11:00-21:00"}	2026-01-11 11:40:29.103901	2026-01-11 11:40:29.103901	3	\N	\N	\N	10
25	Gvara	Wyjątkowa kuchnia europejska i lokalna.	ul. Długa 81/83, 80-831 Gdańsk	+48 58 305 30 50	biuro@gvara.pl	{"mon-sun": "12:00-22:00"}	2026-01-11 11:40:29.103901	2026-01-11 11:40:29.103901	4	\N	\N	\N	10
26	Billy’s American Restaurant	Amerykańskie burgery i steki.	ul. Tkacka 21/22, 80-836 Gdańsk	+48 58 320 12 13	kontakt@billys.pl	{"mon-sun": "13:00-23:00"}	2026-01-11 11:40:29.103901	2026-01-11 11:40:29.103901	4	\N	\N	\N	10
27	Mandu	Najlepsze pierogi w Trójmieście.	ul. Elżbietańska 4/8, 80-894 Gdańsk	+48 58 573 20 70	info@mandu.pl	{"mon-sun": "12:00-22:00"}	2026-01-11 11:40:29.103901	2026-01-11 11:40:29.103901	4	\N	\N	\N	10
28	Chleb i Wino	Restauracja i winiarnia z klimatem.	ul. Rynek Staromiejski 22, 87-100 Toruń	+48 56 477 60 10	rezerwacje@chlebiwino.pl	{"mon-sun": "12:00-22:00"}	2026-01-11 11:40:29.103901	2026-01-11 11:40:29.103901	5	\N	\N	\N	10
\.


--
-- TOC entry 4865 (class 0 OID 16401)
-- Dependencies: 220
-- Data for Name: tables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tables (id, restaurant_id, table_number, capacity, is_available, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 225
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_id_seq', 140, true);


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 221
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 57, true);


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 227
-- Name: menu_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_items_id_seq', 315, true);


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 223
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservations_id_seq', 17, true);


--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 217
-- Name: restaurants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.restaurants_id_seq', 165, true);


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 219
-- Name: tables_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tables_id_seq', 1, false);


--
-- TOC entry 4706 (class 2606 OID 16469)
-- Name: cities cities_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_name_key UNIQUE (name);


--
-- TOC entry 4708 (class 2606 OID 16467)
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- TOC entry 4696 (class 2606 OID 16429)
-- Name: customers customers_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);


--
-- TOC entry 4698 (class 2606 OID 16427)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- TOC entry 4710 (class 2606 OID 16520)
-- Name: menu_items menu_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4704 (class 2606 OID 16442)
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- TOC entry 4685 (class 2606 OID 16399)
-- Name: restaurants restaurants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT restaurants_pkey PRIMARY KEY (id);


--
-- TOC entry 4690 (class 2606 OID 16409)
-- Name: tables tables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_pkey PRIMARY KEY (id);


--
-- TOC entry 4692 (class 2606 OID 16411)
-- Name: tables tables_restaurant_id_table_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_restaurant_id_table_number_key UNIQUE (restaurant_id, table_number);


--
-- TOC entry 4687 (class 2606 OID 16577)
-- Name: restaurants unique_restaurant_name_per_city; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT unique_restaurant_name_per_city UNIQUE (name, city_id);


--
-- TOC entry 4694 (class 2606 OID 16476)
-- Name: tables unique_restaurant_table; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT unique_restaurant_table UNIQUE (restaurant_id, table_number);


--
-- TOC entry 4699 (class 1259 OID 16581)
-- Name: idx_reservation_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservation_date ON public.reservations USING btree (reservation_date);


--
-- TOC entry 4700 (class 1259 OID 16582)
-- Name: idx_reservation_restaurant; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservation_restaurant ON public.reservations USING btree (restaurant_id);


--
-- TOC entry 4701 (class 1259 OID 16458)
-- Name: idx_reservations_date_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservations_date_time ON public.reservations USING btree (reservation_date, reservation_time);


--
-- TOC entry 4702 (class 1259 OID 16459)
-- Name: idx_reservations_restaurant; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservations_restaurant ON public.reservations USING btree (restaurant_id);


--
-- TOC entry 4688 (class 1259 OID 16460)
-- Name: idx_tables_restaurant; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tables_restaurant ON public.tables USING btree (restaurant_id);


--
-- TOC entry 4716 (class 2606 OID 16521)
-- Name: menu_items menu_items_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES public.restaurants(id) ON DELETE CASCADE;


--
-- TOC entry 4713 (class 2606 OID 16443)
-- Name: reservations reservations_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- TOC entry 4714 (class 2606 OID 16448)
-- Name: reservations reservations_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES public.restaurants(id) ON DELETE CASCADE;


--
-- TOC entry 4715 (class 2606 OID 16453)
-- Name: reservations reservations_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.tables(id) ON DELETE CASCADE;


--
-- TOC entry 4711 (class 2606 OID 16470)
-- Name: restaurants restaurants_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT restaurants_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE SET NULL;


--
-- TOC entry 4712 (class 2606 OID 16412)
-- Name: tables tables_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES public.restaurants(id) ON DELETE CASCADE;


-- Completed on 2026-01-14 21:40:23

--
-- PostgreSQL database dump complete
--

