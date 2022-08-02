--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: constellation; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.constellation (
    constellation_id integer NOT NULL,
    name character varying(50) NOT NULL,
    stars integer
);


ALTER TABLE public.constellation OWNER TO freecodecamp;

--
-- Name: constellation_constellation_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.constellation_constellation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.constellation_constellation_id_seq OWNER TO freecodecamp;

--
-- Name: constellation_constellation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.constellation_constellation_id_seq OWNED BY public.constellation.constellation_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(50) NOT NULL,
    morphology character varying(30),
    diameter_in_light_years numeric,
    distance_from_earth_in_light_years numeric,
    constellation_id integer
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    has_life boolean,
    mean_radius numeric,
    surface_gravity numeric,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    planet_type character varying(30),
    has_life boolean,
    siderial_orbital_period numeric,
    satellites integer,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    age_in_millions_of_years numeric,
    planets integer,
    distance_from_earth_in_light_years numeric,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_id_seq OWNER TO freecodecamp;

--
-- Name: star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_id_seq OWNED BY public.star.star_id;


--
-- Name: constellation constellation_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation ALTER COLUMN constellation_id SET DEFAULT nextval('public.constellation_constellation_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_id_seq'::regclass);


--
-- Data for Name: constellation; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.constellation VALUES (2, 'Andromeda', 16);
INSERT INTO public.constellation VALUES (3, 'Triangulum', 3);
INSERT INTO public.constellation VALUES (1, 'Saggitarius', 12);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (3, 'Andromeda', 'Barred spiral galaxy', 22000, 2500000, 2);
INSERT INTO public.galaxy VALUES (4, 'Triangulum', 'Spiral galaxy', 60000, 273000, 3);
INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Barred spiral galaxy', 200000, 27140, 1);
INSERT INTO public.galaxy VALUES (6, 'Helix Nebula', 'Intermediate spiral galaxy', 58040, 650, 1);
INSERT INTO public.galaxy VALUES (7, 'Pinwheel Galaxy', 'Spiral galaxy', 170000, 20900000, 1);
INSERT INTO public.galaxy VALUES (5, 'Cigar Galaxy', 'Starburst galaxy', 37000, 11400000, 1);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Luna', 'Earth''s only natural satellite', false, 1737.4, 1.622, 3);
INSERT INTO public.moon VALUES (2, 'Deimos', 'The smaller of Mar''s moons', false, 6.2, 0.003, 4);
INSERT INTO public.moon VALUES (3, 'Phobos', 'The larger of Mar''s moons', false, 11, 0.0057, 4);
INSERT INTO public.moon VALUES (4, 'Io', 'The densest moon in the solar system', false, 1821.3, 1.796, 5);
INSERT INTO public.moon VALUES (5, 'Europa', 'The smallest of the Galilean moons', false, 1560.8, 1.314, 5);
INSERT INTO public.moon VALUES (6, 'Ganymede', 'The largest moon in the Solar System', false, 2634.1, 1.428, 5);
INSERT INTO public.moon VALUES (7, 'Callisto', 'The second largest of Jupiter''s moons', false, 2410.3, 1.235, 5);
INSERT INTO public.moon VALUES (8, 'Enceladus', 'One of the most reflective bodies in the Solar System', false, 252.1, 0.113, 6);
INSERT INTO public.moon VALUES (9, 'Titan', 'The only known moon with a dense atmosphere', false, 2574.73, 1.352, 6);
INSERT INTO public.moon VALUES (10, 'Ariel', 'Ariel''s orbit is perpendicular to that of Uranus', false, 578.9, 0.249, 7);
INSERT INTO public.moon VALUES (43, 'Belinda', 'A satellite of Uranus discovered by Voyager 2', false, 40.3, 0.014, 7);
INSERT INTO public.moon VALUES (44, 'Caliban', 'An irregular satellite of Uranus', false, 21, 0.015, 7);
INSERT INTO public.moon VALUES (45, 'Despina', 'The third closest inner moon of Neptune', false, 78, 0.026, 8);
INSERT INTO public.moon VALUES (46, 'Galatea', 'Galatea is slowly spiralling inwards towards Neptune', false, 87.4, 0.018, 8);
INSERT INTO public.moon VALUES (47, 'Halimede', 'A retrograde irregular satellite of Neptune', false, 31, 0.006, 8);
INSERT INTO public.moon VALUES (48, 'Charon', 'The largest of Pluto''s known satellites', false, 606, 0.288, 9);
INSERT INTO public.moon VALUES (49, 'Iapetus', 'The third largest of Saturn''s moons', false, 734.5, 0.223, 6);
INSERT INTO public.moon VALUES (50, 'Mimas', 'The smallest astronomical body known to be rounded', false, 198.2, 0.064, 6);
INSERT INTO public.moon VALUES (51, 'Rhea', 'The second largest of Saturn''s moon', false, 763.8, 0.264, 6);
INSERT INTO public.moon VALUES (52, 'Tethys', 'Tethys has the lowest density of the major moons in the Solar System', false, 531.1, 0.146, 6);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 'The smallest planet in the solar system and the closest to the Sun', 'terrestrial', false, 87.9691, 0, 2);
INSERT INTO public.planet VALUES (2, 'Venus', 'The second planet in the solar system and brightest natural object in the night sky after the Moon', 'terrestrial', false, 224.701, 0, 2);
INSERT INTO public.planet VALUES (3, 'Earth', 'Our home planet and the only one known to harbour life', 'terrestrial', true, 365.25, 1, 2);
INSERT INTO public.planet VALUES (4, 'Mars', 'A cold dead rock in space', 'terrestrial', false, 686.98, 2, 2);
INSERT INTO public.planet VALUES (5, 'Jupiter', 'The largest planet in the solar system', 'gas giant', false, 4332.59, 80, 2);
INSERT INTO public.planet VALUES (6, 'Saturn', 'The sixth and second largest planet in the solar system', 'gas giant', false, 10759.22, 83, 2);
INSERT INTO public.planet VALUES (7, 'Uranus', 'The seventh planet in the solar system', 'ice giant', false, 30688.5, 27, 2);
INSERT INTO public.planet VALUES (8, 'Neptune', 'The eight planet in the solar system', 'ice giant', false, 60195, 14, 2);
INSERT INTO public.planet VALUES (9, 'Pluto', 'Tragically demoted to dwarf planet in 2006', 'dwarf planet', false, 90560, 5, 2);
INSERT INTO public.planet VALUES (10, 'HR 2562 b', 'A gas giant 37% more massive than the Sun', 'gas giant', false, 29309.5, 0, 7);
INSERT INTO public.planet VALUES (11, 'Kepler-452b', 'A super Earth orbiting in the habitable zone of its star', 'terrestrial', false, 384.84, 0, 8);
INSERT INTO public.planet VALUES (12, 'PSR B1257+12 A', 'The least massive known exoplanet', 'terrestrial', false, 25.262, 0, 9);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Arcturus', 'The brightest star in the constellation Bootes', 7100, 0, 36.7, 1);
INSERT INTO public.star VALUES (2, 'Sol', 'The star at the centre of our solar system', 4600, 8, 0.00001581, 1);
INSERT INTO public.star VALUES (4, 'Antares', 'The brightest star in the constellation Scorpius', 15, 0, 550, 1);
INSERT INTO public.star VALUES (5, 'Sirius', 'The brightest star in the night sky', 242, 0, 8.7, 1);
INSERT INTO public.star VALUES (7, 'HR 2562', 'HR 2562 is about 37% more massive than the Sun', 600, 2, 110.92, 1);
INSERT INTO public.star VALUES (8, 'Kepler-452', 'Kepler-452 is 20% brighter than the Sun', 6000, 1, 1830, 1);
INSERT INTO public.star VALUES (9, 'PSR B1257+12', 'Also known as Lich', 3000, 3, 2300, 1);
INSERT INTO public.star VALUES (6, 'Aldebaran', 'The brightest star in the constellation Taurus', 6400, 1, 65.3, 1);
INSERT INTO public.star VALUES (3, 'Betelgeuse', 'The tenth brightest star in the night sky', 8500, 0, 600, 1);


--
-- Name: constellation_constellation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.constellation_constellation_id_seq', 3, true);


--
-- Name: galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_id_seq', 7, true);


--
-- Name: moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_id_seq', 52, true);


--
-- Name: planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_id_seq', 12, true);


--
-- Name: star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_id_seq', 9, true);


--
-- Name: constellation constellation_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation
    ADD CONSTRAINT constellation_name_key UNIQUE (name);


--
-- Name: constellation constellation_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation
    ADD CONSTRAINT constellation_pkey PRIMARY KEY (constellation_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: galaxy galaxy_constellation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_constellation_id_fkey FOREIGN KEY (constellation_id) REFERENCES public.constellation(constellation_id);


--
-- Name: moon planet_fk; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT planet_fk FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id) ON DELETE CASCADE;


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

