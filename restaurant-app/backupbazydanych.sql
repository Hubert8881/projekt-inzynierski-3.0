--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2026-01-26 19:49:46

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
-- TOC entry 230 (class 1259 OID 16599)
-- Name: admin_account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_account (
    id integer NOT NULL,
    password_hash text NOT NULL,
    login_attempts integer DEFAULT 0,
    lock_until timestamp with time zone
);


--
-- TOC entry 229 (class 1259 OID 16598)
-- Name: admin_account_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 229
-- Name: admin_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_account_id_seq OWNED BY public.admin_account.id;


--
-- TOC entry 232 (class 1259 OID 16609)
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_logs (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    event_type text NOT NULL,
    user_role text,
    ip_address text,
    details text,
    success boolean
);


--
-- TOC entry 231 (class 1259 OID 16608)
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.audit_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 231
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- TOC entry 226 (class 1259 OID 16462)
-- Name: cities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 16461)
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 225
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- TOC entry 222 (class 1259 OID 16418)
-- Name: customers; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 221 (class 1259 OID 16417)
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 221
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- TOC entry 228 (class 1259 OID 16515)
-- Name: menu_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.menu_items (
    id integer NOT NULL,
    restaurant_id integer,
    name character varying(255) NOT NULL,
    price numeric(10,2) NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 16514)
-- Name: menu_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.menu_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 227
-- Name: menu_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.menu_items_id_seq OWNED BY public.menu_items.id;


--
-- TOC entry 224 (class 1259 OID 16431)
-- Name: reservations; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 223 (class 1259 OID 16430)
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reservations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 223
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reservations_id_seq OWNED BY public.reservations.id;


--
-- TOC entry 218 (class 1259 OID 16390)
-- Name: restaurants; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 217 (class 1259 OID 16389)
-- Name: restaurants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.restaurants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 217
-- Name: restaurants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.restaurants_id_seq OWNED BY public.restaurants.id;


--
-- TOC entry 220 (class 1259 OID 16401)
-- Name: tables; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 219 (class 1259 OID 16400)
-- Name: tables_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tables_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 219
-- Name: tables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tables_id_seq OWNED BY public.tables.id;


--
-- TOC entry 4693 (class 2604 OID 16602)
-- Name: admin_account id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_account ALTER COLUMN id SET DEFAULT nextval('public.admin_account_id_seq'::regclass);


--
-- TOC entry 4695 (class 2604 OID 16612)
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- TOC entry 4691 (class 2604 OID 16465)
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- TOC entry 4684 (class 2604 OID 16421)
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- TOC entry 4692 (class 2604 OID 16518)
-- Name: menu_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_items ALTER COLUMN id SET DEFAULT nextval('public.menu_items_id_seq'::regclass);


--
-- TOC entry 4687 (class 2604 OID 16434)
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations ALTER COLUMN id SET DEFAULT nextval('public.reservations_id_seq'::regclass);


--
-- TOC entry 4676 (class 2604 OID 16393)
-- Name: restaurants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.restaurants ALTER COLUMN id SET DEFAULT nextval('public.restaurants_id_seq'::regclass);


--
-- TOC entry 4680 (class 2604 OID 16404)
-- Name: tables id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tables ALTER COLUMN id SET DEFAULT nextval('public.tables_id_seq'::regclass);


--
-- TOC entry 4895 (class 0 OID 16599)
-- Dependencies: 230
-- Data for Name: admin_account; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_account (id, password_hash, login_attempts, lock_until) FROM stdin;
1	$2b$10$C35CEnbOwjMWVFG.EysWv.DxO6lasVKDuvFXeHwiqK.5uqM16mbzC	0	\N
\.


