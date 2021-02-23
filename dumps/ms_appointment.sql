--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1 (Debian 13.1-1.pgdg100+1)
-- Dumped by pg_dump version 13.1 (Debian 13.1-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: appointment_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointment_status (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.appointment_status OWNER TO postgres;

--
-- Name: appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointments (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "idUser" uuid NOT NULL,
    "idService" uuid NOT NULL,
    "idServicePeriod" uuid NOT NULL,
    "idAppointmentStatus" uuid DEFAULT '19091a27-77a6-42a0-915f-c5adffdd601c'::uuid NOT NULL,
    date timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.appointments OWNER TO postgres;

--
-- Name: service_periods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_periods (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "idService" uuid NOT NULL,
    "startTime" time without time zone NOT NULL,
    "endTime" time without time zone NOT NULL,
    removed boolean DEFAULT false NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.service_periods OWNER TO postgres;

--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    "idCompany" uuid NOT NULL,
    removed boolean DEFAULT false NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.services OWNER TO postgres;

--
-- Data for Name: appointment_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointment_status (id, name, "createdAt", "updatedAt") FROM stdin;
19091a27-77a6-42a0-915f-c5adffdd601c	PENDING	2021-02-23 00:40:00.772731	2021-02-23 00:40:00.772731
b15b3641-8c46-494c-a501-02c2cbf8f1c1	CANCEL_SYSTEM	2021-02-23 01:02:56.728215	2021-02-23 01:02:56.728215
7bb87638-25f3-4d5c-b87d-7a6147d12695	CANCEL_CUSTOMER	2021-02-23 01:26:33.641154	2021-02-23 01:26:33.641154
fbb9dc19-6861-4ae7-acec-269b1e768553	FINISHED	2021-02-23 22:23:27.768957	2021-02-23 22:23:27.768957
\.


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointments (id, "idUser", "idService", "idServicePeriod", "idAppointmentStatus", date, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: service_periods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_periods (id, "idService", "startTime", "endTime", removed, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, name, "idCompany", removed, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Name: service_periods PK_2b1b49b7d4265010db8413abc52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_periods
    ADD CONSTRAINT "PK_2b1b49b7d4265010db8413abc52" PRIMARY KEY (id);


--
-- Name: appointments PK_4a437a9a27e948726b8bb3e36ad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT "PK_4a437a9a27e948726b8bb3e36ad" PRIMARY KEY (id);


--
-- Name: appointment_status PK_8f42047c7975a9606576ca274e7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment_status
    ADD CONSTRAINT "PK_8f42047c7975a9606576ca274e7" PRIMARY KEY (id);


--
-- Name: services PK_ba2d347a3168a296416c6c5ccb2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT "PK_ba2d347a3168a296416c6c5ccb2" PRIMARY KEY (id);


--
-- Name: appointments FK_1437e9289c49dae70c4650d0123; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT "FK_1437e9289c49dae70c4650d0123" FOREIGN KEY ("idService") REFERENCES public.services(id);


--
-- Name: service_periods FK_89ee42d490283e06c0a512b81a0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_periods
    ADD CONSTRAINT "FK_89ee42d490283e06c0a512b81a0" FOREIGN KEY ("idService") REFERENCES public.services(id);


--
-- Name: appointments FK_a5c6c8c12b2b74fc62779bc03c6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT "FK_a5c6c8c12b2b74fc62779bc03c6" FOREIGN KEY ("idAppointmentStatus") REFERENCES public.appointment_status(id);


--
-- Name: appointments FK_bfef9369d012b3a657175676080; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT "FK_bfef9369d012b3a657175676080" FOREIGN KEY ("idServicePeriod") REFERENCES public.service_periods(id);


--
-- PostgreSQL database dump complete
--

