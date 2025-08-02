--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

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
-- Name: activities; Type: TABLE; Schema: public; Owner: POSTGRES_USER
--

CREATE TABLE public.activities (
    id integer NOT NULL,
    name_1 character varying,
    name_2 character varying,
    name_3 character varying
);


ALTER TABLE public.activities OWNER TO "POSTGRES_USER";

--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: POSTGRES_USER
--

CREATE SEQUENCE public.activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activities_id_seq OWNER TO "POSTGRES_USER";

--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: POSTGRES_USER
--

ALTER SEQUENCE public.activities_id_seq OWNED BY public.activities.id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: POSTGRES_USER
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO "POSTGRES_USER";

--
-- Name: buildings; Type: TABLE; Schema: public; Owner: POSTGRES_USER
--

CREATE TABLE public.buildings (
    id integer NOT NULL,
    address character varying NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL
);


ALTER TABLE public.buildings OWNER TO "POSTGRES_USER";

--
-- Name: buildings_id_seq; Type: SEQUENCE; Schema: public; Owner: POSTGRES_USER
--

CREATE SEQUENCE public.buildings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.buildings_id_seq OWNER TO "POSTGRES_USER";

--
-- Name: buildings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: POSTGRES_USER
--

ALTER SEQUENCE public.buildings_id_seq OWNED BY public.buildings.id;


--
-- Name: organization_activity; Type: TABLE; Schema: public; Owner: POSTGRES_USER
--

CREATE TABLE public.organization_activity (
    organization_id integer NOT NULL,
    activity_id integer NOT NULL
);


ALTER TABLE public.organization_activity OWNER TO "POSTGRES_USER";

--
-- Name: organizations; Type: TABLE; Schema: public; Owner: POSTGRES_USER
--

CREATE TABLE public.organizations (
    id integer NOT NULL,
    name character varying NOT NULL,
    building_id integer NOT NULL
);


ALTER TABLE public.organizations OWNER TO "POSTGRES_USER";

--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: POSTGRES_USER
--

CREATE SEQUENCE public.organizations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.organizations_id_seq OWNER TO "POSTGRES_USER";

--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: POSTGRES_USER
--

ALTER SEQUENCE public.organizations_id_seq OWNED BY public.organizations.id;


--
-- Name: phones; Type: TABLE; Schema: public; Owner: POSTGRES_USER
--

CREATE TABLE public.phones (
    id integer NOT NULL,
    number character varying NOT NULL,
    organization_id integer NOT NULL
);


ALTER TABLE public.phones OWNER TO "POSTGRES_USER";

--
-- Name: phones_id_seq; Type: SEQUENCE; Schema: public; Owner: POSTGRES_USER
--

CREATE SEQUENCE public.phones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.phones_id_seq OWNER TO "POSTGRES_USER";

--
-- Name: phones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: POSTGRES_USER
--

ALTER SEQUENCE public.phones_id_seq OWNED BY public.phones.id;


--
-- Name: activities id; Type: DEFAULT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.activities ALTER COLUMN id SET DEFAULT nextval('public.activities_id_seq'::regclass);


--
-- Name: buildings id; Type: DEFAULT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.buildings ALTER COLUMN id SET DEFAULT nextval('public.buildings_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);


--
-- Name: phones id; Type: DEFAULT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.phones ALTER COLUMN id SET DEFAULT nextval('public.phones_id_seq'::regclass);


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: POSTGRES_USER
--

COPY public.activities (id, name_1, name_2, name_3) FROM stdin;
1	Еда	Мясная продукция	\N
2	Еда	Молочная продукция	\N
3	Автомобили	Грузовые	\N
4	Автомобили	Легковые	Запчасти
5	Еда	\N	\N
6	Автомобили	\N	\N
7	Автомобили	Легковые	\N
8	Автомобили	Легковые	Аксессуары
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: POSTGRES_USER
--

COPY public.alembic_version (version_num) FROM stdin;
71dcb532c1b1
\.


--
-- Data for Name: buildings; Type: TABLE DATA; Schema: public; Owner: POSTGRES_USER
--

COPY public.buildings (id, address, latitude, longitude) FROM stdin;
1	г. Москва, ул. Ленина 1, офис 3	55.751244	37.618423
2	г. Санкт-Петербург, Невский пр. 100	59.93428	30.335098
\.


--
-- Data for Name: organization_activity; Type: TABLE DATA; Schema: public; Owner: POSTGRES_USER
--

COPY public.organization_activity (organization_id, activity_id) FROM stdin;
2	3
2	4
1	1
1	2
\.


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: POSTGRES_USER
--

COPY public.organizations (id, name, building_id) FROM stdin;
1	ООО Рога и Копыта	1
2	АвтоГигант	2
\.


--
-- Data for Name: phones; Type: TABLE DATA; Schema: public; Owner: POSTGRES_USER
--

COPY public.phones (id, number, organization_id) FROM stdin;
1	+79154345481	1
2	+79154345482	1
3	+79154345483	2
\.


--
-- Name: activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: POSTGRES_USER
--

SELECT pg_catalog.setval('public.activities_id_seq', 8, true);


--
-- Name: buildings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: POSTGRES_USER
--

SELECT pg_catalog.setval('public.buildings_id_seq', 2, true);


--
-- Name: organizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: POSTGRES_USER
--

SELECT pg_catalog.setval('public.organizations_id_seq', 2, true);


--
-- Name: phones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: POSTGRES_USER
--

SELECT pg_catalog.setval('public.phones_id_seq', 3, true);


--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: buildings buildings_pkey; Type: CONSTRAINT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.buildings
    ADD CONSTRAINT buildings_pkey PRIMARY KEY (id);


--
-- Name: organization_activity organization_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.organization_activity
    ADD CONSTRAINT organization_activity_pkey PRIMARY KEY (organization_id, activity_id);


--
-- Name: organizations organizations_name_key; Type: CONSTRAINT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_name_key UNIQUE (name);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: phones phones_number_key; Type: CONSTRAINT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT phones_number_key UNIQUE (number);


--
-- Name: phones phones_pkey; Type: CONSTRAINT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT phones_pkey PRIMARY KEY (id);


--
-- Name: organization_activity organization_activity_activity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.organization_activity
    ADD CONSTRAINT organization_activity_activity_id_fkey FOREIGN KEY (activity_id) REFERENCES public.activities(id);


--
-- Name: organization_activity organization_activity_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.organization_activity
    ADD CONSTRAINT organization_activity_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: organizations organizations_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_building_id_fkey FOREIGN KEY (building_id) REFERENCES public.buildings(id);


--
-- Name: phones phones_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: POSTGRES_USER
--

ALTER TABLE ONLY public.phones
    ADD CONSTRAINT phones_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- PostgreSQL database dump complete
--