--
-- TOC entry 4897 (class 0 OID 16609)
-- Dependencies: 232
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.audit_logs (id, "timestamp", event_type, user_role, ip_address, details, success) FROM stdin;
1	2026-01-25 17:51:54.743971+01	LOGIN_SUCCESS	admin	127.0.0.1	Poprawne logowanie administratora	t
2	2026-01-25 17:54:23.626125+01	LOGIN_SUCCESS	admin	127.0.0.1	Poprawne logowanie administratora	t
3	2026-01-25 17:54:35.922894+01	LOGIN_FAILURE	admin	127.0.0.1	Błędne hasło (próba 1/5)	f
4	2026-01-25 17:54:43.616036+01	LOGIN_FAILURE	admin	127.0.0.1	Błędne hasło (próba 2/5)	f
5	2026-01-25 17:54:48.589255+01	LOGIN_SUCCESS	admin	127.0.0.1	Poprawne logowanie administratora	t
6	2026-01-26 17:52:21.331714+01	LOGIN_SUCCESS	admin	127.0.0.1	Poprawne logowanie administratora	t
7	2026-01-26 17:54:19.997968+01	LOGIN_SUCCESS	admin	127.0.0.1	Poprawne logowanie administratora	t
8	2026-01-26 17:54:52.42158+01	LOGIN_SUCCESS	admin	127.0.0.1	Poprawne logowanie administratora	t
9	2026-01-26 17:59:03.333001+01	LOGIN_SUCCESS	admin	127.0.0.1	Poprawne logowanie administratora	t
10	2026-01-26 18:00:44.235262+01	LOGIN_SUCCESS	admin	127.0.0.1	Poprawne logowanie administratora	t
11	2026-01-26 18:02:40.018172+01	LOGIN_FAILURE	admin	127.0.0.1	Błędne hasło (próba 1/5)	f
12	2026-01-26 18:02:41.580496+01	LOGIN_FAILURE	admin	127.0.0.1	Błędne hasło (próba 2/5)	f
13	2026-01-26 18:02:42.740901+01	LOGIN_FAILURE	admin	127.0.0.1	Błędne hasło (próba 3/5)	f
14	2026-01-26 18:02:44.967049+01	LOGIN_FAILURE	admin	127.0.0.1	Błędne hasło (próba 4/5)	f
15	2026-01-26 18:02:46.714245+01	LOGIN_FAILURE	admin	127.0.0.1	Błędne hasło (próba 5/5)	f
16	2026-01-26 18:03:13.086947+01	LOGIN_ATTEMPT	admin	127.0.0.1	Próba logowania na zablokowane konto	f
17	2026-01-26 18:05:00.79903+01	LOGIN_ATTEMPT	admin	127.0.0.1	Próba logowania na zablokowane konto	f
18	2026-01-26 18:05:22.155409+01	LOGIN_ATTEMPT	admin	127.0.0.1	Próba logowania na zablokowane konto	f
19	2026-01-26 18:49:50.488928+01	LOGIN_SUCCESS	admin	127.0.0.1	Poprawne logowanie administratora	t
\.


--
-- TOC entry 4891 (class 0 OID 16462)
-- Dependencies: 226
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cities (id, name) FROM stdin;
1	Warszawa
2	Kraków
3	Poznań
4	Gdańsk
5	Toruń
\.


--
-- TOC entry 4887 (class 0 OID 16418)
-- Dependencies: 222
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: -
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
58	fdgsg	dfgdf	gfdgfd@jsdfnfsd.fdgfd	+48345653534	\N	2026-01-14 21:58:29.762444	2026-01-14 21:58:29.762444
59	fdsfds	fsdfs	sdffsd@fsdjsf.fdsjnf	+48534534534	\N	2026-01-14 22:11:58.362929	2026-01-14 22:11:58.362929
60	dgf	dg	gdf@fsd.sdf	+48543534534	\N	2026-01-15 18:10:44.464468	2026-01-15 18:10:44.464468
61	jan	kowalski	jankowalski@jankowalski.zz	+48435435435	\N	2026-01-15 18:25:07.668189	2026-01-15 18:25:07.668189
62	jan	kowalski	jankowalski@jankowalski.mmmm	+48999999999	\N	2026-01-15 18:30:51.873669	2026-01-15 18:30:51.873669
63	piotr	nowak	piotrnowak@piotrnowak.mmmm	+48999999999	\N	2026-01-15 18:31:13.308414	2026-01-15 18:31:13.308414
64	dsa	das	dasdas@sdfh.fidsjfd	+48567567567	\N	2026-01-15 18:38:15.402672	2026-01-15 18:38:15.402672
65	fsd	fds	fds@fds.dsf	+48453534535	\N	2026-01-15 18:39:39.832811	2026-01-15 18:39:39.832811
66	fds	fsd	fsdjnf@fdsj.fds	+48453894385	\N	2026-01-15 18:46:19.596249	2026-01-15 18:46:19.596249
67	dsffds	fdsfds	sdfsdf@fdsj.dsf	+48435543534	\N	2026-01-15 18:47:17.554484	2026-01-15 18:47:17.554484
68	wwwwwwwww	wwwwwwwwwwwwww	wwwwwwwww@wwwwwww.wwwww	+48435345345	\N	2026-01-15 18:52:00.365531	2026-01-15 18:52:00.365531
69	jann	jann	jann@jann.jan	+48423423423	\N	2026-01-15 18:58:27.025854	2026-01-15 18:58:27.025854
70	jan	nowak	kowalski@jan.dfff	+48345345345	\N	2026-01-15 19:26:52.965921	2026-01-15 19:26:52.965921
71	Piotr	Kowalski	piotrpiotr@piotrpiotr.sfdsf	999999999	\N	2026-01-16 22:15:32.525045	2026-01-16 22:15:32.525045
72	fsd	fsd	sfdsdf@fds.fdsf	345543345	\N	2026-01-16 22:31:25.231604	2026-01-16 22:31:25.231604
73	jan	nowak	jank@kowalsk.dsadasadsdassad	432432432	\N	2026-01-16 22:44:59.986389	2026-01-16 22:44:59.986389
74	piotr	nowak	piotrnowak@piotrnowak.kowalski	432432423	\N	2026-01-18 12:07:49.702441	2026-01-18 12:07:49.702441
75	fdsfs	sfd	fdsfs@fsd.dsfds	534534543	\N	2026-01-18 12:08:38.401884	2026-01-18 12:08:38.401884
76	fds	fsd	fdsfds@fds.fds	435345345	\N	2026-01-18 12:14:50.203638	2026-01-18 12:14:50.203638
77	jan	kowalski	jannowak@janufds.fdsf	654654654	\N	2026-01-18 12:16:53.220619	2026-01-18 12:16:53.220619
78	fsd	fsd	fsd@fds.fds	534535345	\N	2026-01-18 12:26:42.195758	2026-01-18 12:26:42.195758
79	dfs	fds	fdssf@fds.sdf	543453345	\N	2026-01-18 12:28:03.933075	2026-01-18 12:28:03.933075
80	gfd	gdf	dfg@fds.fds	54353535	\N	2026-01-19 19:00:58.021152	2026-01-19 19:00:58.021152
81	fdsf	fsdsd	fsdsdf@fds.fsd	3	\N	2026-01-19 19:01:19.024228	2026-01-19 19:01:19.024228
82	piotr	kowalski	piotrnowak@dddd.xfkj	333333333	\N	2026-01-19 19:07:25.014414	2026-01-19 19:07:25.014414
83	gv	gfd	fds@2.dsa	324324234	\N	2026-01-20 17:32:09.843934	2026-01-20 17:32:09.843934
84	fds	fsd	sfd@fds.fd	435345435	\N	2026-01-20 18:07:15.95908	2026-01-20 18:07:15.95908
85	dsa	das	dsada@das.das	342423423	\N	2026-01-20 19:06:54.220685	2026-01-20 19:06:54.220685
86	das	das	dasd@fs.fds	423423423	\N	2026-01-20 19:07:26.749388	2026-01-20 19:07:26.749388
87	jadsh	fdsjh	jsdfkhfs@fdsj.fds	424324234	\N	2026-01-20 19:11:49.361871	2026-01-20 19:11:49.361871
88	fdsfd	sdfsdf	dfssdf@fdsf.sfds	432423423	\N	2026-01-20 19:12:22.751196	2026-01-20 19:12:22.751196
89	das	das	dsa@dsa.dsa	432423423	\N	2026-01-22 20:15:51.119309	2026-01-22 20:15:51.119309
90	gfd	gfd	sfd@dsaa.ads	543543534	\N	2026-01-22 20:29:36.153476	2026-01-22 20:29:36.153476
91	hfg	hgf	hffds@fdsfsd.sdf	432432423	\N	2026-01-22 20:30:32.238461	2026-01-22 20:30:32.238461
92	fds	fds	dsa@ds.fd	443242342	\N	2026-01-25 16:07:24.706358	2026-01-25 16:07:24.706358
93	fsd	fds	fsd@fds.dfs	234432424	\N	2026-01-25 16:45:01.142747	2026-01-25 16:45:01.142747
94	jan	nowak	jankowalski@asdada.asd	231312312	\N	2026-01-25 16:56:21.674804	2026-01-25 16:56:21.674804
95	piotr	kowalski	piotrkowalski@lkkkk.fds	342432432	\N	2026-01-25 17:02:22.187315	2026-01-25 17:02:22.187315
96	piotr	kowalski	oisdiklfns@fdsfsd.fds	222222222	\N	2026-01-25 17:06:31.936902	2026-01-25 17:06:31.936902
97	fds	fds	fds@fds.ds	432432432	\N	2026-01-25 17:26:28.768543	2026-01-25 17:26:28.768543
98	Jan	Nowak	JanNowak@ww.pl	444444444	\N	2026-01-26 17:51:56.636113	2026-01-26 17:51:56.636113
99	Jan	Nowak	JanNowak@wwwwww.pl	974387283	\N	2026-01-26 17:54:43.38128	2026-01-26 17:54:43.38128
100	Jan	Kowalski	JanKowalski@wwwwwww.pl	544444444	\N	2026-01-26 17:58:57.762371	2026-01-26 17:58:57.762371
101	piotr	kowalski	piuotrwak@fdsksd.fd	321312312	\N	2026-01-26 19:06:15.469746	2026-01-26 19:06:15.469746
\.


--
-- TOC entry 4893 (class 0 OID 16515)
-- Dependencies: 228
-- Data for Name: menu_items; Type: TABLE DATA; Schema: public; Owner: -
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
532	25	Salami Piccante	42.00
533	28	Bruschetta z pomidorami	24.00
534	28	Makaron Carbonara	38.00
535	28	Pizza Parma	46.00
536	28	Salatka z kozim serem	36.00
537	28	Tiramisu domowe	22.00
538	24	Pierogi Piecuchy Miesne	34.00
539	24	Pierogi Lepiochy Ruskie	29.00
540	24	Barszcz czerwony z uszkami	18.00
541	24	Placki ziemniaczane z gulaszem	42.00
542	24	Pierogi na slodko z twarogiem	28.00
543	22	Przegrzebki z kalafiorem	65.00
544	22	Comber z jelenia	120.00
545	22	Gicz jagnieca	95.00
546	22	Foie gras z pigwa	72.00
547	22	Deser czekoladowy z trufla	45.00
548	23	Pizza Margherita DOP	32.00
549	23	Spaghetti Frutti di Mare	54.00
550	23	Gnocchi z pesto	36.00
551	23	Carpaccio wolowe	44.00
552	23	Panna Cotta malinowa	24.00
553	20	Bowl z pieczona dynia	38.00
554	20	Burger z boczniaka	36.00
555	20	Zupa krem z pomidor�w	20.00
556	20	Hummus z warzywami	26.00
557	20	Sernik nerkownik	22.00
558	21	Pizza Marinara	28.00
559	21	Pizza Diavola	42.00
560	21	Burrata z anchois	38.00
561	21	Ravioli z ricotta	40.00
562	21	Cannoli sycylijskie	18.00
563	27	Pierogi koreanskie Mandu	36.00
564	27	Pierogi z dziczyzna	39.00
565	27	Pierogi z bobem	32.00
566	27	Zupa Kimchi	22.00
567	27	Pierogi z owocami sezonowymi	29.00
568	26	Billys Classic Burger	44.00
569	26	BBQ Pork Ribs	58.00
570	26	Buffalo Chicken Wings	32.00
571	26	New York Cheesecake	26.00
572	26	Steak & Fries	85.00
573	25	Tatar wolowy z dodatkami	46.00
574	25	Zupa rybna z owocami morza	34.00
575	25	Konfitowana noga z kaczki	68.00
576	25	Pieczony filet z dorsza	59.00
\.


--
-- TOC entry 4889 (class 0 OID 16431)
-- Dependencies: 224
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reservations (id, customer_id, restaurant_id, table_id, reservation_date, reservation_time, party_size, status, special_requests, created_at, updated_at, guest_first_name, guest_last_name, guest_email, guest_phone) FROM stdin;
2	\N	26	\N	2026-01-21	15:11:00	4	pending	\N	2026-01-11 12:08:13.893986	2026-01-11 12:08:13.893986	dfs	fdjg	dsfih@fsd.pl	+48832974324
68	101	28	\N	2026-01-26	21:00:00	2	confirmed	\N	2026-01-26 19:06:15.469746	2026-01-26 19:06:15.469746	\N	\N	\N	\N
\.


--
-- TOC entry 4883 (class 0 OID 16390)
-- Dependencies: 218
-- Data for Name: restaurants; Type: TABLE DATA; Schema: public; Owner: -
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
-- TOC entry 4885 (class 0 OID 16401)
-- Dependencies: 220
-- Data for Name: tables; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tables (id, restaurant_id, table_number, capacity, is_available, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 229
-- Name: admin_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_account_id_seq', 1, true);


--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 231
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 19, true);


--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 225
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cities_id_seq', 595, true);


--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 221
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customers_id_seq', 101, true);


--
-- TOC entry 4915 (class 0 OID 0)
-- Dependencies: 227
-- Name: menu_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.menu_items_id_seq', 576, true);


--
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 223
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reservations_id_seq', 68, true);


--
-- TOC entry 4917 (class 0 OID 0)
-- Dependencies: 217
-- Name: restaurants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.restaurants_id_seq', 1530, true);


--
-- TOC entry 4918 (class 0 OID 0)
-- Dependencies: 219
-- Name: tables_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tables_id_seq', 1, false);


--
-- TOC entry 4728 (class 2606 OID 16607)
-- Name: admin_account admin_account_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_account
    ADD CONSTRAINT admin_account_pkey PRIMARY KEY (id);


--
-- TOC entry 4730 (class 2606 OID 16617)
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 4722 (class 2606 OID 16469)
-- Name: cities cities_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_name_key UNIQUE (name);


--
-- TOC entry 4724 (class 2606 OID 16467)
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- TOC entry 4710 (class 2606 OID 16429)
-- Name: customers customers_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);


--
-- TOC entry 4712 (class 2606 OID 16427)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- TOC entry 4726 (class 2606 OID 16520)
-- Name: menu_items menu_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4718 (class 2606 OID 16442)
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- TOC entry 4699 (class 2606 OID 16399)
-- Name: restaurants restaurants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT restaurants_pkey PRIMARY KEY (id);


--
-- TOC entry 4704 (class 2606 OID 16409)
-- Name: tables tables_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_pkey PRIMARY KEY (id);


--
-- TOC entry 4706 (class 2606 OID 16411)
-- Name: tables tables_restaurant_id_table_number_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_restaurant_id_table_number_key UNIQUE (restaurant_id, table_number);


--
-- TOC entry 4720 (class 2606 OID 16595)
-- Name: reservations unique_customer_reservation; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT unique_customer_reservation UNIQUE (customer_id, reservation_date, reservation_time);


--
-- TOC entry 4701 (class 2606 OID 16577)
-- Name: restaurants unique_restaurant_name_per_city; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT unique_restaurant_name_per_city UNIQUE (name, city_id);


--
-- TOC entry 4708 (class 2606 OID 16476)
-- Name: tables unique_restaurant_table; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT unique_restaurant_table UNIQUE (restaurant_id, table_number);


--
-- TOC entry 4713 (class 1259 OID 16597)
-- Name: idx_reservation_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reservation_date ON public.reservations USING btree (reservation_date);


--
-- TOC entry 4714 (class 1259 OID 16582)
-- Name: idx_reservation_restaurant; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reservation_restaurant ON public.reservations USING btree (restaurant_id);


--
-- TOC entry 4715 (class 1259 OID 16596)
-- Name: idx_reservations_date_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reservations_date_time ON public.reservations USING btree (reservation_date, reservation_time);


--
-- TOC entry 4716 (class 1259 OID 16459)
-- Name: idx_reservations_restaurant; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reservations_restaurant ON public.reservations USING btree (restaurant_id);


--
-- TOC entry 4702 (class 1259 OID 16460)
-- Name: idx_tables_restaurant; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tables_restaurant ON public.tables USING btree (restaurant_id);


--
-- TOC entry 4736 (class 2606 OID 16521)
-- Name: menu_items menu_items_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_items
    ADD CONSTRAINT menu_items_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES public.restaurants(id) ON DELETE CASCADE;


--
-- TOC entry 4733 (class 2606 OID 16443)
-- Name: reservations reservations_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- TOC entry 4734 (class 2606 OID 16448)
-- Name: reservations reservations_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES public.restaurants(id) ON DELETE CASCADE;


--
-- TOC entry 4735 (class 2606 OID 16453)
-- Name: reservations reservations_table_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_table_id_fkey FOREIGN KEY (table_id) REFERENCES public.tables(id) ON DELETE CASCADE;


--
-- TOC entry 4731 (class 2606 OID 16470)
-- Name: restaurants restaurants_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT restaurants_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE SET NULL;


--
-- TOC entry 4732 (class 2606 OID 16412)
-- Name: tables tables_restaurant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tables
    ADD CONSTRAINT tables_restaurant_id_fkey FOREIGN KEY (restaurant_id) REFERENCES public.restaurants(id) ON DELETE CASCADE;


-- Completed on 2026-01-26 19:49:46

--
-- PostgreSQL database dump complete
--

