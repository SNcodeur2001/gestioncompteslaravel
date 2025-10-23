--
-- PostgreSQL database dump
--

\restrict cRbJEC0OKVuQ1x5Fad2Z02qzpvE0vmgAUh2JJLHmdCyZHMfS0oA6qUPoUy2WTga

-- Dumped from database version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.10 (Ubuntu 16.10-0ubuntu0.24.04.1)

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
-- Name: clients; Type: TABLE; Schema: public; Owner: mon_user
--

CREATE TABLE public.clients (
    id uuid NOT NULL,
    titulaire character varying(255) NOT NULL,
    nci character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    telephone character varying(255),
    adresse text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.clients OWNER TO mon_user;

--
-- Name: comptes; Type: TABLE; Schema: public; Owner: mon_user
--

CREATE TABLE public.comptes (
    id uuid NOT NULL,
    client_id uuid NOT NULL,
    numero character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    "soldeInitial" numeric(15,2) NOT NULL,
    solde numeric(15,2) NOT NULL,
    devise character varying(10) DEFAULT 'FCFA'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    statut character varying(255) DEFAULT 'actif'::character varying NOT NULL,
    "motifBlocage" text,
    deleted_at timestamp(0) without time zone,
    archived boolean DEFAULT false NOT NULL,
    CONSTRAINT comptes_statut_check CHECK (((statut)::text = ANY ((ARRAY['actif'::character varying, 'bloque'::character varying, 'ferme'::character varying])::text[])))
);


ALTER TABLE public.comptes OWNER TO mon_user;

--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: mon_user
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO mon_user;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: mon_user
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO mon_user;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mon_user
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: mon_user
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO mon_user;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: mon_user
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO mon_user;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mon_user
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: mon_user
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO mon_user;

--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: mon_user
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO mon_user;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: mon_user
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO mon_user;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mon_user
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: mon_user
--

CREATE TABLE public.transactions (
    id uuid NOT NULL,
    compte_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    montant numeric(15,2) NOT NULL,
    solde_avant numeric(15,2) NOT NULL,
    solde_apres numeric(15,2) NOT NULL,
    devise character varying(10) NOT NULL,
    description text,
    compte_destination_id uuid,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.transactions OWNER TO mon_user;

--
-- Name: users; Type: TABLE; Schema: public; Owner: mon_user
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    role character varying(255) DEFAULT 'client'::character varying NOT NULL,
    client_id uuid
);


ALTER TABLE public.users OWNER TO mon_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: mon_user
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO mon_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mon_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: mon_user
--

COPY public.clients (id, titulaire, nci, email, telephone, adresse, created_at, updated_at) FROM stdin;
e95d1e5d-938b-48e1-8619-f66bd722bef6	Nadia Pagac	0591181348545	lemuel48@example.com	71756695	47407 Clemens Flats Suite 606\nPort Trentonton, DC 93574-0843	2025-10-22 04:20:04	2025-10-22 04:20:04
8bf00dad-8b2e-4613-befb-7d1ea0ebfa9f	Isaac Friesen	0756757485213	elton87@example.org	72620790	179 Raphael Crest\nNew Queeniechester, CO 16118	2025-10-22 04:20:04	2025-10-22 04:20:04
e5124af5-bd00-4258-b108-71cfdc87ad0e	Mr. Jimmie Bernhard Jr.	6285662126193	julianne.farrell@example.com	76929541	7518 O'Keefe Mills\nEast Moriah, RI 01534	2025-10-22 04:20:04	2025-10-22 04:20:04
9bd8a465-9d17-4d7e-9305-62fb0607343b	Loy Lebsack	2401214667888	xdietrich@example.net	72348676	744 Kiara Junction\nLake Deronborough, MD 91266	2025-10-22 04:20:04	2025-10-22 04:20:04
b510bc18-5651-4a5e-b29c-7d90508f9e7f	Mustafa Hyatt	6865701504688	cummerata.boyd@example.com	76508907	6278 Bailey Cove Apt. 330\nMoorestad, TN 46768	2025-10-22 04:20:04	2025-10-22 04:20:04
2295ef16-8bf3-4dd0-b5d4-955a5cf530ab	Lazaro Becker DDS	7032723286835	everardo11@example.org	78051421	2987 Gleichner Gardens\nBauchberg, CT 42570-0097	2025-10-22 04:20:04	2025-10-22 04:20:04
fc0cd2db-3088-44bd-b5bb-598f2bb42e60	Cicero Corwin	6906646459020	sonya.hettinger@example.net	79417326	5341 VonRueden Hills Suite 292\nEast Morris, NV 10396	2025-10-22 04:20:04	2025-10-22 04:20:04
6bae69dc-e0d8-48e7-a954-6d1ccddf8e5b	Tara Nolan	2042577307697	oda.little@example.net	75425904	273 Sterling Heights\nEast Candido, OH 59681-6284	2025-10-22 04:20:04	2025-10-22 04:20:04
9d382fb7-007a-44a5-8a75-db82e67bd11a	Paris Wuckert	4205870972391	geo53@example.net	76257314	591 Harber Port\nPort Christelletown, IL 91750	2025-10-22 04:20:04	2025-10-22 04:20:04
cb887754-e21d-4121-919f-0ffbebf11ca0	Gilbert Trantow	1634137575722	ivy.schmitt@example.org	79577951	514 Macejkovic Drive Apt. 505\nLuellaburgh, WI 36821-6146	2025-10-22 04:20:04	2025-10-22 04:20:04
2912aa20-3d30-48ae-8512-e952ba87eb39	Dr. Christopher Eichmann IV	0833739847101	nemard@example.com	79112910	3654 Cartwright Mountains Apt. 379\nJoannyberg, KY 21935	2025-10-22 04:20:04	2025-10-22 04:20:04
0ceae423-15ec-4ab6-9b86-70e460387a05	Ransom Keebler	0943093465051	fterry@example.net	76399491	9212 Alberto Alley\nWileyville, WI 27061-2374	2025-10-22 04:20:04	2025-10-22 04:20:04
dd581f92-714d-4f99-a15b-83df753fef5e	Dr. Jacinto D'Amore	8667794518340	gottlieb.vickie@example.com	77294568	154 McGlynn Glens\nLake Nathanton, CO 88825-1699	2025-10-22 04:20:04	2025-10-22 04:20:04
ebe3bd84-4621-4108-b1e6-b14c26e22b26	Miss Beaulah Rice PhD	2248537759899	osinski.orland@example.org	70496033	537 Yasmin River\nNew Nelsbury, AR 23016-9029	2025-10-22 04:20:04	2025-10-22 04:20:04
bcaba780-6ade-4767-a976-7fe36aa6ca5d	Paxton Romaguera	1224592084386	augusta20@example.net	72306166	1493 Alba Garden\nSouth Narcisofort, CA 59133	2025-10-22 04:20:04	2025-10-22 04:20:04
3cdfa2b2-70b6-47fe-bd2c-c5d2766495bd	Mr. Hershel Kiehn	2993019673834	tmarks@example.net	75597084	3002 Caroline Hills\nPort Jerome, KY 49107-7894	2025-10-22 04:20:04	2025-10-22 04:20:04
bfe819a2-a5a9-4020-baa8-457166d3393d	Isabel Murray	3140388223206	tanya17@example.com	78665327	484 Feest Fall\nNew Thalia, VA 94880-8485	2025-10-22 04:20:04	2025-10-22 04:20:04
1d1218e2-d355-4fa0-8d6a-3ce3607bd466	Jamey Thiel V	4669992001365	prosacco.rupert@example.com	74314417	573 Kiara Villages\nHoegerview, DC 44203-8907	2025-10-22 04:20:04	2025-10-22 04:20:04
aeff48dd-a1ef-43a9-a238-d8ab29043a3b	Lilly Morissette	1344680403452	gdaugherty@example.net	79139389	948 Donnelly Ridges Suite 317\nPort Roslynborough, UT 76531	2025-10-22 04:20:04	2025-10-22 04:20:04
c32528e6-2bde-4230-85b1-78b5d8592a2d	Nikko McKenzie PhD	4350895706106	alvena.denesik@example.net	71739835	4311 Goyette Radial\nKemmerview, NJ 64993	2025-10-22 04:20:04	2025-10-22 04:20:04
cce4a4ea-bf15-4cd6-9dda-f8f1a2c84940	Mr. Mallory Price IV	3271507859415	diamond.schoen@example.com	76826263	65246 Grant Union Apt. 013\nFisherville, TN 21197-8112	2025-10-22 04:20:04	2025-10-22 04:20:04
75f52710-4bec-4c5f-a6a2-f28ec6a07c2e	Josiah Stehr	2536081484268	oparker@example.net	75259566	52422 Jaylan Skyway Apt. 987\nWest Vernaport, LA 06004	2025-10-22 04:20:04	2025-10-22 04:20:04
8261ec53-efe5-4a6e-b59a-6243991f0de1	Geoffrey Berge	9276486835711	tobin28@example.org	76470902	5216 Lemke Underpass Apt. 865\nElyssabury, WI 17135-5730	2025-10-22 04:20:04	2025-10-22 04:20:04
312f0bb7-7a81-41fd-a028-0e6d2536f052	Kole Skiles	9448675822809	mcclure.chadd@example.com	75106123	847 Milford Plaza\nNew Whitney, SC 87986	2025-10-22 04:20:04	2025-10-22 04:20:04
2dfda345-cd89-4a83-b8cc-2db4bdc81d29	Dora Maggio	1870480674970	alf.stanton@example.org	78571325	6272 Ledner Lights\nDelphaton, FL 78169	2025-10-22 04:20:04	2025-10-22 04:20:04
ccf2fbd6-f8a6-49c6-99a8-0b19c9238883	Bradford Ryan	5633052743120	zjohns@example.com	73832592	8013 Taya Summit Suite 680\nWest Dale, NM 95382-2683	2025-10-22 04:20:04	2025-10-22 04:20:04
da44670d-282e-46cc-8a18-d21c67b5d461	Lorenz Boehm	5354300525480	block.grant@example.org	77316308	8947 Holden Ridges\nWest Felipe, TN 14147-2441	2025-10-22 04:20:04	2025-10-22 04:20:04
8d914f61-b8ce-4377-901a-e4ec16df779e	Mrs. Leola Hodkiewicz	5551874336013	rosalind.mcglynn@example.com	75854462	4321 Johnathan Hills\nNew Amirberg, WA 98779	2025-10-22 04:20:04	2025-10-22 04:20:04
da5c9586-f643-40eb-9533-59486a743663	Tracy Rippin	8563538156642	laurine.greenholt@example.net	74080168	9144 Kaya Trace Apt. 894\nSouth Angelica, MO 31530	2025-10-22 04:20:04	2025-10-22 04:20:04
1074fd3a-8114-4da6-b81b-8ecc2bf19f35	Dr. Kirstin Heaney Jr.	3211167962838	wendell.hodkiewicz@example.com	72569179	964 Gorczany View Suite 977\nNorth Virginiabury, SD 89902	2025-10-22 04:20:04	2025-10-22 04:20:04
a097455e-e8c1-488c-ba84-eccc0400a33e	Brook Hodkiewicz	3192579674098	kylee.rosenbaum@example.com	76508579	728 Trevion Glens Suite 601\nAdelialand, GA 84198	2025-10-22 04:20:04	2025-10-22 04:20:04
4ad2659f-e8b0-4910-87f9-7e704ccd0f61	Martine Maggio	3620418410302	lstokes@example.com	70232828	17505 Heather Inlet Apt. 149\nNorth Babyfort, UT 52219	2025-10-22 04:20:04	2025-10-22 04:20:04
f3251594-3802-482c-85fe-f2506786993b	Dr. Anjali Erdman MD	4039644090649	schuster.kenny@example.net	74576269	149 Landen Court\nPort Goldaland, AK 28444-7494	2025-10-22 04:20:04	2025-10-22 04:20:04
ed8141c0-a52e-4435-8a79-3786a11a060d	Kelsie Hintz	8583464907860	halvorson.verona@example.com	79118733	70394 Padberg Drives\nNew Cletusstad, MT 62823	2025-10-22 04:20:04	2025-10-22 04:20:04
8d021504-e42c-4f05-ac16-f3f8921ff113	Lessie Dooley	9399706913319	jose39@example.com	75372943	13375 Marvin Shoal Suite 861\nStromanland, WY 25914-2398	2025-10-22 04:20:04	2025-10-22 04:20:04
d89292f6-49cc-4110-9a9e-fe1099e2122c	Yesenia Huels	2592930333936	leon15@example.org	71510031	436 Breanne Roads Suite 012\nSouth Armanitown, OR 40858-9294	2025-10-22 04:20:04	2025-10-22 04:20:04
098a4597-69b4-4630-9573-b180a76e192f	Jaime Waters	4971940636439	powlowski.americo@example.net	72327723	97718 Bailey Crescent Apt. 060\nLake Leanne, MI 71926	2025-10-22 04:20:04	2025-10-22 04:20:04
4acc195c-2bcc-40c1-bf78-a467fff4a6af	Monte Hagenes	2253674441621	lowe.berneice@example.org	77352801	794 Harvey Spurs\nNew Matt, FL 51017	2025-10-22 04:20:04	2025-10-22 04:20:04
bd6fb870-ed1d-48ec-a5ff-d0208df93693	Justus Boyle	2670381512824	kankunding@example.net	78331087	936 Stokes Wells\nStromanborough, AK 48849-3698	2025-10-22 04:20:04	2025-10-22 04:20:04
3f868e3e-b5b9-4de8-b5b6-d706a7349ef3	Ms. Abbey Schmitt	9850048651881	gsmith@example.net	73663365	20185 Schmitt Path Apt. 160\nPort Queenborough, AZ 28467	2025-10-22 04:20:04	2025-10-22 04:20:04
aa3fae35-389c-4895-ace4-7dea84308f30	Vicky Muller V	7809429429527	taryn.wilkinson@example.net	76641050	406 Michaela Forge\nTillmanstad, NV 03899-1348	2025-10-22 04:20:04	2025-10-22 04:20:04
bb1a060b-656a-41a5-af5d-8320a51813be	Heloise Schmeler	1286593326774	mcclure.liliana@example.com	77112133	9354 Conn Burgs Suite 721\nSouth Asaside, HI 60722-8814	2025-10-22 04:20:04	2025-10-22 04:20:04
d9fb583a-3d16-4c9a-ae62-6ccb501c3fe7	Zane Rowe	3335132476769	kaitlyn77@example.com	76698191	480 Schmeler Islands Apt. 322\nElmerhaven, AL 23412	2025-10-22 04:20:04	2025-10-22 04:20:04
a635266b-b848-4f32-ac98-47d6d9300170	Chelsey Orn	3369881175125	wilderman.madaline@example.com	78385062	211 Lebsack Ramp Suite 671\nEvansport, WY 98977	2025-10-22 04:20:04	2025-10-22 04:20:04
95fdb5ed-170c-4347-9247-b139e76497bd	Cary Hintz V	2200278289803	delilah43@example.com	78132081	7586 Pfeffer Crossing Apt. 071\nFraneckimouth, LA 69269	2025-10-22 04:20:04	2025-10-22 04:20:04
b045bbca-91ee-47b0-a0a4-69f7d33c23bc	Mya Bergnaum	6651709569463	wiza.rowena@example.com	77604200	92567 Daphney Highway Apt. 763\nNew Paige, MD 47022-4047	2025-10-22 04:20:04	2025-10-22 04:20:04
5c93b383-9271-40d7-9ace-0b0ff83b57bb	Oren Bruen	0094106287250	justina.crona@example.org	70665819	3434 Durward Square\nWalkerfort, SD 81256-5217	2025-10-22 04:20:04	2025-10-22 04:20:04
3edae546-cba6-4221-84c5-3c9542892a9f	Destinee Bogan	9793279831152	margarette.dach@example.net	73743255	947 Mayer Squares Suite 243\nLake Emmet, AZ 51404-1482	2025-10-22 04:20:04	2025-10-22 04:20:04
fe90c2b9-026e-47a1-a95c-87ba5ccb7460	Dr. Ryder Hill	4909875659726	madonna83@example.com	71199452	8688 Evalyn Isle\nPort Abdielview, GA 85852-2203	2025-10-22 04:20:04	2025-10-22 04:20:04
83168a4b-4675-4b9f-b8dc-36c1fc8aa6e8	Ms. Yasmeen Borer	3259959335688	okon.loren@example.org	70232270	21816 Kuvalis Points\nKemmerstad, NE 01104	2025-10-22 04:20:04	2025-10-22 04:20:04
9f6b2e93-d025-41fd-8c7f-26663c13ec58	Elyssa Howell	7424539215789	jevon.crona@example.com	72182540	83420 Ivory Manors\nBayerport, MT 98455-0361	2025-10-22 04:20:04	2025-10-22 04:20:04
b4ad6ec5-3457-4433-97e4-90df7b25e1ed	Adolphus McCullough	1363295484354	kian.mckenzie@example.org	74738330	271 Ophelia Shores\nLake Armandohaven, MO 25394	2025-10-22 04:20:04	2025-10-22 04:20:04
e2025eec-308a-4aa3-a32b-5a89afbb4b5a	Florian Hermann	0972115720347	xmarks@example.org	78821690	70850 Koch Green Suite 652\nNorth Julio, IN 38305	2025-10-22 04:20:04	2025-10-22 04:20:04
ddf188b3-a434-4323-b1a8-16275fb15073	Lavon Bergnaum	8403400450471	neil68@example.net	76231172	9584 Bertrand Greens\nEast Chelseyland, MN 18545	2025-10-22 04:20:04	2025-10-22 04:20:04
c0b8ebaa-6d8c-4cd9-ab02-ccdf1030bd93	Crystel Moore	9563071950032	aaliyah.rodriguez@example.org	71750313	8273 Lea Plains\nMarcellusshire, WI 11538-5688	2025-10-22 04:20:04	2025-10-22 04:20:04
ef7a27e7-7044-4d20-ba94-6e412223b84d	Cole Runte	9401973998563	prudence94@example.net	78556978	5323 Cummerata Springs\nNorth Carlo, WY 57896-6048	2025-10-22 04:20:04	2025-10-22 04:20:04
ec758530-666d-4458-85d5-b5f060b58a1d	Lavada Tillman	0801630862042	nparisian@example.org	77145185	53090 Hegmann Route\nPort Saul, NJ 44496-9560	2025-10-22 04:20:04	2025-10-22 04:20:04
9381e924-3568-4672-8ee6-9d49c059adfe	Merle Hessel PhD	5350506103002	forrest46@example.org	71201896	6643 Kristina Spring\nNorth Benedict, TN 73965	2025-10-22 04:20:04	2025-10-22 04:20:04
de66bcd0-2eac-403c-8998-343851a96118	Thelma Trantow DVM	7065972431279	jensen64@example.com	77111513	7709 Jacobson Walk Apt. 576\nLake Donatomouth, MN 97192-3856	2025-10-22 04:20:04	2025-10-22 04:20:04
dfca4fe1-63b7-4ed8-8f5e-43d49c0a8b71	Freeda Lind	0854834391767	freilly@example.org	72356638	627 Nienow Plains Suite 020\nNew Leatha, RI 05496	2025-10-22 04:20:04	2025-10-22 04:20:04
0ca7caf8-9b31-4fb4-a138-79c6138eb0b8	Mr. Herbert Price	8239672395217	dewayne56@example.com	73508586	741 Werner Crossing Apt. 251\nNorth Waldo, MT 54310	2025-10-22 04:20:04	2025-10-22 04:20:04
2aeae0a6-25ab-4abb-896c-501c7b90100c	Bethany Kshlerin	5628735458482	susana28@example.org	79665427	51514 Bruen Drive\nEast Terrellburgh, OH 39038-7004	2025-10-22 04:20:04	2025-10-22 04:20:04
7a9196e1-636b-4a55-8d11-2139340a7ce9	Orlo Lesch	0926123578044	pete98@example.org	78420823	649 Greenholt Greens\nWest Harvey, DC 29379	2025-10-22 04:20:04	2025-10-22 04:20:04
4871d970-0707-46d2-94a1-a225e66b3341	Braeden Kiehn Sr.	5506723916600	schumm.ayden@example.net	74274609	769 Jorge Hollow Apt. 930\nWest Berthaside, NM 53299	2025-10-22 04:20:04	2025-10-22 04:20:04
3cba95c1-75c0-4c1a-ac61-5b9a0174ccf6	Irving Strosin	7878260948209	rippin.darrin@example.net	72758899	3070 Fahey Spur\nLake Isaiahhaven, MI 96619-7359	2025-10-22 04:20:04	2025-10-22 04:20:04
8d80229b-6a0b-476e-9c7e-4df3241bf1ae	Berniece Hills	5760653799343	rolando66@example.com	78869176	971 Ned Ford\nSouth Callie, MA 16868	2025-10-22 04:20:04	2025-10-22 04:20:04
df6e313d-634e-4e25-9cf4-7e8fc76849e8	Sofia Kautzer	2654681809789	vance.botsford@example.com	78800434	9951 Breanne Route Apt. 348\nWuckertville, SD 09844-2284	2025-10-22 04:20:04	2025-10-22 04:20:04
7ddf1549-eaa3-41f7-848d-6b105daee39f	Sarah Daugherty	3757758153647	chasity.krajcik@example.net	76049850	184 Lockman Plain Apt. 129\nSouth Pierreton, AL 83839-5391	2025-10-22 04:20:04	2025-10-22 04:20:04
89d78ef9-28aa-4fb3-82b9-ba9f21b96c07	Fidel Thiel	4924597246528	jolie.huels@example.com	73408933	182 Okuneva Plaza Apt. 981\nEast Delia, DE 20584	2025-10-22 04:20:04	2025-10-22 04:20:04
608a27c3-f676-4f17-88a0-fd6eaccaa49c	Prof. Anahi Reichert	7669604081751	reichel.missouri@example.net	75730011	180 Jakubowski Roads Apt. 015\nJerodmouth, CA 52834-9450	2025-10-22 04:20:04	2025-10-22 04:20:04
237694dd-576c-46e1-842c-448bf5dc6668	Braeden Barton	9729582591939	pasquale.bernier@example.org	71464487	2112 Trevion Junction Apt. 711\nNorth Johnsonstad, MI 45533	2025-10-22 04:20:04	2025-10-22 04:20:04
8ca37be7-86c7-4391-b752-8f9ec15b27ee	Shad Gaylord DDS	4945437852340	mturner@example.net	76487137	486 Earl Extensions\nSouth Alisaberg, IL 00101-0807	2025-10-22 04:20:04	2025-10-22 04:20:04
8ebf1d88-deac-4e1a-bd71-f9b1c73031c3	Dejah Mosciski	9665063171044	hfarrell@example.com	76123044	408 Quitzon Circle\nWest Furmanbury, TN 31551	2025-10-22 04:20:04	2025-10-22 04:20:04
5d7ff698-8f01-4c09-aa91-e625e07661bf	General Runolfsson	4195628329486	olson.ethelyn@example.org	70144994	4917 Feil Expressway\nNew Judsonland, VT 72116-8475	2025-10-22 04:20:04	2025-10-22 04:20:04
d5a42fa1-4780-4d6f-aa8f-1db7a5d87a7f	Daija Graham	0960246194688	treilly@example.com	70559190	661 Hessel Port Suite 802\nNorth Santiagoton, IN 94424	2025-10-22 04:20:04	2025-10-22 04:20:04
b5f588c7-4086-40d4-9eef-1d1a274ba9e8	Silas Murazik	7813436715505	stark.kiel@example.org	79628430	9713 Melba Hollow Apt. 735\nPort Quentinshire, KY 43443	2025-10-22 04:20:04	2025-10-22 04:20:04
a95d0a6b-2420-4f42-86df-cfa2b45e1513	Daphne Reinger	3143687778336	vpadberg@example.net	76025384	3382 Braun Trafficway Apt. 035\nWest Christborough, MD 38207	2025-10-22 04:20:04	2025-10-22 04:20:04
0718e2ab-937c-4b09-a023-8a55edd8e20e	Kimberly Dooley	7218973008476	terry.rempel@example.com	71383726	5478 Mann Terrace\nCandidaport, AK 75563	2025-10-22 04:20:05	2025-10-22 04:20:05
1bbe3e47-da3b-470f-a61b-712cd4c896b1	Camylle Gerhold	7871874165599	damore.marcella@example.org	72282681	53872 Kshlerin Light\nCorrineside, DC 57095	2025-10-22 04:20:05	2025-10-22 04:20:05
3bf4be6a-b7dd-4fd1-aa85-90364b537b05	Dr. Sister Turcotte	5429676900561	mhessel@example.org	75009449	631 Reina Rapid\nNorth Melyssa, WA 71013	2025-10-22 04:20:05	2025-10-22 04:20:05
e9ebe070-30b5-4666-8ce3-67eeb5fa17c7	Leonel Glover	4317749269293	othompson@example.net	71214695	3180 Cassin Ford Apt. 723\nWest Rosetta, MT 00761	2025-10-22 04:20:05	2025-10-22 04:20:05
9af08392-e4a9-4724-b175-9aa0e601a23a	Kevon Schinner DVM	3294854457309	lind.hannah@example.net	75348819	182 Luther Shoals Suite 675\nLockmanport, MD 15568	2025-10-22 04:20:05	2025-10-22 04:20:05
60f5f868-adc9-4cae-b4b5-3ad56467867b	Mariela Tremblay	5353013931070	brooklyn.block@example.com	77288157	626 Simonis Forge\nMoenmouth, ME 56213	2025-10-22 04:20:05	2025-10-22 04:20:05
eb62ece6-1b49-4645-b417-68daa5ded4a0	Valentine Ankunding IV	4306843847104	auer.reymundo@example.org	70636070	91443 Bartell Squares Suite 476\nNorth Edwin, LA 36263-3110	2025-10-22 04:20:05	2025-10-22 04:20:05
dde9f652-6ba7-4ee0-9fc4-2e00b84a18bb	Dr. Trevion Breitenberg	0148780759644	grady.ratke@example.org	73505131	310 Madie Harbors\nBaileyshire, KY 00981-9074	2025-10-22 04:20:05	2025-10-22 04:20:05
7d559181-5e06-4607-85ee-051bf81da552	Mr. Elbert McCullough	6781072860018	kledner@example.com	76610246	900 Gottlieb Prairie Apt. 533\nStromanburgh, LA 16054	2025-10-22 04:20:05	2025-10-22 04:20:05
2b15bf65-df76-4d3c-bbf0-f5a6f0657828	Marisa Heaney DDS	5430722746008	dayne.weber@example.com	75472900	12964 Lebsack Radial\nEast Adan, IN 64340-1047	2025-10-22 04:20:05	2025-10-22 04:20:05
18e47158-94b8-4268-9dd7-699b81b05ed5	Loren Koss	0532499624091	maynard.mills@example.org	72269695	19404 Bergnaum Creek\nLake Monteville, MD 21121-8806	2025-10-22 04:20:05	2025-10-22 04:20:05
480fbc1e-e234-47a8-9c01-59e9f06b5de4	Magali Schaefer	1467960984679	aisha46@example.org	76145325	3727 Lehner Island\nEast Cotymouth, OK 82136-9340	2025-10-22 04:20:05	2025-10-22 04:20:05
817c0b58-4528-4ae4-8bd4-e1b94e3c7d7b	Isabell Goldner	7827123669106	watsica.lenore@example.org	72661435	31597 Glennie Plaza Apt. 332\nLabadieland, VT 22720-5137	2025-10-22 04:20:05	2025-10-22 04:20:05
1ec3b569-b566-4929-a21e-12c488f98246	Coy Smith	3577490924253	hegmann.ofelia@example.net	78021481	2247 Witting Motorway\nLethamouth, AR 34999-2053	2025-10-22 04:20:05	2025-10-22 04:20:05
e4ad9aae-ba11-4081-b3e8-96668af4ebf5	Grace Lakin	8650891009912	kkoelpin@example.net	73591114	830 Asia Lakes Suite 619\nDerickmouth, WV 18042-3130	2025-10-22 04:20:05	2025-10-22 04:20:05
c07b5d67-cc11-4cec-9de1-4937f32fadee	Dr. Zachary Kuhic	1718474143484	hudson73@example.com	72341998	185 Ona Valleys\nZenahaven, IN 04441	2025-10-22 04:20:05	2025-10-22 04:20:05
df3c6d94-1c20-418e-8c76-667cb13a842d	Kiarra Gottlieb	3186080808428	wilkinson.rossie@example.com	74798226	23835 Wolf Meadows\nNew Sheilabury, KY 83079	2025-10-22 04:20:05	2025-10-22 04:20:05
18867b1a-197e-450c-91ac-67ab4950ab21	Mr. Presley Kihn Jr.	1763887199775	lauriane27@example.com	77264715	38776 Aryanna Meadow Apt. 827\nNew Rudolph, PA 13093-1605	2025-10-22 04:20:05	2025-10-22 04:20:05
6575c0d2-5298-4d39-ae36-65fb65e83efd	Leonora Kovacek	8331529576152	daphney.rosenbaum@example.org	76245374	824 Kilback Hollow\nLake Gudrun, MI 15350-4641	2025-10-22 04:20:05	2025-10-22 04:20:05
059ec1da-b9b0-419b-a630-4be38e1b9c9e	Miss Elisha Mohr	9331899809045	katelynn15@example.com	74538019	93600 Flatley Brooks\nLake Olga, WI 57893	2025-10-22 04:20:05	2025-10-22 04:20:05
1e91d290-b04f-4773-aeca-6c77f0a84193	Lillian Frami Jr.	9638586164162	imitchell@example.com	73854524	43558 Jacobs Junctions Apt. 001\nLangworthmouth, WI 72120	2025-10-22 04:20:05	2025-10-22 04:20:05
802c23bd-44bf-4777-9984-aa168298376e	Annetta Jenkins	3006835183158	lilyan.cronin@example.org	76820905	99511 Ines Plains Apt. 526\nNorth Dimitribury, TX 91167	2025-10-22 04:20:05	2025-10-22 04:20:05
3cf1758c-3335-4f9c-b98f-17da0563f499	Candida Jacobson	9582316871389	dovie.rodriguez@example.net	71633924	91781 White Forge\nPierceton, CA 32697-3774	2025-10-22 04:20:05	2025-10-22 04:20:05
112dfabc-1caa-4af8-8df2-43d40b4da622	Prof. Jacynthe Nolan I	4963396872280	hiram.jacobi@example.org	70840586	14088 Larry Points Suite 086\nSouth Jovany, MI 50026-3002	2025-10-22 04:40:04	2025-10-22 04:40:04
1e6d3d08-dfff-48e9-aaa9-769caf8f21e3	Dr. Albert Bosco	6583421441524	hirthe.chasity@example.net	77462196	15835 Kreiger Island Suite 392\nEast Antwonstad, NV 83858	2025-10-22 04:40:04	2025-10-22 04:40:04
9a5b0fbb-2106-487f-b644-93b23321ea29	Ms. Daija Mayert I	9530933312304	morar.cyril@example.net	71636576	20912 Murray Pike Suite 703\nPort Augustside, MI 39976-5669	2025-10-22 04:40:04	2025-10-22 04:40:04
68434504-c1b6-41d8-bea1-e2ccc0d6c938	Dr. Shad Mosciski	1250164159605	pollich.griffin@example.org	75838271	1255 Arielle Summit\nSouth Eldashire, TN 68693-2241	2025-10-22 04:40:05	2025-10-22 04:40:05
9dc9deee-0c13-4c2f-8799-818e61e5a434	Prof. Amina Nienow DVM	8971554802391	pauline30@example.net	77123876	7950 Mark Radial Suite 773\nPort Tyrelland, FL 38050-8692	2025-10-22 04:40:05	2025-10-22 04:40:05
d4bbf9b1-29c0-4146-8125-422c54cc79ce	Hipolito Ullrich	0217312735183	marlon50@example.com	79904726	458 Camille Inlet\nSouth Rosalia, OH 50144	2025-10-22 04:40:05	2025-10-22 04:40:05
e21f1400-308a-48f6-9406-3fd554b8ee68	Kasandra Hirthe	7856356253424	orin51@example.org	71786363	645 Dora Falls Apt. 843\nWest Dominique, IA 96101-6877	2025-10-22 04:40:05	2025-10-22 04:40:05
741eaa88-bc64-4044-9a9b-59cba8f157b0	Prof. Amy Kutch	2895360157257	tfay@example.org	76193081	117 Clement Dale Apt. 122\nSouth Santinoport, MN 74834	2025-10-22 04:40:05	2025-10-22 04:40:05
1685a896-c5ea-4830-8902-6f9847f4e03a	Macie Kihn	8634797658142	cstamm@example.net	77077703	80661 Bosco Plain\nBraulioview, NC 74798	2025-10-22 04:40:05	2025-10-22 04:40:05
42d9e762-be28-4ee5-8f6a-96c8db192dc7	Rosalyn Harris	6021024367790	mwunsch@example.com	74374439	652 Trantow Common\nBergstromfort, CO 06271	2025-10-22 04:40:05	2025-10-22 04:40:05
18cb80f8-bd87-4def-a825-80e1603ce669	Carmela Larson V	3753676888913	roslyn37@example.com	78820671	5957 Cummings Glens Apt. 857\nBogisichton, PA 79001	2025-10-22 04:40:05	2025-10-22 04:40:05
a2c47393-4e16-49d8-b342-613878b63408	Maryse Effertz	1345706921393	arenner@example.org	73767002	2419 Bobbie Shoals Apt. 826\nParisianville, MO 57064	2025-10-22 04:40:05	2025-10-22 04:40:05
0d07a970-21ff-46a8-9f0f-e177880262db	Prof. Morton Stiedemann	8652075701390	koss.felicita@example.org	76488792	883 Enola Mission Suite 051\nSchinnerbury, ID 78132	2025-10-22 04:40:05	2025-10-22 04:40:05
31e04a4a-9b9e-48ee-ac55-529596e40c4e	Ana Thompson	2680240572655	reymundo61@example.com	78365986	691 Dibbert Station\nNew Madieshire, SD 99697-2140	2025-10-22 04:40:05	2025-10-22 04:40:05
96a0fa41-7ce5-4ece-bab0-8a804b6f9b7a	Aiyana Johnston	4040598464341	nettie.schmidt@example.com	76189930	154 Ebert Vista\nLemkefort, VA 90572-2320	2025-10-22 04:40:05	2025-10-22 04:40:05
240fa186-5b27-4ecc-96ae-1c380d9791ba	Macey Klein	0662862321837	leonie57@example.net	78921751	752 Lola Extensions Suite 291\nSouth Jodymouth, VA 53761	2025-10-22 04:40:05	2025-10-22 04:40:05
dea98ae9-eef1-4b50-9eb1-ce8433c30846	Boyd Schaefer	6815546426580	stamm.judah@example.org	75640683	2652 Ondricka Forks Suite 394\nKelsistad, CA 77459	2025-10-22 04:40:05	2025-10-22 04:40:05
ff4a4eac-62cb-41be-b997-b9dc5700d51c	Allison Schroeder	4444199007167	lulu.johnston@example.com	76460393	627 Margarete Summit\nSouth Armandland, MO 46944-0870	2025-10-22 04:40:05	2025-10-22 04:40:05
316dc6cc-d40a-4f6b-aa55-9f1e090896e3	Mrs. Emilia Keebler	3297938477089	keshaun09@example.com	76458652	34985 Hansen Station Suite 165\nHandport, TN 92600-3509	2025-10-22 04:40:05	2025-10-22 04:40:05
1fc2bf58-985e-48aa-85dd-64180015e007	Abigail Rogahn III	9568071529887	jace50@example.com	72297809	5418 Clemmie Squares\nNorth Abdul, IN 31549-8650	2025-10-22 04:40:05	2025-10-22 04:40:05
f7cfe2d4-023e-4113-b6d0-4542feccbd53	Dr. Madaline Nader	6755699705524	tod.ullrich@example.net	77414596	650 Koss Fork\nNew Terranceland, VT 16746	2025-10-22 04:40:05	2025-10-22 04:40:05
2ed86228-5443-4fa2-8529-4d9a3ea96891	Virginie Ratke	0124978684818	adelia.schumm@example.com	74623606	2446 Flo Plain Suite 487\nLebsackland, NJ 16628-8614	2025-10-22 04:40:05	2025-10-22 04:40:05
7d37a98b-65bc-420f-acef-3c48673507e2	Norwood Murazik	0723711618964	jamison.sauer@example.com	71402558	1017 Bartoletti Forks\nTrantowview, NJ 32319	2025-10-22 04:40:05	2025-10-22 04:40:05
8cf589a5-979b-4daf-b993-633dcc066eff	Bruce Jaskolski	1256196677014	rosalyn.harris@example.org	71995009	557 Rolfson Estate Suite 889\nNorth Titusport, NY 54987	2025-10-22 04:40:05	2025-10-22 04:40:05
af5527eb-47a6-44f0-a658-e7ac41575fc8	Ms. Jaunita Ankunding DVM	4040943306791	skautzer@example.com	70292127	542 Marks Ridges Suite 304\nNew Jameyshire, NY 84839-8090	2025-10-22 04:40:05	2025-10-22 04:40:05
3f89d232-821b-4fc0-870d-b030d5fa2fa9	Myrna Effertz Jr.	6916480952609	rschimmel@example.org	71830573	27118 Okey Branch\nKihnberg, MA 93747-9586	2025-10-22 04:40:05	2025-10-22 04:40:05
01599aad-5b40-418a-921e-10f9d2b42073	Betsy Gerlach II	0045937289828	barton.skyla@example.org	75036287	532 Kailey Hollow\nWest Savanahchester, HI 92266	2025-10-22 04:40:05	2025-10-22 04:40:05
866fa58c-964a-439b-ae75-caff3b0e3feb	Mr. Miles Glover	1223609684222	stark.aurore@example.net	75794613	441 Prince Ridge\nMcLaughlinmouth, SD 74903	2025-10-22 04:40:05	2025-10-22 04:40:05
e69a2ea2-51ac-4806-a9e6-dd1abe23768a	Prof. Ebony Champlin DDS	8512626933688	lcollier@example.org	72197630	3864 Gleason Squares Apt. 018\nAngelicamouth, HI 61077	2025-10-22 04:40:05	2025-10-22 04:40:05
cc7bfbbd-d7d8-4c6b-821c-01f5c548bbb4	Trever Leuschke	5314719684862	qmertz@example.org	71676975	46348 Schulist Manors\nNorth Clinton, WY 59084	2025-10-22 04:40:05	2025-10-22 04:40:05
18565320-b658-4807-8baa-2059d5ad6aeb	Timmy Stoltenberg	6069171883292	gardner.sauer@example.org	78040355	6472 Baumbach Alley\nWilliamsonshire, OK 42787	2025-10-22 04:40:05	2025-10-22 04:40:05
6ede63b6-2056-446c-8d65-ceaeb7e9918c	Tiana Effertz	8517435251724	doug.bauch@example.org	78454965	34971 Gerhold Plains\nSouth Abbigailport, VA 87152-0364	2025-10-22 04:40:05	2025-10-22 04:40:05
cf45b084-5490-40cb-9b36-f92ac4f91d28	Liliana Marquardt	2259528047463	claude.altenwerth@example.org	71122911	9033 Edwardo Loaf\nNorth Ramiroview, VT 02108	2025-10-22 04:40:05	2025-10-22 04:40:05
750b8316-b107-40dd-b281-4d24372be743	Mrs. Jaunita Dickinson	9390538834198	nitzsche.hank@example.net	72871209	31592 Yvette Island Suite 327\nSwaniawskiview, MA 17318-0342	2025-10-22 04:40:05	2025-10-22 04:40:05
671eb48c-99c9-4444-bb24-05d2b29519f5	Colby Spencer	6145295070932	walter.freddie@example.com	75932922	640 Wisozk Highway Apt. 373\nMelynabury, MN 70171	2025-10-22 04:40:05	2025-10-22 04:40:05
4c4f0856-fcaa-4f71-a376-ffc7d899435d	Dr. Antone Dach Jr.	9437451895491	stroman.drake@example.org	77046136	8721 Michaela Spring Apt. 497\nNew Hipolitoside, NJ 36222-3129	2025-10-22 04:40:05	2025-10-22 04:40:05
66917bfe-b112-46b7-8198-df9f848b165b	Theresa Aufderhar	1716057763700	lavada.crooks@example.org	72716431	4335 Petra Locks\nSouth Ricardo, CT 60388-8187	2025-10-22 04:40:05	2025-10-22 04:40:05
9fbf7fdd-8277-40fc-8aed-76952ca6d2f5	Serena Ortiz	9863604912831	alice.homenick@example.org	71460605	11583 Haven Centers\nNew Heavenside, MN 66903	2025-10-22 04:40:05	2025-10-22 04:40:05
d2a023fb-82df-4bce-86be-51fc630399c3	Jerrod Walter	4429534894751	dgoodwin@example.com	71507405	52691 Filiberto Stravenue Apt. 705\nTierraside, CO 74885-0907	2025-10-22 04:40:05	2025-10-22 04:40:05
afe6c2c9-d3f2-4b8a-a0b5-885079b4209d	Carter Keebler	7198219950805	zemlak.ransom@example.net	74668700	792 Collins Fort\nWest Alexannehaven, ND 61353	2025-10-22 04:40:05	2025-10-22 04:40:05
d7140bbe-ec49-4f7e-8e13-ad1db47a991e	Beau Daugherty	6506979594149	purdy.sabina@example.com	72685590	590 Reinger Freeway Suite 672\nSouth Tannerfurt, WV 44010-9144	2025-10-22 04:40:05	2025-10-22 04:40:05
9f9e36a6-66e7-4202-87ef-9d04398bfe8d	Opal Mayer	2882720068527	timmothy61@example.org	76208895	5059 Bogisich Ville\nLake Candace, MI 59435-3895	2025-10-22 04:40:05	2025-10-22 04:40:05
dbe1ca9c-ff1a-48d4-9e15-dbeefb52cd4e	Sherwood White	5002352254667	dpacocha@example.net	79912763	230 Rice Villages Apt. 407\nMadelinehaven, NY 71932-8654	2025-10-22 04:40:05	2025-10-22 04:40:05
a591ef34-cb6b-47ce-8df4-e663723b945c	Prof. Stanford Langosh DVM	3201281390401	elias.will@example.com	77363362	35345 Kuhn Extension Apt. 610\nTheresiaville, ND 88946-8133	2025-10-22 04:40:05	2025-10-22 04:40:05
c2fd2e6a-ecbd-45fc-9966-1f69c5d69159	Randall McDermott	4540240892800	lkoepp@example.net	74862664	7637 Dedric Centers Apt. 808\nEast Narcisobury, MA 28990	2025-10-22 04:40:05	2025-10-22 04:40:05
118cbf85-bbbd-4a58-8356-c38fb412d073	Adrianna Braun	9062738633582	pauer@example.org	70015149	6878 Lynn Street\nHillarychester, MT 09813-2631	2025-10-22 04:40:05	2025-10-22 04:40:05
be575917-2cd1-47c6-966b-72b8f6520e4f	Randal Borer	0207200599434	oconnell.maurine@example.org	74633918	22379 Cruickshank Rest\nEast Rolandoport, MD 57266-8669	2025-10-22 04:40:05	2025-10-22 04:40:05
deea0ef0-1e98-43af-b187-cec41491109e	Axel Rau	6283571276737	murl.gaylord@example.net	72652068	89898 Botsford Prairie Apt. 252\nMaynardland, WI 24322-3053	2025-10-22 04:40:05	2025-10-22 04:40:05
08f2f7d3-76ac-45c8-b322-fd5ebc21a2e3	Simone Osinski III	2655706799219	haag.skylar@example.net	76557326	1624 Ewell Valley Suite 863\nLake Duncan, NC 57765-8304	2025-10-22 04:40:05	2025-10-22 04:40:05
b276397a-f91c-46fc-a77a-541801840984	Miss Dasia Johnston	6590060151579	thompson.clinton@example.com	73256999	2283 Daniela Point\nLake Reggieburgh, IL 54298-2958	2025-10-22 04:40:05	2025-10-22 04:40:05
e606690c-b515-42c4-8448-e7181f0137fc	Mr. Emile Nolan II	3956242248804	pheller@example.org	77480656	542 Noble Path\nCodyfurt, OR 52194-1659	2025-10-22 04:40:09	2025-10-22 04:40:09
85f9d22c-f85d-4d1b-bdda-bd4f8b1dea60	Tevin Senger IV	0445817122128	yosinski@example.org	73571912	86422 Kali Turnpike Suite 102\nLake Bulahshire, IL 99570-7850	2025-10-22 04:40:09	2025-10-22 04:40:09
9da5cfe0-879e-4296-85cd-dfee6c885a54	Ms. Marlen Leannon	0503144917482	trace.brekke@example.net	72748518	6075 Flo Road Suite 136\nSarinaborough, CT 11746-1739	2025-10-22 04:40:09	2025-10-22 04:40:09
51befc13-fa09-4f61-9831-68b4dcc6f0e0	Keenan Stanton Jr.	6554053497170	scartwright@example.org	74303286	6431 Randy Village\nAngelineton, IA 38741	2025-10-22 04:40:09	2025-10-22 04:40:09
6bd8ac72-c57c-422e-bbd8-4a4112f3752c	Dr. Baron Bauch	9221638632788	korey.dickinson@example.com	72586772	1857 Kiehn Drives\nThielburgh, CO 45048	2025-10-22 04:40:09	2025-10-22 04:40:09
b29500b1-2b28-4e6c-9bce-01de64694ce1	Lonnie Glover	8247174436770	zemlak.reid@example.net	71239415	4835 Cassie Ramp Apt. 564\nBayerberg, DC 52816-5312	2025-10-22 04:40:09	2025-10-22 04:40:09
e991c31f-0596-4525-a2ae-8e2e9c6ed646	Barbara Labadie I	3454795191193	erik.bode@example.org	77019307	6522 Roberts Harbors\nAkeemstad, ID 71201	2025-10-22 04:40:09	2025-10-22 04:40:09
da73ea37-b58b-4129-8ce6-70673a6db16b	Arno Dietrich DVM	8405646811561	neoma.beer@example.org	72219593	32543 Deron Expressway\nReillychester, OR 26973-4433	2025-10-22 04:40:09	2025-10-22 04:40:09
5767a19a-4172-4fbd-b538-1d65d37ed15a	Mrs. Hettie Quigley	9557114513267	jairo.lehner@example.net	72800770	878 Marvin Points Apt. 998\nLake Kelley, SD 46389-8909	2025-10-22 04:40:09	2025-10-22 04:40:09
bf9fb8dc-323b-45d3-b2b6-79520a3be347	Vernie Wyman V	8506271784217	camylle72@example.net	75010895	46084 Hailey Plains\nLake Rhoda, MN 38214	2025-10-22 04:40:09	2025-10-22 04:40:09
810e5046-9373-42d3-8d65-2273222ebdc0	Cale Schultz	2890480601697	adeckow@example.org	74247454	12926 Cassin Pike Suite 534\nCreminfort, MT 15175-2936	2025-10-22 04:40:09	2025-10-22 04:40:09
89326a4b-51d0-4b4b-a751-c064e8cbcfc5	Ernest O'Reilly	7975038468845	grimes.samanta@example.org	77380697	8242 Efrain Summit Apt. 853\nWillaville, GA 66271-7183	2025-10-22 04:40:09	2025-10-22 04:40:09
0aa34572-d94b-4c1d-90a4-fa1991db051c	Prof. Allene Dibbert	7268037215302	tbradtke@example.com	72540686	4259 Liliane Green\nLake Lura, OR 60385	2025-10-22 04:40:09	2025-10-22 04:40:09
3a72de7c-dd64-45b3-ab54-eb2b50be7b44	Kristopher Buckridge	0823642296006	ghuel@example.org	75918501	8105 Brakus Island Suite 576\nLake Lennie, NE 64440-0153	2025-10-22 04:40:09	2025-10-22 04:40:09
d03f6adc-ec69-4894-a728-ec7f30a48f83	Nicholas Macejkovic	3972483028619	zakary.gerhold@example.net	77492714	89726 Bayer Land\nWest Emilio, AK 28856	2025-10-22 04:40:09	2025-10-22 04:40:09
352eb474-3747-459e-8c76-ad9868752791	Prof. Taurean Skiles	3083772350481	alphonso86@example.net	77264104	3095 Kaya Mountain Suite 163\nVontown, VT 17656-6376	2025-10-22 04:40:09	2025-10-22 04:40:09
56f1ff07-16eb-4f32-a018-149b4720e136	Tatum Roob	3085878937102	rodriguez.edyth@example.org	71784063	4324 Reynold Springs Suite 557\nHellerbury, WA 35775-7470	2025-10-22 04:40:09	2025-10-22 04:40:09
df041703-f34a-401d-a767-540134063b2b	Icie Ledner	2370307800825	gudrun.schultz@example.org	72258902	9944 McCullough River\nWest Goldaport, ME 26891	2025-10-22 04:40:09	2025-10-22 04:40:09
d1e59ae7-bc1f-4620-89a9-9ed9fc0959bf	Courtney Raynor	7504311448279	tomas07@example.net	76987873	190 Mann Lock Apt. 337\nSouth Sheldonchester, NM 31630-5831	2025-10-22 04:40:09	2025-10-22 04:40:09
86a44920-96a4-4520-83f6-ed412e917f55	Efrain Smith	2749855703973	qcrona@example.com	77594576	5845 Roberts Divide Apt. 452\nNorth Chesleyville, TN 43500	2025-10-22 04:40:09	2025-10-22 04:40:09
147802e4-6804-4038-aafe-abc7c0fec06f	Leif Anderson	6499570104288	ansel.kuhlman@example.org	70904602	828 Brando Junctions Suite 608\nNorth Elenaville, NH 51774	2025-10-22 04:40:09	2025-10-22 04:40:09
fe9e61b6-1adb-45ad-9216-0f525fdcb55a	Mr. George Corwin I	3364282330839	wprohaska@example.org	72148958	30006 Muller Mills Apt. 266\nWindlerton, CO 08371	2025-10-22 04:40:09	2025-10-22 04:40:09
c966655f-8dff-4c7d-be48-41e97463cf06	Maegan Emmerich	2879291768022	uharris@example.net	79509734	813 Bahringer Street Apt. 708\nKleinborough, MO 93185	2025-10-22 04:40:09	2025-10-22 04:40:09
e185883e-5b8d-4a8e-847e-98eaf6b3b887	Oceane Rau	3616852380481	heidenreich.geovany@example.org	75779135	256 Rex Locks Apt. 056\nEviemouth, OK 28351	2025-10-22 04:40:09	2025-10-22 04:40:09
d6dd5eaf-6784-420a-9a5c-1db83d48cc4e	Nadia Wunsch	4896795902479	morissette.laury@example.com	70777499	6832 Hoppe Highway Suite 840\nBertrandborough, KS 50112	2025-10-22 04:40:09	2025-10-22 04:40:09
f93526da-c381-4006-bb31-e8430a134b11	Cecilia Dach MD	1285359886376	ulises56@example.org	72759158	868 Else Run\nHettingershire, CO 85674-8210	2025-10-22 04:40:09	2025-10-22 04:40:09
d1b09fe1-f37f-4d19-8e49-40cea14610d6	Dr. Braxton Spinka	3909540533677	barry17@example.org	70930817	5385 Amely Orchard\nLabadieport, NY 70413-3868	2025-10-22 04:40:09	2025-10-22 04:40:09
6aa441af-59d4-48f5-82bf-1ff86c288ee5	Miss Gerda Zemlak DDS	3441957264436	davion91@example.net	70096594	69962 Pacocha Club Suite 435\nPort Luther, WV 79242-4781	2025-10-22 04:40:09	2025-10-22 04:40:09
b8fa7fd1-d2b4-46e1-acbf-1250410d82dc	Elsie Hammes I	9953417836304	akeem56@example.com	78772660	3445 Greenfelder Vista\nKuphalfort, NE 65869-1107	2025-10-22 04:40:09	2025-10-22 04:40:09
b1c57f01-2184-4af7-add5-1d97de70117f	Krystina Grady	5465357052480	sim46@example.com	74384712	98879 Juvenal Alley\nNorth Vinnie, FL 33887-6745	2025-10-22 04:40:09	2025-10-22 04:40:09
1a465688-24e9-47b9-9e42-1d57ee67c1c7	Kiera Terry MD	0626175036578	dibbert.hosea@example.net	77512745	1324 Colt Throughway\nStokeston, NH 48569-8798	2025-10-22 04:40:09	2025-10-22 04:40:09
147589f0-778d-44cf-94c2-9b856fd06b51	Jamarcus Kertzmann	6735046310411	ismael20@example.org	73562977	69274 Kraig Haven Suite 075\nSouth Allie, NJ 88323	2025-10-22 04:40:09	2025-10-22 04:40:09
4a22eb33-477c-44bd-8449-2bada6eb92a5	Ward Schimmel	4323124970238	mcdermott.sebastian@example.net	78727006	5675 Jamal Trail\nHeidenreichbury, VA 50611	2025-10-22 04:40:09	2025-10-22 04:40:09
b37c0212-3391-4970-8d36-7c44d3536ea4	Guiseppe Gaylord DDS	8564338927499	joanny.windler@example.com	75123700	3280 Little Burgs\nNew Maynard, VT 69111-0294	2025-10-22 04:40:09	2025-10-22 04:40:09
f3d02145-b718-41d6-8ade-2925d8ea85f6	Prof. Jimmie Armstrong	8401253046092	tdickinson@example.com	79127378	96629 Thora Ranch Apt. 155\nWalkerport, AK 95725	2025-10-22 04:40:09	2025-10-22 04:40:09
4d5de09a-b5ca-4010-8e14-b85128ca1c57	Minerva Kutch	4454177690235	ghowe@example.net	72738556	62756 Kenny Loaf\nEast Keon, OK 53138-9271	2025-10-22 04:40:09	2025-10-22 04:40:09
1f3e3578-7e14-42e4-8b15-edb74643d95f	Oda Denesik	0327593302154	twalsh@example.com	78873545	867 Quigley Union Suite 241\nEast Candaceside, WI 50969	2025-10-22 04:40:09	2025-10-22 04:40:09
7316d8d8-bf78-494a-a3d1-76d88ee77945	Lorna Wehner	5626067362826	chomenick@example.net	70795109	534 Frieda Route Suite 346\nOndrickaborough, MI 26203	2025-10-22 04:40:09	2025-10-22 04:40:09
3754e5d7-5661-4324-81dd-2993753cd080	Prof. Avery Brown	9435582423068	rterry@example.org	79017272	605 Maye Hollow\nLoritown, PA 45354	2025-10-22 04:40:09	2025-10-22 04:40:09
fcaff7db-b786-45eb-afa5-c99e43609de2	Jermain Zieme	9064590072666	rahul02@example.net	71163349	82233 Murray Glens\nNew Kanetown, VT 99378	2025-10-22 04:40:09	2025-10-22 04:40:09
6122abc3-6e04-41cc-ac81-86cf164b44c4	Dr. Kaitlin Kuhlman	2578044928967	smitham.idell@example.com	79321425	23681 Jamison Spurs\nSouth Brant, KY 08537-1703	2025-10-22 04:40:09	2025-10-22 04:40:09
b5868a84-f87c-4909-a782-741531c03d53	Prof. Adrienne Murphy IV	0413623561463	hoppe.edd@example.org	74290210	71420 Gibson Meadows Suite 012\nMarquisemouth, IL 33164	2025-10-22 04:40:09	2025-10-22 04:40:09
944c7c36-ccc5-48e0-bd5c-7da009c4eb40	Will Hegmann	1860813551570	norma70@example.net	78099689	3593 Ashleigh Station\nEstabury, AZ 96519	2025-10-22 04:40:09	2025-10-22 04:40:09
3314e233-3626-4826-b011-00261fdd2dac	Miss Maia Bergnaum V	6719484290196	ostark@example.net	74254199	1968 Gwen Trail Apt. 939\nNorth Maximushaven, AZ 57078-2066	2025-10-22 04:40:09	2025-10-22 04:40:09
777ba784-985b-4894-adb0-0a61911c5407	Miss Shana Oberbrunner	3759813555686	ward.cordelia@example.net	78073981	97605 Hudson Greens Apt. 760\nKerlukeville, AZ 58470	2025-10-22 04:40:09	2025-10-22 04:40:09
9c437a57-9559-46b4-a130-33b386bd2c08	Vanessa Cremin	7229385317141	jaycee12@example.net	71159426	8175 Schimmel Crescent\nRunolfssonton, TN 47308	2025-10-22 04:40:09	2025-10-22 04:40:09
5162d28a-3cfb-4b94-820c-0637fbd7e5fc	Vilma Friesen	6743383115640	sstreich@example.net	76104138	770 Hermann Bypass Suite 010\nBechtelarfort, CA 89086	2025-10-22 04:40:09	2025-10-22 04:40:09
b23f15cd-9b9a-4949-bced-994363f359e8	Arnold Mann	4238002477167	ellsworth26@example.org	79705038	80750 Emard Ports\nSatterfieldchester, WV 95370	2025-10-22 04:40:09	2025-10-22 04:40:09
ee6aa98b-420d-4ef4-abfb-318e19832eac	Elias Huel I	2238249024136	brent.denesik@example.com	75306070	73193 Hamill Gateway Apt. 627\nAmbrosehaven, NE 46432	2025-10-22 04:40:09	2025-10-22 04:40:09
71710459-aab9-4cdd-97a5-e48c29545aaf	Deron Leannon	2505198802353	boyer.keshawn@example.net	72288754	2649 Seamus Place Suite 584\nNorth Jacintheborough, DE 29669	2025-10-22 04:40:09	2025-10-22 04:40:09
b417c745-fd9b-42fc-9660-f9da5e0d2c65	Hawa BB Wane	1987654321098	hawa.wane@example.com	+221771234567	Dakar, Sénégal	2025-10-22 05:16:27	2025-10-22 05:16:27
1347865b-d151-4ba1-99c9-999d44d7f725	Mamadou Diallo	1123456789012	mamadou.diallo@example.com	+221701234567	Saint-Louis, Sénégal	2025-10-22 05:17:24	2025-10-22 05:17:24
a631f43f-0401-4166-b917-c4a38abb6889	Fatou Ndiaye	1234567890123	fatou.ndiaye@example.com	+221761234567	Thiès, Sénégal	2025-10-22 05:18:17	2025-10-22 05:18:17
99982406-b20f-4cfe-9558-f41b4791cd69	Ludie Miller	0163923617246	rgrady@example.org	78760789	47824 Powlowski Grove\nNew Stellaport, NC 54259	2025-10-23 10:59:11	2025-10-23 10:59:11
54882760-d36d-4a76-960d-d7a403e13137	Christina Funk	0304412355994	rosinski@example.net	70589899	5368 Will Turnpike\nZolafort, WA 29057-7419	2025-10-23 10:59:12	2025-10-23 10:59:12
5f8a767a-cb5d-475d-b1de-e7bd57e8780d	Hal Schmeler	8857655859260	kohler.triston@example.com	74678121	642 Jeanie Field Suite 780\nWest Cindy, IA 48505	2025-10-23 10:59:12	2025-10-23 10:59:12
b1a544b2-a3ee-4770-8c4c-28bc5bb8afdd	Willy Cummerata	2487384246638	malvina05@example.org	75845327	8727 Bergnaum Light Apt. 633\nEmardville, VA 57108	2025-10-23 10:59:12	2025-10-23 10:59:12
8da18411-f9b5-409f-9c90-d45bb40fb73b	Shyann Lubowitz	0692024494096	pdavis@example.net	73126701	72932 Langworth Route Apt. 015\nPort Gabriella, ID 02301-2437	2025-10-23 10:59:12	2025-10-23 10:59:12
bcacf6a7-2920-486f-ba69-f45491b46912	Destini Powlowski	9255586085080	marc57@example.net	76923947	913 Aubrey Club\nProvidenciview, PA 66046	2025-10-23 10:59:12	2025-10-23 10:59:12
9d78ac0b-af96-4268-8af1-3b84c4a87b98	Tillman Schumm	9593109180754	carolyne04@example.org	74558970	79536 Jovani Locks Suite 628\nKoelpinside, MT 55468-7413	2025-10-23 10:59:12	2025-10-23 10:59:12
1353359d-ad23-44d4-bb0a-2202c8e87f75	Quincy Cummings	2767883727182	bgrant@example.net	79136111	764 Harber Curve Apt. 632\nEudorafurt, NC 11342	2025-10-23 10:59:12	2025-10-23 10:59:12
80b4336e-373e-442c-aec5-e13abaa78095	Aylin Bednar	6629687738142	ymertz@example.com	70495034	442 Leffler Burg Apt. 533\nMarksland, NC 43210-3488	2025-10-23 10:59:12	2025-10-23 10:59:12
1646e3d1-ee65-4e92-a76e-b300cee2402d	Stephen Feeney	6403423635208	vnitzsche@example.com	73479592	9739 Annabelle Prairie Suite 888\nNorth Edgardo, IN 14229	2025-10-23 10:59:12	2025-10-23 10:59:12
f73a560f-9ebf-4d55-9986-b737796a60f1	Cordia Murazik	0326155816219	myrtle77@example.com	78672738	432 Tremayne Parkway\nO'Keefebury, DE 65833-5028	2025-10-23 10:59:12	2025-10-23 10:59:12
f2cb4304-c1d2-4d0b-a68a-ffad6cfacca5	Yazmin Heathcote	0697890608653	gregoria.donnelly@example.net	70701079	59892 Antoinette Track\nSibylfort, KS 65735	2025-10-23 10:59:12	2025-10-23 10:59:12
bcd58031-fa35-4f1f-bd33-85c8545aff45	Cyrus Luettgen	3903473969348	althea07@example.org	76570564	21189 Rene Coves Apt. 220\nSouth Leonor, DE 02280	2025-10-23 10:59:12	2025-10-23 10:59:12
775b50ae-6051-436b-aa1e-0a34b223cbb5	Stephan Waters Sr.	6459675566984	emanuel31@example.net	75323511	91122 Barton Overpass Suite 496\nHamillfort, SD 12435	2025-10-23 10:59:12	2025-10-23 10:59:12
253faeec-5732-45c5-9f3b-9bfb71809282	Millie Bernhard	1893303326951	santiago07@example.com	79816874	4074 Kiehn Squares Suite 659\nEast Camylle, NM 80571	2025-10-23 10:59:12	2025-10-23 10:59:12
5c0038c3-020a-4d52-a5ff-ab344bb8f784	Sheila Lockman Sr.	2773861980359	srowe@example.net	71196670	5648 Jacobson Points\nEast Eloisa, DE 74860	2025-10-23 10:59:12	2025-10-23 10:59:12
db91fa9f-28fb-40d9-a6a4-bb02f17fcbc9	Linnie Pagac I	7582183890755	nmann@example.com	78459200	1108 Armstrong Vista\nCarolborough, OR 87185-7985	2025-10-23 10:59:12	2025-10-23 10:59:12
608007af-54ef-4096-bd1c-f21c0cd4bf28	August Langworth	4054459679758	gromaguera@example.com	72941247	92232 Streich Estate\nLake Hollismouth, VA 87528-4523	2025-10-23 10:59:12	2025-10-23 10:59:12
765466f3-a8ca-4ad2-a3bf-c1413059c4bf	Kylee Conn	3010619668341	kspencer@example.net	79625676	6390 Robel Lodge\nLake Helga, RI 38770	2025-10-23 10:59:12	2025-10-23 10:59:12
d06cc0ae-5d4b-45db-96a0-b6fc53e57fc7	Caden Reilly	4638604999352	zulauf.isabel@example.org	75985998	49094 Joesph Well\nWest Jonathantown, MO 17389-4667	2025-10-23 10:59:12	2025-10-23 10:59:12
1aca3b3f-abd9-4e23-a94f-936cce30e0e5	Marianna Bernhard	8983546086447	bsporer@example.com	73791996	3830 Felipe Motorway Suite 900\nLake Cobyfurt, DC 84596-6566	2025-10-23 10:59:12	2025-10-23 10:59:12
2b1645a1-620d-438e-bfcf-9759773d00b9	Mina Skiles	9379787280835	zwest@example.net	73748009	655 Walsh River\nRowestad, AL 11332-7997	2025-10-23 10:59:12	2025-10-23 10:59:12
516355b3-e848-43ae-ad6e-8b856ba05b00	Kaylee Friesen	1300915827577	schmitt.hailey@example.net	75154145	8797 Bulah Pines Suite 153\nMcGlynnberg, AK 83939	2025-10-23 10:59:12	2025-10-23 10:59:12
a14ee34b-cf1c-411f-89f7-867f23a52c6f	Hazel Zieme	4192188899862	grutherford@example.net	79960024	42261 Lueilwitz Overpass Apt. 210\nLake Meaghanmouth, RI 01761	2025-10-23 10:59:12	2025-10-23 10:59:12
4d15c1eb-3c36-47ea-990f-7aba19d33c01	Larry Gulgowski II	5969587437016	hane.brain@example.net	76616564	721 Mandy Place Apt. 092\nNestorburgh, ID 05811-3398	2025-10-23 10:59:12	2025-10-23 10:59:12
dabf9799-88ab-4c61-b07c-7dce6f42d704	Reid Wolff DDS	7324903390470	chad.okon@example.net	70784551	63879 Maiya Highway\nMcLaughlinbury, OH 39025	2025-10-23 10:59:12	2025-10-23 10:59:12
3f8896bf-70c3-4635-b1ff-974f72133f66	Delfina Collier	7964290056521	kale.schoen@example.com	71856106	82621 Hills Estates Apt. 872\nVictorport, UT 90243-2214	2025-10-23 10:59:12	2025-10-23 10:59:12
953fc06d-59e5-4279-b8b4-8e61c3bd37d9	Ramiro Hills	2865416768409	jessica25@example.org	72360320	77133 Arturo Mill\nLavernefort, IN 04024-0254	2025-10-23 10:59:12	2025-10-23 10:59:12
2b834aff-cbd6-47e3-bf74-9fc1fd65b151	Hollis White Sr.	3359806045312	iboyle@example.com	71507878	32313 Rutherford Circles Suite 133\nRashadborough, VT 64931-9844	2025-10-23 10:59:12	2025-10-23 10:59:12
ee116291-aa96-43bc-9f36-b07f22d7c1ff	Abbie Gerhold	4209361461213	dcrooks@example.org	77089691	3736 Larson Crossing Apt. 099\nEast Vincent, GA 72218	2025-10-23 10:59:12	2025-10-23 10:59:12
11bab41b-7c5c-499f-b6da-aea5ffd88927	Warren Quitzon II	1178455016294	kennith73@example.org	76023087	492 Susana Falls Suite 559\nChristiansenland, OH 27312-2761	2025-10-23 10:59:12	2025-10-23 10:59:12
3be51def-3a7e-48f0-a997-f0f7a67c71fd	Issac Kautzer	9309385039790	bschulist@example.org	75226657	606 Caleb Course\nEast Marty, WY 04652-0624	2025-10-23 10:59:12	2025-10-23 10:59:12
fec5675e-c248-4fb8-b9b7-7699e60c626d	Mrs. Sierra Daniel II	3058322404853	pthiel@example.net	79718982	987 Myron Viaduct\nPort Elisabethtown, WV 80777-3975	2025-10-23 10:59:12	2025-10-23 10:59:12
c5d4defa-2049-4f5e-88e2-b6dd398ec919	Dr. Marisol Bins	2279721320270	ehegmann@example.net	79188566	126 Rahul Loop\nPort Fletaport, MS 42591-9153	2025-10-23 10:59:12	2025-10-23 10:59:12
c399c020-ed92-4eff-bb1a-ab15638f094e	Ron Heathcote PhD	4359027536561	camylle.schimmel@example.org	78053887	834 Demetris Wall\nSouth Clayview, KY 18892	2025-10-23 10:59:12	2025-10-23 10:59:12
2f4712a5-d6e1-4a2f-a94b-a67cbca46035	Dario O'Reilly	9292300951910	bernardo.gusikowski@example.org	77597468	5280 Fae Mall Suite 860\nWest Amy, NJ 12776-3936	2025-10-23 10:59:12	2025-10-23 10:59:12
ec4c86e5-4e27-4f11-b3ac-d76e51a7fd8c	Cornell Skiles	2969574880677	kkoelpin@example.org	79783996	85636 Pouros Trafficway Suite 749\nStammport, WI 03445-9317	2025-10-23 10:59:12	2025-10-23 10:59:12
56937b38-3691-4975-a8d7-1995835dc7d0	Krystel Botsford DVM	0011243494580	bernier.mario@example.org	79433164	59884 Orn Spur Suite 621\nWest Kyle, WV 58023	2025-10-23 10:59:12	2025-10-23 10:59:12
137fae38-ff96-4ec9-a14e-7fd1f1ac316c	Valerie Jaskolski I	0509182368826	lillie33@example.org	74421864	35808 Bennie Mountain\nEast Lilianemouth, NC 62881	2025-10-23 10:59:12	2025-10-23 10:59:12
809f64b5-852f-4bd8-bc92-21beb24a4117	Prof. Emerson Bednar	2329634076769	wilfrid35@example.com	78127093	5999 Aditya Run\nJacobsmouth, MT 81979	2025-10-23 10:59:12	2025-10-23 10:59:12
84c4d501-93ff-4a50-bb9c-24eadd9eff86	Kade Larkin	8386107836103	nick.marks@example.net	78527339	243 Icie Stravenue Suite 628\nBoehmbury, OK 07333-1804	2025-10-23 10:59:12	2025-10-23 10:59:12
ab3a556e-d8d7-4f04-b0df-8c37e535f091	Thad Waelchi Sr.	2834510096234	wturner@example.com	73605901	486 McClure Inlet\nLake Mackenzie, MO 23435-7120	2025-10-23 10:59:12	2025-10-23 10:59:12
d53bd01e-ad5d-4a7e-b7ce-549dc914d751	Mrs. Marjolaine Medhurst	7421138743103	myra.nolan@example.net	72085996	67954 Zboncak Curve\nGlenton, TN 82099	2025-10-23 10:59:12	2025-10-23 10:59:12
0d53b67c-716d-46db-912b-bb4323ed42c6	Eduardo Hauck	8694421814268	sasha01@example.org	77868290	53962 Von Keys\nBrisaborough, WA 17943-7563	2025-10-23 10:59:12	2025-10-23 10:59:12
ea54383d-cffe-478b-b9e7-3ed43a8ba1b4	Arno Weimann V	8523806573113	alana.satterfield@example.net	79343480	743 King Squares\nAndreanneborough, DE 14407-7487	2025-10-23 10:59:12	2025-10-23 10:59:12
94882288-1e0b-4f1b-844a-62202b21af9e	Ms. Cheyanne Koss	6866718182441	peyton25@example.org	74790363	11731 Laney Causeway\nSouth Othatown, AL 54219	2025-10-23 10:59:12	2025-10-23 10:59:12
625679b3-24d1-4d02-b741-89b63c342f13	Mr. Jerrold Schaefer	7299464841916	hand.zion@example.com	73121716	13454 Wolf Road\nBruenchester, FL 86328	2025-10-23 10:59:12	2025-10-23 10:59:12
dbd9f4a0-9d1d-4890-8d3b-970959db5bee	Deven Zieme	7199720554166	ettie.erdman@example.org	71160079	95140 Devyn Shore Apt. 350\nNorth Roslynbury, NV 75152	2025-10-23 10:59:12	2025-10-23 10:59:12
5504a004-c6d4-4849-b555-73e24eb755d7	Prof. Maybelle Rath DDS	7315615803432	nicholaus49@example.com	79257286	332 Yasmin Locks\nPort Adachester, ID 22245-5946	2025-10-23 10:59:12	2025-10-23 10:59:12
f834d3a2-6c1b-4464-a167-7225dcd69968	Dr. Alf Schoen DDS	0391467107531	bmcclure@example.org	74011633	974 Eunice Hill Suite 755\nDachview, OR 95919-9473	2025-10-23 10:59:12	2025-10-23 10:59:12
d32bdaf3-62e1-4ecc-bf56-23130b1e50af	Enola Carter	2256404154786	fkeebler@example.com	74423777	344 Ebert Forges\nRoobland, WY 64083-5319	2025-10-23 12:36:42	2025-10-23 12:36:42
13a57b1c-5a9f-4e0c-935c-4c1c75ee7f62	Prof. Amy Ryan	3225595290702	cschowalter@example.net	70809506	73511 Elyse Trafficway\nWiltonside, LA 97292	2025-10-23 12:36:42	2025-10-23 12:36:42
e40bffd4-135b-44de-aa32-b9a6442003b6	Electa Wilderman	6983487169456	otto62@example.net	76865171	11830 Elissa River Suite 450\nPort Ellsworth, WV 96064	2025-10-23 12:36:42	2025-10-23 12:36:42
f5b5e6cc-59f2-4657-809a-41568231c4d8	Zachary Kuhlman	8085504344018	senger.amely@example.com	75039048	85131 Hintz Neck\nSouth Diamond, WA 58383	2025-10-23 12:36:42	2025-10-23 12:36:42
8648bcd0-b47c-41fc-9ebc-44865abf911b	Tara Dietrich	7332528456677	huel.karli@example.org	72937292	86814 Heaney Shores\nEast Anaisville, AK 75552-3294	2025-10-23 12:36:42	2025-10-23 12:36:42
f2f93c52-87a7-4f9b-a013-b36d2c65222d	Mrs. Clara Mueller PhD	6329401659404	winnifred.collier@example.com	70007659	494 Lexus Ramp\nArmandoborough, MI 07851-1977	2025-10-23 12:36:42	2025-10-23 12:36:42
18d75213-b637-4adb-916b-7cac68fe535f	Mr. Clay Legros	1088635544310	annalise.heathcote@example.com	75510175	1099 Alfreda Unions\nPredovicside, NH 42435	2025-10-23 12:36:42	2025-10-23 12:36:42
46e7c889-84f5-49c1-ae8f-0ed4a705e315	Ibrahim Rau	8242957720599	wiley.padberg@example.org	73726603	930 Norene Views\nWest Salma, IL 99433	2025-10-23 12:36:42	2025-10-23 12:36:42
e0e5c109-aee3-433d-abd1-3d640a89c852	Lauretta Lebsack	2817699457220	gardner77@example.net	76461727	77446 Graham Mountains Apt. 854\nNew Rylan, RI 96030	2025-10-23 12:36:42	2025-10-23 12:36:42
bd0eb4d8-7bbd-4f2f-bfa3-ea8790f8272a	Stephen Reichert	8337739155692	tiana.tremblay@example.org	76601918	83991 Abigayle Fords Apt. 196\nWest Kimberlymouth, GA 93556	2025-10-23 12:36:42	2025-10-23 12:36:42
a1095246-27d5-449f-953d-2dc925fddcdc	Mr. Karl Leuschke	0225517914506	roderick68@example.net	71510961	322 Chelsie Road\nLillianland, ND 91485-8934	2025-10-23 12:36:42	2025-10-23 12:36:42
2d2a67f9-5c80-4f47-b974-5371224309a9	Paxton Schneider	9206496062566	gusikowski.layla@example.com	79148172	26863 Keeling Meadows Apt. 514\nWest Briceshire, NJ 18261	2025-10-23 12:36:42	2025-10-23 12:36:42
c75405f9-2b2a-4928-bef0-6ea4e6ff4779	Prof. Burdette Kemmer V	6191008198580	blair.waters@example.net	71957402	7015 Genevieve Extension\nWest Bertahaven, GA 15567	2025-10-23 12:36:42	2025-10-23 12:36:42
518912d2-d98f-4e97-911c-d00b8ba28e44	Jeanette Nikolaus	0683982472172	chanelle86@example.com	71707109	28069 Hattie Harbors Apt. 339\nEast Dasia, IL 29743	2025-10-23 12:36:42	2025-10-23 12:36:42
c369357b-b9dc-4d98-9039-030a8fefb4e3	Vince Cronin	6358631411295	danial.stracke@example.net	74162502	652 Runolfsson Groves\nNorth Michellehaven, MN 80857	2025-10-23 12:36:42	2025-10-23 12:36:42
17a02934-6c53-4993-85b6-77b7c54cea0d	Luigi Monahan	1372498000737	brandyn68@example.net	76886153	71333 Vivien Avenue\nWest Casperbury, AK 43981	2025-10-23 12:36:42	2025-10-23 12:36:42
a5c554f1-600e-4fc5-aa2b-802bf47ac1ce	Oscar Lebsack Sr.	2686228166338	germaine.hegmann@example.org	73836493	145 Elian Valleys Suite 046\nWehnerville, AK 34095-8632	2025-10-23 12:36:42	2025-10-23 12:36:42
2470e530-0daf-49d1-af4b-040aaa5e9b91	Stevie Gerhold	0194793912884	lisa.hansen@example.org	73492605	72609 Alysha Terrace\nNew Corbin, IL 74748-8148	2025-10-23 12:36:42	2025-10-23 12:36:42
b9cbc96b-8553-4385-adb1-7953ccb5759b	Jayme Marks	6041479198676	blanda.nichole@example.com	71140937	74883 Sawayn Forges\nWest Keara, KY 79653-5658	2025-10-23 12:36:42	2025-10-23 12:36:42
f0dd905b-951f-4c83-aeb4-84057d13562d	Mona Towne	1557862450329	rowe.bertrand@example.org	71485622	3375 Enoch Crest Suite 684\nNorth Marilie, NJ 39176-1988	2025-10-23 12:36:42	2025-10-23 12:36:42
b1a30a60-859e-4f2e-b28e-4f80dfb36f24	Robin Renner	9641416224631	hazle64@example.org	72780420	314 Wilkinson Island\nWest Callieview, LA 79602	2025-10-23 12:36:42	2025-10-23 12:36:42
9f211bf1-a3e6-4912-8f24-f482fa90dfb6	Jessy Green V	8323940363963	hartmann.guido@example.org	73863147	99498 Angus Pass Suite 849\nPhoebemouth, MI 66828	2025-10-23 12:36:42	2025-10-23 12:36:42
a00d36ba-e9d3-429e-a133-0c7af3f178b6	Edison Nienow	7829320100188	sarina.smitham@example.org	78367436	6462 Gregory Crossing Apt. 615\nKameronfort, TX 36621-3595	2025-10-23 12:36:42	2025-10-23 12:36:42
969d68dc-ceb8-4b83-ba0d-3bd467e9b1a6	Prof. Jeramy Fadel	5624500395209	amckenzie@example.net	75060280	7265 Hackett Isle\nNorth Foster, ME 15706-6476	2025-10-23 12:36:42	2025-10-23 12:36:42
7e5fde02-fd3a-440f-b80d-a41c5c006961	Jannie Keebler II	0037666665169	arno93@example.org	72429934	610 Rolfson Lake\nGreenport, OH 87810-1523	2025-10-23 12:36:42	2025-10-23 12:36:42
b0ce1d42-0fdc-4a07-91c4-9261254e228f	Amina Bins	5125247423790	justice49@example.net	79677377	9218 Bednar Orchard\nSouth Hudsonmouth, AL 73111	2025-10-23 12:36:42	2025-10-23 12:36:42
701e68cf-430c-454b-8606-d4195a9df744	Kadin Thiel I	4102593503886	ngottlieb@example.org	72663776	602 Littel Islands Suite 666\nHeidenreichshire, UT 95735	2025-10-23 12:36:42	2025-10-23 12:36:42
17150007-f034-40a3-9f85-db054f6ae724	Mrs. Ressie Gleichner	3630936240987	edward.torphy@example.com	75078079	248 Monahan Trail\nWest Fritz, OK 38633	2025-10-23 12:36:42	2025-10-23 12:36:42
aa6c75d9-129d-4b73-a7c9-ec1688de8d15	Alisa Mann	3760817461203	epadberg@example.net	77651856	69720 Dallas Estate Suite 147\nEast Warrenville, VA 19994-6035	2025-10-23 12:36:42	2025-10-23 12:36:42
97899989-feac-415d-af41-d39eb6941db5	Dr. Hattie Lebsack II	7266561981743	bogisich.emmitt@example.net	70525337	243 Reichel Club Suite 280\nDietrichchester, CT 89192	2025-10-23 12:36:42	2025-10-23 12:36:42
58a44965-8297-40fe-8507-02f3263f8de4	Johnathan Kerluke	2029305023904	gibson.adriel@example.net	70795468	3859 Modesta Mills Apt. 061\nLake Dillon, MS 10305	2025-10-23 12:36:42	2025-10-23 12:36:42
570e0f3c-3884-4e26-857c-4006cc660046	Eliane Shanahan	9582948991858	gianni20@example.com	71197265	71697 Mills River Apt. 390\nStammview, MA 90881	2025-10-23 12:36:42	2025-10-23 12:36:42
90c35c37-1b90-4b69-bcb8-c714c3488ac0	Kayli Ryan Jr.	3623609946708	skub@example.com	71813364	92066 Muller Lodge\nNoahstad, RI 58439-9314	2025-10-23 12:36:42	2025-10-23 12:36:42
259a3cb5-5a3a-4c0d-b4ff-f9ddb3c66fa2	Anthony Kuvalis	0106239521063	nhamill@example.com	78597649	5647 Champlin Walk Apt. 649\nLake Kaylie, VA 79797	2025-10-23 12:36:42	2025-10-23 12:36:42
0d7b7821-c94e-45b2-8a4f-70fc12d963e6	Dr. Jordon Rutherford III	9826855211508	violet.purdy@example.com	75893938	23136 Torp Groves Suite 999\nEast Jeffry, MN 48343	2025-10-23 12:36:42	2025-10-23 12:36:42
e6b85ec9-ad26-4a8a-ba63-bbf299bbdf0b	Burdette Bergnaum	8783746630588	ottis.hegmann@example.net	73471753	67697 Lionel Skyway Apt. 122\nSouth Archibaldport, WV 67482	2025-10-23 12:36:42	2025-10-23 12:36:42
43df25aa-b0de-4704-b743-8f3a3ee54c83	Allan Okuneva DVM	6398768300191	cloyd.hettinger@example.org	74964790	711 Lesch Viaduct\nPort Jacquelynport, MD 28637	2025-10-23 12:36:42	2025-10-23 12:36:42
5305ea3d-9c75-47a3-b96a-097065c7c601	Kaelyn Murazik	4100757961246	prippin@example.org	70342396	70569 Bogan Locks Suite 135\nSouth Guillermomouth, CA 10119-3367	2025-10-23 12:36:42	2025-10-23 12:36:42
779b68b2-38af-4b6b-90b6-e6f6ef07fec4	Ms. Jazlyn Cummings Jr.	6505295840768	kaleb.tromp@example.net	72982992	38987 Barton Orchard Apt. 362\nPort Bentonton, DC 44957-9048	2025-10-23 12:36:42	2025-10-23 12:36:42
b9513cd6-79cc-451b-965b-f3de1b98c32c	Freda McClure	1844496357471	grenner@example.org	77824073	2980 Homenick Harbors\nLisafurt, AZ 65587-5699	2025-10-23 12:36:42	2025-10-23 12:36:42
5b219ac7-db4d-4180-a8dd-6bda2993d10d	Prof. Joe Gulgowski DVM	5635099618850	wokon@example.com	79768959	245 VonRueden Crossroad Suite 988\nWest Breanne, ME 11981	2025-10-23 12:36:42	2025-10-23 12:36:42
0c63095d-af8c-4e42-8a41-e6289a5a0bb6	Pedro Johns	5181229784573	amckenzie@example.org	73593796	7835 Harvey Turnpike\nKeelingside, HI 50627-1416	2025-10-23 12:36:42	2025-10-23 12:36:42
441e192e-9087-4011-81c5-5558b1be392a	Prof. Marta Gutkowski Jr.	7171721294452	nwaelchi@example.org	77652356	2582 Nash Stream Suite 844\nWest Cornellland, AR 03480-9009	2025-10-23 12:36:42	2025-10-23 12:36:42
d2d5a94a-49ae-4d53-9639-20dcca3e7ea9	Marcelino Durgan	4501824565148	damien56@example.org	74993655	5073 Crystal Lights\nDouglasport, UT 49908-0692	2025-10-23 12:36:42	2025-10-23 12:36:42
695f9c44-4d17-41f4-aad3-57572a0fc621	Daniella Mitchell	4370387098239	schuster.berneice@example.net	77201747	54116 Mohamed Passage Suite 324\nJaidenborough, PA 59258-0513	2025-10-23 12:36:42	2025-10-23 12:36:42
66cd9370-f827-4b9f-9957-02f350738e59	Oran Dare	2471560648192	reece.torphy@example.net	79908853	32129 Grace Cliff Suite 645\nWest Nolan, AR 47126	2025-10-23 12:36:42	2025-10-23 12:36:42
18e61342-47ac-4210-8211-ce204aaafb4e	Adrianna Wunsch	6108097076035	myron58@example.net	76050683	4776 Feeney Locks Apt. 572\nBreitenbergstad, TX 94603-8556	2025-10-23 12:36:42	2025-10-23 12:36:42
fa0f81b3-6bfa-4f64-b165-3a447f5bf298	Leda Pacocha	5381907497722	corine20@example.com	79597700	58111 Cummings Causeway\nMalindaborough, IN 52241-1593	2025-10-23 12:36:42	2025-10-23 12:36:42
240eac98-f488-4e39-9792-444cec93cade	Vincent Schowalter PhD	7638905794121	declan99@example.com	70823797	408 Crystal Corners\nNigelberg, CT 87234	2025-10-23 12:36:42	2025-10-23 12:36:42
7797a06c-bec6-4875-a3c2-4415545512be	Dr. Claud Stark V	3905461256181	wilton.metz@example.com	76893423	81831 Kessler Ports Suite 964\nGrahamchester, KS 96443-6045	2025-10-23 12:36:42	2025-10-23 12:36:42
d64303e5-0889-4e00-a429-08391fdf6344	Lamont Donnelly	0749427040755	murazik.viva@example.net	74625815	2629 Deja Summit\nJastburgh, IA 38867-4881	2025-10-23 12:36:48	2025-10-23 12:36:48
be7f8045-6242-4e77-ba75-75735db95e9d	Weston Hill	1257102891089	heaney.domenick@example.net	79542017	257 Hollie Inlet\nWest Amani, WI 86931-8526	2025-10-23 12:36:48	2025-10-23 12:36:48
f3bd1f90-e7fc-493f-8931-d16766f9ba7b	Kyra Bradtke	4741245758137	rhermann@example.net	71708321	85862 Gutmann Stravenue\nNorth Sylvesterstad, WV 52923-9548	2025-10-23 12:36:48	2025-10-23 12:36:48
f90fd66e-9a29-438f-adff-989e2e8099ea	Bette Leannon	8458241614918	beier.nelda@example.com	75052458	3519 Rath Burgs\nNorth Melodymouth, WA 96347	2025-10-23 12:36:48	2025-10-23 12:36:48
2774f358-8b25-4f61-a096-348dee14c533	Brannon Olson	9941995578152	jalyn.ratke@example.net	73021491	32051 Terry Crossing Apt. 187\nWest Gisselle, NY 37022-0787	2025-10-23 12:36:48	2025-10-23 12:36:48
74d3477a-eb07-43ab-9379-05c3a67a8f37	Prof. Garret Bartoletti II	7087026662707	esta.towne@example.com	70335592	21023 Lavina Expressway\nNew Anibal, AL 41668	2025-10-23 12:36:48	2025-10-23 12:36:48
189c3ac4-3fc3-4323-8084-cfb2d618dadb	Vilma Gislason II	6469418705290	oran66@example.com	77131909	246 Stoltenberg Groves\nMarionfort, NJ 73074-1455	2025-10-23 12:36:48	2025-10-23 12:36:48
4493e725-e510-460e-a232-eee311e89289	Mrs. Eleanore Kozey Jr.	6143858106307	cronin.elroy@example.org	76609401	731 Sawayn Centers Apt. 981\nWest Gillianton, ND 22896-0851	2025-10-23 12:36:48	2025-10-23 12:36:48
227adbca-8d48-4101-854c-40a47c99d138	Brannon Adams	3729239205528	rutherford.jamaal@example.com	76505405	4785 Magdalena Flat\nKaelyntown, IA 44993-6145	2025-10-23 12:36:48	2025-10-23 12:36:48
fabb0b79-d834-478d-b073-ef94c703aca0	Mr. Felton Bartoletti	9812025508996	laney.west@example.org	78619397	483 Weldon Fields Apt. 466\nWest Borisview, MD 12259-3165	2025-10-23 12:36:48	2025-10-23 12:36:48
5ec6b5c2-c08d-4a08-ae74-c820dad049bb	Amari Medhurst	2096919469146	leonie47@example.net	78965371	564 Beier Turnpike Apt. 415\nLake Hal, AR 35508	2025-10-23 12:36:48	2025-10-23 12:36:48
56f4c0cc-dc2d-44ad-b7bf-ce8a6d06e396	Mr. Ashton Hahn Jr.	6087877208049	derick.jast@example.org	74594332	878 Daniel Manors\nNorth Bertrammouth, AL 64006	2025-10-23 12:36:48	2025-10-23 12:36:48
9a008823-fd5a-4572-9aee-4f913256b40d	Dr. Meda Welch	5890099515123	dallas.lakin@example.com	79693267	572 Champlin Knoll Suite 313\nLehnerchester, NY 48861-5594	2025-10-23 12:36:48	2025-10-23 12:36:48
e87409c9-0d61-40c7-95f3-ada7d8231197	Grace Goodwin	2437480824512	astrid28@example.com	73057629	86175 Maida Fork Apt. 896\nEast Tiaburgh, WI 33132	2025-10-23 12:36:48	2025-10-23 12:36:48
b6078137-f31d-420e-b5fe-a2a4d052ae43	Dr. Loma Kemmer MD	7673602010518	moen.mertie@example.net	73861887	76542 Michele Mission Suite 487\nBernieceside, GA 94460-8392	2025-10-23 12:36:48	2025-10-23 12:36:48
4cafd6f3-364c-4e99-9bbe-7d3d39193e98	Dena Rowe	7331330850085	schultz.marielle@example.net	77258714	311 Ervin Springs\nHansenfurt, MI 64112-2889	2025-10-23 12:36:48	2025-10-23 12:36:48
20e064f7-6c00-4c18-b60a-21bfb7ff987f	Prof. David Ebert	3922933793606	jerde.edward@example.net	72448604	69451 Kemmer Brook\nNew Christiana, OH 75592	2025-10-23 12:36:48	2025-10-23 12:36:48
0f63d569-95d8-406e-bbe6-3ac320fdfcca	Green Champlin	6252772811568	genoveva33@example.net	70165609	5378 Kertzmann Mountain\nLake Vivian, MI 43050	2025-10-23 12:36:48	2025-10-23 12:36:48
07d7bef7-47b7-4441-9aa6-de48b9c40cf0	Prof. Ralph Kautzer	2245707084404	manuel.barton@example.org	71333356	27337 Jaclyn Vista Suite 924\nHandberg, MA 82276-9371	2025-10-23 12:36:48	2025-10-23 12:36:48
28a2be62-5234-48b0-9470-13def4fd5952	Coleman Prosacco DDS	6101841664767	spinka.peyton@example.net	74331482	87834 Conor Greens\nKassulketown, LA 35927-9365	2025-10-23 12:36:48	2025-10-23 12:36:48
950a49b5-9832-475d-925b-c63bdc529483	Timothy Mante	4727073654713	brown74@example.net	73808074	339 Brooks Radial Suite 130\nMacejkovicstad, OH 77874-3824	2025-10-23 12:36:48	2025-10-23 12:36:48
e334f044-cbf8-4ece-846f-0caf94265a3c	Miss Kylie Hirthe	4895474539116	ehuel@example.com	73697322	9789 Bartell Ridges Apt. 946\nPort Winstonshire, MN 76919	2025-10-23 12:36:48	2025-10-23 12:36:48
66c884c3-122b-48fe-aa5b-1cc98a46807c	Americo Luettgen Jr.	0773410960116	ttreutel@example.net	71351761	863 Keith Isle Suite 901\nSouth Nyasia, AZ 46835-1089	2025-10-23 12:36:48	2025-10-23 12:36:48
f3fa1721-f9a8-4664-9922-d5504ba40c87	Sonya Gibson DDS	6438261299924	mcglynn.braxton@example.net	71814589	783 Korbin Port\nSchuppefort, IA 08596-9646	2025-10-23 12:36:48	2025-10-23 12:36:48
c89d8067-f233-437e-8196-998b558386cc	Kevon Cartwright	9909148874063	auer.lisandro@example.com	70430809	798 Wintheiser Corner\nNew Damionshire, WA 07034-0975	2025-10-23 12:36:48	2025-10-23 12:36:48
09e0f4ba-0b30-472c-ae3e-09d158543511	Ayden Koepp PhD	3774510551196	tremblay.christine@example.com	78921477	256 Arthur View Suite 522\nBretberg, IA 29385-3595	2025-10-23 12:36:48	2025-10-23 12:36:48
e8d0d439-43fd-4754-bf38-e1b4b79282eb	Aurelie Stehr	8396497020264	nkunze@example.org	76989422	53453 Tremaine Fields Apt. 047\nSouth Lloydburgh, WY 87470	2025-10-23 12:36:48	2025-10-23 12:36:48
f24f631e-6662-4968-b269-bc24c7889c34	Cassandra Baumbach IV	7174825749493	bailey.hans@example.org	70867297	1649 Jones Shore\nSouth Horacio, GA 68092-7100	2025-10-23 12:36:48	2025-10-23 12:36:48
173444b5-ac93-4e90-9f78-2d0041bf2acf	Rae Crooks	6531415594687	ullrich.jocelyn@example.net	72190511	324 Dan Wells Suite 332\nUllrichbury, ME 47696	2025-10-23 12:36:48	2025-10-23 12:36:48
fc6f527d-4c28-440c-b28a-461a65c53345	Miss Elsie Collins	0151628516907	kitty92@example.com	75980472	4911 Christy Crescent\nSchadenshire, AZ 94167-5327	2025-10-23 12:36:48	2025-10-23 12:36:48
7e6fbd7a-f685-40cc-9e5f-7d03b1906b0d	Dominique Ritchie	1922244914023	bnicolas@example.net	72717348	7721 Anjali Drive Apt. 576\nRolfsonview, IA 43746	2025-10-23 12:36:48	2025-10-23 12:36:48
11f1d6a8-f31e-4251-ad6a-b80a7be1e838	Gerda Tremblay	2437642529708	nmraz@example.com	73973551	205 Will View Apt. 034\nWatsicaside, ME 23760-8884	2025-10-23 12:36:48	2025-10-23 12:36:48
0720eab1-98a8-4e1c-89f7-d12594d65b22	Nelle Zboncak	3466151848269	gkovacek@example.net	70892120	69982 Deckow Curve\nNorth Waino, MO 40636	2025-10-23 12:36:48	2025-10-23 12:36:48
f5fdc916-b056-4ea5-9444-27c7603377c1	Cortez Dickinson	3727484948261	abelardo.halvorson@example.net	71606766	2409 Cartwright Stravenue\nNew Madisonview, FL 98078-5528	2025-10-23 12:36:48	2025-10-23 12:36:48
fbbb3214-44c9-4ec2-b132-802761ea7d77	Tatyana Klein	2288254477746	hammes.hildegard@example.org	73135222	9897 Aurelio Throughway\nSouth Tony, NM 80435-8608	2025-10-23 12:36:48	2025-10-23 12:36:48
e0e01e61-ef12-48d3-b0b7-6954f7b114b5	Aurore Osinski	8928762165361	eliza.brakus@example.org	71985041	424 Heller Parkways Apt. 813\nYasminburgh, VT 26400-3364	2025-10-23 12:36:48	2025-10-23 12:36:48
b7256906-ecc0-4097-9804-66884b69a96f	Gia Ritchie III	1127486782624	janessa64@example.org	75501031	70752 Zulauf Cove\nDomenickport, CT 25029	2025-10-23 12:36:48	2025-10-23 12:36:48
3de7bc15-7c4f-4f86-8160-af93888121d5	Faustino Thompson	8007445516982	conn.vidal@example.com	78137452	476 Imogene Courts Suite 503\nWest Estatown, NH 10480	2025-10-23 12:36:48	2025-10-23 12:36:48
30680227-333e-43e3-85b0-48886dcc9f3b	Baby Armstrong	8478821693754	fstroman@example.net	78304016	5038 Lexus Street\nKassulkeport, FL 62340	2025-10-23 12:36:48	2025-10-23 12:36:48
3b01b9f6-cf1f-40e7-a0f1-58b155c057bc	Jan Hoppe	9095442506403	etorp@example.org	71538495	17844 Jake Glen\nRomaineview, SC 60093	2025-10-23 12:36:48	2025-10-23 12:36:48
b566af75-88b8-4acb-81a2-f47f0a1534e0	Prof. Stacy Jacobi	5982986713586	wzulauf@example.com	71856643	5332 Einar Springs Apt. 743\nDenesiktown, CO 68145	2025-10-23 12:36:48	2025-10-23 12:36:48
4f6af01a-4996-47f9-a818-4dec5c0e01de	Kirsten Baumbach	6265282496545	schumm.agustina@example.org	70733929	81410 Hackett Glens Suite 774\nEast Soniashire, MD 33355	2025-10-23 12:36:48	2025-10-23 12:36:48
a60014fa-0410-4072-8e3e-1b3de32fb1db	Gaston O'Reilly IV	0455706012677	barrows.johathan@example.org	78432020	1148 Langosh Plaza Apt. 844\nKaraborough, FL 66078-3823	2025-10-23 12:36:48	2025-10-23 12:36:48
b26cfeee-3b3d-4c59-89f0-ac9c765d630a	Prof. Donnie Yost V	5779874540899	woodrow81@example.com	76020177	520 Donnelly Parks\nNorth Kelliebury, OH 02429	2025-10-23 12:36:48	2025-10-23 12:36:48
6954d4d8-8ab6-4dc8-a5e0-3cad534e5154	Lavern Stark	4218716478705	uhagenes@example.com	78188918	874 Tanner Lake Apt. 886\nEast Rodgerfurt, OH 34810	2025-10-23 12:36:48	2025-10-23 12:36:48
1559da65-b809-4ee8-ac12-49868ca42514	Jamison Prosacco	5089058589525	lucinda53@example.org	77931888	58165 Verda Skyway\nLake Halleview, SD 10887	2025-10-23 12:36:48	2025-10-23 12:36:48
c133c137-e152-44d6-a620-93284678a527	Charlotte Padberg MD	8070949031230	okeefe.betsy@example.org	79024335	700 Arlene Highway Suite 683\nSouth Rileyburgh, AZ 01523-6739	2025-10-23 12:36:48	2025-10-23 12:36:48
9a906672-ea5b-4bcb-b034-686e9bb10fe2	Mr. Berry Gulgowski	4808088832339	kuhlman.edison@example.net	77444105	191 Rath Crescent Apt. 741\nLake Hunterfort, IA 49792-8087	2025-10-23 12:36:48	2025-10-23 12:36:48
575d26c1-0813-4e84-8367-cede38ee69ed	Joe Kassulke III	2372088960035	jedidiah90@example.net	79846728	65704 Raina Crescent\nSouth Chanelstad, IN 00530	2025-10-23 12:36:49	2025-10-23 12:36:49
0b2c1a38-460d-400f-96a5-705bfd0e8c2d	Danika Ullrich PhD	6676428832044	dreichert@example.com	78523893	46542 Ned Rapids Apt. 075\nOsvaldoville, PA 76376	2025-10-23 12:36:49	2025-10-23 12:36:49
c2380284-2ef5-4752-9d33-c5afdc1bbc70	Ms. Santina Kuphal DVM	6931165819738	sylvan66@example.org	75170010	935 Gabrielle Estate\nPort Jannieport, NJ 23563-1627	2025-10-23 14:44:54	2025-10-23 14:44:54
9c6429b3-b9dc-4a70-9926-b99c4b889374	Greg Ortiz	2899348931278	nwillms@example.com	73766674	17928 Schumm Shoal\nLake Emelie, NC 88641	2025-10-23 14:44:54	2025-10-23 14:44:54
8f53cfca-6446-49ad-85a5-be27b573b63e	Arvel Barton	3496483324338	annabel58@example.org	73108218	677 Deborah Road Suite 856\nLake Price, MO 63645	2025-10-23 14:44:54	2025-10-23 14:44:54
9fc6c038-d712-491a-a9ff-41a32f5ff707	Prof. Jerome Mills Sr.	7733271976642	ulesch@example.com	70813101	32374 McKenzie Square Apt. 180\nWest Andreane, MI 99367	2025-10-23 14:44:54	2025-10-23 14:44:54
20564aa2-67ef-4152-93bb-e110cababf1e	Ms. Sylvia Roob	9281134820153	jayne.hickle@example.org	70375168	22600 Annamae Burg Apt. 761\nVellaberg, KS 09830-3495	2025-10-23 14:44:54	2025-10-23 14:44:54
883f34ee-9a30-4a34-8e0d-4b97e608e662	Tatum Kiehn II	8495289721778	camila.walter@example.com	73263570	5214 Nicolas Hills\nMyamouth, LA 14013	2025-10-23 14:44:54	2025-10-23 14:44:54
b65e3a40-9410-4252-8c2f-1d89ade02821	Ms. Daniella Waelchi DDS	6574904968647	kole.kub@example.com	71670563	30357 Stamm Place\nNew Nataliemouth, DC 21043	2025-10-23 14:44:54	2025-10-23 14:44:54
e2fd2e62-02d5-4eea-9ce1-4caf3b363182	Zoie DuBuque	9676429831868	hudson.helmer@example.net	77115002	9938 Kevin Summit\nJohnsborough, MA 40135	2025-10-23 14:44:54	2025-10-23 14:44:54
4eb1ecae-ebd4-4e46-a4ba-b49808e1250e	Esperanza Deckow	3285917735271	rhoda.wyman@example.net	72946936	108 Zemlak Trail Suite 186\nAlbertaton, CA 96094	2025-10-23 14:44:54	2025-10-23 14:44:54
eee6d77c-cb82-486d-8d99-8983fd023e67	Macey Wilderman III	0258386729440	aabbott@example.org	73741375	741 Okuneva Stream\nPort Sandytown, ND 16893	2025-10-23 14:44:54	2025-10-23 14:44:54
54e9ce95-fe73-488c-bf30-50f06df8c379	Sandra Dooley	9698104607310	kling.adah@example.org	74213933	528 Else Mills\nLake Sherwoodburgh, MN 82355	2025-10-23 14:44:54	2025-10-23 14:44:54
1e71fe7d-91af-4b43-9cdc-0e8613934f22	Prof. Danny Boyer	6840375461981	gjacobs@example.net	79274063	8323 Sauer Point Suite 586\nLake Amarimouth, DC 18149	2025-10-23 14:44:54	2025-10-23 14:44:54
2be8ff2d-4ab6-435f-8874-d29b5c092e39	Miss Salma Ondricka	1964570185224	klabadie@example.com	74750497	7336 Fay Underpass Apt. 359\nRogersbury, NM 36751-2292	2025-10-23 14:44:54	2025-10-23 14:44:54
585cd23d-f32f-4dc7-80ee-e0f294ec9384	Jazlyn Rosenbaum IV	0766574293424	tkoepp@example.net	72858236	897 Araceli Motorway Suite 502\nWest Lorenabury, NC 01062	2025-10-23 14:44:54	2025-10-23 14:44:54
1fd9e1b4-1c7a-4d14-bc52-62780323a201	Stuart Rippin	5439080121528	runolfsson.bertram@example.net	78324110	40188 Grace Passage Suite 375\nBaileyburgh, WI 41236-4443	2025-10-23 14:44:54	2025-10-23 14:44:54
f0faba84-8bc5-4704-a9f2-2e5f6d392c94	Dr. Casper Hand	5884047196891	douglas.dallas@example.com	71939393	901 Lera Mountains\nPort Russel, IL 33595-5572	2025-10-23 14:44:54	2025-10-23 14:44:54
5aac6f83-79a9-48b6-8a4a-782865f15711	Dean Abshire	9870208219326	rau.irving@example.com	70437239	99557 Tressie Ports\nBahringerbury, AR 66275	2025-10-23 14:44:54	2025-10-23 14:44:54
312bf9ac-ab47-4315-8a1a-09a6cc9135d1	Elwin Christiansen	8468660385008	constance.mueller@example.com	70477915	9639 Marlene River Apt. 253\nAndrewport, MD 15557	2025-10-23 14:44:54	2025-10-23 14:44:54
b4d97843-61e4-495c-b9b5-b7ac78eb212d	Tierra Bauch	1105697956060	joel33@example.com	75899194	4748 Jeanne Road Suite 384\nWest Itzelborough, AL 09683	2025-10-23 14:44:54	2025-10-23 14:44:54
8e9c0106-35ad-4b1d-91ad-6b53191f8cb8	Triston Friesen	8597695920575	fharvey@example.com	74955376	75437 Amparo Summit\nHilpertborough, OK 00814-4044	2025-10-23 14:44:54	2025-10-23 14:44:54
d7aa7097-b3ea-4c5f-b656-ab76b136ea47	Ian Frami IV	7990812646183	fchamplin@example.org	75737499	593 Metz Rapid Apt. 047\nMorissettefort, RI 35757	2025-10-23 14:44:54	2025-10-23 14:44:54
a7a361af-8205-4851-8129-1c2af68e185d	Jadon Denesik	3700056895059	lillie.prosacco@example.org	79196867	689 Giles Prairie\nAstridland, NC 37944-4662	2025-10-23 14:44:54	2025-10-23 14:44:54
38363bd8-1530-4842-a061-842163d5aeff	Cayla Emard PhD	4877332660559	windler.kimberly@example.org	71835778	659 Oliver Falls Suite 368\nHaileeborough, TX 81397	2025-10-23 14:44:54	2025-10-23 14:44:54
6fecd457-c9ab-4270-8ba4-15fe31e1d193	Amiya Hill	2879608413786	rath.asa@example.net	76353582	39011 Koepp Ville Apt. 197\nHilltown, ME 37104	2025-10-23 14:44:54	2025-10-23 14:44:54
1f220de4-cb0c-4700-bc06-d1dca2c1e26f	Filomena Schuster	2909146380829	kaleigh.cassin@example.com	70279965	4876 Lavonne Overpass\nPercymouth, VA 19001-1468	2025-10-23 14:44:54	2025-10-23 14:44:54
5defe0dd-28e0-435b-8c32-19857e7074d0	Frida Funk	4345459808255	maxine.russel@example.org	79413246	989 Cremin Path Suite 672\nWest Cooper, KS 58240	2025-10-23 14:44:54	2025-10-23 14:44:54
73fcf66d-7b0b-49d4-a0a5-89a7d7637567	Kali Hyatt	9019035486481	louisa82@example.net	73566107	811 Riley Mill\nMortonton, AZ 22733	2025-10-23 14:44:54	2025-10-23 14:44:54
c6acc860-3168-4f33-82d5-0a22bcfeb066	Mia Becker II	5479185271385	iwitting@example.com	77807839	4048 Herzog Crossroad\nPort Daija, ID 44627-0400	2025-10-23 14:44:54	2025-10-23 14:44:54
fd19cd7d-0bdf-409a-9d20-13e8f8eeebc9	Prof. Kasandra Heaney Sr.	0487949772122	ylesch@example.com	74818551	316 Howell Hill Suite 346\nLake Arnoldville, HI 25907-3740	2025-10-23 14:44:54	2025-10-23 14:44:54
b199f85b-0efa-4f5f-ada0-f29d7929afb1	Brisa Block IV	1509781238782	bbruen@example.org	74097569	3135 Arely Ports Suite 027\nEast Stefan, NV 90054	2025-10-23 14:44:54	2025-10-23 14:44:54
06e2bdf8-720c-484d-b9c4-ef0696c0e5d4	Marianne Stoltenberg	1343157475072	anader@example.com	70404140	8812 Raynor Path Apt. 480\nPort Ramonaberg, ID 24643-0105	2025-10-23 14:44:54	2025-10-23 14:44:54
ab1e1cc7-24f1-4d7e-988c-c8574b5757a6	Brady Romaguera	5742910248686	cassin.ernestine@example.net	73251766	93573 Louisa Glens\nKuvalisstad, OR 07506-6001	2025-10-23 14:44:54	2025-10-23 14:44:54
060bc4ff-0a57-4f77-addd-6d01c6b00411	Alize Wisoky	8192457687830	darrion.beahan@example.org	78277325	5526 Mraz Mews Suite 035\nEast Waltonton, MD 79563	2025-10-23 14:44:54	2025-10-23 14:44:54
b1d3dc1c-0da7-4a99-b36c-9c86b448b3a1	Efren Veum	3629301642952	wschmidt@example.com	74680925	6783 Rex Lane\nLabadiechester, NE 75944	2025-10-23 14:44:54	2025-10-23 14:44:54
08b5712e-2ebd-4308-b553-a6e6c8c874fc	Prof. Kadin Maggio III	3986498618678	ychristiansen@example.net	70801924	468 Cassin Course Suite 246\nMarcellamouth, ME 77446-9054	2025-10-23 14:44:54	2025-10-23 14:44:54
25b66ab5-4af7-4ef0-8666-a7e59910937a	Norval Haag	6986822182332	madelyn.vonrueden@example.com	77527911	8625 Sam Causeway Suite 621\nManleyshire, OH 28019	2025-10-23 14:44:54	2025-10-23 14:44:54
58aeccce-c992-48b1-8525-ceba74e0d984	Prof. Luis Dooley	0954991489656	eulah.lang@example.com	78074294	522 King Via\nNew Mohammed, NY 62163-1343	2025-10-23 14:44:54	2025-10-23 14:44:54
9f8d117b-9197-4867-84f3-1353fbba47b9	Ms. Aliza Braun	2204503980049	crooks.mariano@example.net	74429566	6682 Carroll Highway Suite 923\nNew Derekfurt, CA 97476	2025-10-23 14:44:54	2025-10-23 14:44:54
9018c601-008c-403d-8699-ef7a344f9693	Alexandre Sanford	6990040251331	abdiel.cummings@example.org	73270688	17071 Hettinger Creek Suite 873\nNorth Ryleighburgh, DE 66764-1539	2025-10-23 14:44:54	2025-10-23 14:44:54
310af7e2-459c-4389-95a9-2a14120a5d14	Miss Alicia Emard	0944841015431	madisen.klein@example.net	75777775	6546 Judd Turnpike Apt. 634\nChanceberg, WY 09212-2900	2025-10-23 14:44:54	2025-10-23 14:44:54
e408f8cc-48d4-4b05-ab31-51389d1974c3	Mr. Corbin Maggio	9663584084686	drunolfsdottir@example.com	71567115	7768 Lance Locks Suite 322\nEast Mike, DE 04098-5962	2025-10-23 14:44:54	2025-10-23 14:44:54
b26d5338-1b39-4b39-9187-d0d59502f042	Salvador Nienow	5258007499419	qkertzmann@example.net	72850611	5419 Skiles Gateway Apt. 548\nWest Jacky, CO 22266-8936	2025-10-23 14:44:54	2025-10-23 14:44:54
2d2149f4-4b01-4bef-bb7e-753dc082994f	Cindy Wunsch	5687798929658	kenton07@example.com	73204445	30801 Hermiston Corner\nDooleyfurt, MI 00062-2549	2025-10-23 14:44:54	2025-10-23 14:44:54
f97deb37-d4d0-475d-b79d-3977771e9145	Dr. Greg Bernier	5305247316912	sstoltenberg@example.com	74441165	49128 Marks Drive Apt. 163\nEast Zanderhaven, MI 15599	2025-10-23 14:44:54	2025-10-23 14:44:54
3e9a8a96-e0e8-4b46-8ef6-fe4a0e42604b	Tate Klocko	9918686110159	smith.philip@example.com	71382640	2018 Eldred Islands Apt. 384\nEast Tiana, RI 59133-7159	2025-10-23 14:44:54	2025-10-23 14:44:54
9a395d5f-8178-44f3-ae46-efab9bfb3d3e	Xander Pagac III	9935776034933	kcrist@example.org	72996058	1302 Stanton Spurs\nDooleyport, IN 56332	2025-10-23 14:44:54	2025-10-23 14:44:54
8212eba5-5162-4bd4-a681-3e4e79bfc244	Elyse Bogan	8192829131257	rhett.medhurst@example.org	74567681	1316 McDermott View Apt. 057\nBeierside, LA 87371-6539	2025-10-23 14:44:54	2025-10-23 14:44:54
41c6c86a-ab47-4628-a123-e58f13dbbab4	Lillian Larson	6823817421880	batz.laura@example.net	73954919	58778 Parker Park Suite 503\nMelanyburgh, GA 55534	2025-10-23 14:44:54	2025-10-23 14:44:54
73f25e8e-e71f-4673-a4f4-0d7700eb35c4	Fay Skiles	1536070146766	billie.effertz@example.org	79588697	17876 Wuckert Island Suite 726\nPort Wavatown, IL 63941	2025-10-23 14:44:54	2025-10-23 14:44:54
27d519fc-0043-4115-b269-867decbcd046	Mrs. Claudia Leffler	0073515870224	corkery.verdie@example.com	74308512	1971 Denesik Pike Apt. 461\nNew Stacychester, HI 98261-9483	2025-10-23 14:44:54	2025-10-23 14:44:54
a84f81d2-1b47-46b9-9911-6f3e6e92340e	Dr. Elsie Hamill	3947744205484	lernser@example.org	73391599	5674 Lizeth Lodge\nLake Emmett, IN 90536-1151	2025-10-23 14:45:23	2025-10-23 14:45:23
03e28c4f-adc6-4f51-9a7e-d8aa77623e8f	Prof. Laury Mann IV	6156874562041	gianni69@example.com	74720288	34735 Hayes Shoal Suite 832\nKeltontown, TX 51279-0770	2025-10-23 14:45:23	2025-10-23 14:45:23
262a320b-c3c0-4948-8f2d-8bdfc1d46dad	Alexanne Prohaska IV	1337535375673	orn.pete@example.com	79413783	22541 Romaguera Junction\nClaudinemouth, KS 65346	2025-10-23 14:45:23	2025-10-23 14:45:23
1cc2ffeb-90b3-41ae-833a-26cd69e72213	Rubie Reinger	3100949831835	carolanne54@example.net	79904948	7374 Okuneva Locks Apt. 994\nLake Hope, CT 40155-1136	2025-10-23 14:45:23	2025-10-23 14:45:23
3ee2ebfa-7947-43a2-9578-efdd7e31a391	Prof. Kianna Morar II	6287259418638	fabernathy@example.org	72731583	2533 Zieme Harbor Suite 575\nLonzobury, NC 62633	2025-10-23 14:45:23	2025-10-23 14:45:23
b14a1493-2d65-4783-9fe1-d06bc3181805	Dr. Ryder Franecki DVM	2544174355032	rosella.wolff@example.com	71820469	9918 Marisa Junctions Apt. 383\nEast Arjun, AR 61007	2025-10-23 14:45:23	2025-10-23 14:45:23
533c7dc2-16f8-4eda-849a-9637366550d4	Dr. Marilie Powlowski Sr.	0652575515822	bkreiger@example.org	79637731	665 Reinger Highway\nJohnstonfort, WI 94166-7248	2025-10-23 14:45:23	2025-10-23 14:45:23
17684072-d11c-46dd-bbe8-b02d207ffbb9	Leslie Stoltenberg	5290154963871	mariela.russel@example.org	75344928	880 Eudora Curve\nJanyfort, VA 51611	2025-10-23 14:45:23	2025-10-23 14:45:23
a8deaee7-b2dd-45ee-b237-50b204ee384b	Marlen Jakubowski	1566070778893	cbruen@example.com	72229568	218 King Squares\nWest Alize, MD 36350-6331	2025-10-23 14:45:23	2025-10-23 14:45:23
bc4d8bee-d0d0-44f9-b5b1-0fc1545a3790	Ms. Connie Langworth Sr.	8469991886696	mmuller@example.net	70703027	27659 Matilde Forges Apt. 852\nNew Jordan, SD 11246-4505	2025-10-23 14:45:23	2025-10-23 14:45:23
a4b8e3de-ea61-451c-a579-06518318e151	Miss Gilda Gerhold	0327950429555	hegmann.kaya@example.org	75539934	2509 Kautzer Plain\nLake Mathildestad, OR 65532-2318	2025-10-23 14:45:23	2025-10-23 14:45:23
55bcb804-3a3e-4b1d-9563-4639c48ad8e3	Alvena Ortiz	3916893797347	alison.baumbach@example.com	70138947	8940 Paucek Mountain\nCasimermouth, UT 31013-3655	2025-10-23 14:45:23	2025-10-23 14:45:23
f536b755-4f18-4213-a8c4-77f268298980	Domingo Stiedemann DDS	8863551373733	yesenia40@example.com	73563768	6572 Bartoletti Throughway Apt. 724\nMorissetteberg, ND 18612-7821	2025-10-23 14:45:23	2025-10-23 14:45:23
04bd9f98-d1f2-449d-b431-9fda00b95e28	Carmelo Harris	8800914716626	gunnar33@example.net	72792552	96962 Ahmed Square\nNelsmouth, MT 14492-3682	2025-10-23 14:45:23	2025-10-23 14:45:23
21514f4b-e747-4fcd-afba-c4a65b84caa0	Kevin Schaefer	3720608281821	elian.rolfson@example.com	74749988	41183 Schowalter Flats\nHamillview, MI 03295	2025-10-23 14:45:23	2025-10-23 14:45:23
88b81948-ef47-4f1c-86cf-b72d5d27f3c5	Ernestina Hauck	5566735966956	bwatsica@example.org	79103955	55276 Walker Plaza Apt. 598\nPourosmouth, IL 91525	2025-10-23 14:45:23	2025-10-23 14:45:23
b113ae69-bf19-4a64-89bc-2de2f42dd1db	Keven Leuschke	1115724164203	swaniawski.dell@example.com	70551739	830 Deangelo Run\nColestad, MI 63133-6438	2025-10-23 14:45:23	2025-10-23 14:45:23
8ffce487-0325-46d3-97ab-74cddec2eac9	Abagail Sporer	7012429430428	kspinka@example.com	73426683	78726 Makenna Glen Suite 777\nGutkowskimouth, KY 86321-5818	2025-10-23 14:45:23	2025-10-23 14:45:23
b4b7a597-132b-4074-8e4a-d601da3c57b2	Bud Feil	7157955874941	alessandro.anderson@example.com	71448459	733 Jack Courts Apt. 802\nRebekahborough, PA 83502	2025-10-23 14:45:23	2025-10-23 14:45:23
d87f2aac-114b-4139-b5bb-b3aea375c8cb	Brendan Glover	0223144604633	magdalen42@example.com	78531446	563 Kieran Lakes Apt. 147\nBrockfort, LA 90861	2025-10-23 14:45:23	2025-10-23 14:45:23
332d8638-fa13-4a4b-87b3-40dfc361b1f8	Arvilla Kozey	9540701344091	nicolas.katarina@example.org	74592703	79599 Dayton Causeway Apt. 089\nShanontown, AR 76946-0806	2025-10-23 14:45:23	2025-10-23 14:45:23
0fc63963-7482-463c-800e-b2bc4dc4b8e1	Marshall Quitzon	8086699292473	adams.molly@example.com	71561034	1681 Alek Roads Apt. 383\nPort Davonte, FL 28274-6189	2025-10-23 14:45:23	2025-10-23 14:45:23
261b9be2-df75-4f7c-a40c-458311aeccd9	Everardo Abernathy	5027937626454	muller.rodger@example.org	73673586	267 Anibal Orchard\nSouth Annamarie, MD 46607	2025-10-23 14:45:23	2025-10-23 14:45:23
93e00ee0-17e2-41cd-b9b3-4dc31ab15173	Trevor Hauck DDS	4278066831815	damore.marco@example.org	71216208	96427 Jovanny Mills Suite 479\nNorth Earlenemouth, ID 19757	2025-10-23 14:45:23	2025-10-23 14:45:23
6af4cc03-6dab-4d92-bd0f-147a2c43faf0	Madonna Hodkiewicz	0637839590106	bzieme@example.com	73180562	43790 Thiel Harbors Apt. 302\nNorth Forest, MD 64853-5567	2025-10-23 14:45:23	2025-10-23 14:45:23
0ffdfa03-5b83-4af5-a974-8794176f3aa4	Mrs. Herta Hayes V	5466156000000	hermiston.lillian@example.com	77743474	52037 Heaney Key Apt. 398\nMozellport, CA 83520-5503	2025-10-23 14:45:23	2025-10-23 14:45:23
c831b9ef-112a-4bc3-a705-38a3e7d48778	Melany Johnson	4818402679397	ycassin@example.com	70041872	6067 Marilyne Wall Suite 310\nEast Catharineton, UT 49033	2025-10-23 14:45:23	2025-10-23 14:45:23
81d91d0c-75fe-4728-ad27-a0089fb57d5c	Lois Doyle	4339392630910	pmitchell@example.net	79745789	6845 Crystel Springs Suite 987\nNorth Adelbertton, NE 91764-9979	2025-10-23 14:45:23	2025-10-23 14:45:23
e9da6b79-38e7-45a4-a2e9-a0949039a30f	Ryann Deckow	9133081723434	ckassulke@example.com	78526576	70965 Schuppe Path\nNew Genevievefort, WV 13202	2025-10-23 14:45:23	2025-10-23 14:45:23
eb92d398-34c5-4c93-9073-719576510f18	Dr. Rupert Aufderhar	8019653333512	meredith.mckenzie@example.org	78899610	452 Madonna Extension Suite 304\nWest Lucasfort, ME 96316	2025-10-23 14:45:23	2025-10-23 14:45:23
82f162f3-d4af-40c7-9016-881f7c4e7246	Leonard Rolfson	2893334379540	sallie.tromp@example.org	72010687	4762 Pete Loaf Apt. 922\nMosciskifurt, MD 69191-1851	2025-10-23 14:45:23	2025-10-23 14:45:23
09a9853e-e0fb-4a49-8f5b-3dca9e5391bf	Hosea Fadel	8926590429395	leonardo.bahringer@example.org	70235824	946 Simonis View\nWest Dwighttown, NV 73425	2025-10-23 14:45:23	2025-10-23 14:45:23
8c74b173-cac2-42c8-806d-db7d9c45d5b4	Reva Murazik	5228937664130	slakin@example.com	71567865	309 Wolff Rapids Suite 893\nRomaguerachester, NC 24737-8377	2025-10-23 14:45:23	2025-10-23 14:45:23
d5ee78ff-79ef-41be-ae6b-fe2c26eed0cc	Miss Ilene Breitenberg	2375718789473	wisozk.aurelie@example.org	79379436	880 Ebert Shoal\nPort Anthonyburgh, NJ 41981	2025-10-23 14:45:23	2025-10-23 14:45:23
23973814-8272-47bd-a2f3-2e914c35b3a0	Susana Padberg	6898837523551	chris96@example.org	70579113	3776 Rau Cliffs\nSouth Nolan, VT 00359-5044	2025-10-23 14:45:23	2025-10-23 14:45:23
65338e5f-9e0f-434d-8d33-8a175eee51b7	Trent Hoppe	1130568490933	eric64@example.net	73803696	79446 Stefanie Harbor Suite 906\nKirstinburgh, MS 37874-8321	2025-10-23 14:45:23	2025-10-23 14:45:23
1c57776d-10d2-405b-94c9-92badce93d47	Imani Fisher	8184886154975	jerel87@example.net	79144460	6869 Gaston Light\nPort Sydniside, ID 20649	2025-10-23 14:45:23	2025-10-23 14:45:23
a5e64d85-78dc-4668-ad15-d32e122fa5da	Brooke Bergstrom	7584381863283	tatyana.dooley@example.org	71493507	89718 Ariel Pines\nNew Marquesberg, CA 60930	2025-10-23 14:45:23	2025-10-23 14:45:23
0d0cc241-4b7e-4c86-bcc4-981b3eeb131d	Dion Morissette	0019323665548	houston33@example.com	79425666	36144 Moore Manor\nEast Adella, IL 43548	2025-10-23 14:45:23	2025-10-23 14:45:23
b3f74ac4-d62a-4bd4-8e9a-9156ea45ea91	Jerrold Dach PhD	3307729639777	freda68@example.com	76510124	387 Crona Valley\nEast Ally, NM 35596	2025-10-23 14:45:23	2025-10-23 14:45:23
cab1e845-47f6-45e0-a7dd-8e5a2637b872	Mr. Preston Kihn	1079136835297	jeramy.langworth@example.com	70383045	68556 Alexane Course\nNorth Vincenzomouth, ME 25243	2025-10-23 14:45:23	2025-10-23 14:45:23
cf001263-3c00-4708-aec9-230d1553e7e1	Sarina Wintheiser	6165186138576	gisselle11@example.org	79543091	45732 Zieme Shoals\nPort Roseview, AL 81299-6539	2025-10-23 14:45:23	2025-10-23 14:45:23
f496019d-f89c-46ba-9819-0bdc76d50bcb	Laurine Rodriguez	9828571742110	jodie46@example.com	73019562	558 Lehner Spur Suite 250\nLake Buckbury, TX 13849-3294	2025-10-23 14:45:23	2025-10-23 14:45:23
1f02d1c1-b72e-41cb-a89c-230a284ca87e	Shanelle Casper V	7177688247084	leopold.mertz@example.com	77043601	30771 Alford Ridges Suite 516\nSouth Blancashire, KY 45629	2025-10-23 14:45:23	2025-10-23 14:45:23
b0a8acf9-736c-4bcc-a1bf-15f493036c47	Federico Kovacek	0799070583444	lubowitz.yvonne@example.org	71017384	4149 Grady Road\nLake Rosetta, OR 37783-1624	2025-10-23 14:45:23	2025-10-23 14:45:23
4f200d1b-579e-4a9f-bc47-342c145d3141	Joy Crooks	5183757086861	nrunte@example.net	70669017	6821 Francisco Views\nPort Erinside, SC 51115	2025-10-23 14:45:23	2025-10-23 14:45:23
b51a1fee-d307-407b-b0a0-83c85a863d93	Alivia Schimmel	9427135684847	amorissette@example.org	78426283	17177 Quinton Tunnel\nNew Esther, CA 74705	2025-10-23 14:45:23	2025-10-23 14:45:23
2fdfb5ca-0e2a-40f7-8b38-ec687bd39392	Mr. Obie Will IV	6110451481691	reanna.cole@example.com	74633591	7991 Bailey Drive Suite 285\nCasperborough, DC 44620	2025-10-23 14:45:23	2025-10-23 14:45:23
ab93ee6f-411b-4a7d-90e8-53a2c6ae4f34	Mr. Adam Bins	6741248647571	turner49@example.net	71083582	292 Romaguera Canyon\nIzaiahborough, CO 37082-3467	2025-10-23 14:45:23	2025-10-23 14:45:23
23fd39e8-25ac-4f3d-958e-7bd6d0d88039	Janie Doyle PhD	3238536749455	murray.erica@example.net	75324733	906 King River\nWymanport, NV 89489	2025-10-23 14:45:23	2025-10-23 14:45:23
df5a9e07-c8ad-45a5-b27d-83c59ad9e1e6	Rachelle Romaguera	1526592859271	dejah60@example.com	74324102	5744 O'Reilly Crossroad Apt. 127\nSouth Sheldonfurt, NH 56856	2025-10-23 14:46:41	2025-10-23 14:46:41
2797fdc6-9ea9-439a-b882-1e749d6cd303	Elsie Halvorson	7063498279122	robel.melissa@example.org	70826180	180 Mueller Falls Apt. 039\nLake Nella, NH 76204	2025-10-23 14:46:41	2025-10-23 14:46:41
d6fa4c65-f92e-4d53-bc23-3ca9cc670213	Warren Barrows	8435325459910	darrin.wintheiser@example.com	78110822	97598 Mosciski Estate Suite 936\nEast Aniyahville, VA 19972-3026	2025-10-23 14:46:41	2025-10-23 14:46:41
f0bd94e9-b0fe-44b2-858d-81fa2c5d25ca	Miss Reva Ferry II	6538308688547	xcorkery@example.net	72641758	83242 Zander Mountains\nSkilesville, GA 47774-0382	2025-10-23 14:46:41	2025-10-23 14:46:41
877fc6f4-8440-4bdd-9ddb-aeb16c437bf4	Elmira Hansen	9496685700968	bryon39@example.com	72406131	2214 Mandy Forest\nWest Destineyside, ME 18872-9897	2025-10-23 14:46:41	2025-10-23 14:46:41
8d65ab01-261c-42e9-85a9-93806e9b91d7	Lyric Kassulke	5827368833674	harvey.august@example.org	77908487	3506 Leannon Hollow\nMurielside, DE 35814	2025-10-23 14:46:41	2025-10-23 14:46:41
8550d420-1b66-401b-9b08-28df072eb45a	Prof. Lelah Osinski DVM	0963572101299	bcassin@example.org	74379275	127 Ernestina Locks Apt. 454\nFlatleyport, NM 98596-6889	2025-10-23 14:46:41	2025-10-23 14:46:41
f7c7725a-985a-45d0-a62e-c05704168c6b	Georgiana Bins Sr.	4341833354490	jaylen.wilkinson@example.net	79628048	39398 Bauch Neck\nEast Estellbury, UT 04535	2025-10-23 14:46:41	2025-10-23 14:46:41
f87b7ba4-2d98-4e60-b6ad-1109b9054ee5	Miss Verona Witting	2000594532750	kelley30@example.net	74521944	728 Kaycee Tunnel\nPasqualetown, DE 91647	2025-10-23 14:46:42	2025-10-23 14:46:42
075f07ea-0591-46e7-a687-d9ca1bc60319	Jarrell Ortiz	7994154527476	maida.weber@example.org	77017618	73150 Ezequiel Manors\nNew Malcolm, DC 69652-0985	2025-10-23 14:46:42	2025-10-23 14:46:42
e2a3b7b0-4ee6-4c4f-b8b9-996dd9b6707a	Maye Mraz	5470005657384	sarai.balistreri@example.com	78818339	6561 Donato Isle Suite 980\nNorth Odahaven, MT 07011	2025-10-23 14:46:42	2025-10-23 14:46:42
4dbd745d-288a-4298-9d67-a10995614a24	Dr. Lennie Rosenbaum Jr.	7264046817204	dejah.lakin@example.net	76780105	72040 Franecki Stream\nEast Dustinville, OR 31198-1567	2025-10-23 14:46:42	2025-10-23 14:46:42
c459c34b-1fdc-4752-83e0-ae597573f7c9	Madge Dicki	8415156476840	cummerata.frances@example.com	70660996	986 Lindgren Ramp\nLake Doug, CA 47613	2025-10-23 14:46:42	2025-10-23 14:46:42
70830e99-e6de-4989-ab84-08d454cd9cf8	Prof. Brody Hirthe	5655300696584	albina.kovacek@example.net	79436567	7240 Batz Isle Apt. 897\nWest Nellie, WI 21258-1458	2025-10-23 14:46:42	2025-10-23 14:46:42
6e1c4f1f-62f1-4aa7-89e6-7b57b83fb6b6	Miss Madaline Mayert	5530948345173	arnulfo.schumm@example.net	78179468	78124 Maritza Courts Apt. 096\nLarsonton, OR 99977-1885	2025-10-23 14:46:42	2025-10-23 14:46:42
4a500650-e1f5-446f-a41b-d348c9d8737f	Brianne Kirlin	2216744942210	kuhic.marcia@example.net	79098152	123 Ophelia Station\nVadaview, GA 71788-9104	2025-10-23 14:46:42	2025-10-23 14:46:42
b9652405-77d0-4a53-a8ad-3b0945bd710e	Dr. Creola Wisoky I	9681277807163	katlyn57@example.net	75235165	12634 Hermann Underpass\nSouth Rod, OH 68910-1566	2025-10-23 14:46:42	2025-10-23 14:46:42
d8d7e143-9a9b-459e-b13d-ecc4066170bc	America Adams	8097660240300	esperanza.hoppe@example.org	75393363	579 Greenholt Spur\nKamrynchester, IL 66208	2025-10-23 14:46:42	2025-10-23 14:46:42
d7baaa27-82d9-4216-83ea-1f3b8697bdc0	Ike Walker	4637942460809	qhermann@example.net	76757655	7540 Klein Forge\nLoischester, ND 03133-7503	2025-10-23 14:46:42	2025-10-23 14:46:42
006a742e-ef5c-4617-a507-d0d6f1d62368	Naomi Bradtke	9194728382232	waters.abe@example.net	75235527	618 Schaden Stream\nGraceland, MT 86764-2324	2025-10-23 14:46:42	2025-10-23 14:46:42
363c493f-bda5-4014-86b9-e1e3d81eb0fa	Rylee Goyette	7104950911071	llebsack@example.net	75884777	465 Ratke Village Apt. 531\nPort Milanfort, OK 92690	2025-10-23 14:46:42	2025-10-23 14:46:42
00a45e90-6f5d-43b7-918c-492905cc06d3	Helen McDermott	5808226681163	santino75@example.com	76376237	242 Krajcik Heights\nWest Kristopherbury, CA 38532-7742	2025-10-23 14:46:42	2025-10-23 14:46:42
fc493500-563a-4274-83ee-02b77c8a1f47	Geovanni Kautzer	4217353114128	ijenkins@example.net	78907582	89049 Rhea Fort\nLake Mona, AZ 52063-9597	2025-10-23 14:46:42	2025-10-23 14:46:42
4845b1fd-4680-4498-8ae0-3de9283ccbc5	Ms. Lela Mraz V	7672407851541	borer.leda@example.net	78418166	607 Fay Mall\nWest Aydenshire, DE 43455-8779	2025-10-23 14:46:42	2025-10-23 14:46:42
19050e22-08cc-4aec-9c7f-b1cc2e78f60b	Ricky Watsica	6388671542431	madaline22@example.com	78801360	50763 Watsica Plaza\nEast Issacton, TX 80105-5327	2025-10-23 14:46:42	2025-10-23 14:46:42
38d79cb1-35b2-403e-9c5f-084a82531c06	Gabe Fay	9653893866853	schmeler.brian@example.org	73584990	7322 Melany Drives\nSouth Yasminehaven, ND 20418-9379	2025-10-23 14:46:42	2025-10-23 14:46:42
e6d08df8-a289-4fb4-b39b-2170cc23c0b2	Phyllis Volkman	9523263372700	raven.wehner@example.net	74126407	55889 O'Kon Locks\nLake Audiefort, PA 82083	2025-10-23 14:46:42	2025-10-23 14:46:42
03f4fe18-5c01-40fc-aaaa-250ce66927a0	Dr. Americo Runolfsson III	2197401681508	jakayla.cassin@example.org	77566814	975 Schamberger Throughway Apt. 104\nLindseymouth, NJ 44715-8262	2025-10-23 14:46:42	2025-10-23 14:46:42
86ed8d6e-72df-4992-921f-04fbf513b223	Roma Breitenberg V	7713868128600	emanuel19@example.org	73615493	4059 Von Passage\nEast Rhett, AK 68579-8053	2025-10-23 14:46:42	2025-10-23 14:46:42
fe9d351a-964a-4221-adc5-0d48ccf0b605	Miss Antonina Gerlach PhD	0285138216741	santos.kulas@example.org	72115673	50741 Eddie Lakes Apt. 368\nSchillermouth, WY 18150-2016	2025-10-23 14:46:42	2025-10-23 14:46:42
f60cf06b-1668-4a19-85ee-acdf35097c98	Dr. Alfreda Kris	7034569584100	norwood95@example.net	71653547	2202 Angela River Apt. 641\nLake Cristina, IA 79357-8935	2025-10-23 14:46:42	2025-10-23 14:46:42
f979f593-07b5-4934-a38a-ae13796b4e47	Emanuel Block	3108824772541	purdy.eda@example.net	75206455	365 Kaela Meadow Suite 561\nLake Chadrick, VT 71674-7197	2025-10-23 14:46:42	2025-10-23 14:46:42
52dd0d65-a0a3-489d-837d-f40c35bd7a09	Patricia Quigley	8750752638048	clarabelle72@example.net	75752328	36925 Steuber Wall\nSouth Jeffery, WV 22858-7392	2025-10-23 14:46:42	2025-10-23 14:46:42
cb5a3c70-ab37-468c-8338-22bbfa86580e	Lupe White	3636156947486	derek17@example.org	76824263	99543 Kassulke Hills Apt. 673\nEichmannmouth, IN 77988	2025-10-23 14:46:42	2025-10-23 14:46:42
10168db8-0cf9-4c33-bce4-de53ad94c90e	Ewald Conn V	7468296756016	daren96@example.com	79762482	12112 Cruickshank Island\nRiceborough, MT 79270-4046	2025-10-23 14:46:42	2025-10-23 14:46:42
03061173-a42d-400a-b016-77aa6838d275	Mac Bernhard II	6894013388353	wrodriguez@example.com	77044984	817 Evan Dam\nSouth Ritashire, OK 64497-8722	2025-10-23 14:46:42	2025-10-23 14:46:42
3208ff71-a802-4ed0-8507-79d93a469f4e	Sammie Rosenbaum II	6163196066948	ziemann.phyllis@example.com	73406173	24357 Chanel Radial\nZboncakport, AZ 92517	2025-10-23 14:46:42	2025-10-23 14:46:42
f64a1455-4c4b-4484-b185-88c50cc3cf6a	Miss Candida Mayert	1344529472070	predovic.genevieve@example.net	71047458	30993 Schroeder Falls Apt. 834\nEast Vivienne, DE 09663	2025-10-23 14:46:42	2025-10-23 14:46:42
0dd2fb6b-db80-4cbd-844b-476f66d8587c	Virgil Prohaska	9802575641733	nils.mayert@example.net	70527186	16437 Randall Knoll Apt. 127\nNew Hector, NJ 11798	2025-10-23 14:46:42	2025-10-23 14:46:42
3a8e196a-e4e7-4acd-a1e3-a97fdb952a13	Miss Jodie Swift MD	0029244308177	daisy80@example.com	77508582	214 Kutch Mall Suite 362\nNorth Kylamouth, RI 66771	2025-10-23 14:46:42	2025-10-23 14:46:42
600f2ce6-3ab5-4454-8e11-791428f1e97f	Mr. Nicholas Hagenes DDS	5911031606064	kaley.stark@example.org	75331709	1530 Sally Vista\nEast Luther, DE 49154-5476	2025-10-23 14:46:42	2025-10-23 14:46:42
f575a9c0-3afa-4110-9062-2c702aa67af8	Chaim Bernier	8061652691020	baumbach.opal@example.org	74586988	4532 Modesta Curve Apt. 180\nWest Fred, KS 79194-0905	2025-10-23 14:46:42	2025-10-23 14:46:42
4c83d2c9-e760-41d0-abae-7cc3eb1ac4c5	Alberta Ratke	9544075008366	yvette98@example.net	70915996	7666 Enos Isle\nClaudinechester, VT 43814-0733	2025-10-23 14:46:42	2025-10-23 14:46:42
437ceab5-4788-4032-8e1e-ae011f06a928	Amy Christiansen V	3933417362033	gusikowski.arnaldo@example.com	73713390	67578 Dayton Court\nHudsontown, TN 80247	2025-10-23 14:46:42	2025-10-23 14:46:42
a5f3e7c7-e3ed-4636-8323-47742165d907	Juliana Herman DVM	8164885222556	annetta06@example.org	73957097	923 Rau Islands\nMullerland, PA 54207	2025-10-23 14:46:42	2025-10-23 14:46:42
038e722a-1220-488b-a555-466fcf8dcec7	Jamar Koelpin	0293143918052	keebler.roberta@example.net	71880917	4012 Sherwood Hill\nNew Emelyton, DE 40811	2025-10-23 14:46:42	2025-10-23 14:46:42
2014310e-35fb-40b9-92aa-d419b3e877c2	Jovanny Schumm	4550253909697	oleta.hartmann@example.com	70063084	24679 Willy Inlet Suite 380\nLazarofurt, SC 40431	2025-10-23 14:46:42	2025-10-23 14:46:42
88a6e545-62b2-4fdb-b73e-18b2e3259b90	Dr. Demetris Zieme	4907634814163	altenwerth.mozelle@example.net	70477248	4207 Russel Springs Apt. 958\nWest Gardnerland, MS 67995	2025-10-23 14:46:42	2025-10-23 14:46:42
4d25ce4d-6d86-41da-ab3f-27aa918b5a1a	Guillermo O'Conner Sr.	3619197404490	izaiah.dare@example.com	71781291	573 Jeff Neck Apt. 457\nLyricfort, MN 70195-7167	2025-10-23 14:46:42	2025-10-23 14:46:42
d9f57e66-530f-4e30-a950-3f714e3d88f3	Mrs. Gilda Hoppe III	8171109156622	stracke.esteban@example.com	73984672	95676 Veum Knoll Apt. 039\nEast Grace, FL 38757-6680	2025-10-23 14:46:42	2025-10-23 14:46:42
3f9f8fdc-c21f-4ead-b053-c968bb0500e0	Thea Wehner Sr.	6870304194896	deborah69@example.net	71294393	899 Josue Loop Suite 191\nDonchester, OR 00184	2025-10-23 14:46:42	2025-10-23 14:46:42
96597611-d7ff-44e1-ab30-d535732ccd16	Terrance Wiza	8014738046709	kian.langworth@example.com	74842664	37411 Justice Gateway Apt. 411\nKanehaven, NV 25297	2025-10-23 14:46:42	2025-10-23 14:46:42
4e1ed019-881e-44ef-93f3-7634237cc7c4	Davion Batz Sr.	8198099524001	leonor66@example.net	73331384	8413 Lue Locks Apt. 258\nLake Olafort, ND 85438	2025-10-23 14:46:42	2025-10-23 14:46:42
a89012e6-9650-4269-a393-7468fcad2ba7	Mr. Dallin Schneider	4621447009490	jason03@example.com	70491660	18294 Schinner Valley\nPort Erin, IL 78984-1540	2025-10-23 14:46:42	2025-10-23 14:46:42
c23b7e14-533c-4427-95e1-d8670cfff8d1	Mr. Rahul Jaskolski	6780674610136	connie91@example.org	74490118	68657 Victor Road\nBrownborough, ID 95749-2755	2025-10-23 14:46:42	2025-10-23 14:46:42
02e979b7-df6e-4278-800a-580557e9d20c	Kip Lowe	2635726367683	greg.casper@example.com	74210088	5198 Reichel Throughway\nPort Electa, PA 89423	2025-10-23 14:46:42	2025-10-23 14:46:42
958647dc-0594-4ad7-84b9-cf52113887eb	Grayce Schuppe	2194840022477	willie.cremin@example.net	73379732	69892 Jakubowski Turnpike\nNew Abner, CA 54581	2025-10-23 14:46:42	2025-10-23 14:46:42
835e06cb-f0de-4363-b338-82a4cebfb918	Prof. Rodrick Brakus	0574826984828	akeem49@example.org	79055798	32293 Cassin Forks\nWintheiserport, TN 61614	2025-10-23 14:46:42	2025-10-23 14:46:42
8545d202-12b5-478c-83c2-ec99895e3897	Dr. Demetris Stracke IV	6184400978572	karen89@example.net	79999575	63248 Cassandre Grove\nEast Germaine, PA 67597	2025-10-23 14:46:42	2025-10-23 14:46:42
2ad2a10b-b6b7-477e-8fa0-ed13a3e05251	Prof. Lee Grady	6313020649783	elinore.bartoletti@example.net	73589380	3944 Veum Unions Suite 391\nEast Elwynport, NV 91225	2025-10-23 14:46:42	2025-10-23 14:46:42
485ccb4e-41b2-4ca5-8d89-9895129117f2	Alf Lemke	5960317481878	tillman.brenna@example.net	78158769	54185 Felipe Garden Apt. 379\nMedhurstton, IA 01808	2025-10-23 14:46:42	2025-10-23 14:46:42
b7514ab4-83c8-4255-a5da-bee9ff513e8f	Jane Fadel	6265738776079	weston16@example.org	79590580	12138 Becker Flats Apt. 400\nStephaniefort, KY 62663	2025-10-23 14:46:42	2025-10-23 14:46:42
f7849e59-84ad-48c5-85d5-26f2d8c67350	Dr. Maeve Ziemann	2970012542798	carley15@example.net	74072308	3659 Muller Valleys Apt. 039\nAraborough, WI 27030	2025-10-23 14:46:42	2025-10-23 14:46:42
69da8650-c68f-41a4-8581-abec6908c1f5	Monroe Harvey	8832137450153	jgreen@example.com	75861061	6005 Reilly Brook\nLake Jefferytown, AR 55228	2025-10-23 14:46:42	2025-10-23 14:46:42
c578c7e4-b1a0-40fc-a5fa-2074f43ae525	Gaylord Hand II	1568690956925	aemmerich@example.com	77518742	688 Mayer Extension\nArmstrongfort, MS 72193	2025-10-23 14:46:42	2025-10-23 14:46:42
8342e838-5fb5-450d-9a04-7077bf53798a	Albertha Lindgren II	2731056792510	vstrosin@example.com	72330732	2763 Boyle Trail\nRaytown, CO 12344-2041	2025-10-23 14:46:42	2025-10-23 14:46:42
65692618-1f0f-4802-ba53-3f1900a9e423	Jewel Bergnaum	6836923761901	ledner.bulah@example.net	78215311	5004 Marguerite Overpass Apt. 298\nBrainbury, DE 34297	2025-10-23 14:46:42	2025-10-23 14:46:42
2cbaeefb-21f8-4044-bc46-f82f925fa072	Maximillian Jerde	4493418944678	yquitzon@example.org	78510847	2951 Freda Green Apt. 497\nHiramview, DE 64018-3508	2025-10-23 14:46:42	2025-10-23 14:46:42
98ae6e6a-1d52-44b9-8ce7-029985bf1a69	Mr. Coty Nader Sr.	4923459453087	hilda.kris@example.net	72571374	9590 Taya Locks\nWest Gardnerhaven, CT 55356	2025-10-23 14:46:42	2025-10-23 14:46:42
2f581332-e02e-47c4-8f46-105b84d2bb7d	Demetrius Effertz	1428573636225	vadams@example.org	75121198	37965 Keeling Ridge\nHaneshire, AL 44223	2025-10-23 14:46:42	2025-10-23 14:46:42
9c21ac8d-ee73-4089-bc8c-cc4f165ab022	Josiah Erdman	2745637038628	zachariah65@example.org	77179239	64911 Schowalter Plains Apt. 668\nGibsonmouth, MA 20373-3987	2025-10-23 14:46:42	2025-10-23 14:46:42
1bcd7dc6-4941-4392-a243-c649741dff89	Julia Carroll	4338175599674	price.kayley@example.com	78083753	7444 Destany Springs\nSouth Pedroberg, NY 70626	2025-10-23 14:46:42	2025-10-23 14:46:42
d308384f-9497-4268-8362-04d7f162fe02	Joana Mayer	0581943792800	roberts.antonette@example.org	74923013	94146 Thompson Vista\nNew Estevan, VT 33815-7028	2025-10-23 14:46:42	2025-10-23 14:46:42
45097f9a-6019-4c55-aa68-c50a56132564	Geovanni Runte	5321002256870	simone67@example.net	70727774	9137 Turner Ports Suite 251\nLuettgenshire, ID 55610	2025-10-23 14:46:42	2025-10-23 14:46:42
c22841cf-0fff-43b3-90cc-a736b1922aca	Miss Katharina Bechtelar	1891853395597	skassulke@example.com	77075376	73489 Joy Highway Apt. 448\nJaniyabury, RI 13803-9229	2025-10-23 14:46:42	2025-10-23 14:46:42
a928c404-8b78-421f-b69e-5d802fdf45f9	Selmer Schmeler DDS	4669578005585	lysanne.murphy@example.com	77908759	223 Carter Alley Apt. 801\nSouth Reanna, WI 07593	2025-10-23 14:46:42	2025-10-23 14:46:42
a4a41854-123c-4413-bfd6-2c3fa234c07d	Makenna Brakus Sr.	4234560580115	lulu55@example.com	77674904	3529 Orie Parkways Apt. 182\nBarneyport, DE 20338	2025-10-23 14:46:42	2025-10-23 14:46:42
573d87f1-a232-4d8d-8474-0842411014a4	Karli Ledner	6311443934908	fthompson@example.org	73507054	282 Ziemann Inlet Apt. 312\nNorth Alexisport, NE 51588	2025-10-23 14:46:42	2025-10-23 14:46:42
29325606-cf22-41e5-b3f9-5cce80d8c62d	Rafaela Larson	4140115866889	arvid.parisian@example.org	76452379	427 Jordi Mountain\nWillborough, IL 07311-9976	2025-10-23 14:46:42	2025-10-23 14:46:42
275d408c-1fd7-487d-a07b-587f0820c86c	Carmela Mante	8047044224493	oreynolds@example.com	79290988	898 Consuelo Squares\nEast Grayce, SD 77498-5239	2025-10-23 14:46:42	2025-10-23 14:46:42
51b37655-c125-4f99-81b1-11fa5b9d7057	Mario Ernser	8221202108556	dfeil@example.com	74410264	1355 Howe Courts\nLake Babyborough, IL 45152	2025-10-23 14:46:42	2025-10-23 14:46:42
45f6e49b-72ec-42d9-80cd-aa46bf0fd665	Breanne Kuphal	2451010997563	leola30@example.org	78031693	6610 Gutkowski Rapids Suite 128\nSouth Angelinaton, IN 26157-7284	2025-10-23 14:46:42	2025-10-23 14:46:42
b882b8ca-f54f-4a07-9f9a-a52e20667ca9	Ms. Abigayle Pacocha	6512400690332	jedidiah69@example.com	74178886	50178 Henry Road Apt. 295\nCarissashire, WV 34530-9667	2025-10-23 14:46:42	2025-10-23 14:46:42
53037a48-3784-4223-88f9-d7e638e29324	Caroline Roberts V	5231774692725	freeda60@example.net	75001601	101 Armstrong Place Suite 178\nFranzland, CT 65600-5540	2025-10-23 14:46:42	2025-10-23 14:46:42
10d8f80c-b67d-40b3-9c28-57da1d0209ce	Adriana Wisoky III	2441453350209	eusebio.vandervort@example.com	75897427	82645 Abshire Stravenue Suite 591\nEdafurt, GA 81351	2025-10-23 14:46:42	2025-10-23 14:46:42
f7b39e08-6193-41f7-a372-def509353bb4	Dr. Felton Kuhn DVM	2673175389624	theron.langworth@example.net	75804590	76494 Gleason Gateway Suite 176\nIsomberg, MN 30239-0459	2025-10-23 14:46:42	2025-10-23 14:46:42
6ba716a8-fdec-48c1-973d-b2c80c28473d	Otilia Bahringer	9573952869952	loma.mayer@example.net	76664597	644 Smitham Flat Suite 136\nIciechester, AL 35516-2392	2025-10-23 14:46:42	2025-10-23 14:46:42
4f8da565-0131-44c8-9bac-9bd2af7c5e58	Cristopher Nitzsche	9419087018544	jlakin@example.net	72733147	8359 Jaqueline Grove Apt. 219\nVontown, KY 72227	2025-10-23 14:46:42	2025-10-23 14:46:42
dc312743-fc63-420e-9bf2-bd6b0c5ee8ed	Mozelle Connelly	1306166048293	lkozey@example.com	72527581	80308 Okuneva Extensions\nEast Monserrate, OR 80566-2015	2025-10-23 14:46:42	2025-10-23 14:46:42
8828069e-4a6e-40d6-b360-12364f9f3d7b	Camilla Lemke	7231473815276	felipa82@example.net	70498371	853 Johnson Junction Suite 159\nWest Nilstown, IL 51943	2025-10-23 14:46:42	2025-10-23 14:46:42
9b224f29-ea11-463a-a9a7-68e6043cc329	Prof. Blanca Langosh DVM	9539500883280	willie69@example.net	74340588	91455 Johnson Court Apt. 995\nNew Antwanburgh, MI 62471-2979	2025-10-23 14:46:42	2025-10-23 14:46:42
74817ff3-57b3-4fdc-9d6a-82bc62f1f6c5	Greta Pouros	2331413747223	okeefe.elta@example.org	79467504	485 Jabari River Suite 863\nSouth Magnolia, TX 39817-7174	2025-10-23 14:46:42	2025-10-23 14:46:42
01922bbf-b20b-440a-9476-5de03cb1c029	Brionna Ullrich	9205202156944	haley.maynard@example.net	74694409	5263 Schuyler Causeway\nPort Travishaven, AR 58781-8884	2025-10-23 14:46:42	2025-10-23 14:46:42
4d93e52a-a5ab-44a1-a786-0f92a42a5353	Adalberto Schmeler DDS	5799445763519	botsford.glennie@example.com	74545682	12262 Dena Ville Apt. 146\nEmmerichberg, MD 65712	2025-10-23 14:46:42	2025-10-23 14:46:42
2c1b850a-e99c-48ec-80dc-e7971d1c3573	Shakira Bradtke V	1142233067811	meda82@example.net	76806391	330 Aurelio Crossing Suite 766\nNew Titus, NM 63326-6142	2025-10-23 14:46:42	2025-10-23 14:46:42
6f8437fb-559c-4002-8b26-5e7d36b6bc99	Dr. Ansley Sawayn	9761012087660	istehr@example.com	77526970	16461 Heloise Locks\nNorth Christ, WV 45945	2025-10-23 14:46:42	2025-10-23 14:46:42
d82c62a8-6b0e-4678-9286-053b2bfe9bd3	Lizzie Gerhold	2352089826882	xwolff@example.org	79386415	330 Halvorson Flats Apt. 171\nBoehmhaven, WY 73050	2025-10-23 14:46:42	2025-10-23 14:46:42
b2724679-8d79-4d1f-b372-943d446efb20	Bette Rempel	3345332134842	okihn@example.net	73030494	7235 Mitchell Inlet\nPaucektown, IA 75811-8768	2025-10-23 14:46:42	2025-10-23 14:46:42
f1b606a9-1ac9-439c-8597-459b9e03656a	Dr. Sigurd Dibbert	9706334044332	tyra46@example.net	75577895	9062 Jaclyn Mission\nCollinsmouth, OH 95681	2025-10-23 14:46:42	2025-10-23 14:46:42
8882db1c-0f07-449e-a149-a303838ea893	Izaiah Harvey	6992658525362	rita.wuckert@example.com	74965395	1969 Cormier Glens\nWest Michaelashire, NJ 24752	2025-10-23 14:46:42	2025-10-23 14:46:42
\.


--
-- Data for Name: comptes; Type: TABLE DATA; Schema: public; Owner: mon_user
--

COPY public.comptes (id, client_id, numero, type, "soldeInitial", solde, devise, created_at, updated_at, statut, "motifBlocage", deleted_at, archived) FROM stdin;
add2482a-de00-41d8-a772-cd4ef6546baa	b4ad6ec5-3457-4433-97e4-90df7b25e1ed	COMP-430185	epagne	352417.00	201835.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
37da1638-f10a-4a03-9eb4-9eb960273866	e2025eec-308a-4aa3-a32b-5a89afbb4b5a	COMP-376267	cheque	663199.00	26944.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	ddf188b3-a434-4323-b1a8-16275fb15073	COMP-853841	courant	919889.00	215784.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
0006e5f7-4df5-46a5-8f9e-90089c5ea052	c0b8ebaa-6d8c-4cd9-ab02-ccdf1030bd93	COMP-639398	epagne	955889.00	65792.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
e774b1e8-095f-4684-a770-c420e32f477a	ef7a27e7-7044-4d20-ba94-6e412223b84d	COMP-721740	courant	171791.00	126373.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
8a4ca722-53cc-428f-a83a-d84a7f681abf	ec758530-666d-4458-85d5-b5f060b58a1d	COMP-518875	epagne	203666.00	447100.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
6131421b-d7d7-4f56-8450-582c37486f68	9381e924-3568-4672-8ee6-9d49c059adfe	COMP-656169	courant	637110.00	348073.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
f3e7fcff-56ce-42a9-bbf9-f2aa186da145	de66bcd0-2eac-403c-8998-343851a96118	COMP-053500	cheque	747349.00	310752.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
64203f77-d74d-4752-9e2b-7a1c40547be9	dfca4fe1-63b7-4ed8-8f5e-43d49c0a8b71	COMP-412868	cheque	435951.00	489151.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
e4ad8455-8e84-4a67-873f-6392338ba743	0ca7caf8-9b31-4fb4-a138-79c6138eb0b8	COMP-268155	epagne	881324.00	268.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	2aeae0a6-25ab-4abb-896c-501c7b90100c	COMP-023374	courant	334296.00	482848.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
54c98069-cb97-4a48-9c06-c8ed239ef726	7a9196e1-636b-4a55-8d11-2139340a7ce9	COMP-346606	courant	396420.00	219062.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	4871d970-0707-46d2-94a1-a225e66b3341	COMP-617356	courant	72500.00	477610.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
916bbfef-cee4-457b-a001-da8e5b0be63d	3cba95c1-75c0-4c1a-ac61-5b9a0174ccf6	COMP-193055	cheque	628998.00	185746.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
2f53ae60-3c7c-4dee-a02c-cad51068f96c	8d80229b-6a0b-476e-9c7e-4df3241bf1ae	COMP-830901	cheque	840469.00	40712.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
2afce742-17e9-45bc-99be-9389a26da3ca	df6e313d-634e-4e25-9cf4-7e8fc76849e8	COMP-524853	epagne	417516.00	21784.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
ce352024-ef0a-4c59-a717-07fa503a38dc	7ddf1549-eaa3-41f7-848d-6b105daee39f	COMP-205986	courant	570443.00	436076.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
f712d8d9-57b6-49a4-a8eb-5e04856619a9	89d78ef9-28aa-4fb3-82b9-ba9f21b96c07	COMP-366815	courant	937337.00	419783.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
65da4070-27f5-40a7-99d9-db64e3163a65	608a27c3-f676-4f17-88a0-fd6eaccaa49c	COMP-888952	cheque	384951.00	255594.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
4e96181f-e984-42f8-9787-a41a67c90aba	237694dd-576c-46e1-842c-448bf5dc6668	COMP-569898	courant	421908.00	455670.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
78038c23-dabc-4bd2-a4b5-e1c09089f492	8ca37be7-86c7-4391-b752-8f9ec15b27ee	COMP-725308	epagne	290312.00	165169.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
bf69dba7-7153-4b9d-885b-f7fa7330e249	8ebf1d88-deac-4e1a-bd71-f9b1c73031c3	COMP-797449	cheque	912904.00	116825.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
f46f2dde-ba75-4234-b729-67c0cd2a3ade	5d7ff698-8f01-4c09-aa91-e625e07661bf	COMP-267062	courant	45107.00	279050.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
d725e859-df50-4ee3-8ab9-65d82dc7fd71	d5a42fa1-4780-4d6f-aa8f-1db7a5d87a7f	COMP-338739	courant	321839.00	133633.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
801e068b-fdc3-4606-bc83-42d2e3fc4a67	b5f588c7-4086-40d4-9eef-1d1a274ba9e8	COMP-179514	courant	866399.00	443978.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
aaa991e6-e52e-48b7-ab07-15a4a8203054	a95d0a6b-2420-4f42-86df-cfa2b45e1513	COMP-530304	cheque	795649.00	398862.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
d2a1ed80-e126-493f-b155-2923909ae924	0718e2ab-937c-4b09-a023-8a55edd8e20e	COMP-652922	epagne	842830.00	185230.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
43543b43-8884-4451-8a39-e16cf1e52d3c	1bbe3e47-da3b-470f-a61b-712cd4c896b1	COMP-376960	courant	423632.00	487487.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
0c099b4c-0616-44d6-af7a-38ed712edbf0	3bf4be6a-b7dd-4fd1-aa85-90364b537b05	COMP-767153	epagne	654391.00	249269.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
f2182e94-c5d0-4b91-8d12-af97e101dd6b	e9ebe070-30b5-4666-8ce3-67eeb5fa17c7	COMP-618078	epagne	511626.00	385571.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
232f5785-5fd1-4398-91e2-4f92589e1d8d	9af08392-e4a9-4724-b175-9aa0e601a23a	COMP-712115	courant	171545.00	345680.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
7643d019-9210-424b-b768-667e79ca8da7	60f5f868-adc9-4cae-b4b5-3ad56467867b	COMP-309563	cheque	819135.00	485706.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	eb62ece6-1b49-4645-b417-68daa5ded4a0	COMP-266578	epagne	57091.00	427760.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	dde9f652-6ba7-4ee0-9fc4-2e00b84a18bb	COMP-422819	courant	405418.00	393814.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
a35ef6df-7249-4f6b-9cd3-9e292984d6ce	7d559181-5e06-4607-85ee-051bf81da552	COMP-124996	courant	818040.00	89619.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
4e0954f5-1956-40db-b392-7a6ee455c257	2b15bf65-df76-4d3c-bbf0-f5a6f0657828	COMP-432449	epagne	943142.00	10565.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
473ba79b-f520-481d-82b7-0a94c75586be	18e47158-94b8-4268-9dd7-699b81b05ed5	COMP-604143	courant	816076.00	496613.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	480fbc1e-e234-47a8-9c01-59e9f06b5de4	COMP-988761	cheque	368901.00	123995.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
e5fbfcb0-c796-4371-80c6-f78f1038a282	817c0b58-4528-4ae4-8bd4-e1b94e3c7d7b	COMP-906951	epagne	250215.00	475214.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
7b3221a6-3b25-4cc8-a934-e795af882682	1ec3b569-b566-4929-a21e-12c488f98246	COMP-343087	courant	844882.00	24767.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
1eece79a-3f27-456a-8f76-0b4de6cba5e4	e4ad9aae-ba11-4081-b3e8-96668af4ebf5	COMP-800918	courant	683742.00	159512.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
a1f1990b-1819-4977-aaf0-bb14a824daa0	c07b5d67-cc11-4cec-9de1-4937f32fadee	COMP-607344	cheque	751807.00	396980.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
1a2a915d-173c-44e7-a655-e29b9a02fd18	df3c6d94-1c20-418e-8c76-667cb13a842d	COMP-961724	courant	79035.00	174764.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
8d706bac-d7d8-4172-8d94-d1a8cdf604db	18867b1a-197e-450c-91ac-67ab4950ab21	COMP-783728	courant	573354.00	333318.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
3b545ec9-8048-4c12-a074-df603671d400	6575c0d2-5298-4d39-ae36-65fb65e83efd	COMP-420053	courant	214763.00	483714.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
61bcb7e8-d7d1-45da-9b25-70fba627d304	059ec1da-b9b0-419b-a630-4be38e1b9c9e	COMP-270363	cheque	256290.00	227247.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
146ccb9b-b2be-4ae4-b58b-21c739bfe95c	1e91d290-b04f-4773-aeca-6c77f0a84193	COMP-694291	cheque	172559.00	113941.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
9c0923b4-0a14-4650-8df8-edf426310de6	802c23bd-44bf-4777-9984-aa168298376e	COMP-976105	courant	468739.00	33137.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
93ec7354-821a-4306-8dcb-5b911268af75	3cf1758c-3335-4f9c-b98f-17da0563f499	COMP-824869	epagne	807718.00	397957.00	FCFA	2025-10-22 04:20:05	2025-10-22 04:20:05	actif	\N	\N	f
7f1efa9d-d4d7-40ff-ad77-c49e8db26274	112dfabc-1caa-4af8-8df2-43d40b4da622	COMP-098325	courant	957154.00	420959.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
2bdeac76-dcb7-4710-9060-e9ca98012722	1e6d3d08-dfff-48e9-aaa9-769caf8f21e3	COMP-698602	cheque	544900.00	407651.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
792c8ff4-749b-469b-95d0-9b98c2283684	9a5b0fbb-2106-487f-b644-93b23321ea29	COMP-655924	courant	593290.00	300640.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
79f54c28-5af3-42a0-b025-afd541eb8dbf	68434504-c1b6-41d8-bea1-e2ccc0d6c938	COMP-830410	epagne	251898.00	405571.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
b1ce150f-0fc3-432e-8d5b-a34f6747804a	9dc9deee-0c13-4c2f-8799-818e61e5a434	COMP-838751	epagne	363705.00	309854.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
ce34889a-7b15-48e8-9003-f1522cf517f8	d4bbf9b1-29c0-4146-8125-422c54cc79ce	COMP-700348	epagne	253128.00	212023.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
d0f4f273-6422-4408-950f-61e6f8d23373	e21f1400-308a-48f6-9406-3fd554b8ee68	COMP-977408	courant	264077.00	421789.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
9d8742db-9975-4f0a-aad4-23d2a22203cd	741eaa88-bc64-4044-9a9b-59cba8f157b0	COMP-607403	epagne	522423.00	106867.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	1685a896-c5ea-4830-8902-6f9847f4e03a	COMP-425772	cheque	362594.00	282961.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
57a5b070-a40d-45d9-b0ee-ba32f96383a6	42d9e762-be28-4ee5-8f6a-96c8db192dc7	COMP-938192	epagne	542919.00	324131.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
2e311570-14e5-403a-a71f-698c77f8454d	18cb80f8-bd87-4def-a825-80e1603ce669	COMP-624650	cheque	379542.00	439948.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
df088290-3d37-4591-8571-389b37349b2a	a2c47393-4e16-49d8-b342-613878b63408	COMP-902516	cheque	123035.00	273540.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
b30db983-96ad-4f5c-a50c-1637c25f3b46	0d07a970-21ff-46a8-9f0f-e177880262db	COMP-724508	epagne	241730.00	220146.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
8af34d52-0c28-48ed-ae2d-87e52f97806a	31e04a4a-9b9e-48ee-ac55-529596e40c4e	COMP-143878	epagne	864390.00	368779.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
b9fcf39f-cbf6-4e3d-99da-428158581521	96a0fa41-7ce5-4ece-bab0-8a804b6f9b7a	COMP-327963	cheque	682064.00	278647.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
968e30c7-1be0-4c05-98ba-5cb8d986a863	240fa186-5b27-4ecc-96ae-1c380d9791ba	COMP-262659	cheque	900014.00	331020.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
a0123386-5767-4f9f-b457-e0613e9f8725	dea98ae9-eef1-4b50-9eb1-ce8433c30846	COMP-976770	epagne	897125.00	474190.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
6b052865-a885-4b74-94d3-9838eadb0208	ff4a4eac-62cb-41be-b997-b9dc5700d51c	COMP-725135	cheque	478888.00	32394.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
39ca01df-9037-4f1b-962a-164c3db984f0	316dc6cc-d40a-4f6b-aa55-9f1e090896e3	COMP-854278	cheque	658361.00	482970.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
3406986a-f161-4a7a-80be-bcdf0e3f2214	1fc2bf58-985e-48aa-85dd-64180015e007	COMP-081883	epagne	427013.00	214655.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
cccd197c-f331-4647-8abe-dacb9cf26b5d	f7cfe2d4-023e-4113-b6d0-4542feccbd53	COMP-774324	cheque	717937.00	246708.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	2ed86228-5443-4fa2-8529-4d9a3ea96891	COMP-320027	courant	472159.00	87869.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
54d5e886-a7a4-4427-b256-7723400f3c4e	7d37a98b-65bc-420f-acef-3c48673507e2	COMP-157256	epagne	279491.00	99304.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
184d6244-4107-464d-9848-8140c6174183	8cf589a5-979b-4daf-b993-633dcc066eff	COMP-002862	epagne	144920.00	330360.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	af5527eb-47a6-44f0-a658-e7ac41575fc8	COMP-286938	cheque	152441.00	102479.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
a03dce74-58f6-42c7-8624-1d21ea760a90	3f89d232-821b-4fc0-870d-b030d5fa2fa9	COMP-110423	cheque	735723.00	18797.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
a5bad169-7741-4b82-9dde-4803bb629488	01599aad-5b40-418a-921e-10f9d2b42073	COMP-176920	courant	816312.00	275160.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
cb45ecae-4f73-42b2-870b-4f41321c9acd	866fa58c-964a-439b-ae75-caff3b0e3feb	COMP-435626	courant	41859.00	490663.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
4bb7fc9b-13d6-4883-b751-283b753d05ed	e69a2ea2-51ac-4806-a9e6-dd1abe23768a	COMP-908500	epagne	440204.00	151689.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
34b84e17-27b4-4080-a77b-3cdb00476a06	cc7bfbbd-d7d8-4c6b-821c-01f5c548bbb4	COMP-234112	courant	549647.00	449873.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
d5017ad9-771a-4ec6-8b01-e408480e8116	18565320-b658-4807-8baa-2059d5ad6aeb	COMP-051531	cheque	296492.00	30557.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	6ede63b6-2056-446c-8d65-ceaeb7e9918c	COMP-594316	epagne	848338.00	58652.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
a90e1a63-43fd-4956-af04-b3458780ca97	cf45b084-5490-40cb-9b36-f92ac4f91d28	COMP-054506	epagne	213888.00	30464.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
6c92b373-c286-44a2-94a3-cf8cf3479100	750b8316-b107-40dd-b281-4d24372be743	COMP-785641	courant	585821.00	372762.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
9119854e-1ca4-4c65-b01a-83ab7cc6baa7	671eb48c-99c9-4444-bb24-05d2b29519f5	COMP-651527	courant	311572.00	468625.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
c5b06daf-ba43-4954-b2b8-1065dfb122ab	4c4f0856-fcaa-4f71-a376-ffc7d899435d	COMP-008879	cheque	973383.00	74183.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	66917bfe-b112-46b7-8198-df9f848b165b	COMP-572455	epagne	621123.00	320094.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
91ad4baf-0c30-4dc8-b74b-db1edc6bff66	9fbf7fdd-8277-40fc-8aed-76952ca6d2f5	COMP-901410	courant	791063.00	138344.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	d2a023fb-82df-4bce-86be-51fc630399c3	COMP-145571	cheque	145619.00	1381.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	afe6c2c9-d3f2-4b8a-a0b5-885079b4209d	COMP-333653	courant	371563.00	206130.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
6bda7cb5-64c7-4f15-a2ac-be3c6f701017	d7140bbe-ec49-4f7e-8e13-ad1db47a991e	COMP-464652	courant	417469.00	383574.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
05c0a3e8-eeae-4976-88c2-848aec6bea96	9f9e36a6-66e7-4202-87ef-9d04398bfe8d	COMP-544997	courant	238284.00	221442.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
b26e640d-87a1-49a8-a880-2a2088a4fca0	dbe1ca9c-ff1a-48d4-9e15-dbeefb52cd4e	COMP-981698	epagne	837452.00	432007.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	a591ef34-cb6b-47ce-8df4-e663723b945c	COMP-298183	epagne	490027.00	114653.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
c2b93a8c-ea1e-4b85-8224-c209137135b0	c2fd2e6a-ecbd-45fc-9966-1f69c5d69159	COMP-336072	courant	670238.00	143077.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
a175ac58-1dc5-4041-b54b-19f48d3900a8	118cbf85-bbbd-4a58-8356-c38fb412d073	COMP-597375	epagne	966765.00	125328.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
9b7cf121-0b29-4457-b5ee-acddd651474c	be575917-2cd1-47c6-966b-72b8f6520e4f	COMP-317026	courant	548813.00	475091.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
74dbd6c0-5b7d-41ee-ba16-196ff2fec124	deea0ef0-1e98-43af-b187-cec41491109e	COMP-951416	courant	500657.00	83570.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
727ed0a8-67ac-4066-84fe-a29a0e13bb30	08f2f7d3-76ac-45c8-b322-fd5ebc21a2e3	COMP-545009	courant	344051.00	70368.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
b3c57074-cab3-490f-9d70-3da5066332f6	b276397a-f91c-46fc-a77a-541801840984	COMP-158620	courant	549407.00	325326.00	FCFA	2025-10-22 04:40:05	2025-10-22 04:40:05	actif	\N	\N	f
5cd10916-6dee-48e6-ab78-7995b1f1ce95	e95d1e5d-938b-48e1-8619-f66bd722bef6	COMP-123456	epargne	100000.00	100000.00	FCFA	2025-10-22 04:43:30	2025-10-22 04:43:30	actif	\N	\N	f
2b138895-6391-4bfe-b137-ca4fa7854a4a	a631f43f-0401-4166-b917-c4a38abb6889	COMP-627186	cheque	50000.00	10000.00	FCFA	2025-10-22 05:18:17	2025-10-22 05:18:17	actif	\N	\N	f
3014d690-a71d-4cb9-ba59-a6c4fea73558	e95d1e5d-938b-48e1-8619-f66bd722bef6	COMP-821722	epargne	25000.00	25000.00	FCFA	2025-10-22 05:18:50	2025-10-22 05:18:50	actif	\N	\N	f
188bace1-4ea4-4d21-83df-7b0a3d7bfefc	99982406-b20f-4cfe-9558-f41b4791cd69	COMP-719396	courant	48980.00	84833.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
914d5be6-2dc2-4063-8219-1ea664a8b058	54882760-d36d-4a76-960d-d7a403e13137	COMP-523248	epagne	9485.00	458476.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	5f8a767a-cb5d-475d-b1de-e7bd57e8780d	COMP-858318	courant	327177.00	296843.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
1ec106c4-a50d-4ad8-8365-f7ad69dd5630	b1a544b2-a3ee-4770-8c4c-28bc5bb8afdd	COMP-701690	courant	100256.00	411815.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
da2856ae-33c2-4d43-959c-2eb0fa7dcffd	8da18411-f9b5-409f-9c90-d45bb40fb73b	COMP-029955	epagne	291596.00	144774.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
31fb6207-f59e-425f-bf86-a1085c47b43f	bcacf6a7-2920-486f-ba69-f45491b46912	COMP-374673	epagne	64206.00	419130.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
818e8545-fc56-4437-b399-56970df2cc32	9d78ac0b-af96-4268-8af1-3b84c4a87b98	COMP-517431	cheque	271146.00	331404.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
03991212-82d0-40f8-aade-bd7a07550872	1353359d-ad23-44d4-bb0a-2202c8e87f75	COMP-440749	cheque	77306.00	470849.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
02e98a52-78e0-4f7e-a6e9-289e19f7a3f8	80b4336e-373e-442c-aec5-e13abaa78095	COMP-128989	epagne	469963.00	151492.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
af23b369-6d2d-416a-9f80-93ac47b6dde3	1646e3d1-ee65-4e92-a76e-b300cee2402d	COMP-137527	cheque	518863.00	449522.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
1b7cd94f-0234-49b8-9971-c35f0b951189	f73a560f-9ebf-4d55-9986-b737796a60f1	COMP-639925	cheque	123932.00	194611.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
e88eac49-5c57-48f8-824a-813a7da0fdc3	f2cb4304-c1d2-4d0b-a68a-ffad6cfacca5	COMP-649415	cheque	251501.00	470426.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
8cc906e8-f49e-48bf-97f7-063a96dd5855	bcd58031-fa35-4f1f-bd33-85c8545aff45	COMP-893558	epagne	642742.00	280830.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	775b50ae-6051-436b-aa1e-0a34b223cbb5	COMP-496181	courant	427933.00	140962.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
fe405432-6112-461d-87cd-a720335c4092	253faeec-5732-45c5-9f3b-9bfb71809282	COMP-152519	cheque	132426.00	88184.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
168369a2-765d-4e68-9282-e69cf56154cf	5c0038c3-020a-4d52-a5ff-ab344bb8f784	COMP-000544	courant	474628.00	489025.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
4339b8f2-e315-454a-b86f-e35bde749370	db91fa9f-28fb-40d9-a6a4-bb02f17fcbc9	COMP-913454	courant	648677.00	56103.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
edc37cd9-41c0-44ba-a8a4-f7da20914b48	608007af-54ef-4096-bd1c-f21c0cd4bf28	COMP-409115	cheque	849604.00	367542.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
ac532c01-37b7-44d5-bc6e-148843aaf375	765466f3-a8ca-4ad2-a3bf-c1413059c4bf	COMP-324395	epagne	493286.00	404914.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
087d0d47-8377-4f2f-82a8-6acbc6e148f1	d06cc0ae-5d4b-45db-96a0-b6fc53e57fc7	COMP-749889	courant	85615.00	222966.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
cc0d2546-7dab-4d38-a26e-fedf481485db	1aca3b3f-abd9-4e23-a94f-936cce30e0e5	COMP-216915	cheque	726759.00	356885.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
08360cab-6365-4da0-80a5-721ba954e61c	2b1645a1-620d-438e-bfcf-9759773d00b9	COMP-395856	courant	167256.00	457054.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
69e0c091-ecb6-4dfa-93ab-590209fb6e8b	516355b3-e848-43ae-ad6e-8b856ba05b00	COMP-957339	epagne	647228.00	115235.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	a14ee34b-cf1c-411f-89f7-867f23a52c6f	COMP-680704	epagne	77381.00	293565.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
43df68e0-310b-41d1-b272-3e281b325b72	4d15c1eb-3c36-47ea-990f-7aba19d33c01	COMP-914081	cheque	611536.00	448094.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	dabf9799-88ab-4c61-b07c-7dce6f42d704	COMP-261852	epagne	435876.00	210217.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
d3ba6f50-5b24-4a03-9002-ded93f5697a3	3f8896bf-70c3-4635-b1ff-974f72133f66	COMP-010194	courant	891673.00	266338.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
6a3575bc-ab64-4315-8ed7-124955e9c44f	953fc06d-59e5-4279-b8b4-8e61c3bd37d9	COMP-995450	courant	326822.00	348093.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
318d8033-6a1d-4dd6-a669-005de93483d3	2b834aff-cbd6-47e3-bf74-9fc1fd65b151	COMP-657430	cheque	946686.00	255138.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
9987f93d-ac57-4bee-aff6-41c16aebe2b4	ee116291-aa96-43bc-9f36-b07f22d7c1ff	COMP-104764	courant	29561.00	229065.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
849dcfa8-90dd-4efb-befe-4a819d763b77	11bab41b-7c5c-499f-b6da-aea5ffd88927	COMP-865314	courant	684654.00	21302.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
4497726b-2732-4f82-ac92-17bdbf1dbca5	3be51def-3a7e-48f0-a997-f0f7a67c71fd	COMP-104185	cheque	854607.00	79632.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
9cd12202-7a97-4ff8-907d-67b3f104c6b6	fec5675e-c248-4fb8-b9b7-7699e60c626d	COMP-864256	courant	755830.00	428457.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
2eab81ba-c2de-4108-9a0e-7ca81af2697c	c5d4defa-2049-4f5e-88e2-b6dd398ec919	COMP-680885	cheque	484471.00	297800.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	c399c020-ed92-4eff-bb1a-ab15638f094e	COMP-496570	cheque	659819.00	135818.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
4f6a44a5-082b-4a67-a0b7-3eae9da2d045	2f4712a5-d6e1-4a2f-a94b-a67cbca46035	COMP-592600	epagne	998247.00	353232.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
3535c846-b093-454b-9743-84b4b3fa9719	ec4c86e5-4e27-4f11-b3ac-d76e51a7fd8c	COMP-247703	epagne	588553.00	43498.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
94b14a72-e4f3-4e5f-ae72-8e6f72e4e901	56937b38-3691-4975-a8d7-1995835dc7d0	COMP-624960	cheque	712131.00	115452.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
e7088ab6-655b-4317-8cdf-46d3de12e2f0	137fae38-ff96-4ec9-a14e-7fd1f1ac316c	COMP-489482	courant	919582.00	467657.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
41e95b7c-81f4-4383-8e18-448d1ab5bd48	809f64b5-852f-4bd8-bc92-21beb24a4117	COMP-099284	courant	807927.00	130370.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
22398797-8a57-4530-b835-7193f3b0fca0	84c4d501-93ff-4a50-bb9c-24eadd9eff86	COMP-301686	epagne	762969.00	215798.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
afffc156-c61b-4b68-9c62-2a3812714585	ab3a556e-d8d7-4f04-b0df-8c37e535f091	COMP-235606	courant	882253.00	340814.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
c7cca6e7-9120-40e6-b0a2-2d86941c73f5	d53bd01e-ad5d-4a7e-b7ce-549dc914d751	COMP-255833	epagne	402270.00	84715.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
0f731b08-109a-4e89-972b-71f8608c0c55	0d53b67c-716d-46db-912b-bb4323ed42c6	COMP-109349	courant	601358.00	358106.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
76b21c81-8380-4df8-87ad-4f2fa9ff5159	ea54383d-cffe-478b-b9e7-3ed43a8ba1b4	COMP-792534	courant	98453.00	246027.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
e4d1caea-baee-4c55-aa8d-8208a299a3f7	94882288-1e0b-4f1b-844a-62202b21af9e	COMP-652369	cheque	36882.00	462242.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
bc779c73-ecf7-44f0-9794-281f495b5ff5	625679b3-24d1-4d02-b741-89b63c342f13	COMP-286759	epagne	852513.00	447105.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
f1e6f840-61c7-4618-bbfd-578d06a2431f	dbd9f4a0-9d1d-4890-8d3b-970959db5bee	COMP-161233	courant	817463.00	326480.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
5097b2e2-ee3c-4043-944d-ba4167071409	5504a004-c6d4-4849-b555-73e24eb755d7	COMP-465137	epagne	553268.00	363609.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
3d77ab88-c4f1-4715-8657-5361aeb99a2c	f834d3a2-6c1b-4464-a167-7225dcd69968	COMP-958283	epagne	528137.00	400329.00	FCFA	2025-10-23 10:59:12	2025-10-23 10:59:12	actif	\N	\N	f
ad629adb-377a-4725-9f12-556a170ef642	9f6b2e93-d025-41fd-8c7f-26663c13ec58	COMP-449150	epagne	428816.00	74072.00	FCFA	2025-10-22 04:20:05	2025-10-23 12:04:23	bloque	\N	\N	f
269d3156-3edd-4bda-99b1-a6cdf48bccdd	d64303e5-0889-4e00-a429-08391fdf6344	COMP-744661	epagne	374455.00	138706.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
e575ca40-926e-4fe2-9c4a-0af557a58c64	be7f8045-6242-4e77-ba75-75735db95e9d	COMP-823978	cheque	578005.00	489745.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
808e915e-a5d8-4751-aaa8-50fe040cde68	f3bd1f90-e7fc-493f-8931-d16766f9ba7b	COMP-738216	cheque	909151.00	476823.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
027e5061-71c4-4a85-af3a-32a651974095	f90fd66e-9a29-438f-adff-989e2e8099ea	COMP-056462	cheque	199913.00	23354.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
ac230aec-8c74-4964-ad30-44dbe9e58cc6	2774f358-8b25-4f61-a096-348dee14c533	COMP-765938	courant	781603.00	157187.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
0b7246d3-cd3d-4162-952a-709242caabaf	74d3477a-eb07-43ab-9379-05c3a67a8f37	COMP-521059	cheque	158593.00	8255.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	189c3ac4-3fc3-4323-8084-cfb2d618dadb	COMP-582477	cheque	345557.00	363214.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
b6facec9-8829-4da5-a631-d1f5680d2f75	4493e725-e510-460e-a232-eee311e89289	COMP-777205	courant	893798.00	481323.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
79fa87c8-8658-4ac8-a54a-53ff2fe252cf	227adbca-8d48-4101-854c-40a47c99d138	COMP-041894	cheque	432578.00	22040.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
f1187d5e-8bc4-4bb1-b970-9a025a5048c4	fabb0b79-d834-478d-b073-ef94c703aca0	COMP-902534	cheque	566065.00	433209.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
5f5f316c-0963-43fc-b6d4-599439e88c6f	5ec6b5c2-c08d-4a08-ae74-c820dad049bb	COMP-509372	epagne	105439.00	261323.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
f3db8624-1334-47ff-83bb-04592844270f	56f4c0cc-dc2d-44ad-b7bf-ce8a6d06e396	COMP-365973	cheque	387259.00	318356.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
dd05cd28-6e89-41fd-8a78-cba1c4607efd	9a008823-fd5a-4572-9aee-4f913256b40d	COMP-159443	epagne	399329.00	272652.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
3badd48d-41cc-4d4c-abfa-55dd1b3e0c1e	e87409c9-0d61-40c7-95f3-ada7d8231197	COMP-185723	cheque	815750.00	153442.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
aed8dd64-e196-4321-8ffc-52ce0cc7e7f7	b6078137-f31d-420e-b5fe-a2a4d052ae43	COMP-586979	courant	514689.00	150739.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
b03a8338-5679-4ed1-9ba5-d4a4cf3ff31d	4cafd6f3-364c-4e99-9bbe-7d3d39193e98	COMP-555545	courant	275337.00	174726.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	20e064f7-6c00-4c18-b60a-21bfb7ff987f	COMP-842462	cheque	954055.00	40167.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
aefad6a9-6ff4-4250-b79c-50f551aaa60e	0f63d569-95d8-406e-bbe6-3ac320fdfcca	COMP-499803	courant	66691.00	410403.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
f959068a-63bd-46ee-a42c-59d124c48cf6	07d7bef7-47b7-4441-9aa6-de48b9c40cf0	COMP-210763	courant	914015.00	276876.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
28a8f0a8-46fa-4589-96fb-a4bf01b6df29	28a2be62-5234-48b0-9470-13def4fd5952	COMP-499583	courant	863011.00	447123.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	950a49b5-9832-475d-925b-c63bdc529483	COMP-186244	epagne	599137.00	392278.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
7bd3be9f-34e2-4eeb-9f78-a68c083c1a96	e334f044-cbf8-4ece-846f-0caf94265a3c	COMP-370609	courant	47956.00	281164.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
5d3634bb-39ae-4beb-a70d-3f7ac49f03cf	66c884c3-122b-48fe-aa5b-1cc98a46807c	COMP-798818	courant	795394.00	292214.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
13b0280b-a95f-48ee-9c35-9fb3c4786166	f3fa1721-f9a8-4664-9922-d5504ba40c87	COMP-322044	courant	575082.00	14334.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
dbcd0804-e931-4453-9ad5-f978ceebb511	c89d8067-f233-437e-8196-998b558386cc	COMP-191682	courant	492170.00	322418.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
b9dbc5e1-4932-4b18-9442-6fbf74b31327	09e0f4ba-0b30-472c-ae3e-09d158543511	COMP-681878	cheque	832370.00	488240.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
5930a704-1cad-486a-bb5e-d5ebac8129b9	e8d0d439-43fd-4754-bf38-e1b4b79282eb	COMP-329259	epagne	44911.00	54493.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	f24f631e-6662-4968-b269-bc24c7889c34	COMP-327306	cheque	324204.00	53357.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
82b41651-c63d-4deb-85c6-3c688eddc121	173444b5-ac93-4e90-9f78-2d0041bf2acf	COMP-859039	cheque	653453.00	140522.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
be33e282-23c2-42e0-8042-11f125606cb1	fc6f527d-4c28-440c-b28a-461a65c53345	COMP-484358	epagne	843907.00	220301.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
24e04f46-72df-4b0e-9024-19c114c552aa	7e6fbd7a-f685-40cc-9e5f-7d03b1906b0d	COMP-877762	epagne	950799.00	95257.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
887e3007-f4a2-4b73-aee8-c70039319c5f	11f1d6a8-f31e-4251-ad6a-b80a7be1e838	COMP-731496	cheque	823304.00	166144.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
720b3789-49c5-4ccc-b8af-be59906bc1d3	0720eab1-98a8-4e1c-89f7-d12594d65b22	COMP-491072	cheque	545889.00	342469.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
4bc9a980-1950-4ed8-9b41-bbb0a53a929c	f5fdc916-b056-4ea5-9444-27c7603377c1	COMP-232449	cheque	300981.00	359155.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
0b052b84-a33e-44e8-90f7-d9d1bfe27464	fbbb3214-44c9-4ec2-b132-802761ea7d77	COMP-371063	cheque	76370.00	472393.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
4bf8b802-4714-4aba-a825-d61404c9d50f	e0e01e61-ef12-48d3-b0b7-6954f7b114b5	COMP-304425	epagne	948313.00	337412.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	b7256906-ecc0-4097-9804-66884b69a96f	COMP-726861	courant	976702.00	295765.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
503088f6-053b-4cbc-a00a-335ae839d447	3de7bc15-7c4f-4f86-8160-af93888121d5	COMP-776230	epagne	737164.00	241198.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
12a1bcc9-6ded-4708-8db3-3ebeb5632e08	30680227-333e-43e3-85b0-48886dcc9f3b	COMP-420016	courant	915377.00	272817.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
db289a68-fb56-4357-aa96-60bcaab5608f	3b01b9f6-cf1f-40e7-a0f1-58b155c057bc	COMP-287207	cheque	711626.00	259671.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
65a4491c-ce37-4732-aa4f-0de79bc822d1	b566af75-88b8-4acb-81a2-f47f0a1534e0	COMP-079413	cheque	834413.00	114127.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
66b42124-fa11-4ffb-a2a3-1fbd435829d3	4f6af01a-4996-47f9-a818-4dec5c0e01de	COMP-114437	cheque	12234.00	216661.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
94b4fef5-88d3-4b9a-98c9-1e0c6c697c0a	a60014fa-0410-4072-8e3e-1b3de32fb1db	COMP-954197	cheque	943507.00	84171.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	b26cfeee-3b3d-4c59-89f0-ac9c765d630a	COMP-146999	courant	403386.00	491241.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
4e9d8251-8bd8-4460-957a-dd1af608920f	6954d4d8-8ab6-4dc8-a5e0-3cad534e5154	COMP-060669	courant	168229.00	19679.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
64ee33cf-f4ed-4559-ab3c-48bccf04f75f	1559da65-b809-4ee8-ac12-49868ca42514	COMP-929593	courant	604588.00	99621.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
bc151b8f-a172-41b6-ab05-310ca341ebf3	c133c137-e152-44d6-a620-93284678a527	COMP-147869	courant	517309.00	464200.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
f61a5805-715d-476c-89ef-33958e3cf001	9a906672-ea5b-4bcb-b034-686e9bb10fe2	COMP-866206	courant	51329.00	272545.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
093dd33b-052d-4191-9176-9120502bd3b0	575d26c1-0813-4e84-8367-cede38ee69ed	COMP-021290	cheque	81346.00	390548.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	0b2c1a38-460d-400f-96a5-705bfd0e8c2d	COMP-375906	cheque	89842.00	233122.00	FCFA	2025-10-23 12:36:49	2025-10-23 12:36:49	actif	\N	\N	f
e5496e24-eb33-42e7-a4fb-383f1898b60a	c2380284-2ef5-4752-9d33-c5afdc1bbc70	COMP-658991	courant	98191.00	437125.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
61f94321-c86e-493d-8ba1-5b6e5ef64063	9c6429b3-b9dc-4a70-9926-b99c4b889374	COMP-546497	cheque	102035.00	34197.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
20d7013c-1f8d-43b3-8d18-8d8d60c4942c	8f53cfca-6446-49ad-85a5-be27b573b63e	COMP-981986	epagne	602857.00	173395.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
b0c691e0-8d66-4c05-8ebf-596b45ab0476	9fc6c038-d712-491a-a9ff-41a32f5ff707	COMP-197574	courant	627359.00	117013.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
ae724e88-4d86-4474-92d6-8806c133fd76	20564aa2-67ef-4152-93bb-e110cababf1e	COMP-348699	courant	578606.00	99507.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
b07ff9d6-dd45-4356-a9a4-64c7194982bc	883f34ee-9a30-4a34-8e0d-4b97e608e662	COMP-188725	epagne	308670.00	400874.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
c121d173-d02b-440b-8f36-5ae57c29610a	b65e3a40-9410-4252-8c2f-1d89ade02821	COMP-199944	epagne	972888.00	42167.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
9d8fd992-ce62-46b2-9321-2e641e71c450	e2fd2e62-02d5-4eea-9ce1-4caf3b363182	COMP-317248	cheque	799417.00	61165.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
c5b20c24-0b13-4067-a534-c8a1799b0755	4eb1ecae-ebd4-4e46-a4ba-b49808e1250e	COMP-644136	courant	522188.00	60248.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
aad99cb5-f3bf-4aea-a048-e4354ea2f729	eee6d77c-cb82-486d-8d99-8983fd023e67	COMP-557272	epagne	924479.00	433996.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
9ada2600-a0ab-4ae5-bca0-ff23b8508033	54e9ce95-fe73-488c-bf30-50f06df8c379	COMP-422522	courant	25130.00	4214.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
67604111-d36b-485d-a28e-df214fa8d166	1e71fe7d-91af-4b43-9cdc-0e8613934f22	COMP-027318	epagne	229293.00	259003.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
2455d16a-1584-46b6-b7ad-8e39aeff3de5	2be8ff2d-4ab6-435f-8874-d29b5c092e39	COMP-163981	cheque	314642.00	57694.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
c0167282-4f61-41ca-88c5-7fe182c9491f	585cd23d-f32f-4dc7-80ee-e0f294ec9384	COMP-890809	courant	893604.00	369920.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
82eb87f3-1665-428b-87f3-f8539213afbc	1fd9e1b4-1c7a-4d14-bc52-62780323a201	COMP-172438	courant	589907.00	402110.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
533c53ef-1bf0-4a74-8b6a-e915e776ad5d	f0faba84-8bc5-4704-a9f2-2e5f6d392c94	COMP-702034	cheque	298685.00	365678.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
648b5760-9a32-4f38-9b41-5f8e1a7204dd	5aac6f83-79a9-48b6-8a4a-782865f15711	COMP-510090	courant	458391.00	65534.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
4f90b617-4bb5-46f7-a829-96c70e537935	312bf9ac-ab47-4315-8a1a-09a6cc9135d1	COMP-040905	epagne	300495.00	303109.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
dada417c-5a95-4cfd-88e7-8587b5db8b6a	b4d97843-61e4-495c-b9b5-b7ac78eb212d	COMP-780659	courant	390643.00	265543.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
06275338-2f29-4f30-b1e3-3bc5436c0c64	8e9c0106-35ad-4b1d-91ad-6b53191f8cb8	COMP-101118	cheque	20353.00	280697.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
a63583c5-df6b-4a28-888a-9fab57af5eed	d7aa7097-b3ea-4c5f-b656-ab76b136ea47	COMP-275331	cheque	116447.00	236348.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
a2c09d2c-b287-4046-b1b1-bbdcae7a62ac	a7a361af-8205-4851-8129-1c2af68e185d	COMP-092069	epagne	452835.00	367147.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
cafa3370-5513-4e65-af64-05a84dd6b17e	38363bd8-1530-4842-a061-842163d5aeff	COMP-549463	cheque	365610.00	173220.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
91d99e34-5b96-4d39-a0dc-7de390db87a1	6fecd457-c9ab-4270-8ba4-15fe31e1d193	COMP-847173	courant	932318.00	35640.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
f3124880-02d1-4177-be9d-a3556de91607	1f220de4-cb0c-4700-bc06-d1dca2c1e26f	COMP-421159	courant	978821.00	219023.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
19b2a08a-101a-4e82-9194-cf16614ec0b8	5defe0dd-28e0-435b-8c32-19857e7074d0	COMP-891730	courant	144244.00	253099.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
18632b20-f36f-431c-b51d-aa6048d6a72a	73fcf66d-7b0b-49d4-a0a5-89a7d7637567	COMP-997982	epagne	852494.00	184250.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
b0c6d67d-fe42-4f75-840d-3affde6e0ff7	c6acc860-3168-4f33-82d5-0a22bcfeb066	COMP-795418	epagne	448817.00	444036.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
bb0ddd60-5795-40f5-8ab3-8dcc6a1a0644	fd19cd7d-0bdf-409a-9d20-13e8f8eeebc9	COMP-682931	courant	673408.00	204001.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
50bf3152-fce0-43c0-90ff-bdee42173a05	b199f85b-0efa-4f5f-ada0-f29d7929afb1	COMP-774245	epagne	323493.00	305077.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
1ada593b-83db-4615-9700-f8d85b341383	06e2bdf8-720c-484d-b9c4-ef0696c0e5d4	COMP-071271	cheque	344584.00	235851.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
2471446d-dfa4-489a-87e5-cea58b75bd28	ab1e1cc7-24f1-4d7e-988c-c8574b5757a6	COMP-208930	courant	727003.00	25249.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
51b6b19c-e030-4361-af7f-43f8889b9abe	060bc4ff-0a57-4f77-addd-6d01c6b00411	COMP-047149	epagne	662379.00	39120.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
b2611b1f-555c-42ef-a583-68e1844fa22e	b1d3dc1c-0da7-4a99-b36c-9c86b448b3a1	COMP-093398	epagne	415899.00	426868.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
28e94a4f-6351-4cc3-9b58-728fcf59effd	08b5712e-2ebd-4308-b553-a6e6c8c874fc	COMP-174912	cheque	222821.00	145937.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
dc8d9f22-1d0e-449b-a3ea-4daab8d18405	25b66ab5-4af7-4ef0-8666-a7e59910937a	COMP-815258	epagne	397759.00	462138.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
0e6cddc1-6135-4ca9-a5f1-231f06da5a80	58aeccce-c992-48b1-8525-ceba74e0d984	COMP-880913	epagne	980478.00	12514.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
f61036c8-1b48-4e28-b938-43d0c2032c1d	9f8d117b-9197-4867-84f3-1353fbba47b9	COMP-658144	epagne	378668.00	356579.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
bea7cc4b-6283-46fa-a958-a588d8c90ee0	9018c601-008c-403d-8699-ef7a344f9693	COMP-579995	courant	757058.00	466011.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
33210cda-cbaf-443d-839b-a2a85efc12e1	310af7e2-459c-4389-95a9-2a14120a5d14	COMP-070430	cheque	329912.00	271783.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
d555487b-a73c-441f-b8e2-0b7860a7b96b	e408f8cc-48d4-4b05-ab31-51389d1974c3	COMP-481907	courant	162066.00	189353.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
b8c898bb-3ae3-4269-acde-b3c28c1cf1c3	b26d5338-1b39-4b39-9187-d0d59502f042	COMP-104291	courant	980763.00	74788.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
f42e8de8-f907-44b6-87b7-859621653260	2d2149f4-4b01-4bef-bb7e-753dc082994f	COMP-196853	epagne	839515.00	181661.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
34564eda-7faf-49b2-85fa-6a0ba58ce905	f97deb37-d4d0-475d-b79d-3977771e9145	COMP-571309	epagne	983988.00	10388.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
d0213b5d-86b8-4356-92f4-503da697fcdf	3e9a8a96-e0e8-4b46-8ef6-fe4a0e42604b	COMP-814439	epagne	271680.00	14157.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
f15ee114-3081-4f99-a60b-05b307d86c1d	9a395d5f-8178-44f3-ae46-efab9bfb3d3e	COMP-880180	cheque	890226.00	250160.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
80307558-5c3d-4337-92f1-397a99f618d0	8212eba5-5162-4bd4-a681-3e4e79bfc244	COMP-959660	courant	470255.00	338517.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
b7904089-7d3a-47f6-8efb-79a851f24621	41c6c86a-ab47-4628-a123-e58f13dbbab4	COMP-191355	courant	200658.00	124325.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
fd033269-1eb0-4cce-8998-c9a410e93a7f	73f25e8e-e71f-4673-a4f4-0d7700eb35c4	COMP-360486	courant	119802.00	408723.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
c51a4c41-e023-4335-899f-f9e52d0b0c52	27d519fc-0043-4115-b269-867decbcd046	COMP-338775	epagne	32337.00	255232.00	FCFA	2025-10-23 14:44:54	2025-10-23 14:44:54	actif	\N	\N	f
e586d59b-7c8b-4eb4-b54b-8db765e2ed18	3f9f8fdc-c21f-4ead-b053-c968bb0500e0	COMP-934511	epagne	506393.00	363594.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
6be8565e-ae22-47eb-9001-5d12ee218ea5	96597611-d7ff-44e1-ab30-d535732ccd16	COMP-628050	epagne	836177.00	21478.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
1c461163-04f5-4d61-95b3-4b1f383cf679	4e1ed019-881e-44ef-93f3-7634237cc7c4	COMP-880101	cheque	511753.00	490742.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
70c412aa-da63-4590-bbf7-6161c17bdb61	a89012e6-9650-4269-a393-7468fcad2ba7	COMP-801732	epagne	87123.00	165756.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
7aa423cd-9b51-49c0-9732-248009a1e987	c23b7e14-533c-4427-95e1-d8670cfff8d1	COMP-304766	epagne	632857.00	181845.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
458d13a0-2a2d-4982-a426-1a5b297cdfbc	02e979b7-df6e-4278-800a-580557e9d20c	COMP-318580	epagne	448334.00	499410.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
913c08e3-dd87-4971-aa30-fc736cfc021d	958647dc-0594-4ad7-84b9-cf52113887eb	COMP-038600	courant	619155.00	155851.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
a24554c0-2b4d-499d-88ae-4d4bba5c2135	835e06cb-f0de-4363-b338-82a4cebfb918	COMP-264137	cheque	521373.00	172897.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
7e5a47e4-0cea-4e34-a074-4dabc6a6aafc	8545d202-12b5-478c-83c2-ec99895e3897	COMP-671892	courant	649343.00	200522.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
2cc545d8-16a6-4c4a-b117-1e21b91fb185	2ad2a10b-b6b7-477e-8fa0-ed13a3e05251	COMP-587678	epagne	419424.00	498625.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
2be50050-a6d9-43ab-b501-dbdb217d5db4	485ccb4e-41b2-4ca5-8d89-9895129117f2	COMP-989115	cheque	227829.00	153927.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
7c6cd8ec-4f17-4560-bd1e-2ce4dc926eaa	b7514ab4-83c8-4255-a5da-bee9ff513e8f	COMP-515954	courant	405079.00	451589.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
8890795c-f9cb-49a4-ae64-185bd169c633	f7849e59-84ad-48c5-85d5-26f2d8c67350	COMP-550319	cheque	807059.00	414000.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
a3413d89-e325-4e97-a3e8-f566be3a6ea8	69da8650-c68f-41a4-8581-abec6908c1f5	COMP-301670	epagne	557402.00	139536.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
6271b98b-1c53-4839-8ce2-28f27784922c	c578c7e4-b1a0-40fc-a5fa-2074f43ae525	COMP-203088	cheque	633066.00	210554.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
3d2f50af-3d8f-4858-801e-88da9832978c	8342e838-5fb5-450d-9a04-7077bf53798a	COMP-665865	courant	477522.00	69111.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
00da18fa-383e-449e-b491-bd51ebe92057	65692618-1f0f-4802-ba53-3f1900a9e423	COMP-222883	courant	338803.00	410494.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
0a83ed62-12b9-490a-9d3c-36b86f693941	2cbaeefb-21f8-4044-bc46-f82f925fa072	COMP-631065	courant	560603.00	410205.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
e258fd21-4e8e-4934-9168-8ff48eec3be3	98ae6e6a-1d52-44b9-8ce7-029985bf1a69	COMP-557929	epagne	726747.00	173813.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
7a9a5d8c-44e7-460d-9267-74fe070a0278	2f581332-e02e-47c4-8f46-105b84d2bb7d	COMP-588054	courant	5949.00	168241.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
1636858a-1e88-4b11-83b7-a4564c211333	9c21ac8d-ee73-4089-bc8c-cc4f165ab022	COMP-902770	cheque	875012.00	357622.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
4f33b533-8be6-4c06-aeb6-2600aa842660	1bcd7dc6-4941-4392-a243-c649741dff89	COMP-332106	courant	634688.00	95826.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
2bd83573-95bb-4767-87bc-e2889d020e9e	d308384f-9497-4268-8362-04d7f162fe02	COMP-895019	courant	876061.00	249709.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
971338c4-6f66-4a47-871d-f7a40e8c0ca1	45097f9a-6019-4c55-aa68-c50a56132564	COMP-602549	cheque	108581.00	404811.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
0100351c-f704-43f7-ae5a-4d652f2743ab	c22841cf-0fff-43b3-90cc-a736b1922aca	COMP-351154	courant	927422.00	26559.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
da0abaed-f988-4bc3-aa46-aa011c2cc76c	a928c404-8b78-421f-b69e-5d802fdf45f9	COMP-118882	cheque	88004.00	306890.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
b0203987-282b-44f8-8c2b-86050e7073a8	a4a41854-123c-4413-bfd6-2c3fa234c07d	COMP-236876	courant	850501.00	481277.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
a91c8a32-aa7d-4d1a-9d35-11d69a6f5a30	573d87f1-a232-4d8d-8474-0842411014a4	COMP-900048	courant	310269.00	293834.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
ab8d2929-c0da-4ed2-87ad-0764234913fd	29325606-cf22-41e5-b3f9-5cce80d8c62d	COMP-781574	cheque	185813.00	223514.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
68eb068c-dd64-44e8-b362-7ebd10a576b7	275d408c-1fd7-487d-a07b-587f0820c86c	COMP-942759	courant	717090.00	484156.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
f67a5864-e1f0-46d0-a16b-f1fb37f1283d	51b37655-c125-4f99-81b1-11fa5b9d7057	COMP-443323	courant	255388.00	479260.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
e6990e06-da2b-41c1-9cca-2eda027f6b79	45f6e49b-72ec-42d9-80cd-aa46bf0fd665	COMP-694260	epagne	723213.00	477644.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
bcc4f58c-d140-4f0a-afdd-352fa6827efb	b882b8ca-f54f-4a07-9f9a-a52e20667ca9	COMP-240893	courant	331101.00	227858.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
0d73ef85-3296-421c-89af-88b933ba10bb	53037a48-3784-4223-88f9-d7e638e29324	COMP-269650	cheque	230089.00	246214.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
e31291b8-4f9e-49d5-a22f-9abce1b74884	10d8f80c-b67d-40b3-9c28-57da1d0209ce	COMP-302665	epagne	260182.00	28284.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
48be86b4-ff3a-4dfa-94e8-7562344620a1	f7b39e08-6193-41f7-a372-def509353bb4	COMP-621508	cheque	242129.00	303767.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
69b36b7a-22d5-44ef-b4aa-79c4cf7152c5	6ba716a8-fdec-48c1-973d-b2c80c28473d	COMP-324386	epagne	127366.00	479190.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
a10e8d36-43cb-4627-97d8-2c1da31d3cff	4f8da565-0131-44c8-9bac-9bd2af7c5e58	COMP-587229	cheque	296679.00	258663.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
f78cf760-a7ed-43ae-bb00-149c0ba02b8d	dc312743-fc63-420e-9bf2-bd6b0c5ee8ed	COMP-699435	epagne	306801.00	468477.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
65a632af-78e9-4c82-ae11-6ded84edb484	8828069e-4a6e-40d6-b360-12364f9f3d7b	COMP-126072	courant	333659.00	423304.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
5097908e-091e-4175-8c0c-31db86fe6c7a	9b224f29-ea11-463a-a9a7-68e6043cc329	COMP-951611	courant	648237.00	374890.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
a2b0cd15-6373-4114-a6ea-0d4ab1a6f831	74817ff3-57b3-4fdc-9d6a-82bc62f1f6c5	COMP-070670	epagne	649540.00	144776.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
57ac3124-b1a2-43fd-801f-8907869c355f	01922bbf-b20b-440a-9476-5de03cb1c029	COMP-087988	epagne	791639.00	455150.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
431d7eb2-8b26-4329-b376-3a91c85a3a37	4d93e52a-a5ab-44a1-a786-0f92a42a5353	COMP-275362	cheque	624087.00	132680.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
4d383773-f1d7-499c-a8aa-ce58a5f8fdf4	2c1b850a-e99c-48ec-80dc-e7971d1c3573	COMP-575154	epagne	639522.00	149335.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
0b22754b-afcf-4047-88e6-3893099d0f88	6f8437fb-559c-4002-8b26-5e7d36b6bc99	COMP-697801	cheque	749403.00	34064.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
323c24ad-a127-4120-8a96-36029e90947b	d82c62a8-6b0e-4678-9286-053b2bfe9bd3	COMP-665243	courant	65618.00	189201.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
a07cca88-82c2-4c8b-8414-4c940a4b7776	b2724679-8d79-4d1f-b372-943d446efb20	COMP-499649	epagne	716657.00	330812.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
d2e940bb-d795-4a9e-ad3e-92aa80c90ef4	f1b606a9-1ac9-439c-8597-459b9e03656a	COMP-705497	courant	661976.00	184920.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
f575d8f5-e487-49cc-9b50-bab4eb103237	8882db1c-0f07-449e-a149-a303838ea893	COMP-745925	epagne	404764.00	347084.00	FCFA	2025-10-23 14:46:42	2025-10-23 14:46:42	actif	\N	\N	f
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: mon_user
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: mon_user
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	2014_10_12_000000_create_users_table	1
2	2014_10_12_100000_create_password_reset_tokens_table	1
3	2019_08_19_000000_create_failed_jobs_table	1
4	2019_12_14_000001_create_personal_access_tokens_table	1
5	2025_10_22_033922_create_clients_table	1
6	2025_10_22_040018_create_comptes_table	1
7	2025_10_22_043633_add_statut_motif_to_comptes_table	2
8	2025_10_22_044040_add_role_client_id_to_users_table	3
9	2025_10_23_103341_create_transactions_table	4
10	2025_10_23_103924_add_soft_deletes_to_comptes_table	5
11	2025_10_23_104051_add_archived_to_comptes_table	6
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: mon_user
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: mon_user
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
2	App\\Models\\User	2	test-token	382a50c931f5cdbf77ad41af6df28649fe190a9df139a29ed4a934b05b1bd9d1	["*"]	2025-10-22 04:43:35	\N	2025-10-22 04:43:03	2025-10-22 04:43:35
1	App\\Models\\User	1	test-token	97f0eba3e0d4f999fe4c337e09ed94b32d06571315f8c414f5be0f3e424a0094	["*"]	2025-10-22 04:43:45	\N	2025-10-22 04:42:20	2025-10-22 04:43:45
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: mon_user
--

COPY public.transactions (id, compte_id, type, montant, solde_avant, solde_apres, devise, description, compte_destination_id, created_at, updated_at) FROM stdin;
3c2c6d9a-bcab-4eb8-ad3c-cd461d052eab	ad629adb-377a-4725-9f12-556a170ef642	retrait	14782.00	74072.00	59290.00	FCFA	Paiement par carte	\N	2025-08-16 03:29:20	2025-10-23 10:35:30
261885a2-0497-46ae-8957-2b5430c6fb64	ad629adb-377a-4725-9f12-556a170ef642	virement	34785.00	74072.00	39287.00	FCFA	Virement salaire	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	2025-09-09 06:46:51	2025-10-23 10:35:30
d6d4a64c-9bd0-4a57-9511-d17c1a1c553a	ad629adb-377a-4725-9f12-556a170ef642	virement	13844.00	74072.00	60228.00	FCFA	Transfert entre comptes	792c8ff4-749b-469b-95d0-9b98c2283684	2025-07-23 10:31:15	2025-10-23 10:35:30
bc64fd54-231b-4a5a-af09-d15e47686940	ad629adb-377a-4725-9f12-556a170ef642	virement	31296.00	74072.00	42776.00	FCFA	Virement vers compte	184d6244-4107-464d-9848-8140c6174183	2025-05-11 01:12:05	2025-10-23 10:35:30
a49ea879-9fc9-4cf3-9a93-66d45d629cfd	ad629adb-377a-4725-9f12-556a170ef642	retrait	3141.00	74072.00	70931.00	FCFA	Paiement par carte	\N	2025-08-05 04:55:46	2025-10-23 10:35:30
4b0265ec-2bb6-4ecf-b9b1-6a8797037d02	add2482a-de00-41d8-a772-cd4ef6546baa	depot	21372.00	201835.00	223207.00	FCFA	Dépôt espèces guichet	\N	2025-04-29 18:23:11	2025-10-23 10:35:30
1b9d1885-e35b-4e1b-be0a-b120c89b8990	add2482a-de00-41d8-a772-cd4ef6546baa	depot	43304.00	201835.00	245139.00	FCFA	Dépôt d'espèces	\N	2025-06-16 21:49:14	2025-10-23 10:35:30
f360eb4e-4fc0-4a3c-abea-787a41fc3b82	add2482a-de00-41d8-a772-cd4ef6546baa	depot	42626.00	201835.00	244461.00	FCFA	Dépôt chèque	\N	2025-07-30 19:32:01	2025-10-23 10:35:30
29e8a793-62fe-4f87-ac5a-b1f414a5d63f	add2482a-de00-41d8-a772-cd4ef6546baa	virement	1570.00	201835.00	200265.00	FCFA	Transfert bancaire	0006e5f7-4df5-46a5-8f9e-90089c5ea052	2025-04-30 07:34:58	2025-10-23 10:35:30
f5e38e0a-1eee-42cd-b331-c68638e6767e	add2482a-de00-41d8-a772-cd4ef6546baa	retrait	18212.00	201835.00	183623.00	FCFA	Retrait guichet	\N	2025-09-23 10:44:18	2025-10-23 10:35:30
e0167bc6-d422-4f16-a27f-01ab933f8e84	add2482a-de00-41d8-a772-cd4ef6546baa	depot	6547.00	201835.00	208382.00	FCFA	Dépôt d'espèces	\N	2025-07-25 16:31:10	2025-10-23 10:35:30
40da8c06-e228-47da-9d78-36c048be2d6a	add2482a-de00-41d8-a772-cd4ef6546baa	depot	11750.00	201835.00	213585.00	FCFA	Versement salaire	\N	2025-07-17 11:28:51	2025-10-23 10:35:30
b7303cc3-7c33-4c06-8c74-96aaea6ce763	add2482a-de00-41d8-a772-cd4ef6546baa	retrait	21088.00	201835.00	180747.00	FCFA	Retrait d'espèces	\N	2025-09-11 13:37:51	2025-10-23 10:35:30
5f8a32cb-92d3-43a4-b390-0dd7ac87352d	add2482a-de00-41d8-a772-cd4ef6546baa	depot	24824.00	201835.00	226659.00	FCFA	Dépôt d'espèces	\N	2025-10-09 12:33:21	2025-10-23 10:35:30
95525700-2c24-4f6f-8832-8110bfa9544e	add2482a-de00-41d8-a772-cd4ef6546baa	depot	46382.00	201835.00	248217.00	FCFA	Dépôt espèces guichet	\N	2025-09-14 16:15:04	2025-10-23 10:35:30
2474f00f-a892-4e78-8242-533347a517d8	add2482a-de00-41d8-a772-cd4ef6546baa	virement	24425.00	201835.00	177410.00	FCFA	Paiement facture	8a4ca722-53cc-428f-a83a-d84a7f681abf	2025-05-11 12:19:25	2025-10-23 10:35:30
9f2485b6-8fad-46d2-989c-2d107472a209	add2482a-de00-41d8-a772-cd4ef6546baa	virement	22553.00	201835.00	179282.00	FCFA	Transfert entre comptes	3b545ec9-8048-4c12-a074-df603671d400	2025-09-18 01:13:47	2025-10-23 10:35:30
5be11bb2-9c1a-4814-b9d2-4647fbd37bd7	37da1638-f10a-4a03-9eb4-9eb960273866	virement	6748.00	26944.00	20196.00	FCFA	Paiement facture	916bbfef-cee4-457b-a001-da8e5b0be63d	2025-10-19 02:05:20	2025-10-23 10:35:30
785cc9d4-94ab-4e2f-80bc-4c5e99793a92	37da1638-f10a-4a03-9eb4-9eb960273866	depot	9974.00	26944.00	36918.00	FCFA	Dépôt espèces guichet	\N	2025-05-13 13:25:47	2025-10-23 10:35:30
9b823ff1-76ec-493b-a4e0-b29ecf4b0fc9	37da1638-f10a-4a03-9eb4-9eb960273866	depot	7984.00	26944.00	34928.00	FCFA	Dépôt chèque	\N	2025-07-29 17:21:58	2025-10-23 10:35:30
1d342816-2050-4fbc-9088-7bca9eba4e40	37da1638-f10a-4a03-9eb4-9eb960273866	virement	46074.00	26944.00	0.00	FCFA	Transfert bancaire	a90e1a63-43fd-4956-af04-b3458780ca97	2025-09-25 15:26:58	2025-10-23 10:35:30
6fb706d3-eb6e-493a-955e-f6b08225147f	37da1638-f10a-4a03-9eb4-9eb960273866	depot	36812.00	26944.00	63756.00	FCFA	Dépôt chèque	\N	2025-07-27 22:17:16	2025-10-23 10:35:30
8f29d51c-37b7-4d28-9091-aee0277bd6d9	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	virement	23022.00	215784.00	192762.00	FCFA	Virement salaire	6c92b373-c286-44a2-94a3-cf8cf3479100	2025-08-09 09:37:49	2025-10-23 10:35:30
c263d2b6-c399-4a5d-b650-34050db63caa	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	depot	30874.00	215784.00	246658.00	FCFA	Dépôt chèque	\N	2025-05-23 13:59:08	2025-10-23 10:35:30
28d5e008-848c-41e6-aeea-834d485522b7	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	virement	40174.00	215784.00	175610.00	FCFA	Transfert bancaire	d725e859-df50-4ee3-8ab9-65d82dc7fd71	2025-06-20 13:11:33	2025-10-23 10:35:30
88dcb84d-cf64-4668-8b61-cbffbcc1a067	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	retrait	39408.00	215784.00	176376.00	FCFA	Prélèvement automatique	\N	2025-07-02 11:12:34	2025-10-23 10:35:30
06cc4b0f-e8e0-4b31-8e68-b5e06ffb2a0c	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	retrait	44298.00	215784.00	171486.00	FCFA	Retrait d'espèces	\N	2025-07-29 10:15:30	2025-10-23 10:35:30
3c1e383e-e46f-418d-b896-51b40dd77e45	0006e5f7-4df5-46a5-8f9e-90089c5ea052	retrait	9079.00	65792.00	56713.00	FCFA	Retrait DAB	\N	2025-08-17 19:22:27	2025-10-23 10:35:30
a1373053-0412-4bf1-88b8-ef3cee2526cc	0006e5f7-4df5-46a5-8f9e-90089c5ea052	virement	37419.00	65792.00	28373.00	FCFA	Paiement facture	61bcb7e8-d7d1-45da-9b25-70fba627d304	2025-07-13 16:18:10	2025-10-23 10:35:30
033bbf37-c6de-49d5-aa59-5e889f964f39	0006e5f7-4df5-46a5-8f9e-90089c5ea052	retrait	2332.00	65792.00	63460.00	FCFA	Prélèvement automatique	\N	2025-10-14 10:52:08	2025-10-23 10:35:30
9b95025f-3241-42e9-8a9c-4a7ded87e978	0006e5f7-4df5-46a5-8f9e-90089c5ea052	retrait	20173.00	65792.00	45619.00	FCFA	Retrait d'espèces	\N	2025-05-12 23:16:36	2025-10-23 10:35:30
b08da608-04cb-494b-9a46-807044e2d67d	0006e5f7-4df5-46a5-8f9e-90089c5ea052	depot	27151.00	65792.00	92943.00	FCFA	Dépôt chèque	\N	2025-09-13 06:55:09	2025-10-23 10:35:30
cf4f0759-e5e8-43de-b62e-795d54c4db9e	0006e5f7-4df5-46a5-8f9e-90089c5ea052	virement	33361.00	65792.00	32431.00	FCFA	Paiement facture	f46f2dde-ba75-4234-b729-67c0cd2a3ade	2025-05-18 10:37:44	2025-10-23 10:35:30
cb378db4-230e-4360-a309-3e2e230f3d8b	0006e5f7-4df5-46a5-8f9e-90089c5ea052	depot	32996.00	65792.00	98788.00	FCFA	Dépôt espèces guichet	\N	2025-08-16 11:23:34	2025-10-23 10:35:30
615e1382-67f0-4745-93b8-38a808a963b5	0006e5f7-4df5-46a5-8f9e-90089c5ea052	retrait	19380.00	65792.00	46412.00	FCFA	Prélèvement automatique	\N	2025-10-22 10:47:47	2025-10-23 10:35:30
68fc8c78-d933-4a80-96b8-5a97bfcaaa5a	0006e5f7-4df5-46a5-8f9e-90089c5ea052	retrait	28012.00	65792.00	37780.00	FCFA	Retrait DAB	\N	2025-09-06 07:42:08	2025-10-23 10:35:30
d520863a-01b8-420a-8dd4-e08bcaeadd3b	0006e5f7-4df5-46a5-8f9e-90089c5ea052	depot	34990.00	65792.00	100782.00	FCFA	Versement salaire	\N	2025-05-26 14:55:52	2025-10-23 10:35:30
db084329-be1f-4a55-a2f2-7df775978ffd	e774b1e8-095f-4684-a770-c420e32f477a	retrait	26999.00	126373.00	99374.00	FCFA	Retrait guichet	\N	2025-10-19 00:25:24	2025-10-23 10:35:30
21f92c76-703b-4d1b-bf1d-4f7184a8aff9	e774b1e8-095f-4684-a770-c420e32f477a	retrait	40335.00	126373.00	86038.00	FCFA	Paiement par carte	\N	2025-05-28 18:59:40	2025-10-23 10:35:30
43e6a17c-f6fa-4192-9179-d3848c723f33	e774b1e8-095f-4684-a770-c420e32f477a	virement	5611.00	126373.00	120762.00	FCFA	Paiement facture	37da1638-f10a-4a03-9eb4-9eb960273866	2025-07-19 13:00:19	2025-10-23 10:35:30
58ef7a69-d9f7-4544-992f-d1a8363d4ce9	e774b1e8-095f-4684-a770-c420e32f477a	retrait	36834.00	126373.00	89539.00	FCFA	Retrait guichet	\N	2025-08-27 14:57:01	2025-10-23 10:35:30
476d185e-95ff-42b9-9613-f373b1f1e47f	e774b1e8-095f-4684-a770-c420e32f477a	retrait	24318.00	126373.00	102055.00	FCFA	Paiement par carte	\N	2025-06-20 19:42:40	2025-10-23 10:35:30
40ef8dc3-d541-43a7-af68-75c96d36b17c	e774b1e8-095f-4684-a770-c420e32f477a	retrait	30855.00	126373.00	95518.00	FCFA	Paiement par carte	\N	2025-06-28 15:49:38	2025-10-23 10:35:30
97da1301-6092-4d36-9a37-3a0295def54b	e774b1e8-095f-4684-a770-c420e32f477a	depot	19103.00	126373.00	145476.00	FCFA	Dépôt espèces guichet	\N	2025-08-27 20:50:00	2025-10-23 10:35:30
00421c77-5bb3-4506-a3de-dbdde4d3bdd0	e774b1e8-095f-4684-a770-c420e32f477a	retrait	1709.00	126373.00	124664.00	FCFA	Paiement par carte	\N	2025-05-13 09:44:00	2025-10-23 10:35:30
b8138b15-d9c3-46ed-aced-d352fe7e0815	e774b1e8-095f-4684-a770-c420e32f477a	retrait	38462.00	126373.00	87911.00	FCFA	Retrait guichet	\N	2025-10-12 00:31:27	2025-10-23 10:35:30
19f9cefd-6bb8-478e-a120-f9884b1fbdc5	e774b1e8-095f-4684-a770-c420e32f477a	virement	15763.00	126373.00	110610.00	FCFA	Paiement facture	c2b93a8c-ea1e-4b85-8224-c209137135b0	2025-09-24 23:24:17	2025-10-23 10:35:30
df5624b4-6239-4bd3-bc42-6a8628da1bdc	8a4ca722-53cc-428f-a83a-d84a7f681abf	retrait	34214.00	447100.00	412886.00	FCFA	Retrait d'espèces	\N	2025-09-22 06:01:32	2025-10-23 10:35:30
c40fb286-73d2-4a75-a881-e98ae1a332a9	8a4ca722-53cc-428f-a83a-d84a7f681abf	depot	30816.00	447100.00	477916.00	FCFA	Dépôt d'espèces	\N	2025-10-04 02:21:56	2025-10-23 10:35:30
42311890-e021-45f7-828e-cd4f1356f813	8a4ca722-53cc-428f-a83a-d84a7f681abf	depot	14017.00	447100.00	461117.00	FCFA	Dépôt espèces guichet	\N	2025-08-19 05:32:22	2025-10-23 10:35:30
6b120914-aad5-43e7-a6cc-98558b21b06d	8a4ca722-53cc-428f-a83a-d84a7f681abf	depot	13084.00	447100.00	460184.00	FCFA	Virement bancaire entrant	\N	2025-08-08 04:35:31	2025-10-23 10:35:30
c070d502-6105-4990-9007-efc43811e984	8a4ca722-53cc-428f-a83a-d84a7f681abf	retrait	20163.00	447100.00	426937.00	FCFA	Paiement par carte	\N	2025-08-20 08:20:57	2025-10-23 10:35:30
37be221b-c822-4422-aaf0-41ae65caac6a	8a4ca722-53cc-428f-a83a-d84a7f681abf	depot	6320.00	447100.00	453420.00	FCFA	Dépôt espèces guichet	\N	2025-05-10 08:09:10	2025-10-23 10:35:30
f0ad6a16-f51c-4bd3-9580-053f2df77b12	8a4ca722-53cc-428f-a83a-d84a7f681abf	virement	16889.00	447100.00	430211.00	FCFA	Virement vers compte	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	2025-09-30 10:58:56	2025-10-23 10:35:30
390ab608-e526-43b9-8867-4c8414f16341	8a4ca722-53cc-428f-a83a-d84a7f681abf	virement	15249.00	447100.00	431851.00	FCFA	Virement vers compte	1a2a915d-173c-44e7-a655-e29b9a02fd18	2025-07-21 07:08:54	2025-10-23 10:35:30
76c6a33a-d134-4aaf-b1ba-019b9ac06eac	6131421b-d7d7-4f56-8450-582c37486f68	retrait	48143.00	348073.00	299930.00	FCFA	Retrait d'espèces	\N	2025-06-08 23:20:42	2025-10-23 10:35:30
a34798b3-a076-4114-9f48-3926dcc8c758	6131421b-d7d7-4f56-8450-582c37486f68	virement	32757.00	348073.00	315316.00	FCFA	Virement salaire	232f5785-5fd1-4398-91e2-4f92589e1d8d	2025-07-11 01:39:51	2025-10-23 10:35:30
8db472b5-8677-4d55-a73e-b6adca23a91e	6131421b-d7d7-4f56-8450-582c37486f68	depot	23501.00	348073.00	371574.00	FCFA	Dépôt espèces guichet	\N	2025-07-10 01:54:01	2025-10-23 10:35:30
10b77b6d-ca2f-4af5-b44b-c9adcc98c8f0	6131421b-d7d7-4f56-8450-582c37486f68	depot	41393.00	348073.00	389466.00	FCFA	Versement salaire	\N	2025-07-03 01:37:53	2025-10-23 10:35:30
e2dbcfbf-6389-4f59-aba3-eba3d1ed81d9	6131421b-d7d7-4f56-8450-582c37486f68	virement	26539.00	348073.00	321534.00	FCFA	Transfert bancaire	c2b93a8c-ea1e-4b85-8224-c209137135b0	2025-10-07 12:00:10	2025-10-23 10:35:30
d2136c2a-f6b4-453f-b527-932d87fa1ab4	6131421b-d7d7-4f56-8450-582c37486f68	retrait	14488.00	348073.00	333585.00	FCFA	Retrait guichet	\N	2025-06-02 22:20:36	2025-10-23 10:35:30
eea6818c-3378-4e37-8477-fb14abd2d117	6131421b-d7d7-4f56-8450-582c37486f68	virement	9000.00	348073.00	339073.00	FCFA	Transfert entre comptes	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	2025-10-13 18:09:12	2025-10-23 10:35:30
8ce0e256-c4ea-43e4-93b7-f368f3e8c6dd	6131421b-d7d7-4f56-8450-582c37486f68	retrait	32368.00	348073.00	315705.00	FCFA	Prélèvement automatique	\N	2025-10-02 22:50:49	2025-10-23 10:35:30
58988798-0bf2-462a-8b91-b7abf3fc642c	6131421b-d7d7-4f56-8450-582c37486f68	depot	8418.00	348073.00	356491.00	FCFA	Dépôt chèque	\N	2025-08-11 13:37:37	2025-10-23 10:35:30
92f8c2d4-b0e1-47c7-a25d-550470775bb8	6131421b-d7d7-4f56-8450-582c37486f68	depot	18767.00	348073.00	366840.00	FCFA	Virement bancaire entrant	\N	2025-10-13 19:05:02	2025-10-23 10:35:30
039e1150-7661-44e7-903d-c16a3580f6f9	6131421b-d7d7-4f56-8450-582c37486f68	retrait	37376.00	348073.00	310697.00	FCFA	Retrait guichet	\N	2025-05-21 02:34:50	2025-10-23 10:35:30
8f41f8df-f7c5-486f-8caf-80578ec7698c	6131421b-d7d7-4f56-8450-582c37486f68	retrait	17159.00	348073.00	330914.00	FCFA	Retrait d'espèces	\N	2025-09-21 11:12:15	2025-10-23 10:35:30
28d324e5-e785-4f16-9386-cf7b7507a553	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	virement	35895.00	310752.00	274857.00	FCFA	Virement salaire	cb45ecae-4f73-42b2-870b-4f41321c9acd	2025-10-19 18:28:27	2025-10-23 10:35:30
c633275e-9f72-4016-a295-59900cbc588c	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	retrait	11053.00	310752.00	299699.00	FCFA	Paiement par carte	\N	2025-09-06 18:54:22	2025-10-23 10:35:30
c97904af-d33c-4d45-8b71-99266161fe87	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	depot	14166.00	310752.00	324918.00	FCFA	Virement bancaire entrant	\N	2025-07-25 05:29:49	2025-10-23 10:35:30
69d20ca7-0483-40ca-8031-a595a3897e70	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	depot	6263.00	310752.00	317015.00	FCFA	Versement salaire	\N	2025-09-27 20:03:10	2025-10-23 10:35:30
1e2dcb96-478f-4462-bb4f-9bf0dc6043b9	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	virement	6336.00	310752.00	304416.00	FCFA	Transfert entre comptes	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	2025-05-07 08:10:40	2025-10-23 10:35:30
22194558-7be6-4c38-8e7c-201022085fe7	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	virement	40106.00	310752.00	270646.00	FCFA	Paiement facture	34b84e17-27b4-4080-a77b-3cdb00476a06	2025-05-01 13:13:50	2025-10-23 10:35:30
5691d94d-b0c8-405a-a176-d00ddba79a43	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	virement	12307.00	310752.00	298445.00	FCFA	Transfert bancaire	43543b43-8884-4451-8a39-e16cf1e52d3c	2025-07-30 19:23:21	2025-10-23 10:35:30
188d82c4-5856-45dd-9d45-6af58b4fcece	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	depot	30514.00	310752.00	341266.00	FCFA	Virement bancaire entrant	\N	2025-10-10 17:16:29	2025-10-23 10:35:30
c788cfe7-83e0-463c-8566-eff9d799ba32	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	retrait	46649.00	310752.00	264103.00	FCFA	Retrait d'espèces	\N	2025-09-03 02:14:05	2025-10-23 10:35:30
53e24e82-e0a7-43de-9491-e81a41e30c88	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	virement	44323.00	310752.00	266429.00	FCFA	Virement vers compte	b30db983-96ad-4f5c-a50c-1637c25f3b46	2025-08-16 04:47:54	2025-10-23 10:35:30
1362deed-c162-43c8-87e1-ff1259bed0b2	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	retrait	43760.00	310752.00	266992.00	FCFA	Retrait DAB	\N	2025-08-07 21:26:16	2025-10-23 10:35:30
528b02fc-d9e5-46e9-b9cf-b76dbffdb384	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	virement	6725.00	310752.00	304027.00	FCFA	Virement salaire	184d6244-4107-464d-9848-8140c6174183	2025-05-15 11:16:26	2025-10-23 10:35:30
4a2e7279-ff44-4e86-ab89-61a38ebf77bb	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	virement	11439.00	310752.00	299313.00	FCFA	Transfert bancaire	05c0a3e8-eeae-4976-88c2-848aec6bea96	2025-09-21 01:58:16	2025-10-23 10:35:30
cb80907c-37a3-41d7-9488-fd246eee265b	64203f77-d74d-4752-9e2b-7a1c40547be9	retrait	18750.00	489151.00	470401.00	FCFA	Paiement par carte	\N	2025-07-30 04:21:24	2025-10-23 10:35:30
c48c9de8-33bd-42e9-9780-962ec53bc2d2	64203f77-d74d-4752-9e2b-7a1c40547be9	depot	12613.00	489151.00	501764.00	FCFA	Dépôt espèces guichet	\N	2025-09-19 12:08:46	2025-10-23 10:35:30
3a1f0c73-57b8-4c94-b6ae-58cc6511203a	64203f77-d74d-4752-9e2b-7a1c40547be9	virement	37739.00	489151.00	451412.00	FCFA	Virement salaire	4bb7fc9b-13d6-4883-b751-283b753d05ed	2025-07-25 14:21:30	2025-10-23 10:35:30
a4f28560-5ae7-4cb1-a89c-4b3ae7053207	64203f77-d74d-4752-9e2b-7a1c40547be9	depot	19491.00	489151.00	508642.00	FCFA	Versement salaire	\N	2025-04-24 00:56:14	2025-10-23 10:35:30
5368f5ca-e36f-43f0-a657-9646c1b4e5a7	64203f77-d74d-4752-9e2b-7a1c40547be9	depot	31136.00	489151.00	520287.00	FCFA	Dépôt chèque	\N	2025-08-18 00:51:19	2025-10-23 10:35:30
0a06605d-2f14-4343-b536-dd1ecc91c16d	e4ad8455-8e84-4a67-873f-6392338ba743	retrait	47084.00	268.00	0.00	FCFA	Retrait d'espèces	\N	2025-08-01 18:44:53	2025-10-23 10:35:30
8415ddc1-fe14-41c0-8e80-d95364e4732e	e4ad8455-8e84-4a67-873f-6392338ba743	depot	43480.00	268.00	43748.00	FCFA	Dépôt d'espèces	\N	2025-08-01 18:16:03	2025-10-23 10:35:30
5545b1b8-f517-443b-a456-754834709564	e4ad8455-8e84-4a67-873f-6392338ba743	retrait	13905.00	268.00	0.00	FCFA	Retrait DAB	\N	2025-09-11 11:05:48	2025-10-23 10:35:30
5648c45a-0f0d-4471-a8eb-5b804595f35e	e4ad8455-8e84-4a67-873f-6392338ba743	retrait	39965.00	268.00	0.00	FCFA	Retrait d'espèces	\N	2025-08-02 12:02:48	2025-10-23 10:35:30
f79c2ee0-53c0-4e12-87e8-11af3f5eeb50	e4ad8455-8e84-4a67-873f-6392338ba743	retrait	9573.00	268.00	0.00	FCFA	Prélèvement automatique	\N	2025-08-06 22:51:11	2025-10-23 10:35:30
5bd8da13-b54a-41cd-9f6d-afa12e8ecb65	e4ad8455-8e84-4a67-873f-6392338ba743	virement	17164.00	268.00	0.00	FCFA	Virement salaire	473ba79b-f520-481d-82b7-0a94c75586be	2025-06-10 21:55:13	2025-10-23 10:35:30
81386577-75d3-4f51-8509-6701734d9cfc	e4ad8455-8e84-4a67-873f-6392338ba743	retrait	45863.00	268.00	0.00	FCFA	Retrait guichet	\N	2025-09-19 08:54:56	2025-10-23 10:35:30
14263f6d-e928-4ef5-a7ed-1226bce3d0cc	e4ad8455-8e84-4a67-873f-6392338ba743	virement	5410.00	268.00	0.00	FCFA	Transfert entre comptes	2f53ae60-3c7c-4dee-a02c-cad51068f96c	2025-05-25 15:40:40	2025-10-23 10:35:30
0fbd2bb3-6de2-4709-82b9-181b6f28792d	e4ad8455-8e84-4a67-873f-6392338ba743	depot	5396.00	268.00	5664.00	FCFA	Virement bancaire entrant	\N	2025-07-12 20:18:42	2025-10-23 10:35:30
46cfd5ec-b385-40ff-a1dc-9c56de2fbce7	e4ad8455-8e84-4a67-873f-6392338ba743	retrait	33255.00	268.00	0.00	FCFA	Prélèvement automatique	\N	2025-05-12 09:01:06	2025-10-23 10:35:30
c97dc0b7-7282-4aff-b1f9-c291263fc325	e4ad8455-8e84-4a67-873f-6392338ba743	depot	22083.00	268.00	22351.00	FCFA	Dépôt chèque	\N	2025-09-04 04:52:24	2025-10-23 10:35:30
8c683e3d-8dba-4e78-861e-5d8dfc0be52f	e4ad8455-8e84-4a67-873f-6392338ba743	depot	40698.00	268.00	40966.00	FCFA	Virement bancaire entrant	\N	2025-07-06 11:59:51	2025-10-23 10:35:30
d8d6f220-19f6-4d95-86b2-b517aa4b793b	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	depot	1178.00	482848.00	484026.00	FCFA	Dépôt chèque	\N	2025-05-15 17:12:31	2025-10-23 10:35:30
1f45c177-8978-4ca4-89af-2bee28f89907	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	retrait	19884.00	482848.00	462964.00	FCFA	Retrait DAB	\N	2025-06-17 12:43:32	2025-10-23 10:35:30
49d25cf2-db19-452e-bcd4-a244b1c2001d	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	depot	33418.00	482848.00	516266.00	FCFA	Dépôt d'espèces	\N	2025-04-29 16:47:07	2025-10-23 10:35:30
aecbc8df-cb6a-40c8-9921-72bce79ef3ff	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	retrait	10935.00	482848.00	471913.00	FCFA	Retrait guichet	\N	2025-06-06 04:26:22	2025-10-23 10:35:30
9c8156c0-84ec-4c67-9e20-34dc5e8d3e9c	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	retrait	29845.00	482848.00	453003.00	FCFA	Prélèvement automatique	\N	2025-05-11 20:33:52	2025-10-23 10:35:30
33d6641f-2f2d-49c6-8403-32769b61509a	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	virement	37394.00	482848.00	445454.00	FCFA	Transfert entre comptes	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	2025-07-16 09:06:24	2025-10-23 10:35:30
5e750dd7-cb48-4bbb-a3cc-8d331a6e0945	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	depot	12530.00	482848.00	495378.00	FCFA	Virement bancaire entrant	\N	2025-08-26 12:07:21	2025-10-23 10:35:30
7a6b1a87-3664-43ac-aee0-f9c500ddae7f	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	depot	20861.00	482848.00	503709.00	FCFA	Virement bancaire entrant	\N	2025-07-30 23:15:28	2025-10-23 10:35:30
a653bbb5-a4eb-4f11-8fd4-f8536ea2da83	54c98069-cb97-4a48-9c06-c8ed239ef726	depot	14263.00	219062.00	233325.00	FCFA	Versement salaire	\N	2025-09-10 20:26:44	2025-10-23 10:35:30
887a33a7-eb78-4659-a429-f663426f0af5	54c98069-cb97-4a48-9c06-c8ed239ef726	virement	2418.00	219062.00	216644.00	FCFA	Virement vers compte	f712d8d9-57b6-49a4-a8eb-5e04856619a9	2025-05-24 06:58:41	2025-10-23 10:35:30
ccbd64d3-2319-4709-ab1b-406d02547c90	54c98069-cb97-4a48-9c06-c8ed239ef726	depot	2917.00	219062.00	221979.00	FCFA	Versement salaire	\N	2025-08-28 04:08:11	2025-10-23 10:35:30
d60d5bdc-cf6b-46f8-8ca2-2f04982dbcd1	54c98069-cb97-4a48-9c06-c8ed239ef726	virement	47702.00	219062.00	171360.00	FCFA	Transfert bancaire	a0123386-5767-4f9f-b457-e0613e9f8725	2025-05-13 04:06:48	2025-10-23 10:35:30
d3500c3a-a570-4aa3-a804-d50504c5a2bd	54c98069-cb97-4a48-9c06-c8ed239ef726	retrait	16199.00	219062.00	202863.00	FCFA	Retrait guichet	\N	2025-09-11 19:20:57	2025-10-23 10:35:30
2c1044e2-a79f-44ce-bcc8-7e714bb731ca	54c98069-cb97-4a48-9c06-c8ed239ef726	virement	45089.00	219062.00	173973.00	FCFA	Paiement facture	3b545ec9-8048-4c12-a074-df603671d400	2025-06-30 20:26:36	2025-10-23 10:35:30
a48839bc-7b5a-438e-9667-cc88ff95be8d	54c98069-cb97-4a48-9c06-c8ed239ef726	depot	22863.00	219062.00	241925.00	FCFA	Dépôt d'espèces	\N	2025-10-22 12:28:08	2025-10-23 10:35:30
db03a198-9d1e-41dd-8c3f-fa42f59c4615	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	retrait	29636.00	477610.00	447974.00	FCFA	Retrait DAB	\N	2025-07-02 07:50:22	2025-10-23 10:35:30
5a99b8ee-dc75-4f4f-ba8a-353b79d90fec	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	virement	15832.00	477610.00	461778.00	FCFA	Virement salaire	1a2a915d-173c-44e7-a655-e29b9a02fd18	2025-08-22 13:49:55	2025-10-23 10:35:30
1ecbec56-08df-46f3-9fdf-622c573dbcb0	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	depot	6493.00	477610.00	484103.00	FCFA	Dépôt d'espèces	\N	2025-07-01 15:19:59	2025-10-23 10:35:30
4517d0c3-c083-4f22-8ecf-dad94f540f92	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	virement	24580.00	477610.00	453030.00	FCFA	Virement salaire	e774b1e8-095f-4684-a770-c420e32f477a	2025-10-01 00:52:43	2025-10-23 10:35:30
2e1c4e97-dc75-49d2-b38b-d55d850664b9	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	retrait	21447.00	477610.00	456163.00	FCFA	Retrait guichet	\N	2025-06-21 23:34:13	2025-10-23 10:35:30
e6ac83f7-0712-41f3-8627-16ea0efa853e	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	virement	3757.00	477610.00	473853.00	FCFA	Paiement facture	8d706bac-d7d8-4172-8d94-d1a8cdf604db	2025-09-08 02:53:16	2025-10-23 10:35:30
d7ab00cd-65d0-490e-9215-0b96d978f683	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	depot	11384.00	477610.00	488994.00	FCFA	Dépôt chèque	\N	2025-09-24 06:53:39	2025-10-23 10:35:30
0c79b2da-f41f-4606-88db-290e18ea4e63	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	depot	28445.00	477610.00	506055.00	FCFA	Dépôt d'espèces	\N	2025-07-30 13:45:22	2025-10-23 10:35:30
baeac9bb-81b8-4f93-a834-d9f4fdea56b7	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	retrait	11639.00	477610.00	465971.00	FCFA	Prélèvement automatique	\N	2025-06-23 00:25:23	2025-10-23 10:35:31
7d875cc0-1e92-4883-b1b9-6dae217e927b	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	virement	48719.00	477610.00	428891.00	FCFA	Transfert entre comptes	d0f4f273-6422-4408-950f-61e6f8d23373	2025-09-06 04:37:08	2025-10-23 10:35:31
cd60038e-28a2-4113-a073-01ce45284337	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	virement	31617.00	477610.00	445993.00	FCFA	Transfert entre comptes	a175ac58-1dc5-4041-b54b-19f48d3900a8	2025-05-24 05:25:08	2025-10-23 10:35:31
70a9727e-8edb-4afe-a40f-62ba02b50438	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	depot	16092.00	477610.00	493702.00	FCFA	Virement bancaire entrant	\N	2025-05-21 01:11:10	2025-10-23 10:35:31
e64c8c65-83aa-49fa-86da-6c3b1600b31f	916bbfef-cee4-457b-a001-da8e5b0be63d	retrait	47518.00	185746.00	138228.00	FCFA	Retrait DAB	\N	2025-06-17 10:49:25	2025-10-23 10:35:31
ea97e584-2a89-47e7-88c5-ca55f1659d1b	916bbfef-cee4-457b-a001-da8e5b0be63d	virement	12082.00	185746.00	173664.00	FCFA	Transfert bancaire	2afce742-17e9-45bc-99be-9389a26da3ca	2025-05-15 03:16:25	2025-10-23 10:35:31
2c43972f-5491-465d-b72f-be2d9f2b1926	916bbfef-cee4-457b-a001-da8e5b0be63d	retrait	24002.00	185746.00	161744.00	FCFA	Paiement par carte	\N	2025-09-13 11:10:56	2025-10-23 10:35:31
e9f1d663-0a0f-4b62-bb32-0613acbed984	916bbfef-cee4-457b-a001-da8e5b0be63d	retrait	28740.00	185746.00	157006.00	FCFA	Prélèvement automatique	\N	2025-09-01 01:18:30	2025-10-23 10:35:31
f30fe0d1-02d3-40dd-a078-dc3eb359fdd6	916bbfef-cee4-457b-a001-da8e5b0be63d	virement	25994.00	185746.00	159752.00	FCFA	Virement vers compte	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	2025-06-25 16:57:30	2025-10-23 10:35:31
4a05b5d3-cb6d-4cbb-bef4-e6e0af2f6883	916bbfef-cee4-457b-a001-da8e5b0be63d	depot	13036.00	185746.00	198782.00	FCFA	Virement bancaire entrant	\N	2025-08-13 11:43:33	2025-10-23 10:35:31
da02c04f-e982-4c63-83d7-088c85cc3c4d	916bbfef-cee4-457b-a001-da8e5b0be63d	virement	10935.00	185746.00	174811.00	FCFA	Virement salaire	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	2025-05-01 01:18:56	2025-10-23 10:35:31
450595dc-d473-41fa-9ccb-c78994d2b777	916bbfef-cee4-457b-a001-da8e5b0be63d	depot	44309.00	185746.00	230055.00	FCFA	Dépôt chèque	\N	2025-07-26 12:55:41	2025-10-23 10:35:31
11b5f354-73f2-4240-b357-11e9c7fc9a06	2f53ae60-3c7c-4dee-a02c-cad51068f96c	depot	19742.00	40712.00	60454.00	FCFA	Dépôt chèque	\N	2025-10-13 23:33:22	2025-10-23 10:35:31
124caf99-3e28-4338-9d4e-a24f79c7604a	2f53ae60-3c7c-4dee-a02c-cad51068f96c	depot	21584.00	40712.00	62296.00	FCFA	Virement bancaire entrant	\N	2025-08-31 16:38:43	2025-10-23 10:35:31
18e57c18-462f-4ba9-9496-89b4605460da	2f53ae60-3c7c-4dee-a02c-cad51068f96c	virement	3138.00	40712.00	37574.00	FCFA	Virement salaire	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	2025-07-25 02:00:50	2025-10-23 10:35:31
4217a945-8029-4309-8a36-a51eb0e58242	2f53ae60-3c7c-4dee-a02c-cad51068f96c	virement	35418.00	40712.00	5294.00	FCFA	Transfert bancaire	2bdeac76-dcb7-4710-9060-e9ca98012722	2025-05-31 00:10:37	2025-10-23 10:35:31
5c20a666-1c9f-4489-a90d-f5388855db9b	2f53ae60-3c7c-4dee-a02c-cad51068f96c	virement	36734.00	40712.00	3978.00	FCFA	Paiement facture	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	2025-09-07 05:50:26	2025-10-23 10:35:31
d679c313-1e5a-4a0f-9951-d028db43c231	2f53ae60-3c7c-4dee-a02c-cad51068f96c	retrait	49930.00	40712.00	0.00	FCFA	Retrait d'espèces	\N	2025-07-23 06:06:14	2025-10-23 10:35:31
6fa2e04d-ab61-4ae3-a7c4-1ac7074db697	2afce742-17e9-45bc-99be-9389a26da3ca	depot	35475.00	21784.00	57259.00	FCFA	Dépôt d'espèces	\N	2025-08-18 01:41:35	2025-10-23 10:35:31
6f0eb695-6831-4304-b4c1-e38a72d2025b	2afce742-17e9-45bc-99be-9389a26da3ca	retrait	45619.00	21784.00	0.00	FCFA	Retrait DAB	\N	2025-06-29 15:44:34	2025-10-23 10:35:31
8e62ea55-184d-4bca-8ec3-5fbc7c25c343	2afce742-17e9-45bc-99be-9389a26da3ca	retrait	23496.00	21784.00	0.00	FCFA	Retrait DAB	\N	2025-07-06 23:41:56	2025-10-23 10:35:31
02f91593-9ac2-4de6-b375-4988d9f85ed1	2afce742-17e9-45bc-99be-9389a26da3ca	depot	48010.00	21784.00	69794.00	FCFA	Dépôt espèces guichet	\N	2025-06-09 10:51:54	2025-10-23 10:35:31
7a16ad7e-0911-4819-a22a-a028e2ccb805	2afce742-17e9-45bc-99be-9389a26da3ca	depot	19002.00	21784.00	40786.00	FCFA	Virement bancaire entrant	\N	2025-06-30 07:57:39	2025-10-23 10:35:31
d5e032d7-ce8f-4fe5-b22d-ec840017986c	2afce742-17e9-45bc-99be-9389a26da3ca	virement	26547.00	21784.00	0.00	FCFA	Virement salaire	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	2025-08-30 16:12:59	2025-10-23 10:35:31
cc15f8b6-75ba-4e65-b210-9714092b8149	2afce742-17e9-45bc-99be-9389a26da3ca	retrait	3585.00	21784.00	18199.00	FCFA	Paiement par carte	\N	2025-09-03 04:27:11	2025-10-23 10:35:31
ad6583b5-6a1e-4d08-850c-bd940ece630f	2afce742-17e9-45bc-99be-9389a26da3ca	virement	48607.00	21784.00	0.00	FCFA	Virement salaire	6131421b-d7d7-4f56-8450-582c37486f68	2025-09-12 02:40:16	2025-10-23 10:35:31
815ce043-4a37-49ab-81ca-8c2153740b27	2afce742-17e9-45bc-99be-9389a26da3ca	depot	10663.00	21784.00	32447.00	FCFA	Dépôt d'espèces	\N	2025-08-26 11:59:57	2025-10-23 10:35:31
43e79346-0285-41f0-8f37-c3c3bce6274f	2afce742-17e9-45bc-99be-9389a26da3ca	retrait	36464.00	21784.00	0.00	FCFA	Retrait DAB	\N	2025-07-30 21:41:56	2025-10-23 10:35:31
569118f8-9d45-4f3b-aa2c-ef7f4de8194c	2afce742-17e9-45bc-99be-9389a26da3ca	retrait	1222.00	21784.00	20562.00	FCFA	Retrait d'espèces	\N	2025-07-09 23:56:35	2025-10-23 10:35:31
a1839e7f-60fb-40ed-b408-1d4eb3c1c723	2afce742-17e9-45bc-99be-9389a26da3ca	retrait	6450.00	21784.00	15334.00	FCFA	Paiement par carte	\N	2025-07-14 13:35:57	2025-10-23 10:35:31
e13c682c-888f-470c-b908-99b5540ea6ae	2afce742-17e9-45bc-99be-9389a26da3ca	virement	32587.00	21784.00	0.00	FCFA	Transfert bancaire	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	2025-08-27 06:16:38	2025-10-23 10:35:31
b03803a2-ec0a-4081-b18f-f4d106440759	2afce742-17e9-45bc-99be-9389a26da3ca	virement	15004.00	21784.00	6780.00	FCFA	Transfert entre comptes	b9fcf39f-cbf6-4e3d-99da-428158581521	2025-08-28 04:06:09	2025-10-23 10:35:31
2c8a907e-f088-4b87-b56f-243ae55aa5a3	2afce742-17e9-45bc-99be-9389a26da3ca	retrait	19321.00	21784.00	2463.00	FCFA	Retrait guichet	\N	2025-09-17 20:03:40	2025-10-23 10:35:31
d3167686-3a53-462f-b4d9-d3fa777a9229	ce352024-ef0a-4c59-a717-07fa503a38dc	retrait	47334.00	436076.00	388742.00	FCFA	Retrait DAB	\N	2025-06-07 17:27:43	2025-10-23 10:35:31
48e8b896-d523-4bbc-b1e2-18f1109dc164	ce352024-ef0a-4c59-a717-07fa503a38dc	depot	44353.00	436076.00	480429.00	FCFA	Dépôt d'espèces	\N	2025-08-12 17:25:13	2025-10-23 10:35:31
26fc11d4-db78-47c1-be82-829ec6724899	ce352024-ef0a-4c59-a717-07fa503a38dc	retrait	39273.00	436076.00	396803.00	FCFA	Prélèvement automatique	\N	2025-04-23 17:56:04	2025-10-23 10:35:31
421c3de4-8c74-4eef-8dc6-4de3d43f9d86	ce352024-ef0a-4c59-a717-07fa503a38dc	depot	28421.00	436076.00	464497.00	FCFA	Dépôt d'espèces	\N	2025-06-02 16:20:05	2025-10-23 10:35:31
4bea304a-f0aa-44a4-bf70-95048137a221	ce352024-ef0a-4c59-a717-07fa503a38dc	depot	23475.00	436076.00	459551.00	FCFA	Dépôt d'espèces	\N	2025-10-13 18:38:35	2025-10-23 10:35:31
83caebd1-c697-42cf-8e4b-0edc4f9f9261	ce352024-ef0a-4c59-a717-07fa503a38dc	depot	28782.00	436076.00	464858.00	FCFA	Versement salaire	\N	2025-08-28 13:07:00	2025-10-23 10:35:31
508bbb75-3877-44a6-b8d7-861beffce491	ce352024-ef0a-4c59-a717-07fa503a38dc	depot	21697.00	436076.00	457773.00	FCFA	Virement bancaire entrant	\N	2025-07-16 17:55:54	2025-10-23 10:35:31
9d7f238d-d4f5-4070-b62b-a5f85ca21ed0	ce352024-ef0a-4c59-a717-07fa503a38dc	depot	12355.00	436076.00	448431.00	FCFA	Dépôt d'espèces	\N	2025-08-02 17:47:34	2025-10-23 10:35:31
8bc21c85-58c8-46ef-b0db-73b89cff6a88	ce352024-ef0a-4c59-a717-07fa503a38dc	retrait	39093.00	436076.00	396983.00	FCFA	Prélèvement automatique	\N	2025-05-30 00:50:34	2025-10-23 10:35:31
f236cebe-4de5-45dd-8fb5-61dcb79c49b7	ce352024-ef0a-4c59-a717-07fa503a38dc	retrait	19845.00	436076.00	416231.00	FCFA	Retrait guichet	\N	2025-09-01 22:38:39	2025-10-23 10:35:31
917bca3b-327e-423d-affb-470fc71aca30	ce352024-ef0a-4c59-a717-07fa503a38dc	retrait	15456.00	436076.00	420620.00	FCFA	Paiement par carte	\N	2025-07-24 09:18:37	2025-10-23 10:35:31
6deca2a6-8ac2-42cd-8bde-eae2b542f8ff	ce352024-ef0a-4c59-a717-07fa503a38dc	depot	11127.00	436076.00	447203.00	FCFA	Dépôt chèque	\N	2025-06-27 05:45:14	2025-10-23 10:35:31
6e145980-cca8-44f1-9530-d37a052cb8dd	f712d8d9-57b6-49a4-a8eb-5e04856619a9	retrait	23028.00	419783.00	396755.00	FCFA	Retrait guichet	\N	2025-07-23 20:54:37	2025-10-23 10:35:31
22d5308b-0650-4740-9b5c-9082d5e79d0b	f712d8d9-57b6-49a4-a8eb-5e04856619a9	retrait	20620.00	419783.00	399163.00	FCFA	Retrait d'espèces	\N	2025-10-19 10:06:12	2025-10-23 10:35:31
a36c1688-7fe8-453b-9563-c01a468ae1fb	f712d8d9-57b6-49a4-a8eb-5e04856619a9	retrait	14050.00	419783.00	405733.00	FCFA	Paiement par carte	\N	2025-07-17 18:44:44	2025-10-23 10:35:31
7d974375-5ebe-4639-a686-24a52b54742f	f712d8d9-57b6-49a4-a8eb-5e04856619a9	virement	16192.00	419783.00	403591.00	FCFA	Virement vers compte	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	2025-07-23 14:01:56	2025-10-23 10:35:31
61a4301d-9615-4e12-995b-e619916b7dc4	f712d8d9-57b6-49a4-a8eb-5e04856619a9	virement	45101.00	419783.00	374682.00	FCFA	Transfert bancaire	a1f1990b-1819-4977-aaf0-bb14a824daa0	2025-06-21 01:42:10	2025-10-23 10:35:31
1bccc03b-7684-48c6-9f11-3b9e85707257	65da4070-27f5-40a7-99d9-db64e3163a65	depot	20182.00	255594.00	275776.00	FCFA	Dépôt espèces guichet	\N	2025-07-21 09:22:20	2025-10-23 10:35:31
e1953c4d-65ee-405f-babe-e1eed9de44a1	65da4070-27f5-40a7-99d9-db64e3163a65	depot	1140.00	255594.00	256734.00	FCFA	Dépôt chèque	\N	2025-09-18 17:33:07	2025-10-23 10:35:31
5c9e80cd-c3e3-482d-95f5-5e9e1d9295bb	65da4070-27f5-40a7-99d9-db64e3163a65	depot	11034.00	255594.00	266628.00	FCFA	Dépôt chèque	\N	2025-05-17 15:50:19	2025-10-23 10:35:31
b907cece-98f2-4f17-ba5f-3179fbd1aca2	65da4070-27f5-40a7-99d9-db64e3163a65	retrait	30630.00	255594.00	224964.00	FCFA	Prélèvement automatique	\N	2025-07-16 03:48:50	2025-10-23 10:35:31
dad46723-5433-4bbe-8ff2-268a94dcfcf2	65da4070-27f5-40a7-99d9-db64e3163a65	retrait	41943.00	255594.00	213651.00	FCFA	Retrait d'espèces	\N	2025-08-21 13:28:04	2025-10-23 10:35:31
868fc39c-64a8-409f-8bab-176b45d759d3	65da4070-27f5-40a7-99d9-db64e3163a65	virement	41287.00	255594.00	214307.00	FCFA	Transfert bancaire	8d706bac-d7d8-4172-8d94-d1a8cdf604db	2025-09-21 13:36:54	2025-10-23 10:35:31
d9ec2a3e-77cf-424e-b9fb-6d9a0dda81ec	65da4070-27f5-40a7-99d9-db64e3163a65	retrait	23163.00	255594.00	232431.00	FCFA	Retrait guichet	\N	2025-08-19 06:31:39	2025-10-23 10:35:31
0b4dae79-7454-4f5a-92c4-a231d9dd0184	65da4070-27f5-40a7-99d9-db64e3163a65	virement	28657.00	255594.00	226937.00	FCFA	Paiement facture	e774b1e8-095f-4684-a770-c420e32f477a	2025-08-09 01:05:22	2025-10-23 10:35:31
83265673-13e1-4d38-99e1-2ba6e0844ef0	65da4070-27f5-40a7-99d9-db64e3163a65	virement	15823.00	255594.00	239771.00	FCFA	Paiement facture	2f53ae60-3c7c-4dee-a02c-cad51068f96c	2025-09-16 05:54:41	2025-10-23 10:35:31
c1fa3b9e-1298-4eec-8278-40d5cc60ee8f	65da4070-27f5-40a7-99d9-db64e3163a65	virement	9244.00	255594.00	246350.00	FCFA	Paiement facture	39ca01df-9037-4f1b-962a-164c3db984f0	2025-04-27 23:07:26	2025-10-23 10:35:31
f0977cce-289c-4967-b079-df1a75f7206c	4e96181f-e984-42f8-9787-a41a67c90aba	depot	4914.00	455670.00	460584.00	FCFA	Dépôt espèces guichet	\N	2025-09-07 01:32:08	2025-10-23 10:35:31
8df02597-d57a-4d39-91d1-eba66f99e7db	4e96181f-e984-42f8-9787-a41a67c90aba	depot	23421.00	455670.00	479091.00	FCFA	Versement salaire	\N	2025-07-02 21:11:08	2025-10-23 10:35:31
66ae47d8-bb8a-4206-870e-d4b2cd621165	4e96181f-e984-42f8-9787-a41a67c90aba	depot	20327.00	455670.00	475997.00	FCFA	Virement bancaire entrant	\N	2025-09-03 20:07:00	2025-10-23 10:35:31
ecf6f599-68be-42d6-b63f-33bfba0035ef	4e96181f-e984-42f8-9787-a41a67c90aba	virement	48056.00	455670.00	407614.00	FCFA	Transfert entre comptes	2e311570-14e5-403a-a71f-698c77f8454d	2025-06-05 02:14:07	2025-10-23 10:35:31
ac23d2e5-46b3-4666-bf5c-f1f1cc9654b5	4e96181f-e984-42f8-9787-a41a67c90aba	depot	20247.00	455670.00	475917.00	FCFA	Dépôt d'espèces	\N	2025-07-21 07:41:44	2025-10-23 10:35:31
6cb2d61a-a23c-4e73-94a7-f228ab27e323	4e96181f-e984-42f8-9787-a41a67c90aba	depot	15238.00	455670.00	470908.00	FCFA	Dépôt chèque	\N	2025-10-21 01:15:00	2025-10-23 10:35:31
82aa4354-a5e4-4866-b284-4a43c979b315	4e96181f-e984-42f8-9787-a41a67c90aba	depot	36525.00	455670.00	492195.00	FCFA	Dépôt chèque	\N	2025-07-22 11:53:55	2025-10-23 10:35:31
965a7b16-4397-4399-9c00-ca079ed40c71	4e96181f-e984-42f8-9787-a41a67c90aba	depot	4051.00	455670.00	459721.00	FCFA	Versement salaire	\N	2025-10-06 12:04:17	2025-10-23 10:35:31
0a51e49e-be33-4f16-8464-74451c2f7923	78038c23-dabc-4bd2-a4b5-e1c09089f492	virement	32153.00	165169.00	133016.00	FCFA	Transfert entre comptes	9b7cf121-0b29-4457-b5ee-acddd651474c	2025-05-03 11:25:03	2025-10-23 10:35:31
b95e7028-fc35-4318-a5c1-9363fac88c27	78038c23-dabc-4bd2-a4b5-e1c09089f492	retrait	40925.00	165169.00	124244.00	FCFA	Paiement par carte	\N	2025-07-03 10:40:25	2025-10-23 10:35:31
75472bc3-0282-4fc3-ba32-34be635ec3d9	78038c23-dabc-4bd2-a4b5-e1c09089f492	virement	20082.00	165169.00	145087.00	FCFA	Virement salaire	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	2025-09-02 00:52:28	2025-10-23 10:35:31
f15f3f80-3dd7-4b15-a91f-319e634c5a1a	78038c23-dabc-4bd2-a4b5-e1c09089f492	retrait	26612.00	165169.00	138557.00	FCFA	Retrait DAB	\N	2025-10-04 01:12:31	2025-10-23 10:35:31
61e69948-f387-442b-b553-2e2f11b9e91e	78038c23-dabc-4bd2-a4b5-e1c09089f492	virement	32416.00	165169.00	132753.00	FCFA	Transfert entre comptes	34b84e17-27b4-4080-a77b-3cdb00476a06	2025-05-02 17:26:25	2025-10-23 10:35:31
f8df431e-0b5c-4456-bd36-9f57a4d2498b	78038c23-dabc-4bd2-a4b5-e1c09089f492	retrait	2069.00	165169.00	163100.00	FCFA	Paiement par carte	\N	2025-08-28 03:09:18	2025-10-23 10:35:31
e51a2723-a9c7-4ab8-a31f-71e69b469b88	78038c23-dabc-4bd2-a4b5-e1c09089f492	depot	40914.00	165169.00	206083.00	FCFA	Versement salaire	\N	2025-05-08 08:20:48	2025-10-23 10:35:31
0f9d0626-f333-44b8-9369-87fcdc3e6e7f	78038c23-dabc-4bd2-a4b5-e1c09089f492	retrait	40881.00	165169.00	124288.00	FCFA	Retrait d'espèces	\N	2025-07-31 11:32:00	2025-10-23 10:35:31
080c5589-3f47-4bf7-9bd6-398f50a25209	78038c23-dabc-4bd2-a4b5-e1c09089f492	retrait	15115.00	165169.00	150054.00	FCFA	Paiement par carte	\N	2025-10-23 08:39:45	2025-10-23 10:35:31
6393f35b-dc14-4005-977f-384fa83e3bf8	78038c23-dabc-4bd2-a4b5-e1c09089f492	virement	4965.00	165169.00	160204.00	FCFA	Paiement facture	39ca01df-9037-4f1b-962a-164c3db984f0	2025-08-10 04:13:12	2025-10-23 10:35:31
bfc6be1f-c845-4c5c-ba93-171d2b2cdeb6	78038c23-dabc-4bd2-a4b5-e1c09089f492	virement	5277.00	165169.00	159892.00	FCFA	Virement salaire	54d5e886-a7a4-4427-b256-7723400f3c4e	2025-07-03 20:38:45	2025-10-23 10:35:31
1b27924f-6a0f-4302-8ddb-103f96f5dea8	78038c23-dabc-4bd2-a4b5-e1c09089f492	virement	49230.00	165169.00	115939.00	FCFA	Virement salaire	d725e859-df50-4ee3-8ab9-65d82dc7fd71	2025-10-14 00:07:54	2025-10-23 10:35:31
81c617eb-b023-4705-ae89-2bfc631f3904	78038c23-dabc-4bd2-a4b5-e1c09089f492	virement	28815.00	165169.00	136354.00	FCFA	Virement vers compte	792c8ff4-749b-469b-95d0-9b98c2283684	2025-08-11 14:24:16	2025-10-23 10:35:31
e11f6331-075f-4f21-adc5-e56e7da62197	78038c23-dabc-4bd2-a4b5-e1c09089f492	retrait	26872.00	165169.00	138297.00	FCFA	Retrait guichet	\N	2025-06-29 01:39:02	2025-10-23 10:35:31
bd748560-ad88-4114-a76e-366daf56ce99	bf69dba7-7153-4b9d-885b-f7fa7330e249	virement	27328.00	116825.00	89497.00	FCFA	Virement vers compte	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	2025-05-06 01:34:37	2025-10-23 10:35:31
93bffa1f-cb34-4a93-95b8-c51f2e1a37f7	bf69dba7-7153-4b9d-885b-f7fa7330e249	retrait	46254.00	116825.00	70571.00	FCFA	Paiement par carte	\N	2025-05-10 17:48:42	2025-10-23 10:35:31
78a43dbc-f0b9-4e94-9424-f39b64cf1e7f	bf69dba7-7153-4b9d-885b-f7fa7330e249	retrait	28808.00	116825.00	88017.00	FCFA	Retrait guichet	\N	2025-06-29 17:30:49	2025-10-23 10:35:31
5650d9b5-0b70-4a54-a557-d25d54f237bc	bf69dba7-7153-4b9d-885b-f7fa7330e249	virement	39534.00	116825.00	77291.00	FCFA	Virement vers compte	a03dce74-58f6-42c7-8624-1d21ea760a90	2025-05-07 11:44:11	2025-10-23 10:35:31
04c29775-5926-4549-9c1f-0ff8ae37333d	bf69dba7-7153-4b9d-885b-f7fa7330e249	depot	43131.00	116825.00	159956.00	FCFA	Virement bancaire entrant	\N	2025-07-29 11:20:26	2025-10-23 10:35:31
b68d2477-f4dd-4dc4-b485-6a726422c627	bf69dba7-7153-4b9d-885b-f7fa7330e249	virement	35039.00	116825.00	81786.00	FCFA	Virement salaire	2bdeac76-dcb7-4710-9060-e9ca98012722	2025-07-18 03:23:01	2025-10-23 10:35:31
13e99bb2-44cb-47d9-9920-c9386b24bb88	bf69dba7-7153-4b9d-885b-f7fa7330e249	depot	39089.00	116825.00	155914.00	FCFA	Versement salaire	\N	2025-05-23 06:40:26	2025-10-23 10:35:31
bf5719de-3588-4030-9d16-68cf6cb729fa	bf69dba7-7153-4b9d-885b-f7fa7330e249	retrait	34548.00	116825.00	82277.00	FCFA	Prélèvement automatique	\N	2025-07-09 08:21:40	2025-10-23 10:35:31
6314f33f-7776-49e9-b774-054fc7682763	bf69dba7-7153-4b9d-885b-f7fa7330e249	depot	43557.00	116825.00	160382.00	FCFA	Dépôt d'espèces	\N	2025-05-18 04:16:04	2025-10-23 10:35:31
dd707ed6-23e8-4e39-b354-3e9ea9d78d6d	f46f2dde-ba75-4234-b729-67c0cd2a3ade	depot	25967.00	279050.00	305017.00	FCFA	Virement bancaire entrant	\N	2025-06-21 21:47:01	2025-10-23 10:35:31
75441d4d-cccf-4c1c-84df-9060be05045e	f46f2dde-ba75-4234-b729-67c0cd2a3ade	retrait	46174.00	279050.00	232876.00	FCFA	Paiement par carte	\N	2025-06-29 20:01:37	2025-10-23 10:35:31
13154738-440b-4a7c-92ee-06c5126fdcb4	f46f2dde-ba75-4234-b729-67c0cd2a3ade	virement	19277.00	279050.00	259773.00	FCFA	Virement vers compte	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	2025-05-10 20:08:36	2025-10-23 10:35:31
5596d755-a1d3-44fd-9b3a-032060c8a561	f46f2dde-ba75-4234-b729-67c0cd2a3ade	retrait	49113.00	279050.00	229937.00	FCFA	Retrait guichet	\N	2025-07-14 18:41:36	2025-10-23 10:35:31
f2b3ec72-bafe-4d40-a1e2-9a3ca2670d91	f46f2dde-ba75-4234-b729-67c0cd2a3ade	depot	9093.00	279050.00	288143.00	FCFA	Dépôt espèces guichet	\N	2025-06-14 08:36:23	2025-10-23 10:35:31
3d5b4d4d-586b-42b0-9795-8f888d25c0b2	f46f2dde-ba75-4234-b729-67c0cd2a3ade	retrait	47018.00	279050.00	232032.00	FCFA	Paiement par carte	\N	2025-05-25 18:19:25	2025-10-23 10:35:31
12b17db5-094c-44db-a94e-6303123ebaee	f46f2dde-ba75-4234-b729-67c0cd2a3ade	retrait	3569.00	279050.00	275481.00	FCFA	Retrait guichet	\N	2025-05-05 23:57:39	2025-10-23 10:35:31
5bf93f1c-5f6d-4e90-8555-d2afe2c79c07	f46f2dde-ba75-4234-b729-67c0cd2a3ade	depot	37685.00	279050.00	316735.00	FCFA	Dépôt espèces guichet	\N	2025-08-07 12:44:40	2025-10-23 10:35:31
f1c4be67-1765-4be6-bb35-3b4091568810	f46f2dde-ba75-4234-b729-67c0cd2a3ade	retrait	45407.00	279050.00	233643.00	FCFA	Retrait DAB	\N	2025-07-30 21:33:40	2025-10-23 10:35:31
d594f32c-9298-42ed-8777-74fcd42af75a	f46f2dde-ba75-4234-b729-67c0cd2a3ade	virement	18521.00	279050.00	260529.00	FCFA	Virement salaire	8af34d52-0c28-48ed-ae2d-87e52f97806a	2025-06-15 03:45:51	2025-10-23 10:35:31
b6ea061e-0d39-44f9-9573-070dedc3fb7b	f46f2dde-ba75-4234-b729-67c0cd2a3ade	virement	16285.00	279050.00	262765.00	FCFA	Virement vers compte	79f54c28-5af3-42a0-b025-afd541eb8dbf	2025-08-31 07:28:21	2025-10-23 10:35:31
9e2d220f-5f42-4ff6-853b-425689643351	f46f2dde-ba75-4234-b729-67c0cd2a3ade	retrait	37102.00	279050.00	241948.00	FCFA	Paiement par carte	\N	2025-05-04 18:28:53	2025-10-23 10:35:31
2624bff4-f247-4c92-877a-9edb883f2c4d	f46f2dde-ba75-4234-b729-67c0cd2a3ade	depot	12744.00	279050.00	291794.00	FCFA	Versement salaire	\N	2025-06-03 13:13:49	2025-10-23 10:35:31
5a6be10d-e631-4b69-b4b9-13724dd03c00	f46f2dde-ba75-4234-b729-67c0cd2a3ade	virement	33073.00	279050.00	245977.00	FCFA	Virement vers compte	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	2025-07-05 11:29:02	2025-10-23 10:35:31
d1b5b6ef-3041-4ec2-ad1d-63b43e689609	d725e859-df50-4ee3-8ab9-65d82dc7fd71	virement	41281.00	133633.00	92352.00	FCFA	Transfert bancaire	93ec7354-821a-4306-8dcb-5b911268af75	2025-10-06 02:56:32	2025-10-23 10:35:31
3e5aa32e-8e52-47ce-a904-22813a6beac6	d725e859-df50-4ee3-8ab9-65d82dc7fd71	virement	22704.00	133633.00	110929.00	FCFA	Paiement facture	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	2025-06-24 13:08:59	2025-10-23 10:35:31
e2ad0115-358f-450c-be73-39eaf04ec75b	916bbfef-cee4-457b-a001-da8e5b0be63d	depot	24456.00	185746.00	210202.00	FCFA	Dépôt chèque	\N	2025-05-08 15:34:20	2025-10-23 12:36:57
ce734673-d44b-4aa3-be05-1b205e4a34c3	d725e859-df50-4ee3-8ab9-65d82dc7fd71	virement	10332.00	133633.00	123301.00	FCFA	Transfert entre comptes	34b84e17-27b4-4080-a77b-3cdb00476a06	2025-09-20 17:16:49	2025-10-23 10:35:31
99931f30-4e5a-48cb-a9ad-5f62276cdd1f	d725e859-df50-4ee3-8ab9-65d82dc7fd71	depot	25712.00	133633.00	159345.00	FCFA	Dépôt d'espèces	\N	2025-08-26 11:07:18	2025-10-23 10:35:31
dbb02861-e830-4701-81ab-26a77b010efd	d725e859-df50-4ee3-8ab9-65d82dc7fd71	retrait	1503.00	133633.00	132130.00	FCFA	Retrait d'espèces	\N	2025-08-21 04:58:06	2025-10-23 10:35:31
467cdc53-68e3-409d-94cb-e4f766811c35	d725e859-df50-4ee3-8ab9-65d82dc7fd71	virement	24454.00	133633.00	109179.00	FCFA	Transfert bancaire	aaa991e6-e52e-48b7-ab07-15a4a8203054	2025-07-31 04:03:33	2025-10-23 10:35:31
8b810b0f-8dfd-4a99-b2a8-2bb2cf37972d	d725e859-df50-4ee3-8ab9-65d82dc7fd71	virement	23386.00	133633.00	110247.00	FCFA	Virement vers compte	801e068b-fdc3-4606-bc83-42d2e3fc4a67	2025-08-18 06:50:32	2025-10-23 10:35:31
9793b211-8bcc-4b47-ba60-86ae29c571f4	d725e859-df50-4ee3-8ab9-65d82dc7fd71	depot	31457.00	133633.00	165090.00	FCFA	Virement bancaire entrant	\N	2025-05-29 08:38:09	2025-10-23 10:35:31
3688bb15-ee8d-4d0b-aa7a-17c329d96d85	801e068b-fdc3-4606-bc83-42d2e3fc4a67	retrait	26937.00	443978.00	417041.00	FCFA	Paiement par carte	\N	2025-06-10 15:12:42	2025-10-23 10:35:31
69526812-c783-41b7-a323-ede65fd5749b	801e068b-fdc3-4606-bc83-42d2e3fc4a67	virement	49702.00	443978.00	394276.00	FCFA	Transfert entre comptes	df088290-3d37-4591-8571-389b37349b2a	2025-06-26 06:16:18	2025-10-23 10:35:31
642c742e-c808-4939-a2b7-1051fc42ece5	801e068b-fdc3-4606-bc83-42d2e3fc4a67	virement	25827.00	443978.00	418151.00	FCFA	Transfert entre comptes	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	2025-08-26 11:34:36	2025-10-23 10:35:31
ebdfa07b-4345-4cb9-a2f8-002995ac1728	801e068b-fdc3-4606-bc83-42d2e3fc4a67	virement	44508.00	443978.00	399470.00	FCFA	Transfert bancaire	5cd10916-6dee-48e6-ab78-7995b1f1ce95	2025-06-03 23:16:27	2025-10-23 10:35:31
3be26353-2232-4c91-9837-2defa4a2c2fd	801e068b-fdc3-4606-bc83-42d2e3fc4a67	retrait	7641.00	443978.00	436337.00	FCFA	Retrait d'espèces	\N	2025-10-01 10:56:54	2025-10-23 10:35:31
b5ccc97d-c598-4268-b4cf-4e31cc9dc58f	801e068b-fdc3-4606-bc83-42d2e3fc4a67	retrait	40642.00	443978.00	403336.00	FCFA	Retrait d'espèces	\N	2025-05-30 19:21:16	2025-10-23 10:35:31
2e41e086-cad9-429f-af22-cc9b82f5fbfc	aaa991e6-e52e-48b7-ab07-15a4a8203054	depot	43212.00	398862.00	442074.00	FCFA	Dépôt d'espèces	\N	2025-04-30 14:48:58	2025-10-23 10:35:31
b1647a9a-7e6a-431f-8558-c7be89018608	aaa991e6-e52e-48b7-ab07-15a4a8203054	retrait	4864.00	398862.00	393998.00	FCFA	Retrait guichet	\N	2025-10-13 00:33:12	2025-10-23 10:35:31
6b02de96-2053-4529-980d-0e14bb9aadfa	aaa991e6-e52e-48b7-ab07-15a4a8203054	virement	13847.00	398862.00	385015.00	FCFA	Paiement facture	34b84e17-27b4-4080-a77b-3cdb00476a06	2025-10-17 22:17:41	2025-10-23 10:35:31
465f9d9b-58c5-484b-9c2b-4410b85a5784	aaa991e6-e52e-48b7-ab07-15a4a8203054	depot	17674.00	398862.00	416536.00	FCFA	Dépôt chèque	\N	2025-06-11 01:44:42	2025-10-23 10:35:31
0fa3486f-fdad-4923-a3d0-6d071bbcf1e1	aaa991e6-e52e-48b7-ab07-15a4a8203054	virement	25501.00	398862.00	373361.00	FCFA	Virement salaire	801e068b-fdc3-4606-bc83-42d2e3fc4a67	2025-08-19 13:07:05	2025-10-23 10:35:31
a87b6b5b-416e-47a9-8941-97e67ee87e5d	aaa991e6-e52e-48b7-ab07-15a4a8203054	depot	45773.00	398862.00	444635.00	FCFA	Versement salaire	\N	2025-05-08 05:26:15	2025-10-23 10:35:31
66c08242-68c6-4b5f-ba79-fe56192ac51c	aaa991e6-e52e-48b7-ab07-15a4a8203054	depot	18592.00	398862.00	417454.00	FCFA	Versement salaire	\N	2025-07-05 03:47:38	2025-10-23 10:35:31
f6bb9a1d-2aca-4385-988a-1fafeb37147b	aaa991e6-e52e-48b7-ab07-15a4a8203054	virement	16080.00	398862.00	382782.00	FCFA	Transfert bancaire	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	2025-06-05 05:05:06	2025-10-23 10:35:31
87295718-5695-422b-9758-95cb28c4229b	aaa991e6-e52e-48b7-ab07-15a4a8203054	retrait	5598.00	398862.00	393264.00	FCFA	Retrait guichet	\N	2025-08-01 18:48:22	2025-10-23 10:35:31
1d5ad27f-5222-4c7f-91c7-f72a80c82b35	aaa991e6-e52e-48b7-ab07-15a4a8203054	retrait	13645.00	398862.00	385217.00	FCFA	Retrait d'espèces	\N	2025-07-21 20:26:02	2025-10-23 10:35:31
cfe47083-0c24-4ea1-84b2-07c3e432b32d	aaa991e6-e52e-48b7-ab07-15a4a8203054	retrait	21899.00	398862.00	376963.00	FCFA	Retrait guichet	\N	2025-10-10 02:45:41	2025-10-23 10:35:31
e83a9919-ed58-4e96-9eb3-5807839ba14d	aaa991e6-e52e-48b7-ab07-15a4a8203054	retrait	43551.00	398862.00	355311.00	FCFA	Retrait guichet	\N	2025-05-05 06:55:59	2025-10-23 10:35:31
f05b4d1d-e658-49e0-85b4-71cd8cef3c06	aaa991e6-e52e-48b7-ab07-15a4a8203054	depot	38838.00	398862.00	437700.00	FCFA	Dépôt d'espèces	\N	2025-08-13 17:13:55	2025-10-23 10:35:31
d88821ee-5092-4703-a529-d2414f701c63	aaa991e6-e52e-48b7-ab07-15a4a8203054	virement	31310.00	398862.00	367552.00	FCFA	Transfert entre comptes	54d5e886-a7a4-4427-b256-7723400f3c4e	2025-10-23 09:19:54	2025-10-23 10:35:31
382bc221-faac-4a9e-9f88-80efb2914f82	d2a1ed80-e126-493f-b155-2923909ae924	retrait	38037.00	185230.00	147193.00	FCFA	Paiement par carte	\N	2025-08-20 19:21:42	2025-10-23 10:35:31
73b25683-027b-4548-b49f-a6dd95ba13e3	d2a1ed80-e126-493f-b155-2923909ae924	virement	25594.00	185230.00	159636.00	FCFA	Virement vers compte	f712d8d9-57b6-49a4-a8eb-5e04856619a9	2025-05-01 04:21:43	2025-10-23 10:35:31
f3db96db-2e83-48a7-a34e-2ba499ce8eea	d2a1ed80-e126-493f-b155-2923909ae924	virement	7964.00	185230.00	177266.00	FCFA	Transfert bancaire	727ed0a8-67ac-4066-84fe-a29a0e13bb30	2025-09-27 21:05:38	2025-10-23 10:35:31
26723805-279c-4aa3-9bb1-5c5714f2e78b	d2a1ed80-e126-493f-b155-2923909ae924	virement	37792.00	185230.00	147438.00	FCFA	Transfert entre comptes	a1f1990b-1819-4977-aaf0-bb14a824daa0	2025-05-05 01:00:56	2025-10-23 10:35:31
088f38e8-55e7-4c5d-a2bf-c294644ed168	d2a1ed80-e126-493f-b155-2923909ae924	virement	3778.00	185230.00	181452.00	FCFA	Transfert bancaire	a0123386-5767-4f9f-b457-e0613e9f8725	2025-05-04 00:03:23	2025-10-23 10:35:31
4ad29e29-0cbf-4b5a-aa1b-34d5d554dd9f	d2a1ed80-e126-493f-b155-2923909ae924	depot	34656.00	185230.00	219886.00	FCFA	Virement bancaire entrant	\N	2025-10-07 14:28:32	2025-10-23 10:35:31
f0df0ee6-4f89-4575-a8d5-90da6ac385f9	d2a1ed80-e126-493f-b155-2923909ae924	virement	26498.00	185230.00	158732.00	FCFA	Virement vers compte	a03dce74-58f6-42c7-8624-1d21ea760a90	2025-08-14 11:25:15	2025-10-23 10:35:31
ccc9b1f6-cf33-4bd1-8d0d-4600962ea5d1	d2a1ed80-e126-493f-b155-2923909ae924	retrait	37458.00	185230.00	147772.00	FCFA	Retrait guichet	\N	2025-06-10 11:24:59	2025-10-23 10:35:31
473ac8ec-ce0d-44ed-af84-f7252221535a	d2a1ed80-e126-493f-b155-2923909ae924	virement	38812.00	185230.00	146418.00	FCFA	Virement vers compte	add2482a-de00-41d8-a772-cd4ef6546baa	2025-10-13 22:01:06	2025-10-23 10:35:31
ae419aa9-6c30-4265-be8e-554075dc6b15	43543b43-8884-4451-8a39-e16cf1e52d3c	virement	20023.00	487487.00	467464.00	FCFA	Paiement facture	4e96181f-e984-42f8-9787-a41a67c90aba	2025-10-20 22:45:22	2025-10-23 10:35:31
45aa72c7-ea7b-482e-9b02-a4e690fc54fc	43543b43-8884-4451-8a39-e16cf1e52d3c	depot	40881.00	487487.00	528368.00	FCFA	Dépôt d'espèces	\N	2025-08-02 01:18:45	2025-10-23 10:35:31
5121e281-8cff-45bd-8677-3e6bf03115e8	43543b43-8884-4451-8a39-e16cf1e52d3c	virement	33757.00	487487.00	453730.00	FCFA	Virement vers compte	cb45ecae-4f73-42b2-870b-4f41321c9acd	2025-07-04 04:44:05	2025-10-23 10:35:31
69a34bd6-f04e-4211-ab7a-eb24321ff64a	43543b43-8884-4451-8a39-e16cf1e52d3c	virement	35233.00	487487.00	452254.00	FCFA	Virement vers compte	a0123386-5767-4f9f-b457-e0613e9f8725	2025-06-22 18:21:37	2025-10-23 10:35:31
3f6c3b67-296f-4065-87ed-f26752c941e4	43543b43-8884-4451-8a39-e16cf1e52d3c	retrait	7502.00	487487.00	479985.00	FCFA	Retrait d'espèces	\N	2025-07-01 18:22:12	2025-10-23 10:35:31
425e932b-62ed-45b0-a559-fed79ba7a60c	43543b43-8884-4451-8a39-e16cf1e52d3c	depot	12177.00	487487.00	499664.00	FCFA	Versement salaire	\N	2025-08-09 16:08:12	2025-10-23 10:35:31
1b001a56-b13d-4e80-9e73-4e6aaefd1437	43543b43-8884-4451-8a39-e16cf1e52d3c	depot	31597.00	487487.00	519084.00	FCFA	Dépôt chèque	\N	2025-07-07 17:20:35	2025-10-23 10:35:31
600ad1bf-d396-4428-acb9-180664f39b85	43543b43-8884-4451-8a39-e16cf1e52d3c	depot	6942.00	487487.00	494429.00	FCFA	Dépôt chèque	\N	2025-10-11 22:47:42	2025-10-23 10:35:31
09ab0063-487b-4159-ac30-7abfb65d4e57	43543b43-8884-4451-8a39-e16cf1e52d3c	retrait	39224.00	487487.00	448263.00	FCFA	Retrait DAB	\N	2025-06-27 03:21:07	2025-10-23 10:35:31
901cbb88-aca6-4f83-8950-9d938705c5b8	43543b43-8884-4451-8a39-e16cf1e52d3c	retrait	15769.00	487487.00	471718.00	FCFA	Paiement par carte	\N	2025-10-15 01:10:46	2025-10-23 10:35:31
e90e98ef-9e67-4607-bacd-73b3293dae04	43543b43-8884-4451-8a39-e16cf1e52d3c	virement	3460.00	487487.00	484027.00	FCFA	Transfert bancaire	8af34d52-0c28-48ed-ae2d-87e52f97806a	2025-06-02 22:07:33	2025-10-23 10:35:31
6e6751ff-3a0c-4995-bc21-8f3d36371102	43543b43-8884-4451-8a39-e16cf1e52d3c	depot	41729.00	487487.00	529216.00	FCFA	Virement bancaire entrant	\N	2025-09-10 09:54:21	2025-10-23 10:35:31
68df868f-e696-438c-ae40-5c4a05a0cbf4	43543b43-8884-4451-8a39-e16cf1e52d3c	depot	8337.00	487487.00	495824.00	FCFA	Dépôt chèque	\N	2025-07-21 17:43:12	2025-10-23 10:35:31
ed9933e3-f08d-431c-8995-db4d94e2cf31	0c099b4c-0616-44d6-af7a-38ed712edbf0	virement	21488.00	249269.00	227781.00	FCFA	Virement salaire	e5fbfcb0-c796-4371-80c6-f78f1038a282	2025-10-23 08:55:00	2025-10-23 10:35:31
ff21dc3e-f388-4404-a47d-96781b50a8c9	0c099b4c-0616-44d6-af7a-38ed712edbf0	virement	28924.00	249269.00	220345.00	FCFA	Transfert bancaire	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	2025-08-16 04:45:29	2025-10-23 10:35:31
8e3ac589-f140-420b-8491-9932394dcc4d	0c099b4c-0616-44d6-af7a-38ed712edbf0	retrait	16768.00	249269.00	232501.00	FCFA	Retrait d'espèces	\N	2025-10-20 11:23:24	2025-10-23 10:35:31
064ce5cc-1c37-4489-944d-d0bc62d9674a	0c099b4c-0616-44d6-af7a-38ed712edbf0	retrait	20302.00	249269.00	228967.00	FCFA	Retrait d'espèces	\N	2025-07-30 07:36:42	2025-10-23 10:35:31
861b8f26-a379-46a7-a23c-aed7588aaf61	0c099b4c-0616-44d6-af7a-38ed712edbf0	depot	19387.00	249269.00	268656.00	FCFA	Dépôt chèque	\N	2025-06-29 23:28:04	2025-10-23 10:35:31
1688bdfa-5619-438a-b4fe-f6dbffce9615	0c099b4c-0616-44d6-af7a-38ed712edbf0	depot	14585.00	249269.00	263854.00	FCFA	Dépôt espèces guichet	\N	2025-10-16 17:01:59	2025-10-23 10:35:31
c5f58167-c4a9-4fc5-ab57-fe4e60a740b5	0c099b4c-0616-44d6-af7a-38ed712edbf0	retrait	25376.00	249269.00	223893.00	FCFA	Retrait DAB	\N	2025-06-15 15:37:12	2025-10-23 10:35:31
52c84bfa-c203-480c-8690-3ded61470a13	0c099b4c-0616-44d6-af7a-38ed712edbf0	virement	48019.00	249269.00	201250.00	FCFA	Paiement facture	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	2025-04-27 13:05:15	2025-10-23 10:35:31
5bf203d3-7c96-4ce6-8837-da89896ebdcd	0c099b4c-0616-44d6-af7a-38ed712edbf0	depot	17254.00	249269.00	266523.00	FCFA	Dépôt chèque	\N	2025-08-25 19:46:42	2025-10-23 10:35:31
104c8ea5-c61e-4495-aa51-da220cce0580	f2182e94-c5d0-4b91-8d12-af97e101dd6b	retrait	47640.00	385571.00	337931.00	FCFA	Retrait d'espèces	\N	2025-07-20 20:56:07	2025-10-23 10:35:31
0b8c9b98-8225-4357-9b10-9620ea859ee5	f2182e94-c5d0-4b91-8d12-af97e101dd6b	depot	40590.00	385571.00	426161.00	FCFA	Dépôt d'espèces	\N	2025-10-13 20:21:54	2025-10-23 10:35:31
5b4f7dc5-3205-4079-8356-f4c8d490d5af	f2182e94-c5d0-4b91-8d12-af97e101dd6b	retrait	14433.00	385571.00	371138.00	FCFA	Prélèvement automatique	\N	2025-05-11 06:19:55	2025-10-23 10:35:31
f56bd5de-a563-460c-a4b2-d1665f927e0b	f2182e94-c5d0-4b91-8d12-af97e101dd6b	depot	46008.00	385571.00	431579.00	FCFA	Dépôt d'espèces	\N	2025-10-13 06:50:03	2025-10-23 10:35:31
aea6189d-b286-4124-ad14-e097ade847ba	f2182e94-c5d0-4b91-8d12-af97e101dd6b	virement	7867.00	385571.00	377704.00	FCFA	Virement vers compte	5cd10916-6dee-48e6-ab78-7995b1f1ce95	2025-07-26 02:36:22	2025-10-23 10:35:31
5ba02a6b-0b4c-400e-9f7b-b94127486dbc	f2182e94-c5d0-4b91-8d12-af97e101dd6b	virement	28323.00	385571.00	357248.00	FCFA	Transfert bancaire	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	2025-05-02 08:16:48	2025-10-23 10:35:31
bf1351ca-dfab-48d9-8fe0-45bd209c7bee	f2182e94-c5d0-4b91-8d12-af97e101dd6b	depot	36939.00	385571.00	422510.00	FCFA	Dépôt espèces guichet	\N	2025-06-08 15:37:10	2025-10-23 10:35:31
edbd9ed1-a837-4571-8ae6-5747bab89065	f2182e94-c5d0-4b91-8d12-af97e101dd6b	virement	25577.00	385571.00	359994.00	FCFA	Transfert entre comptes	9b7cf121-0b29-4457-b5ee-acddd651474c	2025-05-22 03:53:41	2025-10-23 10:35:31
2a049c8c-39ef-492b-ac8f-4f84c06e203f	f2182e94-c5d0-4b91-8d12-af97e101dd6b	retrait	30689.00	385571.00	354882.00	FCFA	Retrait d'espèces	\N	2025-07-18 01:34:03	2025-10-23 10:35:31
cf5e5338-6960-4bd1-bc73-882c8ddf30d6	f2182e94-c5d0-4b91-8d12-af97e101dd6b	depot	2431.00	385571.00	388002.00	FCFA	Versement salaire	\N	2025-08-19 10:40:31	2025-10-23 10:35:31
cc95abec-f6f8-426c-9d8c-d9c11ab51779	232f5785-5fd1-4398-91e2-4f92589e1d8d	retrait	9359.00	345680.00	336321.00	FCFA	Retrait DAB	\N	2025-10-18 17:59:45	2025-10-23 10:35:31
4470ec0d-985d-4d41-8f86-2f2b1cb5cbaa	232f5785-5fd1-4398-91e2-4f92589e1d8d	virement	33618.00	345680.00	312062.00	FCFA	Transfert bancaire	e5fbfcb0-c796-4371-80c6-f78f1038a282	2025-05-16 08:34:53	2025-10-23 10:35:31
10eb3f11-f009-4528-8a1a-71fb03be379a	232f5785-5fd1-4398-91e2-4f92589e1d8d	retrait	29532.00	345680.00	316148.00	FCFA	Retrait DAB	\N	2025-06-26 13:30:02	2025-10-23 10:35:31
15ee9932-bb01-45c7-be16-d183db571391	232f5785-5fd1-4398-91e2-4f92589e1d8d	depot	34160.00	345680.00	379840.00	FCFA	Dépôt chèque	\N	2025-07-20 00:33:54	2025-10-23 10:35:31
e16d3f78-ebec-407e-a10c-66f4d13abe6c	232f5785-5fd1-4398-91e2-4f92589e1d8d	depot	43378.00	345680.00	389058.00	FCFA	Versement salaire	\N	2025-07-31 23:37:29	2025-10-23 10:35:31
9e11b0ec-217c-4959-87b5-f11caa947d1a	232f5785-5fd1-4398-91e2-4f92589e1d8d	depot	41951.00	345680.00	387631.00	FCFA	Versement salaire	\N	2025-09-29 04:52:02	2025-10-23 10:35:31
7f1bc775-abb8-4986-b4ee-14aa5d1d5170	232f5785-5fd1-4398-91e2-4f92589e1d8d	retrait	34541.00	345680.00	311139.00	FCFA	Retrait guichet	\N	2025-08-24 20:29:33	2025-10-23 10:35:31
4877e427-b9b9-41dc-96f5-d64722258945	232f5785-5fd1-4398-91e2-4f92589e1d8d	depot	30588.00	345680.00	376268.00	FCFA	Versement salaire	\N	2025-05-08 07:27:21	2025-10-23 10:35:31
07535c8d-7af9-43db-a975-850da63c4f87	232f5785-5fd1-4398-91e2-4f92589e1d8d	depot	8879.00	345680.00	354559.00	FCFA	Virement bancaire entrant	\N	2025-09-01 06:00:04	2025-10-23 10:35:31
019722ad-79ef-49be-9363-af3fe7db1575	232f5785-5fd1-4398-91e2-4f92589e1d8d	virement	42906.00	345680.00	302774.00	FCFA	Transfert entre comptes	7643d019-9210-424b-b768-667e79ca8da7	2025-07-08 14:19:40	2025-10-23 10:35:31
aa6e5fb4-3c8d-4d28-8e17-f27eccb9102e	232f5785-5fd1-4398-91e2-4f92589e1d8d	retrait	17462.00	345680.00	328218.00	FCFA	Retrait d'espèces	\N	2025-05-14 01:05:59	2025-10-23 10:35:31
300e735c-f9ee-44ce-a3d3-affc2519e0cd	7643d019-9210-424b-b768-667e79ca8da7	retrait	18499.00	485706.00	467207.00	FCFA	Paiement par carte	\N	2025-05-08 23:24:30	2025-10-23 10:35:31
e8f88734-1f54-4dd2-b1fd-ce04463f7c27	7643d019-9210-424b-b768-667e79ca8da7	depot	48279.00	485706.00	533985.00	FCFA	Dépôt espèces guichet	\N	2025-10-03 23:16:48	2025-10-23 10:35:31
7531b645-9ead-4f46-b0ce-b9023c35d0ea	7643d019-9210-424b-b768-667e79ca8da7	retrait	20446.00	485706.00	465260.00	FCFA	Retrait DAB	\N	2025-05-27 16:55:52	2025-10-23 10:35:31
2ac6c158-850e-4170-8181-9cc631c26dcc	7643d019-9210-424b-b768-667e79ca8da7	retrait	28510.00	485706.00	457196.00	FCFA	Retrait guichet	\N	2025-09-28 10:09:10	2025-10-23 10:35:31
a0a59897-7aac-4e8f-a04b-9f6ea6d34680	7643d019-9210-424b-b768-667e79ca8da7	virement	44313.00	485706.00	441393.00	FCFA	Virement vers compte	2e311570-14e5-403a-a71f-698c77f8454d	2025-10-13 06:13:20	2025-10-23 10:35:31
5cbdf990-3e81-49c5-b8bb-be5909f22615	7643d019-9210-424b-b768-667e79ca8da7	retrait	7301.00	485706.00	478405.00	FCFA	Retrait guichet	\N	2025-06-16 08:58:35	2025-10-23 10:35:31
9799b7fe-4ad4-42ae-9c6e-8722ed3c730d	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	virement	7735.00	427760.00	420025.00	FCFA	Transfert entre comptes	37da1638-f10a-4a03-9eb4-9eb960273866	2025-10-07 18:25:12	2025-10-23 10:35:31
bd0fe6a8-8308-4438-953b-e9a741e39c39	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	virement	49228.00	427760.00	378532.00	FCFA	Transfert bancaire	c2b93a8c-ea1e-4b85-8224-c209137135b0	2025-07-21 18:53:52	2025-10-23 10:35:31
4d950f94-524f-4faa-99ac-34f47b478e93	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	virement	17904.00	427760.00	409856.00	FCFA	Transfert bancaire	3406986a-f161-4a7a-80be-bcdf0e3f2214	2025-07-17 07:45:00	2025-10-23 10:35:31
ccf816be-063b-4db8-ba9b-02315e9478ed	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	retrait	4176.00	427760.00	423584.00	FCFA	Retrait guichet	\N	2025-07-16 19:03:19	2025-10-23 10:35:31
c81b9c2a-f05f-429d-952e-03c1b7eccecd	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	depot	4575.00	427760.00	432335.00	FCFA	Dépôt chèque	\N	2025-08-06 16:02:07	2025-10-23 10:35:31
24eb7da8-669a-4e88-9687-61b0b9e0246f	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	retrait	18002.00	427760.00	409758.00	FCFA	Retrait DAB	\N	2025-05-14 21:35:11	2025-10-23 10:35:31
4daeb603-9901-45d8-93e4-94a1c35acaa8	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	retrait	7070.00	393814.00	386744.00	FCFA	Retrait d'espèces	\N	2025-09-21 02:19:03	2025-10-23 10:35:31
e2961c79-bf1c-4af0-a5ee-235cffee0f4d	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	retrait	33843.00	393814.00	359971.00	FCFA	Retrait guichet	\N	2025-08-18 14:49:52	2025-10-23 10:35:31
645a4431-d942-42c8-ab1f-f3031f0fe46a	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	depot	39045.00	393814.00	432859.00	FCFA	Dépôt d'espèces	\N	2025-06-08 04:55:55	2025-10-23 10:35:31
cc3d3776-6aa6-4cbd-a92a-c4e590b850f9	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	depot	45369.00	393814.00	439183.00	FCFA	Dépôt d'espèces	\N	2025-10-20 21:30:55	2025-10-23 10:35:31
98cc1b24-3500-4b8f-b614-4280ed009480	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	virement	11391.00	393814.00	382423.00	FCFA	Virement vers compte	6c92b373-c286-44a2-94a3-cf8cf3479100	2025-06-01 23:57:33	2025-10-23 10:35:31
c4091e79-5c0e-4ce7-a4df-501bf5ff111a	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	virement	24395.00	393814.00	369419.00	FCFA	Transfert bancaire	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	2025-06-01 20:11:37	2025-10-23 10:35:31
4ca8324a-24af-439e-981d-238718c4aa35	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	retrait	14627.00	89619.00	74992.00	FCFA	Retrait d'espèces	\N	2025-08-29 02:32:03	2025-10-23 10:35:31
0f328f12-435f-41af-bc50-27116c83f983	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	retrait	43925.00	89619.00	45694.00	FCFA	Prélèvement automatique	\N	2025-08-11 11:24:56	2025-10-23 10:35:31
3c0e6265-a4d9-489c-9927-5b441130234c	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	retrait	25075.00	89619.00	64544.00	FCFA	Retrait guichet	\N	2025-06-11 13:58:32	2025-10-23 10:35:31
f5fcd70b-25b9-4d8e-b105-5bd7d487eac9	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	retrait	26880.00	89619.00	62739.00	FCFA	Paiement par carte	\N	2025-08-19 21:32:10	2025-10-23 10:35:31
06284219-e9f1-4c9b-a09e-8b1c90d0550b	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	depot	15208.00	89619.00	104827.00	FCFA	Versement salaire	\N	2025-07-21 20:16:58	2025-10-23 10:35:31
03af08e4-f2fd-40be-ac2d-30eb13a75d0c	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	retrait	13128.00	89619.00	76491.00	FCFA	Paiement par carte	\N	2025-06-02 17:44:22	2025-10-23 10:35:31
277646c0-1b0d-4e63-899b-bcc494629532	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	retrait	24037.00	89619.00	65582.00	FCFA	Prélèvement automatique	\N	2025-08-01 07:26:40	2025-10-23 10:35:31
a49a7abd-f41b-4c35-9b7c-5c44b23552ce	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	depot	23917.00	89619.00	113536.00	FCFA	Dépôt espèces guichet	\N	2025-08-06 01:36:11	2025-10-23 10:35:31
11b56a57-d851-4ee6-a632-2c41a6f2d052	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	retrait	13097.00	89619.00	76522.00	FCFA	Retrait DAB	\N	2025-05-26 10:49:15	2025-10-23 10:35:31
a169bddb-f75e-433e-9098-8b70fff2ff00	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	depot	36751.00	89619.00	126370.00	FCFA	Dépôt espèces guichet	\N	2025-07-22 01:25:19	2025-10-23 10:35:31
8ea240d7-9a8b-418f-a99f-3c7d4b8105ed	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	depot	29389.00	89619.00	119008.00	FCFA	Dépôt espèces guichet	\N	2025-08-31 04:02:19	2025-10-23 10:35:31
fa51f962-df6f-409e-8d6f-a9200a1c54a8	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	retrait	46476.00	89619.00	43143.00	FCFA	Paiement par carte	\N	2025-09-14 19:17:33	2025-10-23 10:35:31
2a28973d-c051-4871-a912-342eda7d4b3b	4e0954f5-1956-40db-b392-7a6ee455c257	depot	48322.00	10565.00	58887.00	FCFA	Dépôt espèces guichet	\N	2025-09-21 07:35:42	2025-10-23 10:35:31
d347bec7-48da-4d45-a847-a05ada482af5	4e0954f5-1956-40db-b392-7a6ee455c257	retrait	10320.00	10565.00	245.00	FCFA	Retrait guichet	\N	2025-10-15 13:29:53	2025-10-23 10:35:31
7aa75395-cb94-43d7-a53e-ceebe0d5bf17	4e0954f5-1956-40db-b392-7a6ee455c257	depot	28005.00	10565.00	38570.00	FCFA	Dépôt d'espèces	\N	2025-07-30 09:51:39	2025-10-23 10:35:31
047ec9f8-e7fc-409b-8626-a77c593cf4d3	4e0954f5-1956-40db-b392-7a6ee455c257	virement	13558.00	10565.00	0.00	FCFA	Transfert entre comptes	232f5785-5fd1-4398-91e2-4f92589e1d8d	2025-09-09 19:59:45	2025-10-23 10:35:31
9cb3c07d-d6dc-4f1d-a1bf-d3cd61e3e353	4e0954f5-1956-40db-b392-7a6ee455c257	retrait	25770.00	10565.00	0.00	FCFA	Retrait guichet	\N	2025-09-27 11:55:01	2025-10-23 10:35:31
89cff042-f38a-4235-86d4-4ba1d3ac8d91	4e0954f5-1956-40db-b392-7a6ee455c257	depot	25090.00	10565.00	35655.00	FCFA	Dépôt chèque	\N	2025-05-07 12:24:54	2025-10-23 10:35:31
1dd99066-87ae-4be6-a29f-0e4958c1c1b9	4e0954f5-1956-40db-b392-7a6ee455c257	virement	10536.00	10565.00	29.00	FCFA	Transfert bancaire	916bbfef-cee4-457b-a001-da8e5b0be63d	2025-09-16 16:30:46	2025-10-23 10:35:31
7afdaf3a-81ba-45cd-8d2a-e376df90317b	4e0954f5-1956-40db-b392-7a6ee455c257	depot	32706.00	10565.00	43271.00	FCFA	Dépôt espèces guichet	\N	2025-06-10 21:59:50	2025-10-23 10:35:31
6afa64c9-e68a-49a5-9e3f-793f65a76092	473ba79b-f520-481d-82b7-0a94c75586be	retrait	37396.00	496613.00	459217.00	FCFA	Prélèvement automatique	\N	2025-06-19 12:07:07	2025-10-23 10:35:31
518fbda4-b29a-493e-b686-06a73434437c	473ba79b-f520-481d-82b7-0a94c75586be	virement	37822.00	496613.00	458791.00	FCFA	Virement salaire	3014d690-a71d-4cb9-ba59-a6c4fea73558	2025-09-27 08:18:50	2025-10-23 10:35:31
ac60b392-a867-4420-b0ea-9bd40445383b	473ba79b-f520-481d-82b7-0a94c75586be	virement	45243.00	496613.00	451370.00	FCFA	Paiement facture	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	2025-06-12 04:52:53	2025-10-23 10:35:31
00245e58-5f7e-4ea4-820d-1684a45d18c4	473ba79b-f520-481d-82b7-0a94c75586be	depot	12817.00	496613.00	509430.00	FCFA	Dépôt espèces guichet	\N	2025-07-13 21:59:32	2025-10-23 10:35:31
d3f8dcf4-49fd-42b9-b5c1-c02ce21191c7	473ba79b-f520-481d-82b7-0a94c75586be	depot	33357.00	496613.00	529970.00	FCFA	Dépôt chèque	\N	2025-08-28 12:31:26	2025-10-23 10:35:31
86c66964-07c7-4633-9015-de0d75ce05b4	473ba79b-f520-481d-82b7-0a94c75586be	depot	45504.00	496613.00	542117.00	FCFA	Dépôt d'espèces	\N	2025-08-27 19:08:32	2025-10-23 10:35:31
9ec9b0cb-7169-47b9-927a-6372576f09ce	473ba79b-f520-481d-82b7-0a94c75586be	virement	28604.00	496613.00	468009.00	FCFA	Transfert entre comptes	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	2025-05-17 16:34:46	2025-10-23 10:35:31
7b9b004a-e13a-4b03-9e65-65475e3988b8	473ba79b-f520-481d-82b7-0a94c75586be	retrait	19967.00	496613.00	476646.00	FCFA	Prélèvement automatique	\N	2025-10-09 11:48:38	2025-10-23 10:35:31
65f861cc-e557-4798-b4f7-35057aede65e	473ba79b-f520-481d-82b7-0a94c75586be	depot	31437.00	496613.00	528050.00	FCFA	Dépôt espèces guichet	\N	2025-06-30 20:50:01	2025-10-23 10:35:31
48224fc3-8447-41f2-a827-dd65172e95e4	473ba79b-f520-481d-82b7-0a94c75586be	depot	28232.00	496613.00	524845.00	FCFA	Dépôt d'espèces	\N	2025-06-07 13:32:18	2025-10-23 10:35:31
2625445c-2e6e-4c0c-8d66-cb231a9a6afd	473ba79b-f520-481d-82b7-0a94c75586be	virement	48269.00	496613.00	448344.00	FCFA	Virement vers compte	b9fcf39f-cbf6-4e3d-99da-428158581521	2025-08-23 19:10:25	2025-10-23 10:35:31
f7294c26-d9fe-4a95-8d03-b8a24420a76d	473ba79b-f520-481d-82b7-0a94c75586be	retrait	37213.00	496613.00	459400.00	FCFA	Prélèvement automatique	\N	2025-04-30 20:00:21	2025-10-23 10:35:31
cdf6689a-d17c-40c6-8482-b72599880194	473ba79b-f520-481d-82b7-0a94c75586be	depot	20124.00	496613.00	516737.00	FCFA	Dépôt chèque	\N	2025-06-09 08:54:11	2025-10-23 10:35:31
e19b6531-75ba-494a-bbd8-17307224103e	473ba79b-f520-481d-82b7-0a94c75586be	retrait	2762.00	496613.00	493851.00	FCFA	Retrait DAB	\N	2025-07-22 02:20:38	2025-10-23 10:35:31
bc2a825f-8ef7-4c1e-beed-9a3e52ce6de5	473ba79b-f520-481d-82b7-0a94c75586be	depot	7138.00	496613.00	503751.00	FCFA	Versement salaire	\N	2025-08-16 11:49:20	2025-10-23 10:35:31
4e491b19-0a54-4a2e-a893-dad6ba46c870	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	virement	34585.00	123995.00	89410.00	FCFA	Transfert bancaire	232f5785-5fd1-4398-91e2-4f92589e1d8d	2025-10-13 22:37:25	2025-10-23 10:35:31
692d5da7-1bec-4d40-a2ff-d99d178abadc	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	depot	17971.00	123995.00	141966.00	FCFA	Dépôt chèque	\N	2025-10-03 03:19:52	2025-10-23 10:35:31
0600db56-e173-453b-be0e-6896ad24188b	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	depot	1284.00	123995.00	125279.00	FCFA	Dépôt espèces guichet	\N	2025-07-09 18:32:19	2025-10-23 10:35:31
663b0699-3b9b-4536-aa61-ba14756b75bb	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	depot	20251.00	123995.00	144246.00	FCFA	Dépôt d'espèces	\N	2025-05-17 23:03:57	2025-10-23 10:35:31
8ccaa792-cd97-4008-9f45-bf22a1d76856	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	depot	38860.00	123995.00	162855.00	FCFA	Dépôt d'espèces	\N	2025-09-18 04:44:55	2025-10-23 10:35:31
137cc8c9-47bb-4037-915b-7db11f43bb47	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	retrait	41977.00	123995.00	82018.00	FCFA	Retrait guichet	\N	2025-05-14 05:13:56	2025-10-23 10:35:31
8e33be9c-c6bc-4fdb-91a5-88fcd8b140e6	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	depot	7170.00	123995.00	131165.00	FCFA	Dépôt espèces guichet	\N	2025-07-20 11:45:10	2025-10-23 10:35:31
fcd2f88f-7506-4d1d-ad88-35f78b3090bd	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	retrait	47428.00	123995.00	76567.00	FCFA	Retrait d'espèces	\N	2025-05-23 22:39:54	2025-10-23 10:35:31
59f1cc7e-b880-4fe0-a1e2-70620716fa7d	e5fbfcb0-c796-4371-80c6-f78f1038a282	virement	38856.00	475214.00	436358.00	FCFA	Virement vers compte	aaa991e6-e52e-48b7-ab07-15a4a8203054	2025-08-14 21:56:39	2025-10-23 10:35:31
4557b94b-52a0-4467-bc80-5a4a10f2d3d7	e5fbfcb0-c796-4371-80c6-f78f1038a282	depot	8740.00	475214.00	483954.00	FCFA	Dépôt chèque	\N	2025-09-01 06:01:50	2025-10-23 10:35:31
d137b5de-f258-4cec-8dfc-16f98dd5252e	e5fbfcb0-c796-4371-80c6-f78f1038a282	depot	11639.00	475214.00	486853.00	FCFA	Virement bancaire entrant	\N	2025-09-23 10:42:16	2025-10-23 10:35:31
7c629ca5-6c44-4555-8445-e1276b80e0be	e5fbfcb0-c796-4371-80c6-f78f1038a282	retrait	20239.00	475214.00	454975.00	FCFA	Retrait DAB	\N	2025-04-30 15:08:16	2025-10-23 10:35:31
46cb47f9-cb1b-4d85-9ce5-190aa98fa5ad	e5fbfcb0-c796-4371-80c6-f78f1038a282	retrait	33106.00	475214.00	442108.00	FCFA	Retrait guichet	\N	2025-06-24 12:55:53	2025-10-23 10:35:31
d55961a2-a293-4f1e-9a28-c52ad15cd303	e5fbfcb0-c796-4371-80c6-f78f1038a282	retrait	34048.00	475214.00	441166.00	FCFA	Prélèvement automatique	\N	2025-09-04 20:42:47	2025-10-23 10:35:31
00e2c62e-ebb4-4254-9bbe-9dbf552300b8	e5fbfcb0-c796-4371-80c6-f78f1038a282	retrait	33852.00	475214.00	441362.00	FCFA	Retrait d'espèces	\N	2025-09-11 00:26:42	2025-10-23 10:35:31
909cc1ca-50dd-490f-979a-a87ba9776b3e	e5fbfcb0-c796-4371-80c6-f78f1038a282	retrait	8081.00	475214.00	467133.00	FCFA	Retrait guichet	\N	2025-08-04 22:21:55	2025-10-23 10:35:31
3755d52a-c2eb-4ef7-9129-66b9133624d2	e5fbfcb0-c796-4371-80c6-f78f1038a282	virement	17089.00	475214.00	458125.00	FCFA	Virement salaire	54c98069-cb97-4a48-9c06-c8ed239ef726	2025-08-07 07:23:29	2025-10-23 10:35:31
86dd9fe2-f9c1-4ed3-81cc-db181bc2b289	e5fbfcb0-c796-4371-80c6-f78f1038a282	virement	4000.00	475214.00	471214.00	FCFA	Virement vers compte	ce34889a-7b15-48e8-9003-f1522cf517f8	2025-07-25 05:41:03	2025-10-23 10:35:31
594f4058-4a06-48c4-a1b6-1ea2a6e7451f	e5fbfcb0-c796-4371-80c6-f78f1038a282	virement	8656.00	475214.00	466558.00	FCFA	Paiement facture	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	2025-10-10 01:32:40	2025-10-23 10:35:31
19aa5aeb-fd5c-4ea0-8014-876ac910beee	e5fbfcb0-c796-4371-80c6-f78f1038a282	retrait	5617.00	475214.00	469597.00	FCFA	Retrait DAB	\N	2025-04-28 16:13:58	2025-10-23 10:35:31
24c735d7-6470-4a9a-b255-43dd46983bbf	e5fbfcb0-c796-4371-80c6-f78f1038a282	depot	5092.00	475214.00	480306.00	FCFA	Versement salaire	\N	2025-07-27 04:59:26	2025-10-23 10:35:31
90af2993-b729-4591-8029-cddaead980ad	e5fbfcb0-c796-4371-80c6-f78f1038a282	depot	32134.00	475214.00	507348.00	FCFA	Virement bancaire entrant	\N	2025-06-07 10:42:01	2025-10-23 10:35:31
98d1a0be-7e81-4755-b34e-9aec2086502f	e5fbfcb0-c796-4371-80c6-f78f1038a282	virement	37264.00	475214.00	437950.00	FCFA	Virement salaire	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	2025-09-14 08:50:58	2025-10-23 10:35:31
76a890dc-a4ce-4b34-a4c7-500a5a19d669	7b3221a6-3b25-4cc8-a934-e795af882682	depot	46635.00	24767.00	71402.00	FCFA	Virement bancaire entrant	\N	2025-05-04 03:58:04	2025-10-23 10:35:31
a92592ae-6c41-4907-83ca-dd20e8683288	7b3221a6-3b25-4cc8-a934-e795af882682	depot	41841.00	24767.00	66608.00	FCFA	Virement bancaire entrant	\N	2025-07-11 03:22:38	2025-10-23 10:35:31
87448683-0985-4e05-bb10-7e52aa5af478	7b3221a6-3b25-4cc8-a934-e795af882682	depot	12738.00	24767.00	37505.00	FCFA	Dépôt chèque	\N	2025-07-05 21:12:28	2025-10-23 10:35:31
19f80216-5c1a-44aa-8bdf-883ba646e493	7b3221a6-3b25-4cc8-a934-e795af882682	virement	7761.00	24767.00	17006.00	FCFA	Transfert entre comptes	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	2025-08-09 09:24:55	2025-10-23 10:35:31
bec83cb1-5473-448b-9d90-051a5322a07a	7b3221a6-3b25-4cc8-a934-e795af882682	retrait	14356.00	24767.00	10411.00	FCFA	Paiement par carte	\N	2025-09-01 23:57:58	2025-10-23 10:35:31
83191dd4-fecc-427b-b3b7-da9dd9399608	7b3221a6-3b25-4cc8-a934-e795af882682	depot	36331.00	24767.00	61098.00	FCFA	Dépôt espèces guichet	\N	2025-08-27 15:30:53	2025-10-23 10:35:31
649370e6-1fda-4e8a-8b16-58ee0a72f96e	7b3221a6-3b25-4cc8-a934-e795af882682	virement	31698.00	24767.00	0.00	FCFA	Virement salaire	a0123386-5767-4f9f-b457-e0613e9f8725	2025-05-26 17:49:11	2025-10-23 10:35:31
1c08e70b-0c0b-44e2-b242-5de545a945cf	7b3221a6-3b25-4cc8-a934-e795af882682	retrait	1124.00	24767.00	23643.00	FCFA	Paiement par carte	\N	2025-06-22 09:10:57	2025-10-23 10:35:31
705d4a3c-a23d-4a15-ba8b-746d3ead5f25	7b3221a6-3b25-4cc8-a934-e795af882682	virement	34939.00	24767.00	0.00	FCFA	Paiement facture	34b84e17-27b4-4080-a77b-3cdb00476a06	2025-06-29 23:18:39	2025-10-23 10:35:31
1c909fc3-eb12-4f1b-a517-dbc74684d0c7	7b3221a6-3b25-4cc8-a934-e795af882682	virement	35017.00	24767.00	0.00	FCFA	Transfert bancaire	b1ce150f-0fc3-432e-8d5b-a34f6747804a	2025-09-11 06:23:31	2025-10-23 10:35:31
460ffc23-dd43-457b-936b-e4fcb066a1dc	7b3221a6-3b25-4cc8-a934-e795af882682	retrait	20273.00	24767.00	4494.00	FCFA	Paiement par carte	\N	2025-06-23 10:08:26	2025-10-23 10:35:31
d48ee66a-ae1a-4fe8-a2a7-9430f67b90d8	7b3221a6-3b25-4cc8-a934-e795af882682	retrait	13022.00	24767.00	11745.00	FCFA	Retrait guichet	\N	2025-10-22 17:12:50	2025-10-23 10:35:31
df2314eb-b7cd-472e-a72e-6c111c43829b	7b3221a6-3b25-4cc8-a934-e795af882682	virement	1209.00	24767.00	23558.00	FCFA	Paiement facture	34b84e17-27b4-4080-a77b-3cdb00476a06	2025-07-22 17:49:41	2025-10-23 10:35:31
d855580f-c42b-4d82-9fbc-027fc2ada949	7b3221a6-3b25-4cc8-a934-e795af882682	depot	16660.00	24767.00	41427.00	FCFA	Dépôt chèque	\N	2025-07-24 06:26:20	2025-10-23 10:35:31
ca720659-f110-4244-8832-30551113398e	7b3221a6-3b25-4cc8-a934-e795af882682	retrait	18323.00	24767.00	6444.00	FCFA	Retrait guichet	\N	2025-04-24 01:36:32	2025-10-23 10:35:31
442eead4-37b5-415d-b617-46ffa80e06fe	1eece79a-3f27-456a-8f76-0b4de6cba5e4	retrait	7724.00	159512.00	151788.00	FCFA	Paiement par carte	\N	2025-09-27 23:07:57	2025-10-23 10:35:31
8af0be92-867e-4c47-bb6c-057223765ce6	1eece79a-3f27-456a-8f76-0b4de6cba5e4	virement	26443.00	159512.00	133069.00	FCFA	Paiement facture	8a4ca722-53cc-428f-a83a-d84a7f681abf	2025-06-01 03:48:34	2025-10-23 10:35:31
19cdd9b6-63b6-45fe-9f75-906f2a16e99b	1eece79a-3f27-456a-8f76-0b4de6cba5e4	retrait	49675.00	159512.00	109837.00	FCFA	Retrait d'espèces	\N	2025-07-22 04:36:18	2025-10-23 10:35:31
1cc41a6a-2669-4251-b4e0-7aec2f469220	1eece79a-3f27-456a-8f76-0b4de6cba5e4	depot	18831.00	159512.00	178343.00	FCFA	Virement bancaire entrant	\N	2025-08-13 12:49:41	2025-10-23 10:35:31
f15f817f-18ba-4cc3-b974-01f80b39286d	1eece79a-3f27-456a-8f76-0b4de6cba5e4	virement	1639.00	159512.00	157873.00	FCFA	Transfert bancaire	0006e5f7-4df5-46a5-8f9e-90089c5ea052	2025-06-12 16:33:59	2025-10-23 10:35:31
b3315a51-fc4b-4952-aece-6897f81198ef	1eece79a-3f27-456a-8f76-0b4de6cba5e4	virement	2115.00	159512.00	157397.00	FCFA	Virement salaire	61bcb7e8-d7d1-45da-9b25-70fba627d304	2025-05-09 18:23:59	2025-10-23 10:35:31
d1f1e067-e712-4386-8ebb-c19f44b924d6	1eece79a-3f27-456a-8f76-0b4de6cba5e4	virement	32675.00	159512.00	126837.00	FCFA	Transfert entre comptes	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	2025-06-20 13:26:35	2025-10-23 10:35:31
616bd178-7d71-4368-b63f-d9ee7000c299	1eece79a-3f27-456a-8f76-0b4de6cba5e4	depot	10458.00	159512.00	169970.00	FCFA	Dépôt chèque	\N	2025-08-30 00:14:31	2025-10-23 10:35:31
38b1c6be-52ea-4320-9ff2-ec02a7d838fd	1eece79a-3f27-456a-8f76-0b4de6cba5e4	virement	7800.00	159512.00	151712.00	FCFA	Virement vers compte	a5bad169-7741-4b82-9dde-4803bb629488	2025-06-05 13:35:39	2025-10-23 10:35:31
4a19fe91-c639-4eab-97d3-c555353b225a	1eece79a-3f27-456a-8f76-0b4de6cba5e4	virement	49691.00	159512.00	109821.00	FCFA	Transfert bancaire	d5017ad9-771a-4ec6-8b01-e408480e8116	2025-08-27 15:12:40	2025-10-23 10:35:31
d508c67e-ec93-494e-9963-f683060f59c1	a1f1990b-1819-4977-aaf0-bb14a824daa0	virement	49376.00	396980.00	347604.00	FCFA	Paiement facture	f712d8d9-57b6-49a4-a8eb-5e04856619a9	2025-05-29 16:39:30	2025-10-23 10:35:31
f3e544fc-a40d-4bb6-b83d-669d4be9ad24	a1f1990b-1819-4977-aaf0-bb14a824daa0	retrait	39698.00	396980.00	357282.00	FCFA	Prélèvement automatique	\N	2025-08-01 10:27:03	2025-10-23 10:35:31
102d31a9-d157-4881-9c9e-d4c70b5344cd	a1f1990b-1819-4977-aaf0-bb14a824daa0	depot	28963.00	396980.00	425943.00	FCFA	Virement bancaire entrant	\N	2025-08-02 20:09:35	2025-10-23 10:35:31
6c02f471-bd80-47fa-ad7e-86a246c85831	a1f1990b-1819-4977-aaf0-bb14a824daa0	retrait	13431.00	396980.00	383549.00	FCFA	Retrait DAB	\N	2025-05-21 03:36:48	2025-10-23 10:35:31
0d34641e-35e5-4a44-b3a8-e45c6038afa8	a1f1990b-1819-4977-aaf0-bb14a824daa0	virement	48381.00	396980.00	348599.00	FCFA	Transfert bancaire	b26e640d-87a1-49a8-a880-2a2088a4fca0	2025-10-04 09:04:02	2025-10-23 10:35:31
792ec857-dd71-4432-ae8d-56bd1c8a9c2e	a1f1990b-1819-4977-aaf0-bb14a824daa0	virement	30835.00	396980.00	366145.00	FCFA	Paiement facture	1eece79a-3f27-456a-8f76-0b4de6cba5e4	2025-06-13 23:07:15	2025-10-23 10:35:31
f4c17be2-6b08-4276-84d5-c7815ca5cce9	a1f1990b-1819-4977-aaf0-bb14a824daa0	virement	14383.00	396980.00	382597.00	FCFA	Virement salaire	e5fbfcb0-c796-4371-80c6-f78f1038a282	2025-08-15 06:15:53	2025-10-23 10:35:31
8fff2e80-e472-4b3c-95a7-468ae286167a	a1f1990b-1819-4977-aaf0-bb14a824daa0	depot	47931.00	396980.00	444911.00	FCFA	Dépôt espèces guichet	\N	2025-08-24 21:01:12	2025-10-23 10:35:31
3f82334b-f2d7-44d2-b975-2691bb2482b1	a1f1990b-1819-4977-aaf0-bb14a824daa0	retrait	26521.00	396980.00	370459.00	FCFA	Retrait DAB	\N	2025-04-30 20:25:21	2025-10-23 10:35:31
c6be76b5-fed1-440d-b0f6-10514f043292	a1f1990b-1819-4977-aaf0-bb14a824daa0	depot	13564.00	396980.00	410544.00	FCFA	Versement salaire	\N	2025-04-24 04:19:55	2025-10-23 10:35:31
3f029327-2b11-4293-bf18-9c9f6593b575	a1f1990b-1819-4977-aaf0-bb14a824daa0	depot	22267.00	396980.00	419247.00	FCFA	Dépôt chèque	\N	2025-10-08 11:14:06	2025-10-23 10:35:31
dcbc8a47-d7c0-4980-93d2-9d9bf7cab609	a1f1990b-1819-4977-aaf0-bb14a824daa0	virement	27389.00	396980.00	369591.00	FCFA	Virement vers compte	b30db983-96ad-4f5c-a50c-1637c25f3b46	2025-05-25 12:48:06	2025-10-23 10:35:31
43fbe0dc-4c4a-4c5f-815e-5184bcb757f9	a1f1990b-1819-4977-aaf0-bb14a824daa0	depot	16408.00	396980.00	413388.00	FCFA	Virement bancaire entrant	\N	2025-07-14 00:35:13	2025-10-23 10:35:31
a2cc7233-ee89-4bbc-9d60-47bdbf96fe03	a1f1990b-1819-4977-aaf0-bb14a824daa0	depot	45980.00	396980.00	442960.00	FCFA	Virement bancaire entrant	\N	2025-09-27 19:48:13	2025-10-23 10:35:31
5c1c7e83-1bea-4e42-9510-6ef40de213f5	1a2a915d-173c-44e7-a655-e29b9a02fd18	virement	48480.00	174764.00	126284.00	FCFA	Virement vers compte	d5017ad9-771a-4ec6-8b01-e408480e8116	2025-08-04 11:02:36	2025-10-23 10:35:31
e52871b0-2937-4a4c-a1cd-309fd957a021	1a2a915d-173c-44e7-a655-e29b9a02fd18	depot	4496.00	174764.00	179260.00	FCFA	Versement salaire	\N	2025-06-08 11:49:22	2025-10-23 10:35:31
e6151c9e-fdd8-4e15-91d2-7ff0a747571f	1a2a915d-173c-44e7-a655-e29b9a02fd18	virement	36131.00	174764.00	138633.00	FCFA	Virement vers compte	bf69dba7-7153-4b9d-885b-f7fa7330e249	2025-09-22 23:28:51	2025-10-23 10:35:31
259fbfe4-acd8-4dbb-83c3-102f599ce26f	1a2a915d-173c-44e7-a655-e29b9a02fd18	retrait	26242.00	174764.00	148522.00	FCFA	Retrait DAB	\N	2025-07-15 21:48:51	2025-10-23 10:35:31
64f7e58d-4129-411c-a9d0-df594b7e586d	1a2a915d-173c-44e7-a655-e29b9a02fd18	virement	40571.00	174764.00	134193.00	FCFA	Virement vers compte	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	2025-08-02 00:19:21	2025-10-23 10:35:31
4affe260-639c-44fc-8e6e-141efd932424	1a2a915d-173c-44e7-a655-e29b9a02fd18	retrait	5963.00	174764.00	168801.00	FCFA	Prélèvement automatique	\N	2025-06-16 17:35:31	2025-10-23 10:35:31
542ff13a-80ea-4de3-a6bf-3bf2061aecad	1a2a915d-173c-44e7-a655-e29b9a02fd18	retrait	45006.00	174764.00	129758.00	FCFA	Prélèvement automatique	\N	2025-07-08 03:36:15	2025-10-23 10:35:31
8379588b-5c16-4124-a797-06fdc3de2541	1a2a915d-173c-44e7-a655-e29b9a02fd18	depot	2152.00	174764.00	176916.00	FCFA	Versement salaire	\N	2025-10-05 11:43:34	2025-10-23 10:35:31
1cc64211-6e4e-4edb-91c4-4eda8667e203	1a2a915d-173c-44e7-a655-e29b9a02fd18	virement	37103.00	174764.00	137661.00	FCFA	Transfert bancaire	64203f77-d74d-4752-9e2b-7a1c40547be9	2025-09-11 14:21:49	2025-10-23 10:35:31
2af8620d-9007-4c06-becc-6dfa5932a7c3	1a2a915d-173c-44e7-a655-e29b9a02fd18	depot	45760.00	174764.00	220524.00	FCFA	Virement bancaire entrant	\N	2025-05-07 22:12:11	2025-10-23 10:35:31
8d90ae79-8af9-4db1-aba8-e5a6e5f935a4	8d706bac-d7d8-4172-8d94-d1a8cdf604db	retrait	13017.00	333318.00	320301.00	FCFA	Paiement par carte	\N	2025-06-21 06:24:10	2025-10-23 10:35:31
93c4be9c-34d0-4104-be37-93b38fed3a50	8d706bac-d7d8-4172-8d94-d1a8cdf604db	virement	15667.00	333318.00	317651.00	FCFA	Virement salaire	b9fcf39f-cbf6-4e3d-99da-428158581521	2025-05-04 00:54:45	2025-10-23 10:35:31
7110a177-b46d-47be-b5b8-4bd07cf60764	8d706bac-d7d8-4172-8d94-d1a8cdf604db	retrait	8816.00	333318.00	324502.00	FCFA	Paiement par carte	\N	2025-05-31 00:32:43	2025-10-23 10:35:31
7085c846-219d-4ce5-8413-41538e80439c	8d706bac-d7d8-4172-8d94-d1a8cdf604db	retrait	35006.00	333318.00	298312.00	FCFA	Retrait DAB	\N	2025-10-02 08:07:25	2025-10-23 10:35:31
b3a60308-9c04-4ddf-b5c6-e6ef66435382	8d706bac-d7d8-4172-8d94-d1a8cdf604db	retrait	2072.00	333318.00	331246.00	FCFA	Retrait d'espèces	\N	2025-10-23 04:56:27	2025-10-23 10:35:31
5b918c2f-3795-4e13-a162-17a930171bb8	8d706bac-d7d8-4172-8d94-d1a8cdf604db	depot	37824.00	333318.00	371142.00	FCFA	Virement bancaire entrant	\N	2025-06-11 09:36:43	2025-10-23 10:35:31
a95e092c-29a3-41e5-a54d-7af9202aac04	8d706bac-d7d8-4172-8d94-d1a8cdf604db	retrait	30895.00	333318.00	302423.00	FCFA	Prélèvement automatique	\N	2025-07-25 19:32:33	2025-10-23 10:35:31
582a4279-42eb-47ff-8f81-110b8e5388cb	8d706bac-d7d8-4172-8d94-d1a8cdf604db	retrait	31421.00	333318.00	301897.00	FCFA	Paiement par carte	\N	2025-08-10 03:53:32	2025-10-23 10:35:31
028c3d4e-2fcd-4a96-85c4-a85a87f49453	8d706bac-d7d8-4172-8d94-d1a8cdf604db	virement	37425.00	333318.00	295893.00	FCFA	Virement salaire	add2482a-de00-41d8-a772-cd4ef6546baa	2025-05-27 14:19:49	2025-10-23 10:35:31
18470e81-b6dd-4a39-b7c2-7d1da043b3a3	8d706bac-d7d8-4172-8d94-d1a8cdf604db	depot	35371.00	333318.00	368689.00	FCFA	Versement salaire	\N	2025-10-05 02:45:31	2025-10-23 10:35:31
c936719d-e3eb-4c0d-a5cc-b90cb8607ce6	8d706bac-d7d8-4172-8d94-d1a8cdf604db	depot	44614.00	333318.00	377932.00	FCFA	Dépôt espèces guichet	\N	2025-10-08 13:30:24	2025-10-23 10:35:31
d722a787-b586-4d81-a48b-9298482d1572	8d706bac-d7d8-4172-8d94-d1a8cdf604db	virement	16116.00	333318.00	317202.00	FCFA	Virement salaire	43543b43-8884-4451-8a39-e16cf1e52d3c	2025-07-04 02:27:32	2025-10-23 10:35:31
5b376ee1-c357-4d56-aa40-62a1484fd27e	3b545ec9-8048-4c12-a074-df603671d400	retrait	7842.00	483714.00	475872.00	FCFA	Retrait d'espèces	\N	2025-05-10 07:23:24	2025-10-23 10:35:31
31d04304-e6c7-4e90-a598-e3018f40ddc9	3b545ec9-8048-4c12-a074-df603671d400	depot	39897.00	483714.00	523611.00	FCFA	Dépôt espèces guichet	\N	2025-08-24 22:48:52	2025-10-23 10:35:31
1cbfb6a5-38af-4fb4-aa38-c8d51afc7fa1	3b545ec9-8048-4c12-a074-df603671d400	virement	30810.00	483714.00	452904.00	FCFA	Transfert entre comptes	05c0a3e8-eeae-4976-88c2-848aec6bea96	2025-05-28 16:28:19	2025-10-23 10:35:31
fa851c4e-4431-41ba-a52e-db58c4808110	3b545ec9-8048-4c12-a074-df603671d400	depot	11773.00	483714.00	495487.00	FCFA	Dépôt chèque	\N	2025-10-21 12:44:07	2025-10-23 10:35:31
c12f7c26-b154-4949-b923-524935aabc62	3b545ec9-8048-4c12-a074-df603671d400	virement	10623.00	483714.00	473091.00	FCFA	Paiement facture	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	2025-07-05 14:36:58	2025-10-23 10:35:31
639c70e3-1f1d-426c-a4b6-189816142962	3b545ec9-8048-4c12-a074-df603671d400	virement	41851.00	483714.00	441863.00	FCFA	Virement salaire	b26e640d-87a1-49a8-a880-2a2088a4fca0	2025-06-14 14:05:33	2025-10-23 10:35:31
d5c0a76f-9d2c-4bbd-b3e6-47c77b7f85fb	3b545ec9-8048-4c12-a074-df603671d400	retrait	22602.00	483714.00	461112.00	FCFA	Paiement par carte	\N	2025-04-27 17:33:05	2025-10-23 10:35:31
a4e525ed-71b1-4587-acb8-13f5099aa2d6	3b545ec9-8048-4c12-a074-df603671d400	virement	13574.00	483714.00	470140.00	FCFA	Virement salaire	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	2025-04-25 04:40:41	2025-10-23 10:35:31
a41e5b18-9e6c-4b02-8051-0379ee2045cd	3b545ec9-8048-4c12-a074-df603671d400	retrait	1581.00	483714.00	482133.00	FCFA	Paiement par carte	\N	2025-09-29 02:33:25	2025-10-23 10:35:31
787964ff-6dcd-4dec-9ef7-fe97ccfe0583	3b545ec9-8048-4c12-a074-df603671d400	retrait	31963.00	483714.00	451751.00	FCFA	Retrait guichet	\N	2025-09-25 22:58:48	2025-10-23 10:35:31
ea0a6469-6ac6-46d7-8606-f143ca5fb7e6	3b545ec9-8048-4c12-a074-df603671d400	virement	47516.00	483714.00	436198.00	FCFA	Paiement facture	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	2025-07-08 00:00:50	2025-10-23 10:35:31
d401f147-9c82-4b9b-915d-dad18ee7a86b	3b545ec9-8048-4c12-a074-df603671d400	virement	13706.00	483714.00	470008.00	FCFA	Paiement facture	05c0a3e8-eeae-4976-88c2-848aec6bea96	2025-04-28 11:51:24	2025-10-23 10:35:31
bd243714-7fa4-405f-8ecd-ebd9046f70aa	3b545ec9-8048-4c12-a074-df603671d400	retrait	15544.00	483714.00	468170.00	FCFA	Paiement par carte	\N	2025-06-22 13:24:22	2025-10-23 10:35:31
19552de6-ccc4-41b3-921d-30b3ed7d02e5	3b545ec9-8048-4c12-a074-df603671d400	virement	33057.00	483714.00	450657.00	FCFA	Transfert entre comptes	f2182e94-c5d0-4b91-8d12-af97e101dd6b	2025-09-27 23:30:44	2025-10-23 10:35:31
53ac0c9e-1c81-4591-98b4-11bd31d03a35	3b545ec9-8048-4c12-a074-df603671d400	virement	29156.00	483714.00	454558.00	FCFA	Virement salaire	add2482a-de00-41d8-a772-cd4ef6546baa	2025-09-26 13:48:43	2025-10-23 10:35:31
57b1b280-a0ca-4891-a802-5db69450a361	61bcb7e8-d7d1-45da-9b25-70fba627d304	depot	25123.00	227247.00	252370.00	FCFA	Virement bancaire entrant	\N	2025-06-03 17:18:17	2025-10-23 10:35:31
4a07e109-41ec-46d5-b60a-f383ad4ebd8b	61bcb7e8-d7d1-45da-9b25-70fba627d304	depot	27107.00	227247.00	254354.00	FCFA	Dépôt espèces guichet	\N	2025-10-03 10:53:38	2025-10-23 10:35:31
f0dd51c6-48a1-471b-a23f-80a8b0ce5b99	61bcb7e8-d7d1-45da-9b25-70fba627d304	virement	14784.00	227247.00	212463.00	FCFA	Transfert bancaire	05c0a3e8-eeae-4976-88c2-848aec6bea96	2025-05-02 16:55:30	2025-10-23 10:35:31
3d55dca2-33e5-478e-98ea-88b47cf1b538	61bcb7e8-d7d1-45da-9b25-70fba627d304	depot	43285.00	227247.00	270532.00	FCFA	Versement salaire	\N	2025-07-31 04:05:41	2025-10-23 10:35:31
e79f12e2-2f98-49d8-9635-3caa823cc62b	61bcb7e8-d7d1-45da-9b25-70fba627d304	depot	39538.00	227247.00	266785.00	FCFA	Versement salaire	\N	2025-08-17 15:30:12	2025-10-23 10:35:31
465253f6-a96d-41af-b449-f7961e9843ad	61bcb7e8-d7d1-45da-9b25-70fba627d304	depot	45964.00	227247.00	273211.00	FCFA	Dépôt d'espèces	\N	2025-07-16 19:58:24	2025-10-23 10:35:31
e00876ff-8c3c-472d-878e-593cbb62dd3a	61bcb7e8-d7d1-45da-9b25-70fba627d304	depot	48480.00	227247.00	275727.00	FCFA	Versement salaire	\N	2025-09-20 13:19:46	2025-10-23 10:35:31
a31a2982-1206-42a9-8b0e-ff48e10263e9	61bcb7e8-d7d1-45da-9b25-70fba627d304	virement	26677.00	227247.00	200570.00	FCFA	Virement vers compte	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	2025-05-20 22:31:28	2025-10-23 10:35:31
99c99d34-69bc-4e45-a7c9-09bf02618421	61bcb7e8-d7d1-45da-9b25-70fba627d304	virement	10026.00	227247.00	217221.00	FCFA	Transfert bancaire	a0123386-5767-4f9f-b457-e0613e9f8725	2025-07-04 08:06:33	2025-10-23 10:35:31
0ae0ffad-5f68-4e75-ab11-b58896e5c45f	61bcb7e8-d7d1-45da-9b25-70fba627d304	virement	32943.00	227247.00	194304.00	FCFA	Transfert entre comptes	e5fbfcb0-c796-4371-80c6-f78f1038a282	2025-08-22 01:42:40	2025-10-23 10:35:31
8a5ce673-f674-484b-9979-218efd0e92b4	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	virement	18782.00	113941.00	95159.00	FCFA	Virement vers compte	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	2025-06-14 17:12:58	2025-10-23 10:35:31
48fc1a6d-81a5-4bb3-980c-fa2af683cf2c	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	virement	21219.00	113941.00	92722.00	FCFA	Virement salaire	b3c57074-cab3-490f-9d70-3da5066332f6	2025-07-30 17:26:15	2025-10-23 10:35:31
839b3eda-164f-43d8-8779-a58555cd658f	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	depot	38162.00	113941.00	152103.00	FCFA	Dépôt espèces guichet	\N	2025-05-02 15:09:22	2025-10-23 10:35:31
0c248ca3-994b-49d3-bc56-f025b9702664	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	depot	14406.00	113941.00	128347.00	FCFA	Dépôt espèces guichet	\N	2025-07-14 06:19:50	2025-10-23 10:35:31
eaa6a71b-bb52-481c-8908-216c46ff7da3	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	virement	28064.00	113941.00	85877.00	FCFA	Transfert entre comptes	bf69dba7-7153-4b9d-885b-f7fa7330e249	2025-07-10 19:33:46	2025-10-23 10:35:31
ca819e67-b370-4f12-9dd1-2c7d95ba6a41	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	retrait	37686.00	113941.00	76255.00	FCFA	Prélèvement automatique	\N	2025-10-03 12:38:47	2025-10-23 10:35:31
b9949bf5-f379-45c6-954c-1ea9e50d3624	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	depot	12810.00	113941.00	126751.00	FCFA	Dépôt espèces guichet	\N	2025-06-26 15:12:04	2025-10-23 10:35:31
227c9993-1561-4801-937e-daee00d15b08	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	virement	7851.00	113941.00	106090.00	FCFA	Transfert bancaire	b3c57074-cab3-490f-9d70-3da5066332f6	2025-09-30 05:04:15	2025-10-23 10:35:31
aaabf320-076b-4fe4-9a36-6d476a9743df	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	virement	12886.00	113941.00	101055.00	FCFA	Paiement facture	4e0954f5-1956-40db-b392-7a6ee455c257	2025-06-07 00:33:10	2025-10-23 10:35:32
a79f8f3a-ceda-4e38-8dee-67bcee625128	9c0923b4-0a14-4650-8df8-edf426310de6	virement	10742.00	33137.00	22395.00	FCFA	Virement salaire	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	2025-08-24 03:21:23	2025-10-23 10:35:32
60db4c05-c72e-406e-87c4-707790c1e56a	9c0923b4-0a14-4650-8df8-edf426310de6	depot	18722.00	33137.00	51859.00	FCFA	Dépôt d'espèces	\N	2025-05-29 10:44:44	2025-10-23 10:35:32
e241252d-068a-4341-ac02-d23a405fc337	9c0923b4-0a14-4650-8df8-edf426310de6	depot	19343.00	33137.00	52480.00	FCFA	Dépôt espèces guichet	\N	2025-08-11 21:09:30	2025-10-23 10:35:32
a1676507-ef36-47d1-a70a-972ed8c035d9	9c0923b4-0a14-4650-8df8-edf426310de6	retrait	27478.00	33137.00	5659.00	FCFA	Prélèvement automatique	\N	2025-10-03 22:09:26	2025-10-23 10:35:32
38a3fc0d-9855-4200-b714-4855c19616ad	9c0923b4-0a14-4650-8df8-edf426310de6	virement	24893.00	33137.00	8244.00	FCFA	Virement salaire	4e0954f5-1956-40db-b392-7a6ee455c257	2025-05-06 15:52:22	2025-10-23 10:35:32
1f1dd399-41be-43a0-8f23-0b567929607e	9c0923b4-0a14-4650-8df8-edf426310de6	virement	45994.00	33137.00	0.00	FCFA	Transfert bancaire	bf69dba7-7153-4b9d-885b-f7fa7330e249	2025-07-05 05:18:04	2025-10-23 10:35:32
b5569243-0acc-41c8-a36b-7ba11159e906	9c0923b4-0a14-4650-8df8-edf426310de6	virement	29936.00	33137.00	3201.00	FCFA	Paiement facture	d5017ad9-771a-4ec6-8b01-e408480e8116	2025-08-26 21:31:14	2025-10-23 10:35:32
beee83f3-bdd5-4369-9c46-16483a8fba8d	9c0923b4-0a14-4650-8df8-edf426310de6	virement	46226.00	33137.00	0.00	FCFA	Virement salaire	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	2025-05-01 01:28:54	2025-10-23 10:35:32
7d74161a-0bc2-42f8-a699-ee0dc2795557	9c0923b4-0a14-4650-8df8-edf426310de6	virement	8586.00	33137.00	24551.00	FCFA	Virement salaire	b3c57074-cab3-490f-9d70-3da5066332f6	2025-10-23 08:03:58	2025-10-23 10:35:32
a903e695-d8b7-4235-bc66-9e7ac72e152b	9c0923b4-0a14-4650-8df8-edf426310de6	virement	46097.00	33137.00	0.00	FCFA	Transfert entre comptes	8a4ca722-53cc-428f-a83a-d84a7f681abf	2025-08-17 14:30:10	2025-10-23 10:35:32
a4641c1d-1ad4-4ab5-9857-09d3108306b2	9c0923b4-0a14-4650-8df8-edf426310de6	retrait	35048.00	33137.00	0.00	FCFA	Prélèvement automatique	\N	2025-06-02 10:18:05	2025-10-23 10:35:32
760fc251-1d84-4cfa-9a96-df58a6537fec	9c0923b4-0a14-4650-8df8-edf426310de6	virement	31116.00	33137.00	2021.00	FCFA	Transfert entre comptes	2e311570-14e5-403a-a71f-698c77f8454d	2025-10-08 21:17:04	2025-10-23 10:35:32
fcc893d8-9204-4ad4-8b71-8abe112fb5c1	9c0923b4-0a14-4650-8df8-edf426310de6	depot	37692.00	33137.00	70829.00	FCFA	Virement bancaire entrant	\N	2025-10-12 13:06:55	2025-10-23 10:35:32
aa91fdb6-3184-4e53-bf6b-0e3baaed30df	9c0923b4-0a14-4650-8df8-edf426310de6	retrait	19218.00	33137.00	13919.00	FCFA	Retrait d'espèces	\N	2025-09-04 02:21:18	2025-10-23 10:35:32
3909719c-a3cb-4f11-ad3a-5b490f8db538	93ec7354-821a-4306-8dcb-5b911268af75	retrait	48396.00	397957.00	349561.00	FCFA	Retrait DAB	\N	2025-05-29 20:59:11	2025-10-23 10:35:32
82a4924a-0cf0-4f56-9805-ef22069e01b8	93ec7354-821a-4306-8dcb-5b911268af75	depot	16455.00	397957.00	414412.00	FCFA	Versement salaire	\N	2025-10-09 00:44:07	2025-10-23 10:35:32
a3f8a13a-d43e-4809-ab0c-8f581630a73e	93ec7354-821a-4306-8dcb-5b911268af75	depot	47101.00	397957.00	445058.00	FCFA	Versement salaire	\N	2025-07-21 16:10:55	2025-10-23 10:35:32
27e750d4-d8e6-4cad-9c81-a795c3a8d2d2	93ec7354-821a-4306-8dcb-5b911268af75	virement	15536.00	397957.00	382421.00	FCFA	Transfert bancaire	b1ce150f-0fc3-432e-8d5b-a34f6747804a	2025-06-11 15:41:12	2025-10-23 10:35:32
9fd31847-da0f-43aa-a5e5-8142e7c74416	93ec7354-821a-4306-8dcb-5b911268af75	depot	13983.00	397957.00	411940.00	FCFA	Dépôt d'espèces	\N	2025-07-15 19:56:37	2025-10-23 10:35:32
62e45d6d-4144-4896-82b0-154ac20d320b	93ec7354-821a-4306-8dcb-5b911268af75	retrait	49677.00	397957.00	348280.00	FCFA	Paiement par carte	\N	2025-05-29 17:44:21	2025-10-23 10:35:32
3b93341c-1fbd-40b1-a6ea-b5ff07cf3821	93ec7354-821a-4306-8dcb-5b911268af75	virement	45370.00	397957.00	352587.00	FCFA	Virement salaire	1eece79a-3f27-456a-8f76-0b4de6cba5e4	2025-05-31 07:34:13	2025-10-23 10:35:32
eefd1dcd-0f4c-4376-9f85-0d4fcd3dbc47	93ec7354-821a-4306-8dcb-5b911268af75	depot	21942.00	397957.00	419899.00	FCFA	Dépôt chèque	\N	2025-09-28 10:43:05	2025-10-23 10:35:32
dc713349-af09-4d05-afe0-a3047389d495	93ec7354-821a-4306-8dcb-5b911268af75	virement	3784.00	397957.00	394173.00	FCFA	Transfert bancaire	65da4070-27f5-40a7-99d9-db64e3163a65	2025-05-29 06:52:28	2025-10-23 10:35:32
0f97a887-4e49-43c0-93f1-c8aea71837aa	93ec7354-821a-4306-8dcb-5b911268af75	virement	32361.00	397957.00	365596.00	FCFA	Transfert bancaire	c2b93a8c-ea1e-4b85-8224-c209137135b0	2025-09-28 04:41:00	2025-10-23 10:35:32
64239c05-64c2-462f-af68-05fbef7f0122	93ec7354-821a-4306-8dcb-5b911268af75	depot	13988.00	397957.00	411945.00	FCFA	Versement salaire	\N	2025-05-22 14:50:03	2025-10-23 10:35:32
6615133e-b39a-4d4f-b8dc-cb3f93dd97b6	93ec7354-821a-4306-8dcb-5b911268af75	retrait	26819.00	397957.00	371138.00	FCFA	Retrait DAB	\N	2025-09-25 22:09:04	2025-10-23 10:35:32
e0734f12-80e4-4275-83ef-577313b1f640	93ec7354-821a-4306-8dcb-5b911268af75	virement	3350.00	397957.00	394607.00	FCFA	Transfert entre comptes	b30db983-96ad-4f5c-a50c-1637c25f3b46	2025-09-25 02:41:56	2025-10-23 10:35:32
e3aac0b5-97e0-42f3-a3f3-d071c7648e9a	93ec7354-821a-4306-8dcb-5b911268af75	depot	21304.00	397957.00	419261.00	FCFA	Dépôt d'espèces	\N	2025-07-10 10:52:18	2025-10-23 10:35:32
fa2ef3fe-dfb3-4544-9b6a-c3adebd15e94	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	virement	24807.00	420959.00	396152.00	FCFA	Transfert entre comptes	b1ce150f-0fc3-432e-8d5b-a34f6747804a	2025-10-20 06:19:18	2025-10-23 10:35:32
e3a8ac1c-5b4a-44b7-b97f-d6d4ee0dff9d	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	virement	9572.00	420959.00	411387.00	FCFA	Transfert entre comptes	79f54c28-5af3-42a0-b025-afd541eb8dbf	2025-08-15 01:10:21	2025-10-23 10:35:32
dc6ba8be-8d96-4d44-bceb-ec17b9be4387	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	virement	47924.00	420959.00	373035.00	FCFA	Paiement facture	3406986a-f161-4a7a-80be-bcdf0e3f2214	2025-08-08 23:59:22	2025-10-23 10:35:32
f7323b7a-c76a-4b8c-9401-09c0c1edac1d	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	virement	33711.00	420959.00	387248.00	FCFA	Virement salaire	968e30c7-1be0-4c05-98ba-5cb8d986a863	2025-08-24 10:29:16	2025-10-23 10:35:32
a03d0fb2-1c1f-4a7e-bc1a-3591ddea9e24	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	depot	11865.00	420959.00	432824.00	FCFA	Dépôt chèque	\N	2025-06-19 14:39:31	2025-10-23 10:35:32
97774fcd-f6a1-4123-9a32-61a390259f92	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	depot	6517.00	420959.00	427476.00	FCFA	Dépôt espèces guichet	\N	2025-05-26 18:08:10	2025-10-23 10:35:32
af89860d-823a-4879-9423-1842131ef676	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	retrait	27435.00	420959.00	393524.00	FCFA	Prélèvement automatique	\N	2025-07-06 07:01:03	2025-10-23 10:35:32
564c1ad5-396a-4f18-945c-a0f6e684af10	2bdeac76-dcb7-4710-9060-e9ca98012722	depot	21178.00	407651.00	428829.00	FCFA	Dépôt espèces guichet	\N	2025-07-09 06:33:12	2025-10-23 10:35:32
24ba413c-8dab-4a2e-853b-c9a0708399ee	2bdeac76-dcb7-4710-9060-e9ca98012722	retrait	5718.00	407651.00	401933.00	FCFA	Paiement par carte	\N	2025-09-23 15:49:41	2025-10-23 10:35:32
508346b9-2d48-4328-bc05-c51ca3b2fdf1	2bdeac76-dcb7-4710-9060-e9ca98012722	virement	6508.00	407651.00	401143.00	FCFA	Virement salaire	6131421b-d7d7-4f56-8450-582c37486f68	2025-10-03 20:20:08	2025-10-23 10:35:32
78fc3cbf-2ccc-48a2-a9b1-b62be9dc651a	2bdeac76-dcb7-4710-9060-e9ca98012722	retrait	40612.00	407651.00	367039.00	FCFA	Prélèvement automatique	\N	2025-06-21 10:08:45	2025-10-23 10:35:32
c60ad2ca-d776-4dbd-b51d-d05e37dd12dd	2bdeac76-dcb7-4710-9060-e9ca98012722	virement	5746.00	407651.00	401905.00	FCFA	Virement vers compte	0c099b4c-0616-44d6-af7a-38ed712edbf0	2025-06-07 03:06:14	2025-10-23 10:35:32
f6d26168-d054-4b4a-b497-fd829544488e	2bdeac76-dcb7-4710-9060-e9ca98012722	retrait	18158.00	407651.00	389493.00	FCFA	Paiement par carte	\N	2025-05-26 18:24:07	2025-10-23 10:35:32
23f3840f-7b5e-4539-af64-6437cf0a7376	2bdeac76-dcb7-4710-9060-e9ca98012722	depot	16276.00	407651.00	423927.00	FCFA	Dépôt chèque	\N	2025-10-05 03:40:37	2025-10-23 10:35:32
2799d1fa-1fb8-48fe-ad8f-07b0e261fba1	2bdeac76-dcb7-4710-9060-e9ca98012722	retrait	37774.00	407651.00	369877.00	FCFA	Paiement par carte	\N	2025-07-25 00:59:20	2025-10-23 10:35:32
7d23ecbe-3495-4f80-8c7c-b49e714a5e4b	2bdeac76-dcb7-4710-9060-e9ca98012722	depot	49935.00	407651.00	457586.00	FCFA	Dépôt chèque	\N	2025-07-11 12:06:20	2025-10-23 10:35:32
b15e6a7e-c2b6-4252-85e8-1e7dda0e8b0a	2bdeac76-dcb7-4710-9060-e9ca98012722	virement	45827.00	407651.00	361824.00	FCFA	Transfert bancaire	add2482a-de00-41d8-a772-cd4ef6546baa	2025-07-21 10:01:23	2025-10-23 10:35:32
33d3c8ce-7690-409b-b811-2c3e187ae0d2	2bdeac76-dcb7-4710-9060-e9ca98012722	virement	5446.00	407651.00	402205.00	FCFA	Paiement facture	916bbfef-cee4-457b-a001-da8e5b0be63d	2025-04-26 01:12:46	2025-10-23 10:35:32
3c43b253-8d25-41dc-869f-580d599cac48	792c8ff4-749b-469b-95d0-9b98c2283684	depot	28088.00	300640.00	328728.00	FCFA	Virement bancaire entrant	\N	2025-09-01 03:43:22	2025-10-23 10:35:32
f88b914b-f96f-43c5-ad32-9eff6a3361a1	792c8ff4-749b-469b-95d0-9b98c2283684	virement	14647.00	300640.00	285993.00	FCFA	Paiement facture	4e0954f5-1956-40db-b392-7a6ee455c257	2025-10-16 03:02:16	2025-10-23 10:35:32
5b4740ce-b47b-4055-8e14-b0cac156e2f1	792c8ff4-749b-469b-95d0-9b98c2283684	depot	26054.00	300640.00	326694.00	FCFA	Dépôt d'espèces	\N	2025-09-16 06:32:04	2025-10-23 10:35:32
cb0fc312-7194-4679-83ea-305156b7a82b	792c8ff4-749b-469b-95d0-9b98c2283684	depot	11059.00	300640.00	311699.00	FCFA	Dépôt espèces guichet	\N	2025-07-09 21:48:40	2025-10-23 10:35:32
104373ef-d380-43eb-bff4-e11f4e0e7a0e	792c8ff4-749b-469b-95d0-9b98c2283684	depot	26300.00	300640.00	326940.00	FCFA	Dépôt d'espèces	\N	2025-10-07 20:29:55	2025-10-23 10:35:32
e52abb6a-39b4-452c-9a53-d042234b2f05	792c8ff4-749b-469b-95d0-9b98c2283684	retrait	14759.00	300640.00	285881.00	FCFA	Prélèvement automatique	\N	2025-06-18 00:59:13	2025-10-23 10:35:32
feff7943-8b9f-44d3-baf8-135625ed6661	792c8ff4-749b-469b-95d0-9b98c2283684	depot	28857.00	300640.00	329497.00	FCFA	Versement salaire	\N	2025-05-30 09:52:32	2025-10-23 10:35:32
f320eecf-416f-404a-a23d-845fd34548d6	792c8ff4-749b-469b-95d0-9b98c2283684	depot	38205.00	300640.00	338845.00	FCFA	Dépôt espèces guichet	\N	2025-10-23 04:14:05	2025-10-23 10:35:32
f1ab5bea-953e-442c-8bd3-e36c4c154555	792c8ff4-749b-469b-95d0-9b98c2283684	depot	19641.00	300640.00	320281.00	FCFA	Versement salaire	\N	2025-07-27 15:28:04	2025-10-23 10:35:32
f4f80656-94b1-4090-92a9-c5414b1583c3	79f54c28-5af3-42a0-b025-afd541eb8dbf	virement	2964.00	405571.00	402607.00	FCFA	Transfert entre comptes	4e96181f-e984-42f8-9787-a41a67c90aba	2025-10-03 07:54:02	2025-10-23 10:35:32
d69f2b39-1051-466b-ac1d-7eb2c61cbeef	79f54c28-5af3-42a0-b025-afd541eb8dbf	virement	1468.00	405571.00	404103.00	FCFA	Transfert entre comptes	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	2025-09-17 21:05:12	2025-10-23 10:35:32
d9cccaee-66df-4924-90b7-53c9b9e67b2f	79f54c28-5af3-42a0-b025-afd541eb8dbf	retrait	42352.00	405571.00	363219.00	FCFA	Retrait DAB	\N	2025-07-20 03:38:20	2025-10-23 10:35:32
0e69976a-7e65-43d3-bdc4-a85ad334e84b	79f54c28-5af3-42a0-b025-afd541eb8dbf	virement	39456.00	405571.00	366115.00	FCFA	Transfert bancaire	57a5b070-a40d-45d9-b0ee-ba32f96383a6	2025-06-22 11:23:29	2025-10-23 10:35:32
db409282-1c50-4665-a89c-ce7d08180cc0	79f54c28-5af3-42a0-b025-afd541eb8dbf	depot	16083.00	405571.00	421654.00	FCFA	Virement bancaire entrant	\N	2025-05-03 10:14:09	2025-10-23 10:35:32
9ffa929b-4bcb-42d0-bc9f-7e2939c23246	79f54c28-5af3-42a0-b025-afd541eb8dbf	retrait	14929.00	405571.00	390642.00	FCFA	Retrait d'espèces	\N	2025-10-03 06:48:27	2025-10-23 10:35:32
5ccbb4bf-d8e4-463b-8df4-52e1fe9d759d	79f54c28-5af3-42a0-b025-afd541eb8dbf	depot	34224.00	405571.00	439795.00	FCFA	Dépôt d'espèces	\N	2025-08-10 18:58:33	2025-10-23 10:35:32
faaf10ee-2d9f-43a4-9682-c3499a41fcfa	b1ce150f-0fc3-432e-8d5b-a34f6747804a	virement	5152.00	309854.00	304702.00	FCFA	Virement salaire	93ec7354-821a-4306-8dcb-5b911268af75	2025-10-09 17:05:59	2025-10-23 10:35:32
09e1d335-6325-4a55-9c3f-9a060855c196	b1ce150f-0fc3-432e-8d5b-a34f6747804a	depot	34159.00	309854.00	344013.00	FCFA	Dépôt espèces guichet	\N	2025-08-04 06:04:01	2025-10-23 10:35:32
aed276dd-f152-4ef0-bb59-51f72d295afd	b1ce150f-0fc3-432e-8d5b-a34f6747804a	retrait	30199.00	309854.00	279655.00	FCFA	Retrait d'espèces	\N	2025-09-24 03:22:28	2025-10-23 10:35:32
e2d672fb-01e3-4734-94b1-563500b17ea3	b1ce150f-0fc3-432e-8d5b-a34f6747804a	virement	29041.00	309854.00	280813.00	FCFA	Transfert entre comptes	f46f2dde-ba75-4234-b729-67c0cd2a3ade	2025-08-09 13:10:06	2025-10-23 10:35:32
4e997922-90cb-4804-bed4-636300eed43c	b1ce150f-0fc3-432e-8d5b-a34f6747804a	virement	41323.00	309854.00	268531.00	FCFA	Paiement facture	ad629adb-377a-4725-9f12-556a170ef642	2025-08-31 04:09:09	2025-10-23 10:35:32
399be995-d69c-461a-b10c-a01bc7f8fe4c	b1ce150f-0fc3-432e-8d5b-a34f6747804a	virement	41046.00	309854.00	268808.00	FCFA	Virement vers compte	37da1638-f10a-4a03-9eb4-9eb960273866	2025-04-24 05:18:11	2025-10-23 10:35:32
9e9be22c-d6b1-44d4-9176-1e7f5a080417	b1ce150f-0fc3-432e-8d5b-a34f6747804a	depot	19535.00	309854.00	329389.00	FCFA	Versement salaire	\N	2025-10-14 10:55:00	2025-10-23 10:35:32
617e3666-6a9b-499f-8410-5aa8bc81c80a	b1ce150f-0fc3-432e-8d5b-a34f6747804a	retrait	19550.00	309854.00	290304.00	FCFA	Prélèvement automatique	\N	2025-07-03 19:52:32	2025-10-23 10:35:32
2f9487dd-5d75-44eb-8323-4f370f4471d6	b1ce150f-0fc3-432e-8d5b-a34f6747804a	depot	4083.00	309854.00	313937.00	FCFA	Dépôt espèces guichet	\N	2025-09-07 15:23:44	2025-10-23 10:35:32
17ec6feb-cc86-4853-9c7a-f07d1bab7f0b	ce34889a-7b15-48e8-9003-f1522cf517f8	depot	8212.00	212023.00	220235.00	FCFA	Dépôt chèque	\N	2025-08-04 17:27:19	2025-10-23 10:35:32
1edcf58e-0bb3-4178-91dd-a7819a728520	ce34889a-7b15-48e8-9003-f1522cf517f8	depot	44203.00	212023.00	256226.00	FCFA	Versement salaire	\N	2025-05-14 19:34:55	2025-10-23 10:35:32
0f7808e2-564b-4c51-9776-8bd447e19851	ce34889a-7b15-48e8-9003-f1522cf517f8	virement	18600.00	212023.00	193423.00	FCFA	Transfert entre comptes	f46f2dde-ba75-4234-b729-67c0cd2a3ade	2025-05-21 09:59:12	2025-10-23 10:35:32
0a530130-d5bc-426e-ad47-f37b796c6e7c	ce34889a-7b15-48e8-9003-f1522cf517f8	depot	24446.00	212023.00	236469.00	FCFA	Versement salaire	\N	2025-04-24 05:14:24	2025-10-23 10:35:32
7d2bb050-d010-4798-b0bf-5d2c06bf0c54	ce34889a-7b15-48e8-9003-f1522cf517f8	depot	8019.00	212023.00	220042.00	FCFA	Dépôt chèque	\N	2025-09-18 02:36:16	2025-10-23 10:35:32
44108c21-63b5-4b93-a393-c4062977dd34	ce34889a-7b15-48e8-9003-f1522cf517f8	virement	5305.00	212023.00	206718.00	FCFA	Transfert bancaire	968e30c7-1be0-4c05-98ba-5cb8d986a863	2025-08-16 11:05:00	2025-10-23 10:35:32
9d2e2d6a-7dc4-4043-9bc1-f89831612587	ce34889a-7b15-48e8-9003-f1522cf517f8	retrait	40604.00	212023.00	171419.00	FCFA	Retrait d'espèces	\N	2025-07-11 03:36:35	2025-10-23 10:35:32
67acb07f-64cd-422e-bea3-068e90d24b87	ce34889a-7b15-48e8-9003-f1522cf517f8	depot	30967.00	212023.00	242990.00	FCFA	Virement bancaire entrant	\N	2025-08-26 17:46:48	2025-10-23 10:35:32
7f227f23-50cd-4f96-894b-d0aedfb21ae5	ce34889a-7b15-48e8-9003-f1522cf517f8	retrait	18569.00	212023.00	193454.00	FCFA	Prélèvement automatique	\N	2025-08-01 12:34:26	2025-10-23 10:35:32
376306a2-fb31-4f40-b250-afae835865e1	d0f4f273-6422-4408-950f-61e6f8d23373	virement	10332.00	421789.00	411457.00	FCFA	Virement salaire	c5b06daf-ba43-4954-b2b8-1065dfb122ab	2025-07-27 06:58:15	2025-10-23 10:35:32
a167b07c-175e-4205-ae57-a9613aef88d8	d0f4f273-6422-4408-950f-61e6f8d23373	retrait	49550.00	421789.00	372239.00	FCFA	Retrait d'espèces	\N	2025-06-30 20:39:17	2025-10-23 10:35:32
9811aed5-8b4a-467d-972b-f86bc1b449ba	d0f4f273-6422-4408-950f-61e6f8d23373	virement	3827.00	421789.00	417962.00	FCFA	Transfert bancaire	aaa991e6-e52e-48b7-ab07-15a4a8203054	2025-10-19 21:14:14	2025-10-23 10:35:32
bd655325-45b4-4fff-8884-7f1a0e4e7be4	d0f4f273-6422-4408-950f-61e6f8d23373	virement	30515.00	421789.00	391274.00	FCFA	Transfert bancaire	f712d8d9-57b6-49a4-a8eb-5e04856619a9	2025-06-10 13:54:04	2025-10-23 10:35:32
bb47a863-6e39-456f-987b-081eefe49d9d	d0f4f273-6422-4408-950f-61e6f8d23373	virement	5197.00	421789.00	416592.00	FCFA	Paiement facture	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	2025-06-08 12:22:22	2025-10-23 10:35:32
361e791f-09fb-424e-96dc-16a62469ab48	d0f4f273-6422-4408-950f-61e6f8d23373	retrait	7620.00	421789.00	414169.00	FCFA	Retrait guichet	\N	2025-05-19 08:50:03	2025-10-23 10:35:32
1fdc3426-a03a-40d6-b2ad-a070806cddad	d0f4f273-6422-4408-950f-61e6f8d23373	virement	42146.00	421789.00	379643.00	FCFA	Virement salaire	1a2a915d-173c-44e7-a655-e29b9a02fd18	2025-10-04 22:05:28	2025-10-23 10:35:32
3baac2a3-f60a-49c0-90d1-0098d9df3ef9	d0f4f273-6422-4408-950f-61e6f8d23373	virement	19868.00	421789.00	401921.00	FCFA	Paiement facture	2f53ae60-3c7c-4dee-a02c-cad51068f96c	2025-04-25 20:52:31	2025-10-23 10:35:32
7d69e9c4-4ee6-42a5-8d2d-7a665b6203f3	d0f4f273-6422-4408-950f-61e6f8d23373	retrait	18925.00	421789.00	402864.00	FCFA	Retrait guichet	\N	2025-07-01 18:05:12	2025-10-23 10:35:32
06aa57c6-ce4e-4085-9a39-c8d9726a4113	d0f4f273-6422-4408-950f-61e6f8d23373	virement	12268.00	421789.00	409521.00	FCFA	Virement vers compte	184d6244-4107-464d-9848-8140c6174183	2025-08-02 08:14:13	2025-10-23 10:35:32
823a4270-4374-4043-b818-9fd709cae65a	d0f4f273-6422-4408-950f-61e6f8d23373	virement	21235.00	421789.00	400554.00	FCFA	Transfert bancaire	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	2025-06-13 06:10:07	2025-10-23 10:35:32
87da4b8c-a9db-4061-9b7e-016e8380d2d3	d0f4f273-6422-4408-950f-61e6f8d23373	virement	20007.00	421789.00	401782.00	FCFA	Virement vers compte	727ed0a8-67ac-4066-84fe-a29a0e13bb30	2025-05-17 12:05:35	2025-10-23 10:35:32
4a9b7ba2-652e-4c8f-82b4-1077b2663a2a	9d8742db-9975-4f0a-aad4-23d2a22203cd	depot	14008.00	106867.00	120875.00	FCFA	Dépôt chèque	\N	2025-05-24 01:35:34	2025-10-23 10:35:32
aebeccc3-261f-4fd0-99e3-f884732f799a	9d8742db-9975-4f0a-aad4-23d2a22203cd	virement	15477.00	106867.00	91390.00	FCFA	Transfert entre comptes	54c98069-cb97-4a48-9c06-c8ed239ef726	2025-10-01 07:38:56	2025-10-23 10:35:32
370d493f-4b92-4aa0-a2ae-a1b594864c3b	9d8742db-9975-4f0a-aad4-23d2a22203cd	depot	35223.00	106867.00	142090.00	FCFA	Dépôt d'espèces	\N	2025-05-17 19:30:04	2025-10-23 10:35:32
99f37546-1e5a-4685-ae0b-f49bc8ec8485	9d8742db-9975-4f0a-aad4-23d2a22203cd	depot	36034.00	106867.00	142901.00	FCFA	Dépôt espèces guichet	\N	2025-04-27 13:22:11	2025-10-23 10:35:32
03befda1-5765-4cac-8f8d-09be903ce616	9d8742db-9975-4f0a-aad4-23d2a22203cd	retrait	42676.00	106867.00	64191.00	FCFA	Paiement par carte	\N	2025-08-05 16:11:07	2025-10-23 10:35:32
cf790435-0d71-4815-89b4-0878d8193a84	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	depot	10869.00	282961.00	293830.00	FCFA	Dépôt d'espèces	\N	2025-09-07 02:22:31	2025-10-23 10:35:32
d3322510-402a-4086-9c69-0fe9a621b535	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	depot	29107.00	282961.00	312068.00	FCFA	Versement salaire	\N	2025-09-14 19:37:13	2025-10-23 10:35:32
8bed1b22-1f54-493a-900f-8909ba067baf	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	virement	3364.00	282961.00	279597.00	FCFA	Transfert bancaire	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	2025-10-03 11:34:38	2025-10-23 10:35:32
3de75865-ad45-46a3-9455-8566de39a36d	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	depot	6396.00	282961.00	289357.00	FCFA	Dépôt espèces guichet	\N	2025-10-11 12:37:16	2025-10-23 10:35:32
b056daac-15b7-4f97-b18e-bbf20e5dea60	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	retrait	33898.00	282961.00	249063.00	FCFA	Paiement par carte	\N	2025-08-20 23:26:26	2025-10-23 10:35:32
f06d2427-2ebc-4eba-b4e1-919102d16ce6	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	retrait	21112.00	282961.00	261849.00	FCFA	Prélèvement automatique	\N	2025-10-16 20:28:25	2025-10-23 10:35:32
bc69560c-b514-4b58-9954-6bd2d84601b0	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	virement	6405.00	282961.00	276556.00	FCFA	Paiement facture	a1f1990b-1819-4977-aaf0-bb14a824daa0	2025-05-15 20:20:11	2025-10-23 10:35:32
d22c0fc8-dc39-4416-b6e8-480187556274	57a5b070-a40d-45d9-b0ee-ba32f96383a6	retrait	39688.00	324131.00	284443.00	FCFA	Paiement par carte	\N	2025-09-23 20:00:34	2025-10-23 10:35:32
ab02d4f2-d47d-4fd1-ae41-45432b966902	57a5b070-a40d-45d9-b0ee-ba32f96383a6	retrait	15021.00	324131.00	309110.00	FCFA	Prélèvement automatique	\N	2025-10-15 01:33:20	2025-10-23 10:35:32
67b19b50-a495-424d-b64c-e7fd80dd37fc	57a5b070-a40d-45d9-b0ee-ba32f96383a6	depot	9396.00	324131.00	333527.00	FCFA	Virement bancaire entrant	\N	2025-05-02 00:05:08	2025-10-23 10:35:32
6830afa7-014e-4e5e-82cf-99a290f71bf1	57a5b070-a40d-45d9-b0ee-ba32f96383a6	virement	28172.00	324131.00	295959.00	FCFA	Virement vers compte	d0f4f273-6422-4408-950f-61e6f8d23373	2025-10-07 15:51:21	2025-10-23 10:35:32
5fd085cb-439c-40a2-ae5c-834baa1b7962	57a5b070-a40d-45d9-b0ee-ba32f96383a6	depot	32278.00	324131.00	356409.00	FCFA	Virement bancaire entrant	\N	2025-08-25 05:14:42	2025-10-23 10:35:32
83be754a-c338-4afe-bf1c-d0e42772ff51	57a5b070-a40d-45d9-b0ee-ba32f96383a6	virement	46352.00	324131.00	277779.00	FCFA	Transfert bancaire	7b3221a6-3b25-4cc8-a934-e795af882682	2025-08-12 09:50:36	2025-10-23 10:35:32
8aae75dc-8899-4b2f-a4fb-978d379378e1	2e311570-14e5-403a-a71f-698c77f8454d	depot	9728.00	439948.00	449676.00	FCFA	Versement salaire	\N	2025-08-10 05:24:53	2025-10-23 10:35:32
463b252e-f978-4c6b-9dcb-9c31761632f4	2e311570-14e5-403a-a71f-698c77f8454d	virement	38502.00	439948.00	401446.00	FCFA	Transfert entre comptes	39ca01df-9037-4f1b-962a-164c3db984f0	2025-07-15 02:06:21	2025-10-23 10:35:32
a4eff625-2753-4585-9df8-2342f61a771a	2e311570-14e5-403a-a71f-698c77f8454d	retrait	8379.00	439948.00	431569.00	FCFA	Retrait DAB	\N	2025-07-01 13:44:13	2025-10-23 10:35:32
3352af8b-cc88-47bb-8d2d-d08900c9123a	2e311570-14e5-403a-a71f-698c77f8454d	retrait	20640.00	439948.00	419308.00	FCFA	Retrait guichet	\N	2025-07-12 08:46:23	2025-10-23 10:35:32
12e3067f-1777-4455-bdb2-56c01f2f4091	2e311570-14e5-403a-a71f-698c77f8454d	retrait	36446.00	439948.00	403502.00	FCFA	Retrait d'espèces	\N	2025-08-25 19:40:48	2025-10-23 10:35:32
12da6cbb-2d9d-4984-818e-f2a3a5d41a31	2e311570-14e5-403a-a71f-698c77f8454d	virement	42171.00	439948.00	397777.00	FCFA	Paiement facture	f712d8d9-57b6-49a4-a8eb-5e04856619a9	2025-09-13 13:38:37	2025-10-23 10:35:32
000598f8-4dd8-4b94-952a-9896a5ee6526	2e311570-14e5-403a-a71f-698c77f8454d	retrait	34243.00	439948.00	405705.00	FCFA	Retrait guichet	\N	2025-10-16 03:02:13	2025-10-23 10:35:32
b92dff7c-013c-4df7-9da1-37dbcd612ac9	2e311570-14e5-403a-a71f-698c77f8454d	retrait	42491.00	439948.00	397457.00	FCFA	Retrait guichet	\N	2025-08-05 21:22:37	2025-10-23 10:35:32
82b190c6-9d3e-4315-a8dc-6ebf2a7f64f8	2e311570-14e5-403a-a71f-698c77f8454d	retrait	30950.00	439948.00	408998.00	FCFA	Retrait guichet	\N	2025-05-18 01:47:20	2025-10-23 10:35:32
829a6c09-6a7b-4a60-90a3-cf9c819c9b2f	2e311570-14e5-403a-a71f-698c77f8454d	virement	41626.00	439948.00	398322.00	FCFA	Virement vers compte	add2482a-de00-41d8-a772-cd4ef6546baa	2025-05-10 13:13:45	2025-10-23 10:35:32
b0428dd3-c181-4ce6-8dae-61fc9c1c1871	2e311570-14e5-403a-a71f-698c77f8454d	depot	1907.00	439948.00	441855.00	FCFA	Virement bancaire entrant	\N	2025-06-27 19:39:35	2025-10-23 10:35:32
df1712a4-cb80-43cd-8ecd-2b346bed6c06	2e311570-14e5-403a-a71f-698c77f8454d	retrait	38735.00	439948.00	401213.00	FCFA	Retrait d'espèces	\N	2025-04-27 13:02:47	2025-10-23 10:35:32
f89acce3-6ada-46b3-8d49-7ee8d91bbb95	2e311570-14e5-403a-a71f-698c77f8454d	retrait	2878.00	439948.00	437070.00	FCFA	Retrait d'espèces	\N	2025-07-13 22:16:38	2025-10-23 10:35:32
a7f72475-9324-429d-b68f-3be24e0a0953	2e311570-14e5-403a-a71f-698c77f8454d	virement	10887.00	439948.00	429061.00	FCFA	Transfert entre comptes	ce34889a-7b15-48e8-9003-f1522cf517f8	2025-10-20 00:31:11	2025-10-23 10:35:32
aaa3fe89-b322-419a-9085-a3c4c3c31da4	2e311570-14e5-403a-a71f-698c77f8454d	depot	17938.00	439948.00	457886.00	FCFA	Versement salaire	\N	2025-08-29 11:01:31	2025-10-23 10:35:32
df281114-42d5-4d08-a129-8cb385a67a21	df088290-3d37-4591-8571-389b37349b2a	depot	34427.00	273540.00	307967.00	FCFA	Dépôt d'espèces	\N	2025-09-28 07:27:52	2025-10-23 10:35:32
e66c6db2-8a56-4595-a78b-a8dd8cc4fc74	df088290-3d37-4591-8571-389b37349b2a	depot	14650.00	273540.00	288190.00	FCFA	Dépôt espèces guichet	\N	2025-09-19 06:44:06	2025-10-23 10:35:32
54d69820-fb93-4781-bf91-4a2eb5e41ebb	df088290-3d37-4591-8571-389b37349b2a	retrait	30732.00	273540.00	242808.00	FCFA	Retrait DAB	\N	2025-05-27 08:17:19	2025-10-23 10:35:32
9b4bf6cd-dfba-4844-a66b-1278f892155b	df088290-3d37-4591-8571-389b37349b2a	retrait	48126.00	273540.00	225414.00	FCFA	Paiement par carte	\N	2025-06-24 00:29:36	2025-10-23 10:35:32
eac1678b-1232-4f82-b359-ad534d4ef434	df088290-3d37-4591-8571-389b37349b2a	depot	31813.00	273540.00	305353.00	FCFA	Dépôt espèces guichet	\N	2025-06-26 12:18:57	2025-10-23 10:35:32
f4828848-0d9e-4e9b-a619-60a6c03c40fe	df088290-3d37-4591-8571-389b37349b2a	retrait	6188.00	273540.00	267352.00	FCFA	Retrait guichet	\N	2025-07-07 19:04:57	2025-10-23 10:35:32
2f93197c-2069-4a86-b5a4-73064d84d3d4	df088290-3d37-4591-8571-389b37349b2a	virement	21108.00	273540.00	252432.00	FCFA	Paiement facture	727ed0a8-67ac-4066-84fe-a29a0e13bb30	2025-06-19 21:15:26	2025-10-23 10:35:32
ce0a5a98-49e8-4dbe-ba23-06137b0bf1a3	df088290-3d37-4591-8571-389b37349b2a	retrait	5354.00	273540.00	268186.00	FCFA	Retrait DAB	\N	2025-05-07 22:51:52	2025-10-23 10:35:32
8a0ae978-f409-4588-b2b4-c92500b1d5c1	df088290-3d37-4591-8571-389b37349b2a	virement	43647.00	273540.00	229893.00	FCFA	Virement vers compte	d725e859-df50-4ee3-8ab9-65d82dc7fd71	2025-09-07 06:52:10	2025-10-23 10:35:32
9af923bf-2445-4c43-8922-9143aec5ec08	df088290-3d37-4591-8571-389b37349b2a	retrait	17074.00	273540.00	256466.00	FCFA	Retrait d'espèces	\N	2025-05-24 05:38:57	2025-10-23 10:35:32
5eb54d2f-14a0-42fa-a424-ba105f241894	b30db983-96ad-4f5c-a50c-1637c25f3b46	virement	43040.00	220146.00	177106.00	FCFA	Transfert bancaire	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	2025-07-15 10:06:27	2025-10-23 10:35:32
3bee65d1-59d3-4ec4-9c81-9075e4f2d8a0	b30db983-96ad-4f5c-a50c-1637c25f3b46	virement	46819.00	220146.00	173327.00	FCFA	Transfert entre comptes	8af34d52-0c28-48ed-ae2d-87e52f97806a	2025-06-06 17:37:56	2025-10-23 10:35:32
bd7dca66-03e0-4812-9b49-f5b73650ded3	b30db983-96ad-4f5c-a50c-1637c25f3b46	virement	1914.00	220146.00	218232.00	FCFA	Transfert bancaire	6b052865-a885-4b74-94d3-9838eadb0208	2025-05-31 08:48:02	2025-10-23 10:35:32
9f4e2ded-f929-410b-b395-07e0479ed6d8	b30db983-96ad-4f5c-a50c-1637c25f3b46	retrait	13336.00	220146.00	206810.00	FCFA	Retrait DAB	\N	2025-06-09 17:23:38	2025-10-23 10:35:32
9ac572e1-0395-40ce-9a09-dc0effa60aff	b30db983-96ad-4f5c-a50c-1637c25f3b46	virement	11358.00	220146.00	208788.00	FCFA	Transfert entre comptes	801e068b-fdc3-4606-bc83-42d2e3fc4a67	2025-05-09 02:48:00	2025-10-23 10:35:32
552dd495-73ca-4514-9648-07d5c7204730	b30db983-96ad-4f5c-a50c-1637c25f3b46	retrait	39181.00	220146.00	180965.00	FCFA	Retrait d'espèces	\N	2025-09-21 16:06:25	2025-10-23 10:35:32
fc96ee73-3f9d-4eab-95e8-4d672a1f5ca8	b30db983-96ad-4f5c-a50c-1637c25f3b46	retrait	3343.00	220146.00	216803.00	FCFA	Retrait DAB	\N	2025-05-21 07:15:24	2025-10-23 10:35:32
3fb7130c-d71e-4399-a3dc-637af21eb062	b30db983-96ad-4f5c-a50c-1637c25f3b46	virement	11520.00	220146.00	208626.00	FCFA	Virement salaire	a03dce74-58f6-42c7-8624-1d21ea760a90	2025-07-03 16:26:10	2025-10-23 10:35:32
1eb98205-c4c8-43c9-9b6f-b9c864323be9	b30db983-96ad-4f5c-a50c-1637c25f3b46	retrait	8978.00	220146.00	211168.00	FCFA	Retrait guichet	\N	2025-07-27 08:50:47	2025-10-23 10:35:32
7d2ad8aa-ee2c-4960-8e29-b00dd4eebdc3	b30db983-96ad-4f5c-a50c-1637c25f3b46	virement	37955.00	220146.00	182191.00	FCFA	Virement vers compte	d2a1ed80-e126-493f-b155-2923909ae924	2025-05-05 17:08:47	2025-10-23 10:35:32
2f582c50-973f-4e70-946c-3fe8e0e4df46	b30db983-96ad-4f5c-a50c-1637c25f3b46	depot	8608.00	220146.00	228754.00	FCFA	Dépôt d'espèces	\N	2025-08-28 09:21:58	2025-10-23 10:35:32
11a1b401-f802-45df-a5db-251cdb6c10c2	b30db983-96ad-4f5c-a50c-1637c25f3b46	retrait	18907.00	220146.00	201239.00	FCFA	Retrait guichet	\N	2025-09-06 15:27:05	2025-10-23 10:35:32
f65a0d10-ebfa-425e-a7ac-6b1eecb04a1b	b30db983-96ad-4f5c-a50c-1637c25f3b46	virement	18408.00	220146.00	201738.00	FCFA	Transfert bancaire	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	2025-09-21 02:49:05	2025-10-23 10:35:32
be42bfbd-4a8e-4469-986b-d7ddd6e93fc7	b30db983-96ad-4f5c-a50c-1637c25f3b46	virement	47617.00	220146.00	172529.00	FCFA	Transfert bancaire	3406986a-f161-4a7a-80be-bcdf0e3f2214	2025-06-14 21:44:01	2025-10-23 10:35:32
866a6000-f4b7-4124-a390-e1b66f241bd3	8af34d52-0c28-48ed-ae2d-87e52f97806a	depot	38463.00	368779.00	407242.00	FCFA	Dépôt d'espèces	\N	2025-07-11 18:00:58	2025-10-23 10:35:32
953c665b-ac48-4745-8a8e-fcda0018514a	8af34d52-0c28-48ed-ae2d-87e52f97806a	virement	12504.00	368779.00	356275.00	FCFA	Transfert bancaire	4bb7fc9b-13d6-4883-b751-283b753d05ed	2025-07-18 03:33:23	2025-10-23 10:35:32
dffc0f15-4a2f-4faa-b609-5e12f38ced21	8af34d52-0c28-48ed-ae2d-87e52f97806a	retrait	42758.00	368779.00	326021.00	FCFA	Paiement par carte	\N	2025-05-11 21:49:24	2025-10-23 10:35:32
41b68578-16aa-4baa-8d76-43fbdee8999c	8af34d52-0c28-48ed-ae2d-87e52f97806a	depot	21368.00	368779.00	390147.00	FCFA	Virement bancaire entrant	\N	2025-10-04 09:53:40	2025-10-23 10:35:32
ae34156e-b144-40e1-87ad-4e7d89585a1f	8af34d52-0c28-48ed-ae2d-87e52f97806a	depot	23205.00	368779.00	391984.00	FCFA	Dépôt espèces guichet	\N	2025-05-10 21:27:59	2025-10-23 10:35:32
17ffd51a-36b5-457d-8682-b298a11ddf7d	8af34d52-0c28-48ed-ae2d-87e52f97806a	retrait	20938.00	368779.00	347841.00	FCFA	Retrait d'espèces	\N	2025-04-25 10:12:45	2025-10-23 10:35:32
878b732f-88f1-4e01-87b8-56d896bd0cc8	8af34d52-0c28-48ed-ae2d-87e52f97806a	virement	25882.00	368779.00	342897.00	FCFA	Virement vers compte	a90e1a63-43fd-4956-af04-b3458780ca97	2025-07-23 23:55:25	2025-10-23 10:35:32
2efcd777-8f28-4b4a-a2d8-ab68417e8ba8	8af34d52-0c28-48ed-ae2d-87e52f97806a	virement	4709.00	368779.00	364070.00	FCFA	Transfert entre comptes	65da4070-27f5-40a7-99d9-db64e3163a65	2025-06-02 13:30:42	2025-10-23 10:35:32
814d9b6d-91fa-45c2-9dca-312901d4f1d6	8af34d52-0c28-48ed-ae2d-87e52f97806a	depot	39094.00	368779.00	407873.00	FCFA	Dépôt espèces guichet	\N	2025-05-10 07:28:32	2025-10-23 10:35:32
da26451f-364a-4ba7-bf69-61b788026846	8af34d52-0c28-48ed-ae2d-87e52f97806a	depot	44058.00	368779.00	412837.00	FCFA	Virement bancaire entrant	\N	2025-05-13 18:26:34	2025-10-23 10:35:32
8b433950-0da6-4bcf-afb2-7edf8d936630	8af34d52-0c28-48ed-ae2d-87e52f97806a	depot	20797.00	368779.00	389576.00	FCFA	Versement salaire	\N	2025-09-30 17:11:54	2025-10-23 10:35:32
9ea6af70-3167-45e4-816f-26587b15762d	8af34d52-0c28-48ed-ae2d-87e52f97806a	retrait	18338.00	368779.00	350441.00	FCFA	Paiement par carte	\N	2025-08-27 02:25:21	2025-10-23 10:35:32
cf826da1-7efb-4098-88d9-5b79b6e99df5	8af34d52-0c28-48ed-ae2d-87e52f97806a	virement	41820.00	368779.00	326959.00	FCFA	Transfert bancaire	34b84e17-27b4-4080-a77b-3cdb00476a06	2025-09-02 15:17:58	2025-10-23 10:35:32
77bf7482-59c6-403c-a01d-e75b53f431e2	8af34d52-0c28-48ed-ae2d-87e52f97806a	depot	28581.00	368779.00	397360.00	FCFA	Dépôt chèque	\N	2025-07-13 10:07:02	2025-10-23 10:35:32
3dbb849f-df58-411d-be02-de21b924767c	b9fcf39f-cbf6-4e3d-99da-428158581521	virement	13342.00	278647.00	265305.00	FCFA	Transfert bancaire	916bbfef-cee4-457b-a001-da8e5b0be63d	2025-06-27 09:23:26	2025-10-23 10:35:32
611eddca-1daa-4d44-bfec-e6a117245135	b9fcf39f-cbf6-4e3d-99da-428158581521	virement	40592.00	278647.00	238055.00	FCFA	Transfert entre comptes	9b7cf121-0b29-4457-b5ee-acddd651474c	2025-05-17 11:25:52	2025-10-23 10:35:32
0f6600f1-c3df-4c1b-8113-e4036fb1bff2	b9fcf39f-cbf6-4e3d-99da-428158581521	retrait	21297.00	278647.00	257350.00	FCFA	Retrait d'espèces	\N	2025-06-19 21:40:58	2025-10-23 10:35:32
24ea7b03-d7da-4535-a146-7b3610c62c24	b9fcf39f-cbf6-4e3d-99da-428158581521	virement	24876.00	278647.00	253771.00	FCFA	Transfert entre comptes	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	2025-07-17 09:10:50	2025-10-23 10:35:32
2cd7c2a6-1beb-4da1-b7d2-7540e9a0f616	b9fcf39f-cbf6-4e3d-99da-428158581521	virement	45448.00	278647.00	233199.00	FCFA	Virement salaire	3b545ec9-8048-4c12-a074-df603671d400	2025-07-14 20:42:17	2025-10-23 10:35:32
976fd88c-32dc-4137-9fbc-3dec01319941	b9fcf39f-cbf6-4e3d-99da-428158581521	retrait	19552.00	278647.00	259095.00	FCFA	Retrait d'espèces	\N	2025-10-17 10:33:35	2025-10-23 10:35:32
b74f030f-82c2-40c3-98c1-ddb9082e2a98	b9fcf39f-cbf6-4e3d-99da-428158581521	retrait	22203.00	278647.00	256444.00	FCFA	Retrait d'espèces	\N	2025-09-28 09:25:27	2025-10-23 10:35:32
bfff5966-72d6-4228-9047-c87a2d0936b8	b9fcf39f-cbf6-4e3d-99da-428158581521	retrait	20062.00	278647.00	258585.00	FCFA	Retrait d'espèces	\N	2025-07-24 09:47:50	2025-10-23 10:35:32
058d65c9-f9f1-41f3-a7d7-a47de0ac95cd	b9fcf39f-cbf6-4e3d-99da-428158581521	virement	33731.00	278647.00	244916.00	FCFA	Paiement facture	a5bad169-7741-4b82-9dde-4803bb629488	2025-10-10 13:30:27	2025-10-23 10:35:32
6c0a9f9f-4bf8-48fa-81ad-8dc7b9a53caf	b9fcf39f-cbf6-4e3d-99da-428158581521	depot	16400.00	278647.00	295047.00	FCFA	Dépôt espèces guichet	\N	2025-06-24 13:56:22	2025-10-23 10:35:32
09ce43d0-fa54-4977-b191-56a39f74be2e	b9fcf39f-cbf6-4e3d-99da-428158581521	retrait	20704.00	278647.00	257943.00	FCFA	Paiement par carte	\N	2025-06-13 23:51:14	2025-10-23 10:35:32
dbbb9477-90e6-4cdf-995a-ed3d2b58d6be	b9fcf39f-cbf6-4e3d-99da-428158581521	retrait	15414.00	278647.00	263233.00	FCFA	Retrait guichet	\N	2025-07-25 09:11:54	2025-10-23 10:35:32
18ecd7ef-3c5f-4517-ba21-356e36776a53	b9fcf39f-cbf6-4e3d-99da-428158581521	depot	23371.00	278647.00	302018.00	FCFA	Dépôt d'espèces	\N	2025-06-23 15:29:36	2025-10-23 10:35:32
0e2c57eb-dbb7-48e4-93f3-a1b958393779	b9fcf39f-cbf6-4e3d-99da-428158581521	depot	21400.00	278647.00	300047.00	FCFA	Dépôt d'espèces	\N	2025-04-24 01:19:41	2025-10-23 10:35:32
f570ea16-e490-48be-b58c-6eaeff319ad1	968e30c7-1be0-4c05-98ba-5cb8d986a863	depot	48155.00	331020.00	379175.00	FCFA	Versement salaire	\N	2025-07-06 14:01:30	2025-10-23 10:35:32
048c7a08-3328-4055-aa11-248e3f9a9f35	968e30c7-1be0-4c05-98ba-5cb8d986a863	retrait	22270.00	331020.00	308750.00	FCFA	Prélèvement automatique	\N	2025-08-06 09:43:32	2025-10-23 10:35:32
c655343e-496a-416e-98b5-8bfeefa821b6	968e30c7-1be0-4c05-98ba-5cb8d986a863	depot	16886.00	331020.00	347906.00	FCFA	Virement bancaire entrant	\N	2025-10-17 03:54:37	2025-10-23 10:35:32
3574204f-b17e-43a5-8da5-8fcf29463d0f	968e30c7-1be0-4c05-98ba-5cb8d986a863	depot	8169.00	331020.00	339189.00	FCFA	Virement bancaire entrant	\N	2025-09-13 14:00:36	2025-10-23 10:35:32
521ed49a-0131-4120-bef1-e0da409f0fc9	968e30c7-1be0-4c05-98ba-5cb8d986a863	retrait	7399.00	331020.00	323621.00	FCFA	Retrait DAB	\N	2025-10-19 05:01:34	2025-10-23 10:35:32
6dd288f5-559b-484f-a326-19c7dc44d03e	968e30c7-1be0-4c05-98ba-5cb8d986a863	retrait	30406.00	331020.00	300614.00	FCFA	Retrait guichet	\N	2025-05-26 15:38:27	2025-10-23 10:35:32
ebccfb1f-6fca-49cc-a7df-f3824de7a5ae	968e30c7-1be0-4c05-98ba-5cb8d986a863	retrait	46072.00	331020.00	284948.00	FCFA	Retrait guichet	\N	2025-07-11 06:51:46	2025-10-23 10:35:32
60310e19-0f9e-4f5f-a4a5-4bdcc1ce482f	968e30c7-1be0-4c05-98ba-5cb8d986a863	virement	19013.00	331020.00	312007.00	FCFA	Paiement facture	6c92b373-c286-44a2-94a3-cf8cf3479100	2025-10-12 01:50:40	2025-10-23 10:35:32
677e9aa3-0e67-4451-85e6-aee525de95ff	a0123386-5767-4f9f-b457-e0613e9f8725	retrait	16556.00	474190.00	457634.00	FCFA	Retrait d'espèces	\N	2025-05-29 18:49:30	2025-10-23 10:35:32
88edab8d-b409-4c08-9110-0cfdb0f66dcd	a0123386-5767-4f9f-b457-e0613e9f8725	retrait	38231.00	474190.00	435959.00	FCFA	Retrait d'espèces	\N	2025-05-08 07:35:56	2025-10-23 10:35:32
085509bd-7b40-42d8-865b-23982426d8ce	a0123386-5767-4f9f-b457-e0613e9f8725	depot	3078.00	474190.00	477268.00	FCFA	Dépôt chèque	\N	2025-07-29 13:37:50	2025-10-23 10:35:32
8d6a10d4-5b9b-49d8-9a65-2e5a8b28bbb8	a0123386-5767-4f9f-b457-e0613e9f8725	virement	18474.00	474190.00	455716.00	FCFA	Virement vers compte	a90e1a63-43fd-4956-af04-b3458780ca97	2025-08-29 05:53:31	2025-10-23 10:35:32
80ddb4bc-10ee-430d-80ce-4184b73619eb	a0123386-5767-4f9f-b457-e0613e9f8725	depot	8098.00	474190.00	482288.00	FCFA	Dépôt d'espèces	\N	2025-10-16 07:44:36	2025-10-23 10:35:32
96006fb2-9dfe-4405-8c49-f9d28407db08	a0123386-5767-4f9f-b457-e0613e9f8725	depot	43685.00	474190.00	517875.00	FCFA	Dépôt d'espèces	\N	2025-09-09 02:07:54	2025-10-23 10:35:32
fbc2fa39-01a7-4389-9429-bda0d9bba80c	6b052865-a885-4b74-94d3-9838eadb0208	depot	28958.00	32394.00	61352.00	FCFA	Dépôt espèces guichet	\N	2025-06-25 02:32:44	2025-10-23 10:35:32
fef5e314-a220-4329-a053-292e9b502c06	6b052865-a885-4b74-94d3-9838eadb0208	retrait	48642.00	32394.00	0.00	FCFA	Retrait DAB	\N	2025-06-16 12:30:16	2025-10-23 10:35:32
0d2fa616-9540-4062-aeae-339dfb6d039f	6b052865-a885-4b74-94d3-9838eadb0208	depot	11020.00	32394.00	43414.00	FCFA	Virement bancaire entrant	\N	2025-08-20 22:34:56	2025-10-23 10:35:32
f4731b93-7874-4592-829d-4af3251f679a	6b052865-a885-4b74-94d3-9838eadb0208	retrait	23120.00	32394.00	9274.00	FCFA	Retrait guichet	\N	2025-05-30 03:06:14	2025-10-23 10:35:32
aaad49ba-e071-4858-89af-d862566b3f9f	6b052865-a885-4b74-94d3-9838eadb0208	virement	35586.00	32394.00	0.00	FCFA	Transfert entre comptes	9b7cf121-0b29-4457-b5ee-acddd651474c	2025-09-22 14:22:02	2025-10-23 10:35:32
8f07702d-6dc7-485f-a1ee-84aed6cb9f6a	6b052865-a885-4b74-94d3-9838eadb0208	virement	17430.00	32394.00	14964.00	FCFA	Transfert entre comptes	b9fcf39f-cbf6-4e3d-99da-428158581521	2025-06-26 20:47:14	2025-10-23 10:35:32
c23ff9e1-029f-47d7-88cc-2bc0ea11d041	6b052865-a885-4b74-94d3-9838eadb0208	retrait	8671.00	32394.00	23723.00	FCFA	Retrait d'espèces	\N	2025-06-07 07:02:46	2025-10-23 10:35:32
5ad6b125-c6e1-4a4a-878f-45ed04df782a	6b052865-a885-4b74-94d3-9838eadb0208	depot	47399.00	32394.00	79793.00	FCFA	Dépôt chèque	\N	2025-09-17 05:29:39	2025-10-23 10:35:32
040460a1-dab4-46b5-899f-2355eecc5eca	6b052865-a885-4b74-94d3-9838eadb0208	virement	32578.00	32394.00	0.00	FCFA	Transfert bancaire	7b3221a6-3b25-4cc8-a934-e795af882682	2025-08-29 12:49:01	2025-10-23 10:35:32
8479e6cf-2c30-4c64-8aba-851498a00a5d	6b052865-a885-4b74-94d3-9838eadb0208	depot	34156.00	32394.00	66550.00	FCFA	Dépôt d'espèces	\N	2025-08-23 08:28:10	2025-10-23 10:35:32
4479e094-a504-4cae-8f3e-10824c49b905	6b052865-a885-4b74-94d3-9838eadb0208	retrait	41704.00	32394.00	0.00	FCFA	Retrait DAB	\N	2025-07-02 23:22:11	2025-10-23 10:35:32
bbd6c52b-9016-48d6-b023-4363e45f0deb	6b052865-a885-4b74-94d3-9838eadb0208	retrait	24446.00	32394.00	7948.00	FCFA	Retrait DAB	\N	2025-04-30 18:53:02	2025-10-23 10:35:32
c64af1f9-dd40-4ad2-8862-387e2b63635a	6b052865-a885-4b74-94d3-9838eadb0208	depot	36004.00	32394.00	68398.00	FCFA	Versement salaire	\N	2025-10-20 22:50:18	2025-10-23 10:35:32
e2778451-4639-4dc6-be59-d5f082e9b657	6b052865-a885-4b74-94d3-9838eadb0208	depot	28371.00	32394.00	60765.00	FCFA	Dépôt d'espèces	\N	2025-08-30 13:08:32	2025-10-23 10:35:32
377e8df2-a196-4a08-9ab4-5b98bb491f71	6b052865-a885-4b74-94d3-9838eadb0208	depot	1163.00	32394.00	33557.00	FCFA	Versement salaire	\N	2025-09-19 13:33:17	2025-10-23 10:35:32
35d68016-fafe-47c7-a063-57a55a6dc694	39ca01df-9037-4f1b-962a-164c3db984f0	retrait	39947.00	482970.00	443023.00	FCFA	Retrait DAB	\N	2025-10-12 07:23:13	2025-10-23 10:35:32
2aaff8e1-1903-421e-a4cb-410c727a8fee	39ca01df-9037-4f1b-962a-164c3db984f0	retrait	48972.00	482970.00	433998.00	FCFA	Retrait guichet	\N	2025-09-24 22:45:36	2025-10-23 10:35:32
e6cb0ebc-4df0-4a84-a8bf-edd0536585d0	39ca01df-9037-4f1b-962a-164c3db984f0	retrait	39203.00	482970.00	443767.00	FCFA	Retrait d'espèces	\N	2025-09-04 03:31:44	2025-10-23 10:35:32
53d77f14-ee3b-46a1-87b8-827fca4f1099	39ca01df-9037-4f1b-962a-164c3db984f0	virement	38041.00	482970.00	444929.00	FCFA	Virement salaire	2b138895-6391-4bfe-b137-ca4fa7854a4a	2025-10-22 19:27:25	2025-10-23 10:35:32
27d13d2b-bae5-44e4-80e4-728ca760c637	39ca01df-9037-4f1b-962a-164c3db984f0	virement	10661.00	482970.00	472309.00	FCFA	Virement vers compte	3b545ec9-8048-4c12-a074-df603671d400	2025-08-23 17:02:09	2025-10-23 10:35:32
ae86c955-9c40-44c4-8791-96a27ef09138	39ca01df-9037-4f1b-962a-164c3db984f0	depot	44570.00	482970.00	527540.00	FCFA	Dépôt espèces guichet	\N	2025-08-28 22:15:42	2025-10-23 10:35:32
cdccd910-e629-4add-b544-014de48d52a0	39ca01df-9037-4f1b-962a-164c3db984f0	retrait	32785.00	482970.00	450185.00	FCFA	Retrait guichet	\N	2025-07-21 09:36:15	2025-10-23 10:35:32
a1f5354f-5227-48e6-8651-8a6b454abf15	39ca01df-9037-4f1b-962a-164c3db984f0	depot	15368.00	482970.00	498338.00	FCFA	Versement salaire	\N	2025-09-06 00:55:29	2025-10-23 10:35:32
d8d83f59-7d9c-46da-a068-fff6019b0414	39ca01df-9037-4f1b-962a-164c3db984f0	depot	28931.00	482970.00	511901.00	FCFA	Dépôt d'espèces	\N	2025-05-15 17:17:35	2025-10-23 10:35:32
8e906c72-c134-477e-9da5-7a07558d7e6c	39ca01df-9037-4f1b-962a-164c3db984f0	depot	20615.00	482970.00	503585.00	FCFA	Dépôt espèces guichet	\N	2025-06-06 16:09:52	2025-10-23 10:35:32
c66ca53d-7a33-4cd5-b38f-8117eb9b78e3	39ca01df-9037-4f1b-962a-164c3db984f0	virement	33887.00	482970.00	449083.00	FCFA	Transfert bancaire	c5b06daf-ba43-4954-b2b8-1065dfb122ab	2025-07-23 21:46:06	2025-10-23 10:35:32
216ccf3b-c49e-4cdc-ac9b-8945aa852a4b	39ca01df-9037-4f1b-962a-164c3db984f0	retrait	33634.00	482970.00	449336.00	FCFA	Paiement par carte	\N	2025-08-27 10:32:46	2025-10-23 10:35:32
a0f61a44-698d-427e-8de3-34f187167ad8	39ca01df-9037-4f1b-962a-164c3db984f0	depot	12775.00	482970.00	495745.00	FCFA	Dépôt d'espèces	\N	2025-05-07 20:37:14	2025-10-23 10:35:32
373f23f3-69af-46aa-8387-7b72336f2c26	39ca01df-9037-4f1b-962a-164c3db984f0	virement	10759.00	482970.00	472211.00	FCFA	Virement vers compte	ce34889a-7b15-48e8-9003-f1522cf517f8	2025-09-13 16:55:36	2025-10-23 10:35:32
13350b95-f046-4b67-a594-c0735b0845e8	3406986a-f161-4a7a-80be-bcdf0e3f2214	depot	4126.00	214655.00	218781.00	FCFA	Versement salaire	\N	2025-07-19 15:58:24	2025-10-23 10:35:32
a563dd6a-796d-4fbe-8bae-0a07ec99e05a	3406986a-f161-4a7a-80be-bcdf0e3f2214	depot	28114.00	214655.00	242769.00	FCFA	Dépôt espèces guichet	\N	2025-05-12 01:44:20	2025-10-23 10:35:32
1076c6aa-0bb0-4416-9427-70a6b51e98d1	3406986a-f161-4a7a-80be-bcdf0e3f2214	retrait	39110.00	214655.00	175545.00	FCFA	Retrait DAB	\N	2025-06-16 19:55:15	2025-10-23 10:35:32
f746fbb5-7b53-4b4c-851b-2adfc4483711	3406986a-f161-4a7a-80be-bcdf0e3f2214	depot	17931.00	214655.00	232586.00	FCFA	Dépôt espèces guichet	\N	2025-10-20 08:22:05	2025-10-23 10:35:32
ae42c002-00d2-4a98-b01a-dcf86dd65398	3406986a-f161-4a7a-80be-bcdf0e3f2214	virement	11586.00	214655.00	203069.00	FCFA	Transfert entre comptes	9b7cf121-0b29-4457-b5ee-acddd651474c	2025-10-14 13:16:56	2025-10-23 10:35:32
c4588631-2eec-404e-a381-5c30aaf9f289	3406986a-f161-4a7a-80be-bcdf0e3f2214	depot	4044.00	214655.00	218699.00	FCFA	Dépôt chèque	\N	2025-07-10 13:30:28	2025-10-23 10:35:32
66ad8532-3a68-407a-a319-41fe2e9951d1	3406986a-f161-4a7a-80be-bcdf0e3f2214	depot	33682.00	214655.00	248337.00	FCFA	Virement bancaire entrant	\N	2025-10-16 16:37:57	2025-10-23 10:35:32
9117d602-b575-42b1-ba49-0dbce4ec58d2	3406986a-f161-4a7a-80be-bcdf0e3f2214	virement	32620.00	214655.00	182035.00	FCFA	Transfert entre comptes	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	2025-09-06 22:01:24	2025-10-23 10:35:32
5b6688b6-0eda-4fbf-aa66-4aec5812cdfd	3406986a-f161-4a7a-80be-bcdf0e3f2214	retrait	34742.00	214655.00	179913.00	FCFA	Prélèvement automatique	\N	2025-10-08 22:33:39	2025-10-23 10:35:32
5e44a78b-65b2-40a1-a44d-fd12612351b2	3406986a-f161-4a7a-80be-bcdf0e3f2214	depot	32469.00	214655.00	247124.00	FCFA	Dépôt d'espèces	\N	2025-05-10 15:13:29	2025-10-23 10:35:32
c390ce1e-3c4d-4e3d-9f37-8379582f51f1	3406986a-f161-4a7a-80be-bcdf0e3f2214	depot	23962.00	214655.00	238617.00	FCFA	Dépôt d'espèces	\N	2025-05-04 15:49:13	2025-10-23 10:35:32
d87d324a-c66b-4322-a507-b78c2ce51fa6	cccd197c-f331-4647-8abe-dacb9cf26b5d	depot	17225.00	246708.00	263933.00	FCFA	Dépôt espèces guichet	\N	2025-05-08 15:53:29	2025-10-23 10:35:32
009eee9f-25ec-418b-822b-1a5bc9d994cd	cccd197c-f331-4647-8abe-dacb9cf26b5d	depot	29198.00	246708.00	275906.00	FCFA	Dépôt espèces guichet	\N	2025-06-18 12:17:41	2025-10-23 10:35:32
e0c2b09f-215f-4f11-bdc8-b09dd0dbd749	cccd197c-f331-4647-8abe-dacb9cf26b5d	retrait	13068.00	246708.00	233640.00	FCFA	Paiement par carte	\N	2025-06-08 21:07:37	2025-10-23 10:35:32
5a2d866f-98e1-44d5-abc4-4d32cbfc0873	cccd197c-f331-4647-8abe-dacb9cf26b5d	retrait	6953.00	246708.00	239755.00	FCFA	Prélèvement automatique	\N	2025-08-10 08:03:33	2025-10-23 10:35:32
c8eb04cd-5138-4350-927c-5f7fdc57e5d6	cccd197c-f331-4647-8abe-dacb9cf26b5d	virement	38590.00	246708.00	208118.00	FCFA	Virement vers compte	8d706bac-d7d8-4172-8d94-d1a8cdf604db	2025-09-17 19:30:46	2025-10-23 10:35:32
c590e6b1-0a8d-42fe-8a40-03591e34bfff	cccd197c-f331-4647-8abe-dacb9cf26b5d	virement	39000.00	246708.00	207708.00	FCFA	Transfert bancaire	f2182e94-c5d0-4b91-8d12-af97e101dd6b	2025-10-06 01:06:02	2025-10-23 10:35:32
c5d8fdcd-ad46-4734-a72a-430b649c7ba7	cccd197c-f331-4647-8abe-dacb9cf26b5d	retrait	22612.00	246708.00	224096.00	FCFA	Retrait DAB	\N	2025-06-15 20:49:30	2025-10-23 10:35:32
d3e3c88b-8f08-4762-931d-b432daee0622	cccd197c-f331-4647-8abe-dacb9cf26b5d	virement	2175.00	246708.00	244533.00	FCFA	Virement vers compte	c5b06daf-ba43-4954-b2b8-1065dfb122ab	2025-05-23 20:31:26	2025-10-23 10:35:32
fa95177a-286e-4083-a298-a6fb9b9b9278	cccd197c-f331-4647-8abe-dacb9cf26b5d	depot	25698.00	246708.00	272406.00	FCFA	Dépôt espèces guichet	\N	2025-05-12 06:12:16	2025-10-23 10:35:32
6026b3ff-a924-4520-bfdc-420a5a3fc6a8	cccd197c-f331-4647-8abe-dacb9cf26b5d	depot	16014.00	246708.00	262722.00	FCFA	Versement salaire	\N	2025-08-30 06:36:28	2025-10-23 10:35:32
af71e720-6ec9-4dbf-a929-c21e6695950c	cccd197c-f331-4647-8abe-dacb9cf26b5d	retrait	44069.00	246708.00	202639.00	FCFA	Retrait DAB	\N	2025-08-22 20:45:06	2025-10-23 10:35:32
97a89b8b-67e7-432c-9502-4f03206dc8d2	cccd197c-f331-4647-8abe-dacb9cf26b5d	depot	38655.00	246708.00	285363.00	FCFA	Versement salaire	\N	2025-05-24 06:01:33	2025-10-23 10:35:32
28250224-5087-4781-b1a2-82e08d60453a	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	depot	6690.00	87869.00	94559.00	FCFA	Virement bancaire entrant	\N	2025-08-27 04:14:32	2025-10-23 10:35:32
fe01f9c9-91c7-4f20-939d-b16eab350113	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	depot	19036.00	87869.00	106905.00	FCFA	Dépôt d'espèces	\N	2025-06-07 23:41:14	2025-10-23 10:35:32
925a2640-908f-4950-bebe-043918b2890e	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	retrait	37810.00	87869.00	50059.00	FCFA	Paiement par carte	\N	2025-06-02 00:29:52	2025-10-23 10:35:32
2ecdcaa5-6486-47b6-bc36-ac3dafc3cf35	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	virement	29518.00	87869.00	58351.00	FCFA	Transfert bancaire	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	2025-10-13 18:08:17	2025-10-23 10:35:32
30e660cf-5409-43b3-81f8-1686e87c6afb	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	retrait	45890.00	87869.00	41979.00	FCFA	Paiement par carte	\N	2025-05-13 05:53:12	2025-10-23 10:35:32
bedf26a2-2a76-4ff3-bfaf-d77b7a7ff4f1	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	retrait	21085.00	87869.00	66784.00	FCFA	Retrait d'espèces	\N	2025-04-29 13:16:23	2025-10-23 10:35:32
cc45ec73-1914-4144-a1a1-7a2bc7dcb151	54d5e886-a7a4-4427-b256-7723400f3c4e	virement	37505.00	99304.00	61799.00	FCFA	Paiement facture	57a5b070-a40d-45d9-b0ee-ba32f96383a6	2025-07-13 19:21:44	2025-10-23 10:35:32
6f2c6f40-feba-451f-a3ca-f1d585d6a77e	54d5e886-a7a4-4427-b256-7723400f3c4e	retrait	37296.00	99304.00	62008.00	FCFA	Retrait guichet	\N	2025-06-22 04:06:12	2025-10-23 10:35:32
aea0317f-2179-4573-ac2d-270087eb050f	54d5e886-a7a4-4427-b256-7723400f3c4e	retrait	30616.00	99304.00	68688.00	FCFA	Retrait d'espèces	\N	2025-06-22 23:11:23	2025-10-23 10:35:32
feb295f3-790b-4d9b-a420-ac40c4457cbf	54d5e886-a7a4-4427-b256-7723400f3c4e	depot	27987.00	99304.00	127291.00	FCFA	Virement bancaire entrant	\N	2025-10-13 20:47:59	2025-10-23 10:35:32
427dbc25-bfaa-4c2b-b198-c22a87238baa	54d5e886-a7a4-4427-b256-7723400f3c4e	depot	28809.00	99304.00	128113.00	FCFA	Versement salaire	\N	2025-05-12 19:23:29	2025-10-23 10:35:32
b69ae99a-41e8-4563-be92-b7cb75d4bb88	54d5e886-a7a4-4427-b256-7723400f3c4e	virement	46019.00	99304.00	53285.00	FCFA	Virement salaire	79f54c28-5af3-42a0-b025-afd541eb8dbf	2025-08-01 18:07:10	2025-10-23 10:35:32
b8557866-51fa-43b8-bccc-0dc0ea4a56fb	184d6244-4107-464d-9848-8140c6174183	retrait	2983.00	330360.00	327377.00	FCFA	Retrait DAB	\N	2025-10-04 13:11:20	2025-10-23 10:35:32
198e4ea7-5f41-479a-bb7a-e42055df68ef	184d6244-4107-464d-9848-8140c6174183	depot	15404.00	330360.00	345764.00	FCFA	Dépôt chèque	\N	2025-07-29 11:11:39	2025-10-23 10:35:32
41b7b85b-0ae4-4263-8592-160e7c789d7e	184d6244-4107-464d-9848-8140c6174183	retrait	42051.00	330360.00	288309.00	FCFA	Paiement par carte	\N	2025-09-07 00:24:03	2025-10-23 10:35:32
4daac95d-8d09-4e53-9aec-c2d60d548ea9	184d6244-4107-464d-9848-8140c6174183	depot	30247.00	330360.00	360607.00	FCFA	Versement salaire	\N	2025-10-08 21:40:25	2025-10-23 10:35:32
b380cbda-8377-4f7d-97ac-e880dc003ecf	184d6244-4107-464d-9848-8140c6174183	depot	20205.00	330360.00	350565.00	FCFA	Dépôt chèque	\N	2025-05-26 17:04:17	2025-10-23 10:35:32
90e35cc7-20ec-415e-a064-0bf716812ae3	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	retrait	37810.00	102479.00	64669.00	FCFA	Retrait DAB	\N	2025-08-24 16:55:36	2025-10-23 10:35:32
3e266b61-0f1f-4281-8ff0-a8484e86633a	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	virement	37061.00	102479.00	65418.00	FCFA	Virement salaire	b1ce150f-0fc3-432e-8d5b-a34f6747804a	2025-06-27 09:07:14	2025-10-23 10:35:32
30c0df66-cac9-4455-a515-b1d581d1eb03	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	depot	40274.00	102479.00	142753.00	FCFA	Virement bancaire entrant	\N	2025-10-04 23:55:03	2025-10-23 10:35:32
ae3b1078-222b-4ea9-8912-eb4687de9c75	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	retrait	28909.00	102479.00	73570.00	FCFA	Paiement par carte	\N	2025-05-17 21:38:18	2025-10-23 10:35:32
395e5a51-9f11-4841-b996-070989d37d9e	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	virement	36048.00	102479.00	66431.00	FCFA	Virement salaire	5cd10916-6dee-48e6-ab78-7995b1f1ce95	2025-08-11 03:46:50	2025-10-23 10:35:32
643cdeb6-c62c-4a56-9cc4-b8ddae545869	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	virement	30044.00	102479.00	72435.00	FCFA	Transfert entre comptes	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	2025-05-25 05:39:47	2025-10-23 10:35:32
5760da87-9c1a-4d72-809a-cc565f7fb980	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	virement	18007.00	102479.00	84472.00	FCFA	Transfert entre comptes	7643d019-9210-424b-b768-667e79ca8da7	2025-05-22 16:29:55	2025-10-23 10:35:33
cd90fe19-2dbd-41e2-a343-b3aad12d36b2	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	depot	43327.00	102479.00	145806.00	FCFA	Dépôt d'espèces	\N	2025-06-06 04:24:07	2025-10-23 10:35:33
08f7a330-79c1-4ecb-b71c-c0a1f18fa60b	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	depot	10775.00	102479.00	113254.00	FCFA	Dépôt espèces guichet	\N	2025-06-21 00:54:25	2025-10-23 10:35:33
77e6eef4-dc53-409c-a965-fbc0b1e8ee5b	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	virement	41819.00	102479.00	60660.00	FCFA	Virement salaire	a5bad169-7741-4b82-9dde-4803bb629488	2025-09-15 09:15:14	2025-10-23 10:35:33
2cd4626e-1e4c-4b55-bff8-6be1fc8880d1	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	depot	16108.00	102479.00	118587.00	FCFA	Dépôt d'espèces	\N	2025-07-30 22:07:33	2025-10-23 10:35:33
1f8d0351-6f5d-4510-afd5-38464f45da16	a03dce74-58f6-42c7-8624-1d21ea760a90	depot	1340.00	18797.00	20137.00	FCFA	Versement salaire	\N	2025-08-02 20:00:38	2025-10-23 10:35:33
fc0af647-2b9d-41d3-9545-7c5af4b12d4a	a03dce74-58f6-42c7-8624-1d21ea760a90	retrait	11363.00	18797.00	7434.00	FCFA	Retrait guichet	\N	2025-05-18 23:16:59	2025-10-23 10:35:33
6a81be8f-91f3-45ad-bf12-2b7715df76e7	a03dce74-58f6-42c7-8624-1d21ea760a90	retrait	39825.00	18797.00	0.00	FCFA	Paiement par carte	\N	2025-09-04 13:33:48	2025-10-23 10:35:33
9ccee26b-adf3-4e89-a4c9-c5adb093dcc2	a03dce74-58f6-42c7-8624-1d21ea760a90	retrait	14402.00	18797.00	4395.00	FCFA	Retrait DAB	\N	2025-08-16 13:47:32	2025-10-23 10:35:33
9f6844e5-3167-4a28-864c-c8412c926cb4	a03dce74-58f6-42c7-8624-1d21ea760a90	retrait	47193.00	18797.00	0.00	FCFA	Paiement par carte	\N	2025-06-20 05:42:26	2025-10-23 10:35:33
07d6d613-ecce-4271-8365-363477dc0ddb	a03dce74-58f6-42c7-8624-1d21ea760a90	retrait	26894.00	18797.00	0.00	FCFA	Retrait DAB	\N	2025-06-04 16:10:37	2025-10-23 10:35:33
29aeafdb-c890-457e-b9cd-47c8d261ad4f	a03dce74-58f6-42c7-8624-1d21ea760a90	retrait	6547.00	18797.00	12250.00	FCFA	Prélèvement automatique	\N	2025-05-03 14:22:07	2025-10-23 10:35:33
c6cbf2f4-2221-4897-8952-586495f62545	a03dce74-58f6-42c7-8624-1d21ea760a90	virement	6233.00	18797.00	12564.00	FCFA	Paiement facture	64203f77-d74d-4752-9e2b-7a1c40547be9	2025-05-08 20:58:16	2025-10-23 10:35:33
cd1acc38-77c6-44e7-939c-7950a7cf3c70	a03dce74-58f6-42c7-8624-1d21ea760a90	depot	15587.00	18797.00	34384.00	FCFA	Dépôt d'espèces	\N	2025-07-05 15:53:31	2025-10-23 10:35:33
bef82e88-30b0-48ca-a2e5-efb3c32d4bd0	a03dce74-58f6-42c7-8624-1d21ea760a90	depot	42669.00	18797.00	61466.00	FCFA	Dépôt espèces guichet	\N	2025-05-30 03:46:25	2025-10-23 10:35:33
acfb0fd0-c155-4dcc-840a-78b2a8ba704b	a5bad169-7741-4b82-9dde-4803bb629488	retrait	44760.00	275160.00	230400.00	FCFA	Retrait d'espèces	\N	2025-09-15 11:51:41	2025-10-23 10:35:33
06871277-2d44-415c-b860-ce0179d2b2eb	a5bad169-7741-4b82-9dde-4803bb629488	depot	26528.00	275160.00	301688.00	FCFA	Dépôt d'espèces	\N	2025-10-01 22:32:39	2025-10-23 10:35:33
627c2ad1-2f83-4854-8119-fcf5a5bb67ff	a5bad169-7741-4b82-9dde-4803bb629488	retrait	7984.00	275160.00	267176.00	FCFA	Paiement par carte	\N	2025-08-17 17:24:25	2025-10-23 10:35:33
714f9229-e51c-4a57-a635-5fe2c4341695	a5bad169-7741-4b82-9dde-4803bb629488	depot	10567.00	275160.00	285727.00	FCFA	Versement salaire	\N	2025-07-24 00:20:41	2025-10-23 10:35:33
af3e0de6-7745-411e-b2b0-182f764690cf	a5bad169-7741-4b82-9dde-4803bb629488	depot	30866.00	275160.00	306026.00	FCFA	Dépôt d'espèces	\N	2025-05-20 08:16:15	2025-10-23 10:35:33
c06e1e8d-807a-4308-8739-5c59cc1aa2af	a5bad169-7741-4b82-9dde-4803bb629488	virement	8761.00	275160.00	266399.00	FCFA	Virement vers compte	9c0923b4-0a14-4650-8df8-edf426310de6	2025-10-10 22:50:49	2025-10-23 10:35:33
39aba65d-6f58-4d49-938a-3d532697fb04	a5bad169-7741-4b82-9dde-4803bb629488	retrait	25858.00	275160.00	249302.00	FCFA	Paiement par carte	\N	2025-06-24 01:07:17	2025-10-23 10:35:33
052d3db1-ba2e-438f-92af-965c355fb235	a5bad169-7741-4b82-9dde-4803bb629488	retrait	17379.00	275160.00	257781.00	FCFA	Paiement par carte	\N	2025-05-09 12:00:26	2025-10-23 10:35:33
3c47350a-59a2-42bb-bedf-c1ee5614df54	a5bad169-7741-4b82-9dde-4803bb629488	depot	29785.00	275160.00	304945.00	FCFA	Versement salaire	\N	2025-08-09 01:09:06	2025-10-23 10:35:33
f8db3cdc-66d0-4539-be6e-70559913d6f1	a5bad169-7741-4b82-9dde-4803bb629488	retrait	8138.00	275160.00	267022.00	FCFA	Retrait d'espèces	\N	2025-08-22 15:20:34	2025-10-23 10:35:33
fcdb02c4-0ced-415d-b200-4cd31483bf9c	a5bad169-7741-4b82-9dde-4803bb629488	virement	13500.00	275160.00	261660.00	FCFA	Transfert bancaire	4bb7fc9b-13d6-4883-b751-283b753d05ed	2025-09-27 01:31:35	2025-10-23 10:35:33
97ff3df4-24b5-4581-ba16-70d3817951aa	a5bad169-7741-4b82-9dde-4803bb629488	retrait	30742.00	275160.00	244418.00	FCFA	Retrait DAB	\N	2025-10-16 09:51:09	2025-10-23 10:35:33
7e8f8a53-3673-4026-8009-ec00b0154835	a5bad169-7741-4b82-9dde-4803bb629488	virement	9506.00	275160.00	265654.00	FCFA	Transfert bancaire	0006e5f7-4df5-46a5-8f9e-90089c5ea052	2025-09-22 17:19:37	2025-10-23 10:35:33
61d25ba7-7a59-4776-9e47-368aa9554cbd	a5bad169-7741-4b82-9dde-4803bb629488	depot	37052.00	275160.00	312212.00	FCFA	Dépôt d'espèces	\N	2025-10-17 20:36:53	2025-10-23 10:35:33
6bddb60b-212a-44e3-883d-500dff5bcf44	a5bad169-7741-4b82-9dde-4803bb629488	retrait	44707.00	275160.00	230453.00	FCFA	Prélèvement automatique	\N	2025-08-25 11:04:13	2025-10-23 10:35:33
26acf47f-73da-4075-af22-bcb198fdb622	cb45ecae-4f73-42b2-870b-4f41321c9acd	virement	16256.00	490663.00	474407.00	FCFA	Virement salaire	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	2025-06-21 06:53:05	2025-10-23 10:35:33
7102f591-c8a7-42d9-a842-b61e69b8e82e	cb45ecae-4f73-42b2-870b-4f41321c9acd	retrait	21234.00	490663.00	469429.00	FCFA	Retrait DAB	\N	2025-09-10 11:14:20	2025-10-23 10:35:33
51bf68eb-7fa0-4eb7-965b-437b96424908	cb45ecae-4f73-42b2-870b-4f41321c9acd	retrait	1389.00	490663.00	489274.00	FCFA	Prélèvement automatique	\N	2025-06-07 02:11:58	2025-10-23 10:35:33
dfc8323e-6147-448a-ac6b-b9ab42153c40	cb45ecae-4f73-42b2-870b-4f41321c9acd	retrait	45846.00	490663.00	444817.00	FCFA	Paiement par carte	\N	2025-10-14 07:19:26	2025-10-23 10:35:33
aafd59fc-e8f4-40a4-abaa-090aeeba3135	cb45ecae-4f73-42b2-870b-4f41321c9acd	retrait	13826.00	490663.00	476837.00	FCFA	Retrait DAB	\N	2025-08-14 17:43:06	2025-10-23 10:35:33
9065d7cd-61cb-461a-bd9e-88bf17259d94	cb45ecae-4f73-42b2-870b-4f41321c9acd	depot	42562.00	490663.00	533225.00	FCFA	Dépôt chèque	\N	2025-05-01 07:45:05	2025-10-23 10:35:33
ebdacdcd-0e29-45f7-bed3-0897b306bb5f	cb45ecae-4f73-42b2-870b-4f41321c9acd	retrait	43772.00	490663.00	446891.00	FCFA	Retrait d'espèces	\N	2025-08-02 18:52:21	2025-10-23 10:35:33
18615aa2-eaf2-4420-a551-94f39172e2ac	cb45ecae-4f73-42b2-870b-4f41321c9acd	depot	11647.00	490663.00	502310.00	FCFA	Dépôt espèces guichet	\N	2025-10-01 17:23:51	2025-10-23 10:35:33
e2728d89-c80a-4b98-8541-8f95c87aa524	cb45ecae-4f73-42b2-870b-4f41321c9acd	depot	45750.00	490663.00	536413.00	FCFA	Dépôt d'espèces	\N	2025-05-20 09:54:22	2025-10-23 10:35:33
fbe11417-263b-43b5-a61c-cd85fbc06548	cb45ecae-4f73-42b2-870b-4f41321c9acd	retrait	43056.00	490663.00	447607.00	FCFA	Retrait guichet	\N	2025-08-17 19:44:26	2025-10-23 10:35:33
2dfff4bc-7cbd-4bb3-abd2-3ed135d12e3d	cb45ecae-4f73-42b2-870b-4f41321c9acd	retrait	36149.00	490663.00	454514.00	FCFA	Retrait DAB	\N	2025-06-04 13:54:43	2025-10-23 10:35:33
61c4c371-5624-4e7c-954d-9969fedb0bc6	cb45ecae-4f73-42b2-870b-4f41321c9acd	depot	44215.00	490663.00	534878.00	FCFA	Dépôt espèces guichet	\N	2025-05-06 20:20:14	2025-10-23 10:35:33
d10081ba-921c-4103-ac2f-5773689767e9	4bb7fc9b-13d6-4883-b751-283b753d05ed	virement	17520.00	151689.00	134169.00	FCFA	Transfert entre comptes	b3c57074-cab3-490f-9d70-3da5066332f6	2025-08-25 15:17:04	2025-10-23 10:35:33
702c6151-3f82-41c3-97d1-0d1ac20e3ca1	4bb7fc9b-13d6-4883-b751-283b753d05ed	virement	26940.00	151689.00	124749.00	FCFA	Paiement facture	f46f2dde-ba75-4234-b729-67c0cd2a3ade	2025-07-22 20:46:52	2025-10-23 10:35:33
897e76bc-6249-4c14-93b8-019cfc27a5d4	4bb7fc9b-13d6-4883-b751-283b753d05ed	depot	30931.00	151689.00	182620.00	FCFA	Dépôt espèces guichet	\N	2025-06-11 08:51:22	2025-10-23 10:35:33
4e18c515-c759-4b2c-a965-c55136e422b4	4bb7fc9b-13d6-4883-b751-283b753d05ed	retrait	2496.00	151689.00	149193.00	FCFA	Paiement par carte	\N	2025-05-05 08:45:13	2025-10-23 10:35:33
4d404ade-d831-43de-904d-3086a4f88841	4bb7fc9b-13d6-4883-b751-283b753d05ed	depot	13355.00	151689.00	165044.00	FCFA	Versement salaire	\N	2025-10-19 21:00:53	2025-10-23 10:35:33
a9cd6a6d-d6a2-4489-b74f-67bec971d905	4bb7fc9b-13d6-4883-b751-283b753d05ed	depot	28045.00	151689.00	179734.00	FCFA	Virement bancaire entrant	\N	2025-06-19 01:39:59	2025-10-23 10:35:33
27564371-da90-48f3-9908-beaa83b8159a	4bb7fc9b-13d6-4883-b751-283b753d05ed	retrait	40443.00	151689.00	111246.00	FCFA	Retrait d'espèces	\N	2025-05-24 04:17:39	2025-10-23 10:35:33
bf2be41d-1926-48c6-becd-a4353d5ec29a	4bb7fc9b-13d6-4883-b751-283b753d05ed	retrait	15020.00	151689.00	136669.00	FCFA	Retrait DAB	\N	2025-10-19 19:01:47	2025-10-23 10:35:33
0cf76bcc-20dd-4a92-8552-d7a92abdf048	4bb7fc9b-13d6-4883-b751-283b753d05ed	retrait	13821.00	151689.00	137868.00	FCFA	Paiement par carte	\N	2025-09-24 00:49:27	2025-10-23 10:35:33
5952c45b-e7aa-4b54-b1ca-309296ae500f	4bb7fc9b-13d6-4883-b751-283b753d05ed	virement	45697.00	151689.00	105992.00	FCFA	Paiement facture	39ca01df-9037-4f1b-962a-164c3db984f0	2025-09-09 15:50:18	2025-10-23 10:35:33
c4130bcd-0130-406c-b418-cde17b2e8a5d	34b84e17-27b4-4080-a77b-3cdb00476a06	retrait	16225.00	449873.00	433648.00	FCFA	Prélèvement automatique	\N	2025-05-22 06:29:18	2025-10-23 10:35:33
0819eb3b-05e8-43aa-b853-bfe942aadfb3	34b84e17-27b4-4080-a77b-3cdb00476a06	virement	22248.00	449873.00	427625.00	FCFA	Virement vers compte	e4ad8455-8e84-4a67-873f-6392338ba743	2025-05-08 20:37:23	2025-10-23 10:35:33
9021c400-c603-44a6-8346-039ce4e4bb33	34b84e17-27b4-4080-a77b-3cdb00476a06	depot	22682.00	449873.00	472555.00	FCFA	Virement bancaire entrant	\N	2025-07-22 16:34:12	2025-10-23 10:35:33
6e1e6468-5eb0-452d-87a3-ce979307d253	34b84e17-27b4-4080-a77b-3cdb00476a06	virement	1948.00	449873.00	447925.00	FCFA	Paiement facture	8a4ca722-53cc-428f-a83a-d84a7f681abf	2025-09-15 12:02:35	2025-10-23 10:35:33
d10a9c77-8bcf-432c-a93c-beced8d51620	34b84e17-27b4-4080-a77b-3cdb00476a06	depot	16176.00	449873.00	466049.00	FCFA	Dépôt espèces guichet	\N	2025-07-09 19:12:16	2025-10-23 10:35:33
daea9eec-bf09-4432-aace-ec1d6d3961ed	34b84e17-27b4-4080-a77b-3cdb00476a06	depot	49243.00	449873.00	499116.00	FCFA	Dépôt d'espèces	\N	2025-05-25 23:09:19	2025-10-23 10:35:33
4e34e9cd-5c81-42b1-bfc6-b499d36444b8	34b84e17-27b4-4080-a77b-3cdb00476a06	virement	23494.00	449873.00	426379.00	FCFA	Virement salaire	c2b93a8c-ea1e-4b85-8224-c209137135b0	2025-06-12 02:31:30	2025-10-23 10:35:33
18deec19-8501-4d34-8c94-5a1aec6a6044	34b84e17-27b4-4080-a77b-3cdb00476a06	retrait	17725.00	449873.00	432148.00	FCFA	Retrait guichet	\N	2025-10-11 05:47:54	2025-10-23 10:35:33
e482a417-90ee-4745-8ab0-d901d12690e1	34b84e17-27b4-4080-a77b-3cdb00476a06	retrait	7395.00	449873.00	442478.00	FCFA	Paiement par carte	\N	2025-06-03 09:48:12	2025-10-23 10:35:33
0ff8389b-c26e-46e2-b50b-e50afee769f9	34b84e17-27b4-4080-a77b-3cdb00476a06	retrait	45661.00	449873.00	404212.00	FCFA	Retrait guichet	\N	2025-07-31 11:41:15	2025-10-23 10:35:33
4ed1611b-d067-4c2e-9007-cf84752e52c5	34b84e17-27b4-4080-a77b-3cdb00476a06	depot	47538.00	449873.00	497411.00	FCFA	Versement salaire	\N	2025-07-14 22:35:23	2025-10-23 10:35:33
7052dd7e-63bd-4997-bb97-5d867db05547	34b84e17-27b4-4080-a77b-3cdb00476a06	depot	19754.00	449873.00	469627.00	FCFA	Virement bancaire entrant	\N	2025-08-25 09:22:50	2025-10-23 10:35:33
829b9071-3f62-482a-9074-144a080f9c94	d5017ad9-771a-4ec6-8b01-e408480e8116	depot	46522.00	30557.00	77079.00	FCFA	Dépôt d'espèces	\N	2025-05-26 01:05:08	2025-10-23 10:35:33
609181cb-7b65-4ff6-b918-f32b38f5b08a	d5017ad9-771a-4ec6-8b01-e408480e8116	retrait	34204.00	30557.00	0.00	FCFA	Paiement par carte	\N	2025-07-17 01:59:16	2025-10-23 10:35:33
bc39ecad-8c43-4479-9018-30899916c538	d5017ad9-771a-4ec6-8b01-e408480e8116	retrait	48346.00	30557.00	0.00	FCFA	Paiement par carte	\N	2025-06-09 02:52:24	2025-10-23 10:35:33
d95e0dea-6770-477d-811c-c34adaf97697	d5017ad9-771a-4ec6-8b01-e408480e8116	virement	46248.00	30557.00	0.00	FCFA	Transfert bancaire	add2482a-de00-41d8-a772-cd4ef6546baa	2025-07-31 17:18:57	2025-10-23 10:35:33
59af9e85-17d7-4dca-b817-bf4a00c26f3a	d5017ad9-771a-4ec6-8b01-e408480e8116	depot	6230.00	30557.00	36787.00	FCFA	Virement bancaire entrant	\N	2025-07-19 08:20:00	2025-10-23 10:35:33
1b01fb09-1dd2-4c13-834e-d8507a1af38d	d5017ad9-771a-4ec6-8b01-e408480e8116	depot	24593.00	30557.00	55150.00	FCFA	Dépôt espèces guichet	\N	2025-09-05 09:12:52	2025-10-23 10:35:33
7fb9304f-aa47-41f0-b353-1053db9853c1	d5017ad9-771a-4ec6-8b01-e408480e8116	retrait	11862.00	30557.00	18695.00	FCFA	Retrait d'espèces	\N	2025-09-26 20:01:35	2025-10-23 10:35:33
aea4251b-f522-491a-bd29-803b725ba472	d5017ad9-771a-4ec6-8b01-e408480e8116	virement	27482.00	30557.00	3075.00	FCFA	Transfert bancaire	54d5e886-a7a4-4427-b256-7723400f3c4e	2025-10-10 03:20:51	2025-10-23 10:35:33
1fdfdb07-75c0-4a8b-a18a-0188cd4d3a6f	d5017ad9-771a-4ec6-8b01-e408480e8116	virement	21008.00	30557.00	9549.00	FCFA	Transfert bancaire	2e311570-14e5-403a-a71f-698c77f8454d	2025-10-10 18:37:44	2025-10-23 10:35:33
8491c9b8-9f33-4b28-9610-bf049232e539	d5017ad9-771a-4ec6-8b01-e408480e8116	retrait	31904.00	30557.00	0.00	FCFA	Retrait guichet	\N	2025-09-13 14:29:21	2025-10-23 10:35:33
4e868b95-95f1-48c2-893b-5428a740962b	d5017ad9-771a-4ec6-8b01-e408480e8116	virement	18957.00	30557.00	11600.00	FCFA	Virement salaire	184d6244-4107-464d-9848-8140c6174183	2025-06-12 21:53:30	2025-10-23 10:35:33
6fc11a41-8254-4110-82d5-3d670423f86a	d5017ad9-771a-4ec6-8b01-e408480e8116	virement	16372.00	30557.00	14185.00	FCFA	Virement vers compte	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	2025-10-06 20:02:27	2025-10-23 10:35:33
c2e6722d-9af3-4e09-9fb8-9e28ecb792f5	d5017ad9-771a-4ec6-8b01-e408480e8116	retrait	29445.00	30557.00	1112.00	FCFA	Paiement par carte	\N	2025-05-18 07:11:44	2025-10-23 10:35:33
71e2d5b6-298e-4699-967b-26b4d1d5011a	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	virement	42885.00	58652.00	15767.00	FCFA	Paiement facture	6131421b-d7d7-4f56-8450-582c37486f68	2025-07-05 13:52:41	2025-10-23 10:35:33
25f214be-162b-439f-89e5-4285e111c514	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	retrait	35720.00	58652.00	22932.00	FCFA	Retrait d'espèces	\N	2025-10-17 16:17:46	2025-10-23 10:35:33
07319964-431d-492b-adf0-7a6a29ccc1c3	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	virement	35295.00	58652.00	23357.00	FCFA	Transfert bancaire	b9fcf39f-cbf6-4e3d-99da-428158581521	2025-09-20 04:09:14	2025-10-23 10:35:33
47c52145-16fc-4b17-a0b5-2446133731a6	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	retrait	30474.00	58652.00	28178.00	FCFA	Retrait DAB	\N	2025-09-20 11:54:22	2025-10-23 10:35:33
99c12afb-cf32-41b4-9396-389bcd9daefe	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	depot	6118.00	58652.00	64770.00	FCFA	Versement salaire	\N	2025-10-16 23:47:59	2025-10-23 10:35:33
4410bee6-6004-4f1f-963d-cf043de9bdb5	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	virement	36110.00	58652.00	22542.00	FCFA	Paiement facture	b1ce150f-0fc3-432e-8d5b-a34f6747804a	2025-06-06 05:54:17	2025-10-23 10:35:33
ea643fd4-d2a2-4cc4-a2df-b6becec077d6	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	retrait	45786.00	58652.00	12866.00	FCFA	Prélèvement automatique	\N	2025-09-27 09:22:15	2025-10-23 10:35:33
9552b2dc-50b9-47a7-a190-235e5f4b0dcf	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	depot	33312.00	58652.00	91964.00	FCFA	Virement bancaire entrant	\N	2025-08-15 16:03:19	2025-10-23 10:35:33
9e86d539-d106-4929-a197-f734d8edd2d2	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	retrait	3622.00	58652.00	55030.00	FCFA	Retrait DAB	\N	2025-08-27 03:39:32	2025-10-23 10:35:33
913dd707-c88c-42be-a3ec-69d8e71562ed	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	retrait	4203.00	58652.00	54449.00	FCFA	Retrait d'espèces	\N	2025-07-04 06:07:57	2025-10-23 10:35:33
3a65a45f-ade3-447e-891a-175c7d24e5b1	a90e1a63-43fd-4956-af04-b3458780ca97	depot	45289.00	30464.00	75753.00	FCFA	Versement salaire	\N	2025-05-24 11:56:54	2025-10-23 10:35:33
20abb91c-4199-4b0c-85ef-9b021cd4fec3	a90e1a63-43fd-4956-af04-b3458780ca97	depot	21713.00	30464.00	52177.00	FCFA	Dépôt chèque	\N	2025-06-22 15:47:10	2025-10-23 10:35:33
932f3b04-6356-4cc1-bbca-9207fb8ec3f1	a90e1a63-43fd-4956-af04-b3458780ca97	retrait	5934.00	30464.00	24530.00	FCFA	Retrait DAB	\N	2025-06-04 22:14:46	2025-10-23 10:35:33
ec9bfaf7-9eb4-4b47-8785-af7c5f2d86b1	a90e1a63-43fd-4956-af04-b3458780ca97	retrait	47861.00	30464.00	0.00	FCFA	Retrait guichet	\N	2025-08-25 10:48:18	2025-10-23 10:35:33
f98be87b-1d77-43f8-9762-ee661a866eaf	a90e1a63-43fd-4956-af04-b3458780ca97	retrait	15649.00	30464.00	14815.00	FCFA	Retrait d'espèces	\N	2025-05-06 20:33:20	2025-10-23 10:35:33
65b2665d-306c-45ec-95e1-7aac904b9d0d	a90e1a63-43fd-4956-af04-b3458780ca97	depot	33510.00	30464.00	63974.00	FCFA	Dépôt d'espèces	\N	2025-06-24 02:36:56	2025-10-23 10:35:33
fcc94d0a-4c78-4798-9e85-836945b9d6f7	a90e1a63-43fd-4956-af04-b3458780ca97	depot	4589.00	30464.00	35053.00	FCFA	Dépôt espèces guichet	\N	2025-08-26 03:29:33	2025-10-23 10:35:33
9564255c-9906-4396-b443-3db8bde979c7	a90e1a63-43fd-4956-af04-b3458780ca97	retrait	35402.00	30464.00	0.00	FCFA	Retrait d'espèces	\N	2025-08-23 07:09:52	2025-10-23 10:35:33
ebb6e0f5-f09d-437e-a354-cdc62cf90159	a90e1a63-43fd-4956-af04-b3458780ca97	depot	29196.00	30464.00	59660.00	FCFA	Versement salaire	\N	2025-09-02 08:42:10	2025-10-23 10:35:33
a078a825-a46c-4c02-89bd-ffaaeade3d3e	a90e1a63-43fd-4956-af04-b3458780ca97	retrait	33622.00	30464.00	0.00	FCFA	Retrait d'espèces	\N	2025-07-31 10:43:23	2025-10-23 10:35:33
7a99cf61-bd18-4049-b18a-b781e1d2676c	a90e1a63-43fd-4956-af04-b3458780ca97	retrait	41756.00	30464.00	0.00	FCFA	Retrait guichet	\N	2025-06-17 18:16:09	2025-10-23 10:35:33
5a755c60-2507-48c9-ba45-13b656a7f7ae	a90e1a63-43fd-4956-af04-b3458780ca97	retrait	23426.00	30464.00	7038.00	FCFA	Retrait guichet	\N	2025-04-26 20:32:11	2025-10-23 10:35:33
2efe0ad7-a0bd-4dd2-b461-98efdb7f736b	a90e1a63-43fd-4956-af04-b3458780ca97	retrait	13966.00	30464.00	16498.00	FCFA	Retrait d'espèces	\N	2025-05-23 20:12:35	2025-10-23 10:35:33
c00b1c66-c5ae-41fc-b2f5-1c808c7469c3	6c92b373-c286-44a2-94a3-cf8cf3479100	retrait	7217.00	372762.00	365545.00	FCFA	Prélèvement automatique	\N	2025-08-05 23:41:13	2025-10-23 10:35:33
8675ce92-4a02-4e64-a545-6f88247e038e	6c92b373-c286-44a2-94a3-cf8cf3479100	retrait	46208.00	372762.00	326554.00	FCFA	Prélèvement automatique	\N	2025-06-26 14:53:08	2025-10-23 10:35:33
f1193939-946c-4701-95fe-8846d661e349	6c92b373-c286-44a2-94a3-cf8cf3479100	virement	32037.00	372762.00	340725.00	FCFA	Transfert entre comptes	9c0923b4-0a14-4650-8df8-edf426310de6	2025-08-01 11:43:32	2025-10-23 10:35:33
c04c0ef5-37f5-487b-8a48-02c721f009b9	6c92b373-c286-44a2-94a3-cf8cf3479100	virement	30026.00	372762.00	342736.00	FCFA	Transfert entre comptes	b26e640d-87a1-49a8-a880-2a2088a4fca0	2025-10-05 21:43:21	2025-10-23 10:35:33
3074fc43-dc06-466d-862f-d5921adf8be4	6c92b373-c286-44a2-94a3-cf8cf3479100	virement	24884.00	372762.00	347878.00	FCFA	Transfert bancaire	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	2025-08-14 21:29:51	2025-10-23 10:35:33
24f05391-3e31-4c97-bd82-e6ef34b85264	6c92b373-c286-44a2-94a3-cf8cf3479100	depot	44675.00	372762.00	417437.00	FCFA	Dépôt espèces guichet	\N	2025-08-21 07:32:32	2025-10-23 10:35:33
999eec0b-3412-4793-8ee3-4f32a5b892b5	6c92b373-c286-44a2-94a3-cf8cf3479100	retrait	29736.00	372762.00	343026.00	FCFA	Retrait DAB	\N	2025-09-05 02:28:25	2025-10-23 10:35:33
f8fe23a0-c104-4996-9951-cb7a53bf334e	6c92b373-c286-44a2-94a3-cf8cf3479100	virement	8111.00	372762.00	364651.00	FCFA	Virement vers compte	05c0a3e8-eeae-4976-88c2-848aec6bea96	2025-06-29 02:06:27	2025-10-23 10:35:33
b85847c9-f3d2-4c00-bfce-5a6a6ab9ec12	6c92b373-c286-44a2-94a3-cf8cf3479100	retrait	9504.00	372762.00	363258.00	FCFA	Retrait DAB	\N	2025-04-23 10:58:20	2025-10-23 10:35:33
56052cfe-b459-4f43-8c1d-58e0a3826af7	6c92b373-c286-44a2-94a3-cf8cf3479100	virement	32617.00	372762.00	340145.00	FCFA	Transfert bancaire	2e311570-14e5-403a-a71f-698c77f8454d	2025-07-04 22:14:47	2025-10-23 10:35:33
63a7d307-fac8-45ae-8d67-e58beedaf79a	6c92b373-c286-44a2-94a3-cf8cf3479100	virement	49235.00	372762.00	323527.00	FCFA	Paiement facture	a03dce74-58f6-42c7-8624-1d21ea760a90	2025-06-09 16:02:28	2025-10-23 10:35:33
460cbeec-9bd0-4939-9f3f-e80850851b92	6c92b373-c286-44a2-94a3-cf8cf3479100	virement	10581.00	372762.00	362181.00	FCFA	Transfert entre comptes	0c099b4c-0616-44d6-af7a-38ed712edbf0	2025-08-19 21:03:55	2025-10-23 10:35:33
f0de5c5b-0cc8-4df2-8a26-b20138d888db	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	retrait	42932.00	468625.00	425693.00	FCFA	Retrait DAB	\N	2025-09-27 14:12:37	2025-10-23 10:35:33
bb15f7d1-5a97-480c-9c42-2f3fe09b2730	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	virement	1777.00	468625.00	466848.00	FCFA	Transfert entre comptes	a0123386-5767-4f9f-b457-e0613e9f8725	2025-10-21 05:25:04	2025-10-23 10:35:33
ad99943d-c65b-4667-b827-200ccfaaa6ef	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	depot	5597.00	468625.00	474222.00	FCFA	Dépôt chèque	\N	2025-06-10 13:46:58	2025-10-23 10:35:33
8d93436c-cb98-4a87-94f9-d32aa006a21d	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	depot	42546.00	468625.00	511171.00	FCFA	Dépôt d'espèces	\N	2025-05-19 04:39:18	2025-10-23 10:35:33
74e39b89-97cf-4e4c-a8d6-3b0418629b9e	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	depot	43919.00	468625.00	512544.00	FCFA	Versement salaire	\N	2025-09-21 18:59:13	2025-10-23 10:35:33
62d1085e-ca3f-4bf7-987d-c23d5ad01bad	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	depot	24482.00	468625.00	493107.00	FCFA	Dépôt espèces guichet	\N	2025-08-06 11:06:21	2025-10-23 10:35:33
78d75199-f33a-4fa4-95a6-419d15df509a	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	depot	44575.00	468625.00	513200.00	FCFA	Virement bancaire entrant	\N	2025-08-06 20:57:35	2025-10-23 10:35:33
11739a1a-11e3-4d12-bc78-7eb484676729	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	retrait	2101.00	468625.00	466524.00	FCFA	Retrait guichet	\N	2025-06-02 10:01:27	2025-10-23 10:35:33
263c0d27-1842-42f0-972d-78341ba17e6e	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	retrait	14481.00	468625.00	454144.00	FCFA	Retrait d'espèces	\N	2025-09-05 16:08:17	2025-10-23 10:35:33
843448e5-e32b-4e71-8a90-87b049f4e35a	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	virement	36145.00	468625.00	432480.00	FCFA	Virement salaire	a90e1a63-43fd-4956-af04-b3458780ca97	2025-09-03 20:52:57	2025-10-23 10:35:33
3d79f131-823f-48f5-a559-19570d45705d	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	virement	9827.00	468625.00	458798.00	FCFA	Transfert entre comptes	df088290-3d37-4591-8571-389b37349b2a	2025-06-04 20:43:21	2025-10-23 10:35:33
5bd7e328-aaea-4e91-978f-22699ab3087a	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	virement	13839.00	468625.00	454786.00	FCFA	Virement salaire	2f53ae60-3c7c-4dee-a02c-cad51068f96c	2025-08-30 06:42:27	2025-10-23 10:35:33
cd8ee487-a259-4817-89a8-4e752f4d34f6	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	retrait	8790.00	468625.00	459835.00	FCFA	Retrait DAB	\N	2025-05-14 11:46:20	2025-10-23 10:35:33
25e552bf-f011-4d2d-b80d-a78ba6ff9fce	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	retrait	21161.00	468625.00	447464.00	FCFA	Retrait d'espèces	\N	2025-08-19 04:26:48	2025-10-23 10:35:33
51c07196-9d09-4857-b57c-8ba6762d8a9d	c5b06daf-ba43-4954-b2b8-1065dfb122ab	depot	34998.00	74183.00	109181.00	FCFA	Dépôt d'espèces	\N	2025-06-07 13:27:09	2025-10-23 10:35:33
660cc6d7-056f-4be3-9823-89fee5f789c4	c5b06daf-ba43-4954-b2b8-1065dfb122ab	retrait	1763.00	74183.00	72420.00	FCFA	Retrait d'espèces	\N	2025-05-05 11:51:30	2025-10-23 10:35:33
a60858de-e215-4b70-82e8-eadbbf208ce0	c5b06daf-ba43-4954-b2b8-1065dfb122ab	depot	20075.00	74183.00	94258.00	FCFA	Virement bancaire entrant	\N	2025-08-22 05:49:15	2025-10-23 10:35:33
933a67d1-77c1-4ae9-892a-fc2f7a509790	c5b06daf-ba43-4954-b2b8-1065dfb122ab	retrait	5792.00	74183.00	68391.00	FCFA	Retrait d'espèces	\N	2025-08-20 04:34:54	2025-10-23 10:35:33
516a4a2d-f387-4b06-8bed-329a42b8a752	c5b06daf-ba43-4954-b2b8-1065dfb122ab	virement	5025.00	74183.00	69158.00	FCFA	Virement salaire	f2182e94-c5d0-4b91-8d12-af97e101dd6b	2025-05-27 05:20:26	2025-10-23 10:35:33
38e015d3-3807-488c-b1a9-e59165e80966	c5b06daf-ba43-4954-b2b8-1065dfb122ab	depot	35165.00	74183.00	109348.00	FCFA	Dépôt d'espèces	\N	2025-05-21 13:34:36	2025-10-23 10:35:33
382eb3fc-1f3d-4dfb-9e0b-6c9c5f7388ef	c5b06daf-ba43-4954-b2b8-1065dfb122ab	depot	34219.00	74183.00	108402.00	FCFA	Versement salaire	\N	2025-07-16 08:36:08	2025-10-23 10:35:33
c8c2b251-652c-4c46-9732-f476f5673427	c5b06daf-ba43-4954-b2b8-1065dfb122ab	depot	31747.00	74183.00	105930.00	FCFA	Virement bancaire entrant	\N	2025-07-30 05:07:32	2025-10-23 10:35:33
2840439c-b7c5-41d5-9cdb-f7a37277466d	c5b06daf-ba43-4954-b2b8-1065dfb122ab	retrait	35098.00	74183.00	39085.00	FCFA	Retrait d'espèces	\N	2025-08-21 18:42:35	2025-10-23 10:35:33
a1debb96-a303-4488-ac8f-baf1fcd88c61	c5b06daf-ba43-4954-b2b8-1065dfb122ab	depot	19965.00	74183.00	94148.00	FCFA	Dépôt d'espèces	\N	2025-08-26 11:07:09	2025-10-23 10:35:33
88834d10-9cc6-4c77-8c90-713850d5a044	c5b06daf-ba43-4954-b2b8-1065dfb122ab	virement	49943.00	74183.00	24240.00	FCFA	Transfert bancaire	cb45ecae-4f73-42b2-870b-4f41321c9acd	2025-05-14 22:06:22	2025-10-23 10:35:33
427436fd-17e8-416d-ac48-56ff21e5ffe2	c5b06daf-ba43-4954-b2b8-1065dfb122ab	retrait	2315.00	74183.00	71868.00	FCFA	Prélèvement automatique	\N	2025-06-26 14:47:20	2025-10-23 10:35:33
4320b334-e485-48c0-b0ca-39542ff9cffa	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	depot	35788.00	320094.00	355882.00	FCFA	Virement bancaire entrant	\N	2025-05-06 00:29:46	2025-10-23 10:35:33
0220499b-9f5a-488c-ac0b-dff9c5ec3df1	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	virement	25178.00	320094.00	294916.00	FCFA	Transfert entre comptes	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	2025-09-06 01:02:19	2025-10-23 10:35:33
ef89b2b4-9eb9-49cb-a459-e4850fd58de5	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	depot	41625.00	320094.00	361719.00	FCFA	Virement bancaire entrant	\N	2025-09-14 15:44:26	2025-10-23 10:35:33
ed47bff9-5e3e-41d6-b577-e076cfcc49d3	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	virement	42307.00	320094.00	277787.00	FCFA	Virement vers compte	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	2025-05-09 21:10:09	2025-10-23 10:35:33
b801f6b6-5804-46ab-9cc3-ff45de34b856	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	virement	13561.00	320094.00	306533.00	FCFA	Virement salaire	a5bad169-7741-4b82-9dde-4803bb629488	2025-07-30 15:25:39	2025-10-23 10:35:33
fe2d277e-f849-43e8-943c-1683a6e2dd4a	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	retrait	30887.00	320094.00	289207.00	FCFA	Retrait DAB	\N	2025-06-02 08:05:18	2025-10-23 10:35:33
8a1e8ebe-7767-450d-923a-78686b415c08	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	depot	38348.00	320094.00	358442.00	FCFA	Dépôt chèque	\N	2025-07-13 03:01:50	2025-10-23 10:35:33
071a7afe-8a23-4b74-adad-58cee57b04fc	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	virement	39013.00	320094.00	281081.00	FCFA	Paiement facture	184d6244-4107-464d-9848-8140c6174183	2025-07-22 01:11:47	2025-10-23 10:35:33
45384417-4035-4d1b-93aa-a503ab429b3c	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	retrait	27559.00	320094.00	292535.00	FCFA	Paiement par carte	\N	2025-08-20 05:37:45	2025-10-23 10:35:33
4acfba58-a030-4dff-93de-185a55a0a9b3	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	retrait	44082.00	320094.00	276012.00	FCFA	Paiement par carte	\N	2025-10-10 07:58:58	2025-10-23 10:35:33
06a24c5c-3473-4640-9438-f10329579fca	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	retrait	24925.00	138344.00	113419.00	FCFA	Retrait guichet	\N	2025-05-04 18:33:21	2025-10-23 10:35:33
6bd49426-f3c5-4219-a860-ac10371a756c	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	depot	23719.00	138344.00	162063.00	FCFA	Versement salaire	\N	2025-07-05 10:16:40	2025-10-23 10:35:33
df2e6109-a742-4164-af0a-d81a1138a7fe	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	retrait	39902.00	138344.00	98442.00	FCFA	Paiement par carte	\N	2025-08-24 13:11:06	2025-10-23 10:35:33
b18cdab9-c31e-4f08-8955-50c0bddb699e	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	depot	22423.00	138344.00	160767.00	FCFA	Dépôt chèque	\N	2025-07-18 22:53:54	2025-10-23 10:35:33
3f1d2deb-7828-410f-9f68-d2fa3fc04d45	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	retrait	26204.00	138344.00	112140.00	FCFA	Retrait guichet	\N	2025-05-30 15:37:12	2025-10-23 10:35:33
67e486d6-6989-4f0d-bd3d-0fdaef7588c3	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	retrait	27521.00	138344.00	110823.00	FCFA	Retrait DAB	\N	2025-05-25 22:46:45	2025-10-23 10:35:33
e48a6da8-e7c0-49c5-91da-d93fec213e60	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	depot	40885.00	138344.00	179229.00	FCFA	Versement salaire	\N	2025-10-22 18:00:30	2025-10-23 10:35:33
3dba6f37-1058-43d9-95c6-5381e521680e	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	virement	7142.00	138344.00	131202.00	FCFA	Transfert bancaire	0c099b4c-0616-44d6-af7a-38ed712edbf0	2025-05-05 13:01:40	2025-10-23 10:35:33
244c1d5b-a9bc-45fc-84c1-274bd9ea5fc9	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	virement	13736.00	138344.00	124608.00	FCFA	Transfert bancaire	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	2025-10-07 13:08:15	2025-10-23 10:35:33
2b5a2cb8-00e2-4879-93f5-1183fd043f06	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	depot	9719.00	138344.00	148063.00	FCFA	Dépôt d'espèces	\N	2025-07-04 14:30:01	2025-10-23 10:35:33
5b6c6a12-948c-4ee6-bb2a-0713cd181262	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	retrait	14921.00	138344.00	123423.00	FCFA	Paiement par carte	\N	2025-08-10 13:43:13	2025-10-23 10:35:33
7910d702-292a-40d1-931c-681fa4390f5b	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	depot	15041.00	138344.00	153385.00	FCFA	Dépôt espèces guichet	\N	2025-08-27 01:45:56	2025-10-23 10:35:33
6efbaeaa-14ac-47d3-b6f6-19371e7c6936	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	depot	17522.00	138344.00	155866.00	FCFA	Dépôt espèces guichet	\N	2025-09-07 11:04:05	2025-10-23 10:35:33
0a54fa81-97cf-424e-b670-7674718f0a59	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	retrait	37524.00	138344.00	100820.00	FCFA	Paiement par carte	\N	2025-08-14 22:46:38	2025-10-23 10:35:33
a481a45b-2edf-4536-b36a-f57bda700864	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	depot	16595.00	1381.00	17976.00	FCFA	Dépôt espèces guichet	\N	2025-05-25 01:01:02	2025-10-23 10:35:33
9edf05dd-df53-4e30-90cc-f2c67e71609c	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	retrait	45670.00	1381.00	0.00	FCFA	Paiement par carte	\N	2025-06-23 06:07:48	2025-10-23 10:35:33
8e75152e-b513-4c71-ab82-4ba936b73106	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	retrait	40755.00	1381.00	0.00	FCFA	Retrait d'espèces	\N	2025-06-02 21:08:17	2025-10-23 10:35:33
bd10c22a-aa78-4fb3-ac33-a909e885e7f6	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	depot	29865.00	1381.00	31246.00	FCFA	Dépôt chèque	\N	2025-08-30 16:00:57	2025-10-23 10:35:33
7b476bab-42e8-4891-9389-cd50d6c096e0	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	virement	21161.00	1381.00	0.00	FCFA	Transfert bancaire	54c98069-cb97-4a48-9c06-c8ed239ef726	2025-07-11 21:26:48	2025-10-23 10:35:33
dec0aad7-4862-4ea1-bef8-408e4ef54fae	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	depot	11338.00	1381.00	12719.00	FCFA	Dépôt espèces guichet	\N	2025-07-01 00:15:01	2025-10-23 10:35:33
b36f2a4c-57d6-43d7-812b-0c7c35edba7a	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	virement	15780.00	1381.00	0.00	FCFA	Transfert bancaire	0006e5f7-4df5-46a5-8f9e-90089c5ea052	2025-05-30 11:52:06	2025-10-23 10:35:33
6bc70958-e680-4e1b-ab2f-484da229f8d2	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	depot	27556.00	206130.00	233686.00	FCFA	Dépôt espèces guichet	\N	2025-09-19 01:25:55	2025-10-23 10:35:33
e1a3ca8f-f0b0-46db-9847-ac311e9b521f	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	depot	16453.00	206130.00	222583.00	FCFA	Dépôt espèces guichet	\N	2025-05-24 01:07:41	2025-10-23 10:35:33
43e83b77-c01c-4847-8289-4f10ec8c03bd	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	retrait	38953.00	206130.00	167177.00	FCFA	Paiement par carte	\N	2025-06-05 23:39:29	2025-10-23 10:35:33
ac400f4f-5fe7-428c-acdd-3874c93095db	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	retrait	46986.00	206130.00	159144.00	FCFA	Retrait d'espèces	\N	2025-07-16 20:10:09	2025-10-23 10:35:33
82dc0393-2301-4c7e-99a9-04c60d0693be	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	depot	6945.00	206130.00	213075.00	FCFA	Dépôt d'espèces	\N	2025-08-30 02:09:17	2025-10-23 10:35:33
0081c26e-439f-4494-830f-70c7ec68be51	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	retrait	18544.00	206130.00	187586.00	FCFA	Paiement par carte	\N	2025-09-04 23:29:38	2025-10-23 10:35:33
3db8ea47-1ec6-4104-a845-0dbd0b8a107e	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	retrait	14885.00	206130.00	191245.00	FCFA	Retrait guichet	\N	2025-09-26 22:15:41	2025-10-23 10:35:33
679d065b-3c2f-493c-977c-324047d49523	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	depot	24771.00	383574.00	408345.00	FCFA	Dépôt espèces guichet	\N	2025-05-13 21:21:06	2025-10-23 10:35:33
f000f943-e049-476b-a791-76db0b605778	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	retrait	24645.00	383574.00	358929.00	FCFA	Paiement par carte	\N	2025-05-09 10:26:18	2025-10-23 10:35:33
d911a226-abfa-4b86-9cfe-60bb9a71e728	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	depot	43969.00	383574.00	427543.00	FCFA	Dépôt chèque	\N	2025-09-15 09:22:36	2025-10-23 10:35:33
700bdee7-ee34-40f2-8898-238f6b587f05	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	retrait	33676.00	383574.00	349898.00	FCFA	Paiement par carte	\N	2025-05-28 01:45:11	2025-10-23 10:35:33
48161f08-c3a7-4f5c-8b51-35d64de59c1b	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	depot	48167.00	383574.00	431741.00	FCFA	Dépôt chèque	\N	2025-07-28 18:05:15	2025-10-23 10:35:33
3fdca239-b4a1-4ddf-9a5d-3c9683f3929b	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	virement	8321.00	383574.00	375253.00	FCFA	Transfert bancaire	7643d019-9210-424b-b768-667e79ca8da7	2025-06-17 13:27:33	2025-10-23 10:35:33
0ad7307e-02a3-488a-9f27-facaa802addb	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	virement	46242.00	383574.00	337332.00	FCFA	Virement salaire	37da1638-f10a-4a03-9eb4-9eb960273866	2025-08-24 07:44:00	2025-10-23 10:35:33
180e771d-8264-454f-98f8-b3fbf89a801d	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	virement	9694.00	383574.00	373880.00	FCFA	Virement vers compte	d725e859-df50-4ee3-8ab9-65d82dc7fd71	2025-06-28 04:44:15	2025-10-23 10:35:33
f8a0204b-19cb-42aa-b7d1-669450bf0361	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	depot	7221.00	383574.00	390795.00	FCFA	Virement bancaire entrant	\N	2025-07-06 19:13:38	2025-10-23 10:35:33
da1dcd54-02f2-4676-b2da-5f549100fc26	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	retrait	4060.00	383574.00	379514.00	FCFA	Retrait DAB	\N	2025-05-19 00:53:51	2025-10-23 10:35:33
53e557b2-fef6-4ddd-926b-d0d6d79ddd88	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	virement	21315.00	383574.00	362259.00	FCFA	Transfert bancaire	8d706bac-d7d8-4172-8d94-d1a8cdf604db	2025-08-27 03:49:35	2025-10-23 10:35:33
c2a154ae-b061-43ba-afb3-2b118443c2dc	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	virement	31433.00	383574.00	352141.00	FCFA	Transfert bancaire	54c98069-cb97-4a48-9c06-c8ed239ef726	2025-05-02 04:08:26	2025-10-23 10:35:33
006001cd-1845-40aa-ad1b-18a8411356b3	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	depot	45005.00	383574.00	428579.00	FCFA	Dépôt espèces guichet	\N	2025-08-30 12:46:57	2025-10-23 10:35:33
10447f59-2df4-43b0-bc1d-8da6b6c7d958	05c0a3e8-eeae-4976-88c2-848aec6bea96	depot	21668.00	221442.00	243110.00	FCFA	Versement salaire	\N	2025-05-28 14:25:09	2025-10-23 10:35:33
dba9b9c8-bcaa-4bdf-bd94-590cfe71576a	05c0a3e8-eeae-4976-88c2-848aec6bea96	virement	9486.00	221442.00	211956.00	FCFA	Virement vers compte	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	2025-06-02 11:05:13	2025-10-23 10:35:33
f49d93d1-6def-4312-bfb8-e111c10094d3	05c0a3e8-eeae-4976-88c2-848aec6bea96	depot	29035.00	221442.00	250477.00	FCFA	Dépôt espèces guichet	\N	2025-09-27 10:04:47	2025-10-23 10:35:33
96746b8a-874f-4eca-9a33-a152acc2353e	05c0a3e8-eeae-4976-88c2-848aec6bea96	retrait	41246.00	221442.00	180196.00	FCFA	Prélèvement automatique	\N	2025-05-12 11:52:29	2025-10-23 10:35:33
a8e90db6-766c-40b9-9f65-d46425ddec8d	05c0a3e8-eeae-4976-88c2-848aec6bea96	depot	25777.00	221442.00	247219.00	FCFA	Dépôt chèque	\N	2025-07-20 07:42:21	2025-10-23 10:35:33
ad999434-2680-41c3-83a2-b5ffeb590aad	05c0a3e8-eeae-4976-88c2-848aec6bea96	virement	1306.00	221442.00	220136.00	FCFA	Transfert bancaire	bf69dba7-7153-4b9d-885b-f7fa7330e249	2025-05-10 20:17:18	2025-10-23 10:35:33
255cfb7c-1a33-4123-8d65-223b60623cb3	05c0a3e8-eeae-4976-88c2-848aec6bea96	depot	14893.00	221442.00	236335.00	FCFA	Dépôt d'espèces	\N	2025-09-02 14:45:10	2025-10-23 10:35:33
b6dbe19b-0587-492c-a8dc-e5fc29edbf23	05c0a3e8-eeae-4976-88c2-848aec6bea96	virement	12957.00	221442.00	208485.00	FCFA	Paiement facture	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	2025-07-25 16:25:26	2025-10-23 10:35:33
50f5bcaa-de33-4f20-b88d-b67b9d3f0b03	05c0a3e8-eeae-4976-88c2-848aec6bea96	retrait	2333.00	221442.00	219109.00	FCFA	Retrait d'espèces	\N	2025-10-18 20:36:08	2025-10-23 10:35:33
dbabe85f-72ba-44b8-9c82-6d192de7155d	05c0a3e8-eeae-4976-88c2-848aec6bea96	depot	12159.00	221442.00	233601.00	FCFA	Virement bancaire entrant	\N	2025-05-09 13:16:49	2025-10-23 10:35:33
a32d9f71-d167-4efb-b201-e5be4a4f38f3	05c0a3e8-eeae-4976-88c2-848aec6bea96	retrait	22156.00	221442.00	199286.00	FCFA	Retrait DAB	\N	2025-10-06 02:22:41	2025-10-23 10:35:33
2a31cb62-e4f6-430b-a9e2-79ec61a75233	05c0a3e8-eeae-4976-88c2-848aec6bea96	virement	29279.00	221442.00	192163.00	FCFA	Paiement facture	a5bad169-7741-4b82-9dde-4803bb629488	2025-07-07 08:52:07	2025-10-23 10:35:33
5191e398-0e2d-47e0-84f5-00ab1d8e67d4	05c0a3e8-eeae-4976-88c2-848aec6bea96	virement	16831.00	221442.00	204611.00	FCFA	Virement vers compte	916bbfef-cee4-457b-a001-da8e5b0be63d	2025-05-24 04:51:41	2025-10-23 10:35:33
9ee108ee-5d53-42ba-9e4c-72032deb7185	b26e640d-87a1-49a8-a880-2a2088a4fca0	depot	40531.00	432007.00	472538.00	FCFA	Dépôt espèces guichet	\N	2025-08-15 11:53:25	2025-10-23 10:35:33
d0c80368-58e7-4f21-9a8c-24372ae0673d	b26e640d-87a1-49a8-a880-2a2088a4fca0	virement	39641.00	432007.00	392366.00	FCFA	Transfert bancaire	e4ad8455-8e84-4a67-873f-6392338ba743	2025-09-22 11:58:26	2025-10-23 10:35:33
dc8bc9d8-24e2-418a-a217-5815371375c9	b26e640d-87a1-49a8-a880-2a2088a4fca0	virement	21358.00	432007.00	410649.00	FCFA	Transfert entre comptes	0006e5f7-4df5-46a5-8f9e-90089c5ea052	2025-07-25 00:58:28	2025-10-23 10:35:33
7ec07cc3-2f69-45be-9264-c2464a8a2776	b26e640d-87a1-49a8-a880-2a2088a4fca0	retrait	3021.00	432007.00	428986.00	FCFA	Prélèvement automatique	\N	2025-06-14 14:15:47	2025-10-23 10:35:33
56b73694-9aa3-4b05-8215-043dbc5663eb	b26e640d-87a1-49a8-a880-2a2088a4fca0	retrait	8581.00	432007.00	423426.00	FCFA	Retrait guichet	\N	2025-07-19 03:06:34	2025-10-23 10:35:33
b00d3068-7b19-44fc-a908-d79ea11e8e58	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	retrait	13890.00	114653.00	100763.00	FCFA	Paiement par carte	\N	2025-07-26 08:55:20	2025-10-23 10:35:33
552858b1-307e-473b-897c-b2d3993c6856	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	depot	49424.00	114653.00	164077.00	FCFA	Dépôt chèque	\N	2025-07-01 22:34:02	2025-10-23 10:35:33
0c886905-11cc-4862-8fe6-6ac1e3b87ed7	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	retrait	34083.00	114653.00	80570.00	FCFA	Prélèvement automatique	\N	2025-07-24 20:29:45	2025-10-23 10:35:33
d3d0e14d-b8cc-4f07-b88e-626667e1bed1	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	depot	9973.00	114653.00	124626.00	FCFA	Dépôt chèque	\N	2025-06-06 10:14:24	2025-10-23 10:35:33
79f444c1-e938-4c5e-9973-b68318695377	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	depot	24454.00	114653.00	139107.00	FCFA	Dépôt d'espèces	\N	2025-06-06 02:28:41	2025-10-23 10:35:33
4b00247a-8eeb-4398-84f1-c9810fd10120	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	depot	8576.00	114653.00	123229.00	FCFA	Dépôt d'espèces	\N	2025-07-24 10:55:10	2025-10-23 10:35:33
a4df808d-53de-4766-924e-c16b3905f085	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	virement	40396.00	114653.00	74257.00	FCFA	Virement vers compte	6b052865-a885-4b74-94d3-9838eadb0208	2025-06-28 01:15:46	2025-10-23 10:35:33
86d910aa-a342-4508-8c93-011bce0f3502	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	depot	16662.00	114653.00	131315.00	FCFA	Versement salaire	\N	2025-09-22 07:45:08	2025-10-23 10:35:33
f48dc72b-1886-445a-94e7-0397ac62682d	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	depot	48529.00	114653.00	163182.00	FCFA	Virement bancaire entrant	\N	2025-07-11 21:08:47	2025-10-23 10:35:33
9e6b0798-80df-4f09-9caf-8760731bdada	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	retrait	7201.00	114653.00	107452.00	FCFA	Retrait d'espèces	\N	2025-07-29 15:12:41	2025-10-23 10:35:33
84885e9f-ab5e-4e7a-b3f9-b53e7a804ae2	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	virement	17467.00	114653.00	97186.00	FCFA	Virement vers compte	3014d690-a71d-4cb9-ba59-a6c4fea73558	2025-09-03 18:34:23	2025-10-23 10:35:33
4c41e28e-3003-4db9-bc02-ee9f1bd3ed73	c2b93a8c-ea1e-4b85-8224-c209137135b0	virement	25084.00	143077.00	117993.00	FCFA	Virement salaire	a03dce74-58f6-42c7-8624-1d21ea760a90	2025-05-17 05:29:55	2025-10-23 10:35:33
c3da0008-fa63-400a-a6ac-0175fe141785	c2b93a8c-ea1e-4b85-8224-c209137135b0	depot	31593.00	143077.00	174670.00	FCFA	Dépôt espèces guichet	\N	2025-09-20 03:39:16	2025-10-23 10:35:33
910d9d86-f3b2-4dc9-a179-5932e6a016cd	c2b93a8c-ea1e-4b85-8224-c209137135b0	depot	47416.00	143077.00	190493.00	FCFA	Dépôt espèces guichet	\N	2025-05-23 17:40:30	2025-10-23 10:35:33
90ffa84c-d604-4066-b0df-c83b14d35ffb	c2b93a8c-ea1e-4b85-8224-c209137135b0	depot	6744.00	143077.00	149821.00	FCFA	Dépôt chèque	\N	2025-06-29 17:21:19	2025-10-23 10:35:33
dc42833a-731a-48e9-881c-00a14e89f3ea	c2b93a8c-ea1e-4b85-8224-c209137135b0	retrait	6462.00	143077.00	136615.00	FCFA	Retrait d'espèces	\N	2025-10-19 15:52:37	2025-10-23 10:35:33
996e2793-c322-4847-8025-8979053ad7ac	c2b93a8c-ea1e-4b85-8224-c209137135b0	depot	35124.00	143077.00	178201.00	FCFA	Versement salaire	\N	2025-09-03 02:26:25	2025-10-23 10:35:33
921a7c58-27d8-4a7c-90df-e49d37d7b2ec	c2b93a8c-ea1e-4b85-8224-c209137135b0	depot	39752.00	143077.00	182829.00	FCFA	Dépôt chèque	\N	2025-05-22 02:14:07	2025-10-23 10:35:33
c41131de-8831-4d1f-9ddf-c8ab998f7f19	c2b93a8c-ea1e-4b85-8224-c209137135b0	virement	49483.00	143077.00	93594.00	FCFA	Transfert entre comptes	57a5b070-a40d-45d9-b0ee-ba32f96383a6	2025-10-04 22:45:12	2025-10-23 10:35:33
cbfa3534-7e3f-42b4-b985-8d2f46cdc29e	c2b93a8c-ea1e-4b85-8224-c209137135b0	virement	26255.00	143077.00	116822.00	FCFA	Transfert bancaire	4e0954f5-1956-40db-b392-7a6ee455c257	2025-06-19 10:37:23	2025-10-23 10:35:33
0f70061e-56bb-4f25-aced-5be814efbc5e	c2b93a8c-ea1e-4b85-8224-c209137135b0	depot	16532.00	143077.00	159609.00	FCFA	Virement bancaire entrant	\N	2025-10-10 11:54:11	2025-10-23 10:35:33
4deaf69c-96f4-4e5c-9861-0180322298f3	c2b93a8c-ea1e-4b85-8224-c209137135b0	retrait	2327.00	143077.00	140750.00	FCFA	Paiement par carte	\N	2025-09-14 03:24:13	2025-10-23 10:35:33
96029f87-61d1-4078-bc11-9e01ac26f7e8	a175ac58-1dc5-4041-b54b-19f48d3900a8	depot	17513.00	125328.00	142841.00	FCFA	Virement bancaire entrant	\N	2025-07-22 23:05:31	2025-10-23 10:35:33
3bbf221f-7dc6-4465-bc2f-e07cd0fc0021	a175ac58-1dc5-4041-b54b-19f48d3900a8	virement	13607.00	125328.00	111721.00	FCFA	Transfert bancaire	232f5785-5fd1-4398-91e2-4f92589e1d8d	2025-08-09 10:00:00	2025-10-23 10:35:33
21b02c0c-6781-4357-b202-8cbec47b8a18	a175ac58-1dc5-4041-b54b-19f48d3900a8	virement	29201.00	125328.00	96127.00	FCFA	Transfert entre comptes	473ba79b-f520-481d-82b7-0a94c75586be	2025-07-27 15:19:45	2025-10-23 10:35:33
8c2e593b-8ac1-469f-8cdd-08b4d75f7ce7	a175ac58-1dc5-4041-b54b-19f48d3900a8	depot	39084.00	125328.00	164412.00	FCFA	Versement salaire	\N	2025-10-15 21:24:05	2025-10-23 10:35:33
f0b222ef-b7a4-4b06-b19b-48b31191e9df	a175ac58-1dc5-4041-b54b-19f48d3900a8	virement	11066.00	125328.00	114262.00	FCFA	Transfert bancaire	f712d8d9-57b6-49a4-a8eb-5e04856619a9	2025-05-11 09:49:46	2025-10-23 10:35:33
f86f3102-0679-424d-9b50-8a04e1736ea6	a175ac58-1dc5-4041-b54b-19f48d3900a8	retrait	49906.00	125328.00	75422.00	FCFA	Retrait guichet	\N	2025-10-21 10:33:44	2025-10-23 10:35:33
85869375-672a-4df2-9abe-fbabc8ef99e5	a175ac58-1dc5-4041-b54b-19f48d3900a8	retrait	49465.00	125328.00	75863.00	FCFA	Paiement par carte	\N	2025-07-31 01:18:58	2025-10-23 10:35:33
cefcc91b-83d3-4288-ad61-616b3cb5affe	a175ac58-1dc5-4041-b54b-19f48d3900a8	retrait	47957.00	125328.00	77371.00	FCFA	Retrait guichet	\N	2025-05-11 13:56:20	2025-10-23 10:35:33
62070666-4c42-4b2e-9aea-8b7e7650b850	a175ac58-1dc5-4041-b54b-19f48d3900a8	virement	30575.00	125328.00	94753.00	FCFA	Paiement facture	a1f1990b-1819-4977-aaf0-bb14a824daa0	2025-09-09 16:59:03	2025-10-23 10:35:33
95e894c0-0996-448a-bf54-8acb7ff12bda	a175ac58-1dc5-4041-b54b-19f48d3900a8	depot	24284.00	125328.00	149612.00	FCFA	Dépôt d'espèces	\N	2025-05-17 03:35:09	2025-10-23 10:35:33
ba7b796f-d1a5-488c-93be-8250ff0a0906	a175ac58-1dc5-4041-b54b-19f48d3900a8	virement	40026.00	125328.00	85302.00	FCFA	Paiement facture	3406986a-f161-4a7a-80be-bcdf0e3f2214	2025-09-09 12:29:52	2025-10-23 10:35:33
e26ff62e-fb87-438e-b278-cbf731f9c11f	a175ac58-1dc5-4041-b54b-19f48d3900a8	depot	10522.00	125328.00	135850.00	FCFA	Virement bancaire entrant	\N	2025-06-26 01:49:41	2025-10-23 10:35:33
a1ba29d4-3357-4469-a4eb-785e9d68f195	a175ac58-1dc5-4041-b54b-19f48d3900a8	depot	26416.00	125328.00	151744.00	FCFA	Dépôt espèces guichet	\N	2025-09-22 18:34:36	2025-10-23 10:35:33
b748b8c2-63a7-4d00-bdbc-5e3a018d6f8a	9b7cf121-0b29-4457-b5ee-acddd651474c	virement	38674.00	475091.00	436417.00	FCFA	Paiement facture	9d8742db-9975-4f0a-aad4-23d2a22203cd	2025-07-22 00:48:37	2025-10-23 10:35:33
5b9504f5-26b6-44b6-9381-1d6f81d100f3	9b7cf121-0b29-4457-b5ee-acddd651474c	retrait	27344.00	475091.00	447747.00	FCFA	Retrait guichet	\N	2025-07-10 16:31:46	2025-10-23 10:35:33
8e3603b6-a56a-4fa7-bf35-71d4c9e1d484	9b7cf121-0b29-4457-b5ee-acddd651474c	virement	1155.00	475091.00	473936.00	FCFA	Transfert entre comptes	3014d690-a71d-4cb9-ba59-a6c4fea73558	2025-07-16 01:01:39	2025-10-23 10:35:33
f7c1fc1d-c7e3-492b-8d44-516101b4a942	9b7cf121-0b29-4457-b5ee-acddd651474c	retrait	47131.00	475091.00	427960.00	FCFA	Retrait d'espèces	\N	2025-10-06 12:11:18	2025-10-23 10:35:33
a07d1f05-a7bc-4554-a7b0-afb8daca0e64	9b7cf121-0b29-4457-b5ee-acddd651474c	virement	39975.00	475091.00	435116.00	FCFA	Paiement facture	2b138895-6391-4bfe-b137-ca4fa7854a4a	2025-10-22 06:58:40	2025-10-23 10:35:33
7560ed75-b9c3-4a5f-8c7f-ae09c88ebbdd	9b7cf121-0b29-4457-b5ee-acddd651474c	retrait	14764.00	475091.00	460327.00	FCFA	Retrait guichet	\N	2025-08-23 08:16:26	2025-10-23 10:35:33
fff98a95-2d4c-4675-adf6-11a009609c5b	9b7cf121-0b29-4457-b5ee-acddd651474c	virement	9686.00	475091.00	465405.00	FCFA	Paiement facture	93ec7354-821a-4306-8dcb-5b911268af75	2025-05-14 00:56:10	2025-10-23 10:35:33
6242b688-4e5b-4f75-b77a-b461d1c34be5	9b7cf121-0b29-4457-b5ee-acddd651474c	virement	42447.00	475091.00	432644.00	FCFA	Transfert entre comptes	1eece79a-3f27-456a-8f76-0b4de6cba5e4	2025-09-24 06:22:47	2025-10-23 10:35:33
f03c7cad-dd4a-434a-a760-8e048db9edc1	9b7cf121-0b29-4457-b5ee-acddd651474c	retrait	37559.00	475091.00	437532.00	FCFA	Retrait guichet	\N	2025-04-26 03:43:29	2025-10-23 10:35:33
379e8574-5da7-423e-af46-c8e4d0447f75	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	retrait	2578.00	83570.00	80992.00	FCFA	Paiement par carte	\N	2025-05-09 21:21:23	2025-10-23 10:35:33
3748fc62-f0b5-4e7b-8675-2271b718c294	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	virement	25274.00	83570.00	58296.00	FCFA	Transfert bancaire	b3c57074-cab3-490f-9d70-3da5066332f6	2025-06-20 17:19:55	2025-10-23 10:35:33
794439ae-9c31-43eb-af30-58976cbf23ee	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	virement	11237.00	83570.00	72333.00	FCFA	Transfert bancaire	7643d019-9210-424b-b768-667e79ca8da7	2025-09-14 01:44:48	2025-10-23 10:35:33
06c077c4-3433-4203-8081-437f57ee4c34	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	retrait	27676.00	83570.00	55894.00	FCFA	Retrait guichet	\N	2025-09-01 16:44:45	2025-10-23 10:35:33
f5cbec1a-a182-4d80-81d1-08c568af2c54	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	virement	1760.00	83570.00	81810.00	FCFA	Paiement facture	37da1638-f10a-4a03-9eb4-9eb960273866	2025-07-28 06:06:52	2025-10-23 10:35:33
6a68cc0e-479c-4916-8d23-1d0888ee6fd9	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	retrait	30674.00	83570.00	52896.00	FCFA	Paiement par carte	\N	2025-07-06 14:50:15	2025-10-23 10:35:33
71aed712-dfe4-4c32-b373-a2b28ebe164a	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	depot	11970.00	83570.00	95540.00	FCFA	Dépôt chèque	\N	2025-07-05 03:16:57	2025-10-23 10:35:33
2a253bf4-2f7b-4839-9f0b-f1a600940b96	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	retrait	27232.00	83570.00	56338.00	FCFA	Paiement par carte	\N	2025-06-10 15:10:14	2025-10-23 10:35:33
8bead969-3cf0-4fb8-ba2e-ca6323f90087	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	virement	25758.00	83570.00	57812.00	FCFA	Virement vers compte	3b545ec9-8048-4c12-a074-df603671d400	2025-09-12 04:09:35	2025-10-23 10:35:33
4e6a776e-2650-4b7a-aa00-1119c66a99e9	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	virement	13703.00	83570.00	69867.00	FCFA	Paiement facture	79f54c28-5af3-42a0-b025-afd541eb8dbf	2025-10-09 20:04:50	2025-10-23 10:35:33
cdada098-6184-4107-8788-8db9c1c4f268	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	retrait	4600.00	83570.00	78970.00	FCFA	Retrait DAB	\N	2025-07-02 06:33:01	2025-10-23 10:35:33
f9e67869-0a45-4421-9352-01acbc04a21d	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	depot	49328.00	83570.00	132898.00	FCFA	Dépôt chèque	\N	2025-07-25 17:15:48	2025-10-23 10:35:33
d2bb4e55-6ad3-44c4-93a9-a883b5b453a0	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	virement	32566.00	83570.00	51004.00	FCFA	Virement salaire	bf69dba7-7153-4b9d-885b-f7fa7330e249	2025-08-25 19:24:45	2025-10-23 10:35:33
ef5d68bc-8d71-4f3c-a2de-0339b44cfea9	727ed0a8-67ac-4066-84fe-a29a0e13bb30	virement	37738.00	70368.00	32630.00	FCFA	Virement salaire	968e30c7-1be0-4c05-98ba-5cb8d986a863	2025-07-09 03:28:30	2025-10-23 10:35:33
9aa79bb8-7f8a-4d01-aa1c-29bd2d5b8ac4	727ed0a8-67ac-4066-84fe-a29a0e13bb30	retrait	47332.00	70368.00	23036.00	FCFA	Prélèvement automatique	\N	2025-08-07 09:55:53	2025-10-23 10:35:33
65a7b3b9-1d86-45f9-abc1-0df007dbeb78	727ed0a8-67ac-4066-84fe-a29a0e13bb30	depot	37408.00	70368.00	107776.00	FCFA	Dépôt chèque	\N	2025-07-03 04:31:50	2025-10-23 10:35:33
298f93ed-52c4-4edc-a7d0-fbc4fee7a175	727ed0a8-67ac-4066-84fe-a29a0e13bb30	depot	7179.00	70368.00	77547.00	FCFA	Versement salaire	\N	2025-04-26 15:30:26	2025-10-23 10:35:33
f6fba4a1-f5dd-4292-a7cc-9f42470b040b	727ed0a8-67ac-4066-84fe-a29a0e13bb30	virement	28168.00	70368.00	42200.00	FCFA	Transfert entre comptes	cb45ecae-4f73-42b2-870b-4f41321c9acd	2025-10-11 12:52:49	2025-10-23 10:35:33
a83965da-c795-43af-b470-01bff2c16ef7	727ed0a8-67ac-4066-84fe-a29a0e13bb30	virement	44243.00	70368.00	26125.00	FCFA	Paiement facture	2afce742-17e9-45bc-99be-9389a26da3ca	2025-04-30 05:22:42	2025-10-23 10:35:33
36477156-3ea5-4002-8381-861dae835bb9	727ed0a8-67ac-4066-84fe-a29a0e13bb30	depot	3925.00	70368.00	74293.00	FCFA	Virement bancaire entrant	\N	2025-08-23 13:15:48	2025-10-23 10:35:33
bff98f8f-8b3a-45ab-8fb8-431696829bb8	727ed0a8-67ac-4066-84fe-a29a0e13bb30	retrait	47414.00	70368.00	22954.00	FCFA	Prélèvement automatique	\N	2025-07-24 10:55:05	2025-10-23 10:35:33
5d00e207-3c72-4d1b-97fd-7cb4e8db83eb	727ed0a8-67ac-4066-84fe-a29a0e13bb30	depot	15120.00	70368.00	85488.00	FCFA	Virement bancaire entrant	\N	2025-10-16 03:03:09	2025-10-23 10:35:33
df9bccab-cf73-4137-b78d-c81ca8b7c45d	727ed0a8-67ac-4066-84fe-a29a0e13bb30	retrait	3801.00	70368.00	66567.00	FCFA	Retrait DAB	\N	2025-07-09 12:02:25	2025-10-23 10:35:33
9a912574-fb98-4771-af55-364e6d6c3379	727ed0a8-67ac-4066-84fe-a29a0e13bb30	depot	19706.00	70368.00	90074.00	FCFA	Dépôt espèces guichet	\N	2025-09-13 21:45:25	2025-10-23 10:35:33
6773a918-b23d-4730-bcda-d34f8858d5df	727ed0a8-67ac-4066-84fe-a29a0e13bb30	depot	36443.00	70368.00	106811.00	FCFA	Dépôt d'espèces	\N	2025-06-11 00:37:11	2025-10-23 10:35:33
d930e98d-ea16-4f16-9820-2a266e98babd	727ed0a8-67ac-4066-84fe-a29a0e13bb30	virement	16176.00	70368.00	54192.00	FCFA	Paiement facture	a175ac58-1dc5-4041-b54b-19f48d3900a8	2025-10-08 00:37:08	2025-10-23 10:35:33
aadf43e1-b31f-46a9-a8f3-b8bc6ef4ed3f	b3c57074-cab3-490f-9d70-3da5066332f6	depot	17053.00	325326.00	342379.00	FCFA	Versement salaire	\N	2025-09-22 09:02:30	2025-10-23 10:35:33
3950bd21-318a-43d8-a36e-8022b4d3c1a3	b3c57074-cab3-490f-9d70-3da5066332f6	retrait	21493.00	325326.00	303833.00	FCFA	Retrait DAB	\N	2025-09-13 21:27:42	2025-10-23 10:35:33
a1aebbe6-912e-4d24-b0c0-a27644297911	b3c57074-cab3-490f-9d70-3da5066332f6	virement	19888.00	325326.00	305438.00	FCFA	Virement salaire	6c92b373-c286-44a2-94a3-cf8cf3479100	2025-05-29 11:30:35	2025-10-23 10:35:33
6a1c4372-fb52-42fc-9266-e93a7db53b64	b3c57074-cab3-490f-9d70-3da5066332f6	retrait	12080.00	325326.00	313246.00	FCFA	Retrait d'espèces	\N	2025-10-16 17:41:24	2025-10-23 10:35:33
cce0fcf7-7f33-44c4-a611-3f694eec161e	b3c57074-cab3-490f-9d70-3da5066332f6	retrait	14838.00	325326.00	310488.00	FCFA	Retrait d'espèces	\N	2025-08-06 18:36:18	2025-10-23 10:35:33
1d1a9ad6-54fc-4b19-80b1-e9771e7d1b8a	b3c57074-cab3-490f-9d70-3da5066332f6	depot	13155.00	325326.00	338481.00	FCFA	Dépôt espèces guichet	\N	2025-07-06 20:17:47	2025-10-23 10:35:33
1915e63e-bedb-46d0-ad0d-c233ff519493	b3c57074-cab3-490f-9d70-3da5066332f6	retrait	42551.00	325326.00	282775.00	FCFA	Prélèvement automatique	\N	2025-09-23 06:34:36	2025-10-23 10:35:33
dc1bc1c6-6676-4fff-b59d-32eb3a5c6fe8	b3c57074-cab3-490f-9d70-3da5066332f6	virement	45744.00	325326.00	279582.00	FCFA	Transfert bancaire	7643d019-9210-424b-b768-667e79ca8da7	2025-09-23 07:36:47	2025-10-23 10:35:33
4ce4e3e6-42d6-4a0c-be06-b356e81a225b	b3c57074-cab3-490f-9d70-3da5066332f6	virement	8013.00	325326.00	317313.00	FCFA	Transfert entre comptes	65da4070-27f5-40a7-99d9-db64e3163a65	2025-07-14 17:03:07	2025-10-23 10:35:33
8c1357d6-b040-463a-be8e-ecc53556aa15	5cd10916-6dee-48e6-ab78-7995b1f1ce95	depot	19122.00	100000.00	119122.00	FCFA	Dépôt chèque	\N	2025-08-02 03:18:58	2025-10-23 10:35:33
0a1feede-cca0-4a0e-be80-693bea1ec2f0	5cd10916-6dee-48e6-ab78-7995b1f1ce95	virement	10419.00	100000.00	89581.00	FCFA	Virement salaire	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	2025-08-20 05:41:59	2025-10-23 10:35:33
f4a05277-89e6-4508-9857-b88b9a5088a1	5cd10916-6dee-48e6-ab78-7995b1f1ce95	retrait	13989.00	100000.00	86011.00	FCFA	Paiement par carte	\N	2025-05-19 11:54:05	2025-10-23 10:35:33
4812ea0d-31fb-42ff-be54-dcf7120bdff5	5cd10916-6dee-48e6-ab78-7995b1f1ce95	virement	43398.00	100000.00	56602.00	FCFA	Transfert entre comptes	d0f4f273-6422-4408-950f-61e6f8d23373	2025-07-02 11:08:52	2025-10-23 10:35:33
36e63061-b8fd-4ed8-bcaa-04499c610314	5cd10916-6dee-48e6-ab78-7995b1f1ce95	virement	46274.00	100000.00	53726.00	FCFA	Transfert bancaire	54d5e886-a7a4-4427-b256-7723400f3c4e	2025-09-17 21:25:19	2025-10-23 10:35:33
9ef83e9d-d4d5-45d5-9faf-cbf1c76ed86e	5cd10916-6dee-48e6-ab78-7995b1f1ce95	retrait	1165.00	100000.00	98835.00	FCFA	Retrait d'espèces	\N	2025-08-24 20:12:15	2025-10-23 10:35:33
d4dc06d5-b4e6-4513-ad35-b9103f233279	5cd10916-6dee-48e6-ab78-7995b1f1ce95	retrait	6571.00	100000.00	93429.00	FCFA	Retrait guichet	\N	2025-07-22 01:37:30	2025-10-23 10:35:33
089542fa-6618-4250-addd-c2fce86e4983	2b138895-6391-4bfe-b137-ca4fa7854a4a	depot	18473.00	10000.00	28473.00	FCFA	Versement salaire	\N	2025-09-26 08:55:59	2025-10-23 10:35:33
446ca4f1-a048-472d-885c-b344a9220805	2b138895-6391-4bfe-b137-ca4fa7854a4a	retrait	1523.00	10000.00	8477.00	FCFA	Retrait d'espèces	\N	2025-07-11 21:04:11	2025-10-23 10:35:34
f139e58f-14dd-4c90-9174-f08db354d64e	2b138895-6391-4bfe-b137-ca4fa7854a4a	depot	14123.00	10000.00	24123.00	FCFA	Versement salaire	\N	2025-07-10 19:41:00	2025-10-23 10:35:34
697e12bf-17d4-4d1b-911a-dfafc33f0579	2b138895-6391-4bfe-b137-ca4fa7854a4a	retrait	10995.00	10000.00	0.00	FCFA	Retrait d'espèces	\N	2025-10-11 08:54:43	2025-10-23 10:35:34
f27425eb-701e-4a56-b44f-a8875c4e17fa	2b138895-6391-4bfe-b137-ca4fa7854a4a	retrait	32068.00	10000.00	0.00	FCFA	Retrait d'espèces	\N	2025-07-30 17:23:10	2025-10-23 10:35:34
c05b6375-af51-49ed-8827-f047af566d13	2b138895-6391-4bfe-b137-ca4fa7854a4a	retrait	41710.00	10000.00	0.00	FCFA	Retrait guichet	\N	2025-07-05 07:06:47	2025-10-23 10:35:34
e0059fb6-0204-4739-9fde-aaa106153904	2b138895-6391-4bfe-b137-ca4fa7854a4a	depot	35582.00	10000.00	45582.00	FCFA	Dépôt espèces guichet	\N	2025-09-08 15:46:49	2025-10-23 10:35:34
81ce48c7-54c0-4844-8e6a-2d937b6deaaf	2b138895-6391-4bfe-b137-ca4fa7854a4a	virement	12409.00	10000.00	0.00	FCFA	Paiement facture	d2a1ed80-e126-493f-b155-2923909ae924	2025-05-13 19:18:35	2025-10-23 10:35:34
8e0c827e-9f5e-4ee5-be0b-945567d1c17b	2b138895-6391-4bfe-b137-ca4fa7854a4a	virement	19458.00	10000.00	0.00	FCFA	Paiement facture	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	2025-10-22 00:28:00	2025-10-23 10:35:34
bce9ebf6-5de0-40b3-9848-b94359e5f8f7	2b138895-6391-4bfe-b137-ca4fa7854a4a	depot	32483.00	10000.00	42483.00	FCFA	Dépôt d'espèces	\N	2025-08-09 13:06:16	2025-10-23 10:35:34
f6cab4d2-bef2-45e3-a63a-8b068b2b2e9a	2b138895-6391-4bfe-b137-ca4fa7854a4a	retrait	17254.00	10000.00	0.00	FCFA	Retrait DAB	\N	2025-08-06 02:21:28	2025-10-23 10:35:34
54dd9e52-d827-424b-bfc0-6ab4d9e4bd17	2b138895-6391-4bfe-b137-ca4fa7854a4a	retrait	36741.00	10000.00	0.00	FCFA	Retrait guichet	\N	2025-09-18 21:58:53	2025-10-23 10:35:34
2b80cfef-ed7d-4778-abd2-d647334a9b44	2b138895-6391-4bfe-b137-ca4fa7854a4a	depot	35446.00	10000.00	45446.00	FCFA	Virement bancaire entrant	\N	2025-06-23 09:33:46	2025-10-23 10:35:34
3af8bf54-8443-4b76-8363-1284f25fba89	2b138895-6391-4bfe-b137-ca4fa7854a4a	retrait	11870.00	10000.00	0.00	FCFA	Prélèvement automatique	\N	2025-08-02 17:37:15	2025-10-23 10:35:34
e3148b74-7ae1-4cac-9dd2-7969b3a56e7f	3014d690-a71d-4cb9-ba59-a6c4fea73558	retrait	11836.00	25000.00	13164.00	FCFA	Retrait d'espèces	\N	2025-09-17 10:29:39	2025-10-23 10:35:34
265ef993-eb81-40cf-83d1-da6b2c1f1e57	3014d690-a71d-4cb9-ba59-a6c4fea73558	retrait	33368.00	25000.00	0.00	FCFA	Retrait d'espèces	\N	2025-08-18 20:35:58	2025-10-23 10:35:34
35bdbbb0-6c87-4a4c-8721-bd82160735bc	3014d690-a71d-4cb9-ba59-a6c4fea73558	retrait	14451.00	25000.00	10549.00	FCFA	Prélèvement automatique	\N	2025-06-07 08:17:21	2025-10-23 10:35:34
537cd1dd-d125-4610-ac48-bf4f1d5a1f9b	3014d690-a71d-4cb9-ba59-a6c4fea73558	depot	36940.00	25000.00	61940.00	FCFA	Versement salaire	\N	2025-08-18 21:12:32	2025-10-23 10:35:34
2939b7f9-6dbb-4fff-a74d-0e906d7017a3	3014d690-a71d-4cb9-ba59-a6c4fea73558	virement	15057.00	25000.00	9943.00	FCFA	Paiement facture	f712d8d9-57b6-49a4-a8eb-5e04856619a9	2025-09-21 14:23:23	2025-10-23 10:35:34
c96cd81f-7196-415a-a9c9-32239896d0b5	3014d690-a71d-4cb9-ba59-a6c4fea73558	depot	39409.00	25000.00	64409.00	FCFA	Dépôt d'espèces	\N	2025-05-17 07:19:51	2025-10-23 10:35:34
31cf7f50-b8fd-4abc-9a66-247091d70fe5	3014d690-a71d-4cb9-ba59-a6c4fea73558	depot	37211.00	25000.00	62211.00	FCFA	Dépôt chèque	\N	2025-10-03 20:57:10	2025-10-23 10:35:34
39b1d294-a7e0-42fd-9639-46f2d657a3cf	add2482a-de00-41d8-a772-cd4ef6546baa	depot	34867.00	201835.00	236702.00	FCFA	Dépôt d'espèces	\N	2025-05-02 16:51:37	2025-10-23 12:36:57
631e5276-6f48-48d3-a20d-659d365e4c49	add2482a-de00-41d8-a772-cd4ef6546baa	virement	3987.00	201835.00	197848.00	FCFA	Paiement facture	792c8ff4-749b-469b-95d0-9b98c2283684	2025-06-27 00:08:22	2025-10-23 12:36:57
6d977cef-aed1-481f-99ba-ffc1e8db982a	add2482a-de00-41d8-a772-cd4ef6546baa	retrait	27258.00	201835.00	174577.00	FCFA	Retrait guichet	\N	2025-08-14 14:09:26	2025-10-23 12:36:57
902cba0a-506c-4075-a451-16171ad56ad0	add2482a-de00-41d8-a772-cd4ef6546baa	retrait	7784.00	201835.00	194051.00	FCFA	Prélèvement automatique	\N	2025-09-23 16:08:58	2025-10-23 12:36:57
0032abdb-9952-4d15-ab84-4f54c6470dea	add2482a-de00-41d8-a772-cd4ef6546baa	depot	49697.00	201835.00	251532.00	FCFA	Versement salaire	\N	2025-08-29 00:20:50	2025-10-23 12:36:57
427ff5d3-852a-4630-bb2a-c85dfda29415	add2482a-de00-41d8-a772-cd4ef6546baa	retrait	49183.00	201835.00	152652.00	FCFA	Retrait d'espèces	\N	2025-06-28 21:25:57	2025-10-23 12:36:57
cddfcd02-054b-446a-a925-6ddfc42f8671	add2482a-de00-41d8-a772-cd4ef6546baa	depot	1310.00	201835.00	203145.00	FCFA	Virement bancaire entrant	\N	2025-07-23 03:52:54	2025-10-23 12:36:57
75bd9bf6-90fe-416f-baee-b1d241f4874a	add2482a-de00-41d8-a772-cd4ef6546baa	virement	20659.00	201835.00	181176.00	FCFA	Virement vers compte	916bbfef-cee4-457b-a001-da8e5b0be63d	2025-07-02 23:17:35	2025-10-23 12:36:57
51761883-d007-40bd-9f3e-0142a1b524c4	add2482a-de00-41d8-a772-cd4ef6546baa	virement	16696.00	201835.00	185139.00	FCFA	Virement vers compte	12a1bcc9-6ded-4708-8db3-3ebeb5632e08	2025-08-01 16:15:03	2025-10-23 12:36:57
882c2335-52f5-411e-a32c-4336d51f5f38	add2482a-de00-41d8-a772-cd4ef6546baa	virement	4940.00	201835.00	196895.00	FCFA	Transfert bancaire	af23b369-6d2d-416a-9f80-93ac47b6dde3	2025-10-01 18:26:07	2025-10-23 12:36:57
90e4fa5a-c447-4360-a48b-1247ee4f84d0	37da1638-f10a-4a03-9eb4-9eb960273866	retrait	33774.00	26944.00	0.00	FCFA	Retrait guichet	\N	2025-10-13 19:16:48	2025-10-23 12:36:57
0ec90ade-f327-438b-944b-092337692ec7	37da1638-f10a-4a03-9eb4-9eb960273866	retrait	10060.00	26944.00	16884.00	FCFA	Retrait DAB	\N	2025-07-05 01:06:08	2025-10-23 12:36:57
01bfb9ef-422b-45e1-b74d-f529a163ee85	37da1638-f10a-4a03-9eb4-9eb960273866	depot	20110.00	26944.00	47054.00	FCFA	Dépôt espèces guichet	\N	2025-05-25 12:28:05	2025-10-23 12:36:57
e9555a1a-e4aa-4941-8981-ae0172cd6e98	37da1638-f10a-4a03-9eb4-9eb960273866	depot	17986.00	26944.00	44930.00	FCFA	Dépôt espèces guichet	\N	2025-08-20 13:32:59	2025-10-23 12:36:57
0a6e99fc-0e74-41a0-b374-bce798422165	37da1638-f10a-4a03-9eb4-9eb960273866	depot	14888.00	26944.00	41832.00	FCFA	Virement bancaire entrant	\N	2025-06-04 12:55:15	2025-10-23 12:36:57
ab05ae88-e981-4237-9c4c-97489b9bad0c	37da1638-f10a-4a03-9eb4-9eb960273866	virement	45337.00	26944.00	0.00	FCFA	Virement salaire	43df68e0-310b-41d1-b272-3e281b325b72	2025-06-12 20:31:32	2025-10-23 12:36:57
89cd261a-aef5-420f-968d-f85c602ad608	37da1638-f10a-4a03-9eb4-9eb960273866	depot	29618.00	26944.00	56562.00	FCFA	Versement salaire	\N	2025-04-27 15:48:41	2025-10-23 12:36:57
4be2efc8-9135-4ae7-825b-bd37a7521de6	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	retrait	10832.00	215784.00	204952.00	FCFA	Paiement par carte	\N	2025-05-03 04:25:18	2025-10-23 12:36:57
ae3110f6-35ac-4ec7-afd2-c187abae38a9	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	virement	6748.00	215784.00	209036.00	FCFA	Virement salaire	b03a8338-5679-4ed1-9ba5-d4a4cf3ff31d	2025-09-29 17:33:06	2025-10-23 12:36:57
83d34eee-2276-4606-9875-48235ea01042	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	depot	15341.00	215784.00	231125.00	FCFA	Dépôt chèque	\N	2025-09-22 23:43:16	2025-10-23 12:36:57
37ef81ff-c8ee-4051-a0f1-cfe9c23ca2c4	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	retrait	17401.00	215784.00	198383.00	FCFA	Retrait guichet	\N	2025-08-29 09:40:52	2025-10-23 12:36:57
8e457146-12ab-4e54-961e-db3cd80b4e5e	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	depot	40029.00	215784.00	255813.00	FCFA	Dépôt espèces guichet	\N	2025-09-01 08:11:49	2025-10-23 12:36:57
2d09b2fc-1c30-4544-813e-5e1809f3374b	916bbfef-cee4-457b-a001-da8e5b0be63d	depot	23283.00	185746.00	209029.00	FCFA	Dépôt chèque	\N	2025-08-22 07:49:14	2025-10-23 12:36:57
f64a00d9-9cc9-4cec-b9b8-9bd7bad0d80b	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	retrait	44234.00	215784.00	171550.00	FCFA	Prélèvement automatique	\N	2025-10-12 10:41:49	2025-10-23 12:36:57
1436ad18-d21d-4e2f-bc76-4e0b41fa67c3	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	virement	42560.00	215784.00	173224.00	FCFA	Virement salaire	4339b8f2-e315-454a-b86f-e35bde749370	2025-07-27 16:51:44	2025-10-23 12:36:57
f8cf197c-3849-437b-8143-83c46dd34473	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	depot	12948.00	215784.00	228732.00	FCFA	Dépôt chèque	\N	2025-08-03 01:22:08	2025-10-23 12:36:57
e9f7b9d6-afff-4722-8703-bb8d42412d63	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	depot	19906.00	215784.00	235690.00	FCFA	Virement bancaire entrant	\N	2025-05-07 12:55:04	2025-10-23 12:36:57
a14e1a5a-69ca-42e8-9bb8-ed809048d0a0	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	virement	42923.00	215784.00	172861.00	FCFA	Transfert bancaire	7643d019-9210-424b-b768-667e79ca8da7	2025-06-03 22:06:53	2025-10-23 12:36:57
93199a0e-c80a-41f9-b3d9-6c40f0f1a141	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	depot	36653.00	215784.00	252437.00	FCFA	Virement bancaire entrant	\N	2025-06-14 02:21:46	2025-10-23 12:36:57
58d84c2b-ac01-4eae-92ae-985ee5946739	0006e5f7-4df5-46a5-8f9e-90089c5ea052	retrait	33313.00	65792.00	32479.00	FCFA	Retrait DAB	\N	2025-06-23 23:16:08	2025-10-23 12:36:57
19aa9971-b0a2-43bc-b037-400419709549	0006e5f7-4df5-46a5-8f9e-90089c5ea052	depot	37539.00	65792.00	103331.00	FCFA	Dépôt chèque	\N	2025-09-02 07:32:52	2025-10-23 12:36:57
488a701f-6a59-4d04-ba42-aa59bd78e48f	0006e5f7-4df5-46a5-8f9e-90089c5ea052	retrait	36441.00	65792.00	29351.00	FCFA	Prélèvement automatique	\N	2025-07-30 05:44:54	2025-10-23 12:36:57
ba820a1f-a46b-4405-8a80-4712d193a99c	0006e5f7-4df5-46a5-8f9e-90089c5ea052	retrait	36169.00	65792.00	29623.00	FCFA	Retrait d'espèces	\N	2025-10-17 01:01:16	2025-10-23 12:36:57
ce1a1369-bc1b-44f0-9419-278aea5fbb4c	0006e5f7-4df5-46a5-8f9e-90089c5ea052	depot	45824.00	65792.00	111616.00	FCFA	Dépôt d'espèces	\N	2025-10-21 22:44:22	2025-10-23 12:36:57
27fdff05-5679-4ff5-9407-ebd2d9dff8fe	0006e5f7-4df5-46a5-8f9e-90089c5ea052	depot	29470.00	65792.00	95262.00	FCFA	Dépôt d'espèces	\N	2025-08-27 18:05:30	2025-10-23 12:36:57
88eb7fa9-f57e-4173-b58a-c442a1a34a6b	e774b1e8-095f-4684-a770-c420e32f477a	virement	17203.00	126373.00	109170.00	FCFA	Paiement facture	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	2025-06-10 23:36:17	2025-10-23 12:36:57
95bcffb5-a706-4252-9027-96f5f7a7019d	e774b1e8-095f-4684-a770-c420e32f477a	retrait	25737.00	126373.00	100636.00	FCFA	Prélèvement automatique	\N	2025-08-13 03:14:50	2025-10-23 12:36:57
d849f6cb-66ff-4bc7-94df-9ce8c0c2e5d9	e774b1e8-095f-4684-a770-c420e32f477a	virement	12016.00	126373.00	114357.00	FCFA	Transfert bancaire	39ca01df-9037-4f1b-962a-164c3db984f0	2025-07-06 06:00:43	2025-10-23 12:36:57
7c9c5da5-fa9e-4315-b8d8-dedf74cc35c7	e774b1e8-095f-4684-a770-c420e32f477a	retrait	32155.00	126373.00	94218.00	FCFA	Prélèvement automatique	\N	2025-05-13 10:20:10	2025-10-23 12:36:57
26c22702-1ce1-4fd7-b8b2-43c61eb40be6	e774b1e8-095f-4684-a770-c420e32f477a	virement	16576.00	126373.00	109797.00	FCFA	Paiement facture	f2182e94-c5d0-4b91-8d12-af97e101dd6b	2025-10-08 14:28:18	2025-10-23 12:36:57
880dcd48-941b-472d-83b5-e309f6d50408	e774b1e8-095f-4684-a770-c420e32f477a	retrait	28670.00	126373.00	97703.00	FCFA	Prélèvement automatique	\N	2025-05-23 05:17:50	2025-10-23 12:36:57
f50ac909-e5d9-4b7b-84ec-3c6b8246d2e4	e774b1e8-095f-4684-a770-c420e32f477a	virement	19338.00	126373.00	107035.00	FCFA	Virement vers compte	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	2025-06-26 02:21:21	2025-10-23 12:36:57
4b0729ca-3cfd-45ab-b1eb-92c9fdec3c5b	e774b1e8-095f-4684-a770-c420e32f477a	depot	41964.00	126373.00	168337.00	FCFA	Dépôt espèces guichet	\N	2025-05-31 17:22:41	2025-10-23 12:36:57
80d1a1bf-d4fb-4aa4-8faa-f85a4b95a16a	e774b1e8-095f-4684-a770-c420e32f477a	virement	19782.00	126373.00	106591.00	FCFA	Paiement facture	f1e6f840-61c7-4618-bbfd-578d06a2431f	2025-10-22 06:20:03	2025-10-23 12:36:57
51952446-f6b1-4265-bf20-282d333c6d0d	e774b1e8-095f-4684-a770-c420e32f477a	virement	31717.00	126373.00	94656.00	FCFA	Paiement facture	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	2025-09-18 15:31:25	2025-10-23 12:36:57
ee1294ec-19a0-442c-8867-36ff9de04aea	e774b1e8-095f-4684-a770-c420e32f477a	depot	32100.00	126373.00	158473.00	FCFA	Virement bancaire entrant	\N	2025-06-26 20:09:47	2025-10-23 12:36:57
a9573cd4-139d-47ec-91fd-2b690d785b44	e774b1e8-095f-4684-a770-c420e32f477a	virement	15197.00	126373.00	111176.00	FCFA	Virement salaire	0c099b4c-0616-44d6-af7a-38ed712edbf0	2025-07-27 07:42:08	2025-10-23 12:36:57
1026780b-6698-4cfe-841c-c3e0e783b97c	e774b1e8-095f-4684-a770-c420e32f477a	retrait	43897.00	126373.00	82476.00	FCFA	Retrait d'espèces	\N	2025-05-03 06:29:20	2025-10-23 12:36:57
7ae52c53-ab71-468d-889b-fcd069d518b4	8a4ca722-53cc-428f-a83a-d84a7f681abf	depot	19669.00	447100.00	466769.00	FCFA	Dépôt chèque	\N	2025-05-13 12:29:16	2025-10-23 12:36:57
897c6308-3210-4ebc-a648-1d2b64c7cd14	8a4ca722-53cc-428f-a83a-d84a7f681abf	virement	9156.00	447100.00	437944.00	FCFA	Paiement facture	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	2025-08-13 03:22:56	2025-10-23 12:36:57
00afddc8-91ca-435d-aa73-84df63a93247	8a4ca722-53cc-428f-a83a-d84a7f681abf	depot	38701.00	447100.00	485801.00	FCFA	Dépôt chèque	\N	2025-05-25 09:10:18	2025-10-23 12:36:57
1a2d4da8-b5ba-4975-8a94-436522efe2bc	8a4ca722-53cc-428f-a83a-d84a7f681abf	virement	15018.00	447100.00	432082.00	FCFA	Virement salaire	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	2025-09-29 03:26:39	2025-10-23 12:36:57
26903a56-1ada-4db5-90f0-b50d1fdf26a9	8a4ca722-53cc-428f-a83a-d84a7f681abf	depot	46816.00	447100.00	493916.00	FCFA	Versement salaire	\N	2025-09-15 23:20:11	2025-10-23 12:36:57
5740ab2b-1b3c-4563-b4dd-c3aefef0c174	8a4ca722-53cc-428f-a83a-d84a7f681abf	retrait	42388.00	447100.00	404712.00	FCFA	Retrait d'espèces	\N	2025-08-26 08:04:43	2025-10-23 12:36:57
c944f63c-b468-4091-8a66-8408b7536c9c	8a4ca722-53cc-428f-a83a-d84a7f681abf	depot	3066.00	447100.00	450166.00	FCFA	Dépôt espèces guichet	\N	2025-09-24 12:56:05	2025-10-23 12:36:57
2f8ea35c-b5ad-4b12-8dbc-26a73ce513a1	6131421b-d7d7-4f56-8450-582c37486f68	depot	5827.00	348073.00	353900.00	FCFA	Dépôt chèque	\N	2025-07-14 12:30:24	2025-10-23 12:36:57
31bd997a-14b7-431b-9aff-95f03629d75d	6131421b-d7d7-4f56-8450-582c37486f68	depot	47762.00	348073.00	395835.00	FCFA	Dépôt d'espèces	\N	2025-07-31 08:57:36	2025-10-23 12:36:57
4f914fba-b8b7-436b-8540-c4d6409f45a1	6131421b-d7d7-4f56-8450-582c37486f68	retrait	45115.00	348073.00	302958.00	FCFA	Retrait d'espèces	\N	2025-04-30 00:31:35	2025-10-23 12:36:57
6583cbbd-cf4e-4940-be9c-d76a288c3e0f	6131421b-d7d7-4f56-8450-582c37486f68	virement	9167.00	348073.00	338906.00	FCFA	Paiement facture	b26e640d-87a1-49a8-a880-2a2088a4fca0	2025-06-04 17:39:53	2025-10-23 12:36:57
4555f5d7-6ae7-48b0-b861-b41c914d1a29	6131421b-d7d7-4f56-8450-582c37486f68	depot	15952.00	348073.00	364025.00	FCFA	Dépôt chèque	\N	2025-06-24 00:10:56	2025-10-23 12:36:57
9bc4b092-8cd6-4178-b3be-11863fbf13da	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	virement	19284.00	310752.00	291468.00	FCFA	Transfert entre comptes	087d0d47-8377-4f2f-82a8-6acbc6e148f1	2025-09-21 21:04:23	2025-10-23 12:36:57
fd8a4130-f36d-437e-9435-6f6c2b4f1380	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	depot	28283.00	310752.00	339035.00	FCFA	Virement bancaire entrant	\N	2025-07-16 00:33:09	2025-10-23 12:36:57
b391ce58-8607-4d69-a912-1c8f4bf2a291	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	virement	9974.00	310752.00	300778.00	FCFA	Transfert bancaire	1a2a915d-173c-44e7-a655-e29b9a02fd18	2025-10-02 04:47:45	2025-10-23 12:36:57
1743f603-2cad-4e0d-9d1c-c54a255d2b68	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	depot	46134.00	310752.00	356886.00	FCFA	Dépôt espèces guichet	\N	2025-06-27 03:28:02	2025-10-23 12:36:57
ce4d8a1e-4886-44aa-9a5f-a8a073cccab9	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	retrait	40457.00	310752.00	270295.00	FCFA	Paiement par carte	\N	2025-09-13 02:51:26	2025-10-23 12:36:57
d0afe8a7-e127-4a06-ac98-2c5cff55b9f2	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	depot	11039.00	310752.00	321791.00	FCFA	Virement bancaire entrant	\N	2025-08-17 12:51:48	2025-10-23 12:36:57
fe635b0d-a713-4f3e-8a13-5eb0c8f553dd	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	retrait	43992.00	310752.00	266760.00	FCFA	Retrait d'espèces	\N	2025-07-05 14:51:15	2025-10-23 12:36:57
7219a348-c66c-4cef-a2ef-6fdab4930a19	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	virement	44736.00	310752.00	266016.00	FCFA	Paiement facture	24e04f46-72df-4b0e-9024-19c114c552aa	2025-05-14 23:18:04	2025-10-23 12:36:57
e05a0926-6beb-4f6d-87fa-9f894d035302	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	virement	23413.00	310752.00	287339.00	FCFA	Paiement facture	e88eac49-5c57-48f8-824a-813a7da0fdc3	2025-06-16 01:45:53	2025-10-23 12:36:57
92c02fc0-07e6-4be7-bfdb-bb16f53dc544	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	retrait	1893.00	310752.00	308859.00	FCFA	Prélèvement automatique	\N	2025-09-20 18:27:21	2025-10-23 12:36:57
a37cedff-bf11-4352-9cd2-8169558f0e64	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	virement	23028.00	310752.00	287724.00	FCFA	Transfert bancaire	e4d1caea-baee-4c55-aa8d-8208a299a3f7	2025-08-18 14:56:11	2025-10-23 12:36:57
ec6f81cc-1dc9-42ba-a384-0c621d9339a0	64203f77-d74d-4752-9e2b-7a1c40547be9	retrait	8374.00	489151.00	480777.00	FCFA	Retrait d'espèces	\N	2025-06-21 19:23:21	2025-10-23 12:36:57
9ab2a22b-a3a9-4af4-9f10-4cf834e318fc	64203f77-d74d-4752-9e2b-7a1c40547be9	retrait	27255.00	489151.00	461896.00	FCFA	Retrait DAB	\N	2025-09-01 03:42:02	2025-10-23 12:36:57
59360580-6b8f-4687-899a-ead41d2f3db4	64203f77-d74d-4752-9e2b-7a1c40547be9	virement	24985.00	489151.00	464166.00	FCFA	Transfert entre comptes	d2a1ed80-e126-493f-b155-2923909ae924	2025-06-22 09:17:42	2025-10-23 12:36:57
ea2d84aa-42f9-41ee-b0af-5ecbcbd67d24	64203f77-d74d-4752-9e2b-7a1c40547be9	depot	28832.00	489151.00	517983.00	FCFA	Virement bancaire entrant	\N	2025-05-16 15:47:31	2025-10-23 12:36:57
9b352241-1026-4e17-85c3-daf36a147946	64203f77-d74d-4752-9e2b-7a1c40547be9	virement	14666.00	489151.00	474485.00	FCFA	Transfert entre comptes	add2482a-de00-41d8-a772-cd4ef6546baa	2025-06-29 10:32:31	2025-10-23 12:36:57
02aba8f9-086e-4113-8163-ea3efcc58145	64203f77-d74d-4752-9e2b-7a1c40547be9	depot	20719.00	489151.00	509870.00	FCFA	Dépôt chèque	\N	2025-05-02 00:31:47	2025-10-23 12:36:57
8ec11d03-11c2-47af-9d37-ee35d5860022	64203f77-d74d-4752-9e2b-7a1c40547be9	virement	11943.00	489151.00	477208.00	FCFA	Virement salaire	8af34d52-0c28-48ed-ae2d-87e52f97806a	2025-05-16 21:04:03	2025-10-23 12:36:57
a2d6ea5d-c03f-46a5-a33e-e20aa88b5d92	64203f77-d74d-4752-9e2b-7a1c40547be9	retrait	40243.00	489151.00	448908.00	FCFA	Retrait d'espèces	\N	2025-04-27 08:15:07	2025-10-23 12:36:57
5b7c0cc8-8ad8-4088-a0fa-d65f02a3a86d	64203f77-d74d-4752-9e2b-7a1c40547be9	depot	20086.00	489151.00	509237.00	FCFA	Dépôt d'espèces	\N	2025-06-29 11:45:32	2025-10-23 12:36:57
12d6f347-c584-4cd0-9d10-e49eca02c2a8	64203f77-d74d-4752-9e2b-7a1c40547be9	retrait	8236.00	489151.00	480915.00	FCFA	Retrait DAB	\N	2025-07-23 09:49:28	2025-10-23 12:36:57
a5d9a74c-d457-4c48-89f6-d2585b4128d3	64203f77-d74d-4752-9e2b-7a1c40547be9	retrait	7504.00	489151.00	481647.00	FCFA	Retrait DAB	\N	2025-09-06 20:09:51	2025-10-23 12:36:57
6b3927ed-374b-4a14-b294-5d82eaa22cb3	64203f77-d74d-4752-9e2b-7a1c40547be9	virement	30956.00	489151.00	458195.00	FCFA	Virement salaire	e88eac49-5c57-48f8-824a-813a7da0fdc3	2025-04-30 15:00:53	2025-10-23 12:36:57
614029e9-7192-45a6-8d8b-3f5c7df5160f	e4ad8455-8e84-4a67-873f-6392338ba743	depot	39470.00	268.00	39738.00	FCFA	Dépôt d'espèces	\N	2025-08-30 16:42:57	2025-10-23 12:36:57
4e7e1567-8ede-4420-8d80-8811b8545558	e4ad8455-8e84-4a67-873f-6392338ba743	virement	20193.00	268.00	0.00	FCFA	Paiement facture	43df68e0-310b-41d1-b272-3e281b325b72	2025-10-17 07:19:17	2025-10-23 12:36:57
238a2588-f6b8-43b2-a1a7-17d3436e5fc7	e4ad8455-8e84-4a67-873f-6392338ba743	depot	46731.00	268.00	46999.00	FCFA	Dépôt chèque	\N	2025-06-03 13:41:29	2025-10-23 12:36:57
ca83d3ae-f475-4319-8df8-f9e89e7caa6a	e4ad8455-8e84-4a67-873f-6392338ba743	virement	9900.00	268.00	0.00	FCFA	Paiement facture	93ec7354-821a-4306-8dcb-5b911268af75	2025-07-07 10:45:49	2025-10-23 12:36:57
51d02226-aefb-4837-9210-7bc96924aa1e	e4ad8455-8e84-4a67-873f-6392338ba743	virement	14494.00	268.00	0.00	FCFA	Transfert bancaire	ce34889a-7b15-48e8-9003-f1522cf517f8	2025-09-16 10:05:09	2025-10-23 12:36:57
ccab0efb-b0e7-4da1-a887-fe562e82636e	e4ad8455-8e84-4a67-873f-6392338ba743	retrait	13473.00	268.00	0.00	FCFA	Retrait DAB	\N	2025-07-06 03:17:21	2025-10-23 12:36:57
87d84906-ba0c-4c0f-9dee-10c13b16f32a	e4ad8455-8e84-4a67-873f-6392338ba743	virement	35162.00	268.00	0.00	FCFA	Virement vers compte	808e915e-a5d8-4751-aaa8-50fe040cde68	2025-09-15 18:14:41	2025-10-23 12:36:57
d06fe3e0-0211-4abb-a563-fcb63ebb7d9e	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	depot	35457.00	482848.00	518305.00	FCFA	Dépôt d'espèces	\N	2025-06-26 15:06:16	2025-10-23 12:36:57
a7aa5f04-9976-4b66-aee6-5bd06b0eee0a	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	retrait	1126.00	482848.00	481722.00	FCFA	Prélèvement automatique	\N	2025-07-07 17:06:46	2025-10-23 12:36:57
6482f073-39bf-43ac-9b05-8674cf2de799	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	depot	30223.00	482848.00	513071.00	FCFA	Dépôt espèces guichet	\N	2025-10-05 19:12:55	2025-10-23 12:36:57
716d9114-4a11-4858-a427-71bd3457b4ef	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	retrait	36762.00	482848.00	446086.00	FCFA	Prélèvement automatique	\N	2025-08-18 23:18:24	2025-10-23 12:36:57
f2a4bba9-5143-4fa9-a066-e6d49659a99a	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	retrait	48075.00	482848.00	434773.00	FCFA	Retrait d'espèces	\N	2025-10-17 19:58:57	2025-10-23 12:36:57
235f1ee6-9d71-4b57-95db-6ab29cd461bc	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	virement	3114.00	482848.00	479734.00	FCFA	Transfert bancaire	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	2025-10-10 11:42:41	2025-10-23 12:36:57
122a840c-189e-4c20-9957-a560cc6b6e24	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	depot	37555.00	482848.00	520403.00	FCFA	Dépôt chèque	\N	2025-07-21 16:20:44	2025-10-23 12:36:57
4bfedddf-a26a-4c53-a069-c61d25746fa9	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	depot	15048.00	482848.00	497896.00	FCFA	Dépôt chèque	\N	2025-06-13 04:38:30	2025-10-23 12:36:57
da22482c-fe0b-4f6e-9a50-a6a5ffec595c	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	virement	48622.00	482848.00	434226.00	FCFA	Virement salaire	39ca01df-9037-4f1b-962a-164c3db984f0	2025-06-06 20:57:30	2025-10-23 12:36:57
6d9ec26c-fe41-49ce-aa0f-3f4f2a2458af	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	depot	43556.00	482848.00	526404.00	FCFA	Dépôt chèque	\N	2025-10-12 23:38:09	2025-10-23 12:36:57
c007ac98-1171-4b97-ab77-3378936aa96f	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	retrait	11321.00	482848.00	471527.00	FCFA	Retrait d'espèces	\N	2025-09-29 00:03:11	2025-10-23 12:36:57
b35a0d06-8310-4b19-bd1e-a5ba28a0b635	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	virement	30142.00	482848.00	452706.00	FCFA	Virement salaire	184d6244-4107-464d-9848-8140c6174183	2025-09-16 06:25:39	2025-10-23 12:36:57
fc997d02-3dcb-4446-afb8-a3e389005363	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	depot	20167.00	482848.00	503015.00	FCFA	Dépôt espèces guichet	\N	2025-04-25 15:19:24	2025-10-23 12:36:57
c1c19d64-f87c-460e-807d-e0155dc2f94d	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	virement	12665.00	482848.00	470183.00	FCFA	Transfert entre comptes	f959068a-63bd-46ee-a42c-59d124c48cf6	2025-05-24 00:50:18	2025-10-23 12:36:57
fa4f6387-3ff9-4bb4-8b01-edcab17707fd	54c98069-cb97-4a48-9c06-c8ed239ef726	virement	13532.00	219062.00	205530.00	FCFA	Virement salaire	a90e1a63-43fd-4956-af04-b3458780ca97	2025-06-16 15:51:19	2025-10-23 12:36:57
3b7e589a-50ef-4521-b3d5-1163c232a186	54c98069-cb97-4a48-9c06-c8ed239ef726	depot	27582.00	219062.00	246644.00	FCFA	Dépôt d'espèces	\N	2025-10-02 02:30:58	2025-10-23 12:36:57
a3110ed3-855f-442b-ba18-00fc74b6ffa6	54c98069-cb97-4a48-9c06-c8ed239ef726	retrait	32304.00	219062.00	186758.00	FCFA	Retrait guichet	\N	2025-06-29 04:04:31	2025-10-23 12:36:57
222a4ae8-3f1d-4e0c-bf0a-7cb35c157e97	54c98069-cb97-4a48-9c06-c8ed239ef726	retrait	17333.00	219062.00	201729.00	FCFA	Prélèvement automatique	\N	2025-04-23 22:04:21	2025-10-23 12:36:57
bc730efe-a063-4697-8fc6-766fc6d26a4e	54c98069-cb97-4a48-9c06-c8ed239ef726	depot	32727.00	219062.00	251789.00	FCFA	Virement bancaire entrant	\N	2025-09-14 09:40:41	2025-10-23 12:36:57
14153281-859b-4762-a8a8-5faecc5d4743	54c98069-cb97-4a48-9c06-c8ed239ef726	retrait	28139.00	219062.00	190923.00	FCFA	Retrait d'espèces	\N	2025-07-02 14:37:43	2025-10-23 12:36:57
ca6035d9-c8b2-404e-b806-607ba8d2ffeb	54c98069-cb97-4a48-9c06-c8ed239ef726	virement	42895.00	219062.00	176167.00	FCFA	Paiement facture	edc37cd9-41c0-44ba-a8a4-f7da20914b48	2025-10-17 07:16:34	2025-10-23 12:36:57
0e5b6146-6840-4e91-850a-72fe651adffe	54c98069-cb97-4a48-9c06-c8ed239ef726	virement	17289.00	219062.00	201773.00	FCFA	Virement salaire	f3db8624-1334-47ff-83bb-04592844270f	2025-08-02 14:09:08	2025-10-23 12:36:57
eb4ed65f-122c-4b74-b013-4bb9d977f048	54c98069-cb97-4a48-9c06-c8ed239ef726	virement	23240.00	219062.00	195822.00	FCFA	Transfert entre comptes	a03dce74-58f6-42c7-8624-1d21ea760a90	2025-06-06 01:13:26	2025-10-23 12:36:57
958bb719-318e-440b-8e10-099f0f9eefa2	54c98069-cb97-4a48-9c06-c8ed239ef726	virement	48735.00	219062.00	170327.00	FCFA	Paiement facture	6c92b373-c286-44a2-94a3-cf8cf3479100	2025-05-05 03:57:47	2025-10-23 12:36:57
38923bc5-0b6f-4b04-b280-ef38ccd4a8c9	54c98069-cb97-4a48-9c06-c8ed239ef726	retrait	40460.00	219062.00	178602.00	FCFA	Retrait guichet	\N	2025-07-11 12:05:43	2025-10-23 12:36:57
1b710f3b-a871-4ec0-b5df-e73359a469a4	54c98069-cb97-4a48-9c06-c8ed239ef726	retrait	28453.00	219062.00	190609.00	FCFA	Retrait guichet	\N	2025-07-14 19:19:50	2025-10-23 12:36:57
18e60d41-8894-4945-9c3f-29d20954ceaa	54c98069-cb97-4a48-9c06-c8ed239ef726	retrait	35146.00	219062.00	183916.00	FCFA	Retrait guichet	\N	2025-08-16 05:21:46	2025-10-23 12:36:57
713a466a-1e05-406a-8deb-519ed8cf7818	54c98069-cb97-4a48-9c06-c8ed239ef726	retrait	20084.00	219062.00	198978.00	FCFA	Retrait d'espèces	\N	2025-08-23 02:51:50	2025-10-23 12:36:57
2efb8b36-cc15-493d-b6ba-79af4b79713b	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	depot	12322.00	477610.00	489932.00	FCFA	Dépôt chèque	\N	2025-07-03 00:28:38	2025-10-23 12:36:57
178abd0c-0560-4be5-b792-7a8f2e775987	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	depot	31584.00	477610.00	509194.00	FCFA	Dépôt d'espèces	\N	2025-08-19 14:18:53	2025-10-23 12:36:57
1158c797-a281-4c1e-b3c6-69bcbc531f6b	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	depot	44510.00	477610.00	522120.00	FCFA	Dépôt chèque	\N	2025-04-27 07:56:45	2025-10-23 12:36:57
303cc3f5-d9b7-4f88-990a-6f4c0729161e	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	virement	43215.00	477610.00	434395.00	FCFA	Paiement facture	968e30c7-1be0-4c05-98ba-5cb8d986a863	2025-06-24 21:03:39	2025-10-23 12:36:57
42c17b43-60d0-4641-afde-848f7680f27d	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	retrait	19779.00	477610.00	457831.00	FCFA	Paiement par carte	\N	2025-07-08 23:58:31	2025-10-23 12:36:57
1785716a-f1c8-4055-8fe0-f5ea220211f6	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	retrait	32513.00	477610.00	445097.00	FCFA	Retrait d'espèces	\N	2025-09-24 11:33:36	2025-10-23 12:36:57
dc507efa-2781-46fc-9a92-88812e1b6486	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	virement	2202.00	477610.00	475408.00	FCFA	Transfert bancaire	24e04f46-72df-4b0e-9024-19c114c552aa	2025-09-06 19:11:42	2025-10-23 12:36:57
0e9a5723-5d83-4644-a855-c12ea2302b9f	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	retrait	4448.00	477610.00	473162.00	FCFA	Paiement par carte	\N	2025-09-22 08:45:07	2025-10-23 12:36:57
ff62238f-de7b-4a2f-8945-e9fe2443dff6	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	depot	5251.00	477610.00	482861.00	FCFA	Virement bancaire entrant	\N	2025-08-08 01:56:28	2025-10-23 12:36:57
3b69ccb5-0f92-4cbe-86c1-97231a7cfc5c	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	virement	24270.00	477610.00	453340.00	FCFA	Virement salaire	e4ad8455-8e84-4a67-873f-6392338ba743	2025-09-04 05:15:20	2025-10-23 12:36:57
a83aee18-3a97-4aba-a6aa-ab00002099ff	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	depot	25968.00	477610.00	503578.00	FCFA	Dépôt d'espèces	\N	2025-09-11 01:47:46	2025-10-23 12:36:57
2bed5a82-d32d-418f-a859-ce4064aa0c28	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	depot	2617.00	477610.00	480227.00	FCFA	Dépôt chèque	\N	2025-05-31 06:17:40	2025-10-23 12:36:57
a0b6864c-8c56-4963-babf-b549a2a1476a	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	depot	25782.00	477610.00	503392.00	FCFA	Dépôt espèces guichet	\N	2025-08-28 17:22:05	2025-10-23 12:36:57
3a5ddc86-8181-4759-962f-b7b927b969dc	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	depot	34877.00	477610.00	512487.00	FCFA	Dépôt espèces guichet	\N	2025-06-24 09:06:53	2025-10-23 12:36:57
56d42843-d77f-4dd8-a456-6e8272220434	6c3bfb96-2628-4e0d-966b-1cf4e6c1ddae	depot	46331.00	477610.00	523941.00	FCFA	Dépôt espèces guichet	\N	2025-08-07 08:08:07	2025-10-23 12:36:57
285c5ab5-6d7c-4906-9aa2-016a44cb3b5a	916bbfef-cee4-457b-a001-da8e5b0be63d	depot	16794.00	185746.00	202540.00	FCFA	Dépôt d'espèces	\N	2025-07-13 05:39:08	2025-10-23 12:36:57
a3351f1c-b2eb-4353-8800-1688c603a4a6	916bbfef-cee4-457b-a001-da8e5b0be63d	virement	46200.00	185746.00	139546.00	FCFA	Virement vers compte	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	2025-10-21 22:38:33	2025-10-23 12:36:57
8400f852-370f-477e-9c7c-0e05250c1e54	916bbfef-cee4-457b-a001-da8e5b0be63d	depot	46584.00	185746.00	232330.00	FCFA	Dépôt d'espèces	\N	2025-09-20 04:04:07	2025-10-23 12:36:57
0f15445c-4fae-4151-b860-e31bbf27d250	916bbfef-cee4-457b-a001-da8e5b0be63d	retrait	19895.00	185746.00	165851.00	FCFA	Retrait guichet	\N	2025-06-11 08:28:42	2025-10-23 12:36:57
0efe11b4-b35a-4635-9d81-45c2e2e79c9d	916bbfef-cee4-457b-a001-da8e5b0be63d	retrait	47212.00	185746.00	138534.00	FCFA	Retrait DAB	\N	2025-09-22 04:40:02	2025-10-23 12:36:57
835d4f04-563e-460c-9c12-656efa043fa5	916bbfef-cee4-457b-a001-da8e5b0be63d	retrait	34974.00	185746.00	150772.00	FCFA	Retrait guichet	\N	2025-06-13 09:20:07	2025-10-23 12:36:57
81c97990-8bf3-4159-b077-c0b985f95b4e	916bbfef-cee4-457b-a001-da8e5b0be63d	depot	27222.00	185746.00	212968.00	FCFA	Dépôt espèces guichet	\N	2025-06-28 06:15:28	2025-10-23 12:36:57
beb2b024-29e4-402b-838d-b6185dcc119e	916bbfef-cee4-457b-a001-da8e5b0be63d	depot	36297.00	185746.00	222043.00	FCFA	Dépôt chèque	\N	2025-06-22 18:56:39	2025-10-23 12:36:57
ec5009a8-975f-4b1e-adb4-ba54946a890b	916bbfef-cee4-457b-a001-da8e5b0be63d	depot	45531.00	185746.00	231277.00	FCFA	Virement bancaire entrant	\N	2025-05-16 14:19:21	2025-10-23 12:36:57
63b58a35-4117-4202-86c4-157a60d694d7	916bbfef-cee4-457b-a001-da8e5b0be63d	retrait	42524.00	185746.00	143222.00	FCFA	Prélèvement automatique	\N	2025-07-01 02:52:23	2025-10-23 12:36:57
18f34f4d-75bf-42bd-bfcd-62b37ad6f13b	916bbfef-cee4-457b-a001-da8e5b0be63d	virement	5379.00	185746.00	180367.00	FCFA	Virement salaire	8d706bac-d7d8-4172-8d94-d1a8cdf604db	2025-10-01 21:59:37	2025-10-23 12:36:57
ab50c29d-f190-4479-afe2-a232b8dc0948	2f53ae60-3c7c-4dee-a02c-cad51068f96c	depot	16915.00	40712.00	57627.00	FCFA	Virement bancaire entrant	\N	2025-05-09 20:46:38	2025-10-23 12:36:57
281d658e-0332-4b1f-9cd4-f038dd5a9be1	2f53ae60-3c7c-4dee-a02c-cad51068f96c	depot	17193.00	40712.00	57905.00	FCFA	Dépôt d'espèces	\N	2025-08-18 03:40:55	2025-10-23 12:36:57
20b42197-aaf7-41e8-839c-77c3ab171a64	2f53ae60-3c7c-4dee-a02c-cad51068f96c	depot	40139.00	40712.00	80851.00	FCFA	Virement bancaire entrant	\N	2025-05-21 11:57:53	2025-10-23 12:36:57
b2af1d9a-5afd-4987-bdd9-a338af6604f0	2f53ae60-3c7c-4dee-a02c-cad51068f96c	retrait	23349.00	40712.00	17363.00	FCFA	Retrait guichet	\N	2025-04-23 16:10:06	2025-10-23 12:36:57
c639d0fe-aac6-40ef-bb27-3ba2ed536b9d	2f53ae60-3c7c-4dee-a02c-cad51068f96c	virement	11112.00	40712.00	29600.00	FCFA	Paiement facture	b9fcf39f-cbf6-4e3d-99da-428158581521	2025-07-25 03:05:29	2025-10-23 12:36:57
b10f246f-61ce-4fb7-80bb-6ec738fded89	2f53ae60-3c7c-4dee-a02c-cad51068f96c	virement	39838.00	40712.00	874.00	FCFA	Virement salaire	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	2025-06-10 05:53:34	2025-10-23 12:36:57
83b89cef-89f8-44fd-9bb1-a71a5db9d05a	2f53ae60-3c7c-4dee-a02c-cad51068f96c	virement	31460.00	40712.00	9252.00	FCFA	Transfert entre comptes	f712d8d9-57b6-49a4-a8eb-5e04856619a9	2025-08-16 19:19:09	2025-10-23 12:36:57
05505afe-9363-45ae-8376-eb3c443ad2e6	2f53ae60-3c7c-4dee-a02c-cad51068f96c	retrait	19677.00	40712.00	21035.00	FCFA	Prélèvement automatique	\N	2025-08-03 23:26:28	2025-10-23 12:36:57
999abef8-4726-49ca-8174-daa51e3a2dbb	2f53ae60-3c7c-4dee-a02c-cad51068f96c	retrait	46687.00	40712.00	0.00	FCFA	Paiement par carte	\N	2025-05-22 03:15:36	2025-10-23 12:36:57
15abdddc-52a0-44e8-ad7c-eb542d395544	2afce742-17e9-45bc-99be-9389a26da3ca	virement	25473.00	21784.00	0.00	FCFA	Transfert bancaire	5d3634bb-39ae-4beb-a70d-3f7ac49f03cf	2025-08-25 18:16:10	2025-10-23 12:36:57
3757fd45-b52e-454e-8e9c-1ed138cba597	2afce742-17e9-45bc-99be-9389a26da3ca	virement	9734.00	21784.00	12050.00	FCFA	Transfert bancaire	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	2025-08-25 11:22:21	2025-10-23 12:36:57
e02427e3-b8a1-4674-99f1-cea71fc78251	2afce742-17e9-45bc-99be-9389a26da3ca	retrait	39574.00	21784.00	0.00	FCFA	Retrait d'espèces	\N	2025-05-29 03:30:21	2025-10-23 12:36:57
3fd2235d-b756-4ff9-93a6-616fa7cb56ef	2afce742-17e9-45bc-99be-9389a26da3ca	virement	47685.00	21784.00	0.00	FCFA	Virement vers compte	5cd10916-6dee-48e6-ab78-7995b1f1ce95	2025-09-22 16:09:55	2025-10-23 12:36:57
f808d942-b35e-4bfd-beab-3ddff3fbf4f0	2afce742-17e9-45bc-99be-9389a26da3ca	retrait	6399.00	21784.00	15385.00	FCFA	Paiement par carte	\N	2025-08-13 02:13:07	2025-10-23 12:36:57
1b0b954a-b890-46ba-a6f8-d99232d34812	2afce742-17e9-45bc-99be-9389a26da3ca	depot	42985.00	21784.00	64769.00	FCFA	Virement bancaire entrant	\N	2025-05-03 22:31:13	2025-10-23 12:36:57
b9eb72d5-8c77-4f1a-84af-4c8bbbcaa9b3	2afce742-17e9-45bc-99be-9389a26da3ca	virement	27218.00	21784.00	0.00	FCFA	Transfert bancaire	f1e6f840-61c7-4618-bbfd-578d06a2431f	2025-05-28 06:25:49	2025-10-23 12:36:57
9ef57c30-7823-47d1-a65a-0b258bc05849	ce352024-ef0a-4c59-a717-07fa503a38dc	depot	45559.00	436076.00	481635.00	FCFA	Dépôt chèque	\N	2025-08-27 00:11:24	2025-10-23 12:36:57
8b53ae24-e30c-443a-8590-4a9a3b604501	ce352024-ef0a-4c59-a717-07fa503a38dc	depot	39268.00	436076.00	475344.00	FCFA	Dépôt d'espèces	\N	2025-07-07 00:34:11	2025-10-23 12:36:57
30c791b8-4ae5-444e-99ac-b796d25166f1	ce352024-ef0a-4c59-a717-07fa503a38dc	depot	3106.00	436076.00	439182.00	FCFA	Dépôt chèque	\N	2025-08-04 17:13:10	2025-10-23 12:36:57
18cef363-2689-40ac-817e-77f121488ded	ce352024-ef0a-4c59-a717-07fa503a38dc	virement	8571.00	436076.00	427505.00	FCFA	Virement vers compte	1a2a915d-173c-44e7-a655-e29b9a02fd18	2025-06-16 11:12:24	2025-10-23 12:36:57
c017e27e-e669-49d8-ab7b-fe1ecc2506e6	ce352024-ef0a-4c59-a717-07fa503a38dc	virement	12848.00	436076.00	423228.00	FCFA	Transfert bancaire	f1e6f840-61c7-4618-bbfd-578d06a2431f	2025-05-27 11:51:59	2025-10-23 12:36:57
a6a4cd21-653e-4d85-a283-54daadd76d0e	ce352024-ef0a-4c59-a717-07fa503a38dc	retrait	37512.00	436076.00	398564.00	FCFA	Retrait d'espèces	\N	2025-09-02 12:12:32	2025-10-23 12:36:57
755ca298-ce33-444f-8666-8639039ccc43	ce352024-ef0a-4c59-a717-07fa503a38dc	depot	5801.00	436076.00	441877.00	FCFA	Dépôt chèque	\N	2025-06-28 15:00:16	2025-10-23 12:36:57
9a2b0249-97be-4f5e-a72c-411565d2a835	ce352024-ef0a-4c59-a717-07fa503a38dc	retrait	14901.00	436076.00	421175.00	FCFA	Prélèvement automatique	\N	2025-08-25 09:17:53	2025-10-23 12:36:57
e4e13b1f-7670-4fa2-b3fd-d3280801babd	ce352024-ef0a-4c59-a717-07fa503a38dc	depot	20755.00	436076.00	456831.00	FCFA	Versement salaire	\N	2025-08-06 23:40:02	2025-10-23 12:36:57
63d2b733-d284-4280-be4e-cf40164ca61a	ce352024-ef0a-4c59-a717-07fa503a38dc	depot	44724.00	436076.00	480800.00	FCFA	Dépôt chèque	\N	2025-05-11 02:39:35	2025-10-23 12:36:57
90c505ef-a8cc-4415-aa42-7545d14af969	ce352024-ef0a-4c59-a717-07fa503a38dc	virement	35239.00	436076.00	400837.00	FCFA	Paiement facture	5f5f316c-0963-43fc-b6d4-599439e88c6f	2025-06-26 00:33:44	2025-10-23 12:36:57
14798796-4f8d-4b88-99a5-9ed0253b6ca4	ce352024-ef0a-4c59-a717-07fa503a38dc	retrait	1843.00	436076.00	434233.00	FCFA	Retrait guichet	\N	2025-10-17 01:56:50	2025-10-23 12:36:57
b1bdbd19-63c9-49cc-895e-4f6c6abe21be	ce352024-ef0a-4c59-a717-07fa503a38dc	retrait	29056.00	436076.00	407020.00	FCFA	Paiement par carte	\N	2025-07-20 03:43:37	2025-10-23 12:36:57
479245f0-8c07-4fe1-9c9d-6379c0789b51	ce352024-ef0a-4c59-a717-07fa503a38dc	depot	3681.00	436076.00	439757.00	FCFA	Versement salaire	\N	2025-06-22 18:50:26	2025-10-23 12:36:57
6e7afef3-db36-4baa-9a72-69c379e922f2	f712d8d9-57b6-49a4-a8eb-5e04856619a9	retrait	26002.00	419783.00	393781.00	FCFA	Retrait DAB	\N	2025-09-13 21:03:39	2025-10-23 12:36:57
4d12fd36-b8f5-45ad-bcdc-cec8b608fd43	f712d8d9-57b6-49a4-a8eb-5e04856619a9	depot	4633.00	419783.00	424416.00	FCFA	Versement salaire	\N	2025-08-14 07:53:56	2025-10-23 12:36:57
b5f62da0-95ff-4e68-aa4b-81eb4d91abfa	f712d8d9-57b6-49a4-a8eb-5e04856619a9	retrait	21726.00	419783.00	398057.00	FCFA	Retrait DAB	\N	2025-10-14 11:29:37	2025-10-23 12:36:57
64af0c9e-ee40-4e5f-9f24-034fb07bfa53	f712d8d9-57b6-49a4-a8eb-5e04856619a9	depot	20832.00	419783.00	440615.00	FCFA	Dépôt espèces guichet	\N	2025-05-01 05:05:05	2025-10-23 12:36:57
322438c7-f998-440f-b22a-3ef8a6a1ad43	f712d8d9-57b6-49a4-a8eb-5e04856619a9	depot	42063.00	419783.00	461846.00	FCFA	Dépôt d'espèces	\N	2025-10-16 16:11:16	2025-10-23 12:36:57
f4d45b48-feda-4af3-881a-38edeaf0171b	65da4070-27f5-40a7-99d9-db64e3163a65	virement	45453.00	255594.00	210141.00	FCFA	Paiement facture	ad629adb-377a-4725-9f12-556a170ef642	2025-09-21 07:37:36	2025-10-23 12:36:57
24dfb351-570a-4109-90ac-46abcb5d8c7e	65da4070-27f5-40a7-99d9-db64e3163a65	virement	31640.00	255594.00	223954.00	FCFA	Virement salaire	0c099b4c-0616-44d6-af7a-38ed712edbf0	2025-09-08 06:27:18	2025-10-23 12:36:57
e5519198-d710-4506-ab6e-4c4422677909	65da4070-27f5-40a7-99d9-db64e3163a65	virement	34691.00	255594.00	220903.00	FCFA	Paiement facture	5930a704-1cad-486a-bb5e-d5ebac8129b9	2025-07-28 22:59:33	2025-10-23 12:36:57
ed2dfc4a-e828-4d38-96c6-04c388fd3936	65da4070-27f5-40a7-99d9-db64e3163a65	virement	33391.00	255594.00	222203.00	FCFA	Transfert entre comptes	e575ca40-926e-4fe2-9c4a-0af557a58c64	2025-09-01 15:55:17	2025-10-23 12:36:57
df7c4ed3-e567-40fc-85d6-ca908cb51311	65da4070-27f5-40a7-99d9-db64e3163a65	virement	4636.00	255594.00	250958.00	FCFA	Transfert bancaire	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	2025-07-24 06:18:24	2025-10-23 12:36:57
59045c70-71d6-48f3-8b8b-8d44e2ea4498	65da4070-27f5-40a7-99d9-db64e3163a65	retrait	37341.00	255594.00	218253.00	FCFA	Retrait d'espèces	\N	2025-08-23 17:08:46	2025-10-23 12:36:57
4c4fddfc-cd12-42af-854f-7d5e55908846	65da4070-27f5-40a7-99d9-db64e3163a65	retrait	40501.00	255594.00	215093.00	FCFA	Retrait DAB	\N	2025-10-07 11:41:01	2025-10-23 12:36:57
67e902d9-3e23-404d-a56e-a7fa8690c1e6	65da4070-27f5-40a7-99d9-db64e3163a65	virement	29640.00	255594.00	225954.00	FCFA	Virement salaire	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	2025-09-13 18:22:17	2025-10-23 12:36:57
4acfb6bc-8027-4b14-934c-2bf2ddc220b3	65da4070-27f5-40a7-99d9-db64e3163a65	retrait	28114.00	255594.00	227480.00	FCFA	Retrait guichet	\N	2025-09-13 13:12:30	2025-10-23 12:36:57
087d5681-53c8-49b7-813b-cedafb22c405	65da4070-27f5-40a7-99d9-db64e3163a65	depot	24242.00	255594.00	279836.00	FCFA	Dépôt d'espèces	\N	2025-08-15 03:47:05	2025-10-23 12:36:57
b8f8bf56-22dd-44dd-8efd-a80bfc512ab4	4e96181f-e984-42f8-9787-a41a67c90aba	retrait	44555.00	455670.00	411115.00	FCFA	Retrait guichet	\N	2025-08-21 03:18:19	2025-10-23 12:36:57
426de8ae-9198-454a-a8b3-dfe21ade6d59	4e96181f-e984-42f8-9787-a41a67c90aba	virement	46851.00	455670.00	408819.00	FCFA	Transfert bancaire	34b84e17-27b4-4080-a77b-3cdb00476a06	2025-08-14 11:01:10	2025-10-23 12:36:57
4cb7bab8-9556-4d8a-8a54-5b74f108eba5	4e96181f-e984-42f8-9787-a41a67c90aba	virement	8059.00	455670.00	447611.00	FCFA	Transfert entre comptes	503088f6-053b-4cbc-a00a-335ae839d447	2025-09-14 16:11:14	2025-10-23 12:36:57
3f88690a-fd8f-4be5-aa1e-61536648ede0	4e96181f-e984-42f8-9787-a41a67c90aba	depot	19841.00	455670.00	475511.00	FCFA	Dépôt d'espèces	\N	2025-05-08 15:06:41	2025-10-23 12:36:57
7ca348d5-0b6c-4e20-bfb5-9de8406d0336	4e96181f-e984-42f8-9787-a41a67c90aba	depot	48543.00	455670.00	504213.00	FCFA	Dépôt chèque	\N	2025-07-29 12:59:52	2025-10-23 12:36:57
de204fc6-0d01-4ec7-ae89-7bd41ec769fd	4e96181f-e984-42f8-9787-a41a67c90aba	virement	14673.00	455670.00	440997.00	FCFA	Paiement facture	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	2025-08-27 02:02:54	2025-10-23 12:36:57
c648f462-077c-40b3-8a22-8562d67bd05f	4e96181f-e984-42f8-9787-a41a67c90aba	depot	8554.00	455670.00	464224.00	FCFA	Dépôt d'espèces	\N	2025-09-05 01:18:19	2025-10-23 12:36:57
504ae303-d09f-474f-a686-82f87cff26cc	4e96181f-e984-42f8-9787-a41a67c90aba	depot	27823.00	455670.00	483493.00	FCFA	Versement salaire	\N	2025-06-23 03:16:25	2025-10-23 12:36:57
5b661ad7-945b-4077-980c-a979f76b4e9d	4e96181f-e984-42f8-9787-a41a67c90aba	depot	24190.00	455670.00	479860.00	FCFA	Versement salaire	\N	2025-06-18 20:43:20	2025-10-23 12:36:57
784deb21-a87d-4c06-8779-23cdc45fe645	4e96181f-e984-42f8-9787-a41a67c90aba	retrait	25289.00	455670.00	430381.00	FCFA	Paiement par carte	\N	2025-04-29 18:56:57	2025-10-23 12:36:57
fc63359e-91b9-445e-a71a-b35ca9a70b32	4e96181f-e984-42f8-9787-a41a67c90aba	virement	41087.00	455670.00	414583.00	FCFA	Virement vers compte	f2182e94-c5d0-4b91-8d12-af97e101dd6b	2025-10-18 13:45:58	2025-10-23 12:36:57
1f8a7dc8-0748-4320-b1d2-50659d2e558b	4e96181f-e984-42f8-9787-a41a67c90aba	virement	17606.00	455670.00	438064.00	FCFA	Virement salaire	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	2025-05-09 02:32:46	2025-10-23 12:36:57
6fab1466-b485-41ea-8106-44648c0dd5d2	4e96181f-e984-42f8-9787-a41a67c90aba	virement	16854.00	455670.00	438816.00	FCFA	Transfert entre comptes	232f5785-5fd1-4398-91e2-4f92589e1d8d	2025-09-07 16:17:46	2025-10-23 12:36:57
caa03d08-6d13-48d5-9951-ee4582427032	78038c23-dabc-4bd2-a4b5-e1c09089f492	retrait	17855.00	165169.00	147314.00	FCFA	Prélèvement automatique	\N	2025-09-22 04:02:05	2025-10-23 12:36:57
027dd799-49ab-481f-8c9c-7109c7655cd0	78038c23-dabc-4bd2-a4b5-e1c09089f492	depot	4143.00	165169.00	169312.00	FCFA	Dépôt chèque	\N	2025-09-07 22:57:22	2025-10-23 12:36:57
e72c9106-4d99-4d12-bf13-30281f1a9b68	78038c23-dabc-4bd2-a4b5-e1c09089f492	depot	39502.00	165169.00	204671.00	FCFA	Versement salaire	\N	2025-09-29 20:59:16	2025-10-23 12:36:57
6445b7a1-86f5-4268-be94-e11e5c3e856b	78038c23-dabc-4bd2-a4b5-e1c09089f492	virement	41485.00	165169.00	123684.00	FCFA	Virement salaire	b1ce150f-0fc3-432e-8d5b-a34f6747804a	2025-10-07 21:53:03	2025-10-23 12:36:57
6175912c-6405-44b3-8db1-0d9bcd58bc13	78038c23-dabc-4bd2-a4b5-e1c09089f492	retrait	42705.00	165169.00	122464.00	FCFA	Retrait DAB	\N	2025-10-10 05:34:35	2025-10-23 12:36:57
66a34404-cd11-45a6-9a75-b091946da107	78038c23-dabc-4bd2-a4b5-e1c09089f492	virement	20549.00	165169.00	144620.00	FCFA	Transfert bancaire	22398797-8a57-4530-b835-7193f3b0fca0	2025-08-14 09:09:12	2025-10-23 12:36:57
f3be2402-a902-4e9e-bc38-0cc9b1029106	78038c23-dabc-4bd2-a4b5-e1c09089f492	virement	6532.00	165169.00	158637.00	FCFA	Transfert bancaire	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	2025-05-29 05:32:08	2025-10-23 12:36:57
0b2a688a-1861-4062-ac56-16913e4df0f4	78038c23-dabc-4bd2-a4b5-e1c09089f492	depot	38085.00	165169.00	203254.00	FCFA	Virement bancaire entrant	\N	2025-08-19 22:48:10	2025-10-23 12:36:57
9dec0969-2b2b-44cb-a8f0-13395ec92528	78038c23-dabc-4bd2-a4b5-e1c09089f492	retrait	34086.00	165169.00	131083.00	FCFA	Paiement par carte	\N	2025-07-21 06:26:51	2025-10-23 12:36:57
2c1e57ac-c569-49f6-9f10-9bde1637c355	78038c23-dabc-4bd2-a4b5-e1c09089f492	retrait	36365.00	165169.00	128804.00	FCFA	Retrait guichet	\N	2025-08-21 22:31:14	2025-10-23 12:36:57
0de9369f-4554-4101-9846-99581e9f1d92	bf69dba7-7153-4b9d-885b-f7fa7330e249	depot	15980.00	116825.00	132805.00	FCFA	Versement salaire	\N	2025-08-25 16:45:39	2025-10-23 12:36:57
57d12e86-06fa-4707-8050-03e7529005ce	bf69dba7-7153-4b9d-885b-f7fa7330e249	virement	47859.00	116825.00	68966.00	FCFA	Transfert entre comptes	24e04f46-72df-4b0e-9024-19c114c552aa	2025-04-30 11:48:08	2025-10-23 12:36:57
2e06125c-9133-42a2-8f24-e7d8c5dc48c7	bf69dba7-7153-4b9d-885b-f7fa7330e249	retrait	47298.00	116825.00	69527.00	FCFA	Paiement par carte	\N	2025-06-20 08:03:13	2025-10-23 12:36:57
d69523ba-ee4b-4116-81bb-372765413d22	bf69dba7-7153-4b9d-885b-f7fa7330e249	virement	34878.00	116825.00	81947.00	FCFA	Transfert entre comptes	087d0d47-8377-4f2f-82a8-6acbc6e148f1	2025-04-25 02:19:53	2025-10-23 12:36:57
22d34b0b-2a31-4522-b81a-742f0eca8f3b	bf69dba7-7153-4b9d-885b-f7fa7330e249	depot	3121.00	116825.00	119946.00	FCFA	Versement salaire	\N	2025-06-23 15:46:53	2025-10-23 12:36:57
a337240c-dda1-4339-a5d6-09f6bd380f01	bf69dba7-7153-4b9d-885b-f7fa7330e249	virement	13307.00	116825.00	103518.00	FCFA	Transfert entre comptes	4e0954f5-1956-40db-b392-7a6ee455c257	2025-09-14 13:06:57	2025-10-23 12:36:57
4bee6f23-6afb-40a0-9bd6-70c202afa077	bf69dba7-7153-4b9d-885b-f7fa7330e249	virement	12985.00	116825.00	103840.00	FCFA	Paiement facture	8d706bac-d7d8-4172-8d94-d1a8cdf604db	2025-08-22 08:26:10	2025-10-23 12:36:57
8b3e16c5-c780-4a66-96d4-c1f53bdeb45f	bf69dba7-7153-4b9d-885b-f7fa7330e249	virement	17569.00	116825.00	99256.00	FCFA	Virement vers compte	914d5be6-2dc2-4063-8219-1ea664a8b058	2025-09-09 05:05:46	2025-10-23 12:36:57
3b237778-cae7-4345-9e5e-096fb1dbd958	bf69dba7-7153-4b9d-885b-f7fa7330e249	retrait	33456.00	116825.00	83369.00	FCFA	Prélèvement automatique	\N	2025-09-03 03:30:20	2025-10-23 12:36:57
cb4e0ecd-448e-4076-937f-a674aecd5b56	bf69dba7-7153-4b9d-885b-f7fa7330e249	retrait	44227.00	116825.00	72598.00	FCFA	Retrait d'espèces	\N	2025-06-28 05:30:02	2025-10-23 12:36:57
d8a1ce79-75c4-4fa6-89bc-ffee99ee6d43	bf69dba7-7153-4b9d-885b-f7fa7330e249	retrait	47902.00	116825.00	68923.00	FCFA	Paiement par carte	\N	2025-10-06 16:21:19	2025-10-23 12:36:57
a4cfb740-9fd9-49ef-9648-d6d3d07a4243	bf69dba7-7153-4b9d-885b-f7fa7330e249	virement	36224.00	116825.00	80601.00	FCFA	Virement vers compte	168369a2-765d-4e68-9282-e69cf56154cf	2025-05-02 01:16:47	2025-10-23 12:36:57
8db78237-e639-4a14-b9bf-99dfbfb83bb2	bf69dba7-7153-4b9d-885b-f7fa7330e249	retrait	9771.00	116825.00	107054.00	FCFA	Retrait DAB	\N	2025-05-13 18:04:29	2025-10-23 12:36:57
3124b237-8e0d-4ebf-b54a-404c14ca2bd0	bf69dba7-7153-4b9d-885b-f7fa7330e249	virement	14765.00	116825.00	102060.00	FCFA	Transfert bancaire	54d5e886-a7a4-4427-b256-7723400f3c4e	2025-05-23 03:25:12	2025-10-23 12:36:57
fe37cd09-2d79-4946-9b5f-1dc44af601c6	f46f2dde-ba75-4234-b729-67c0cd2a3ade	retrait	32549.00	279050.00	246501.00	FCFA	Prélèvement automatique	\N	2025-05-03 11:22:36	2025-10-23 12:36:57
1203b806-d596-446c-8d86-92763660bea8	f46f2dde-ba75-4234-b729-67c0cd2a3ade	depot	47879.00	279050.00	326929.00	FCFA	Virement bancaire entrant	\N	2025-10-10 15:43:42	2025-10-23 12:36:57
44379528-2eed-4726-9aca-b0a3b855aead	f46f2dde-ba75-4234-b729-67c0cd2a3ade	virement	26651.00	279050.00	252399.00	FCFA	Transfert bancaire	3b545ec9-8048-4c12-a074-df603671d400	2025-09-24 08:58:32	2025-10-23 12:36:57
e5f1db5e-906c-4b9f-9324-4e9d162a8f24	f46f2dde-ba75-4234-b729-67c0cd2a3ade	virement	10042.00	279050.00	269008.00	FCFA	Paiement facture	82b41651-c63d-4deb-85c6-3c688eddc121	2025-08-11 05:15:47	2025-10-23 12:36:57
9f8ef0a1-40a7-4690-b623-1466e1602494	f46f2dde-ba75-4234-b729-67c0cd2a3ade	virement	12810.00	279050.00	266240.00	FCFA	Paiement facture	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	2025-09-26 02:14:15	2025-10-23 12:36:57
db83bb18-473e-4700-bab4-6e2be47c3ce7	f46f2dde-ba75-4234-b729-67c0cd2a3ade	depot	27379.00	279050.00	306429.00	FCFA	Dépôt espèces guichet	\N	2025-08-17 02:59:13	2025-10-23 12:36:57
46a05241-b0ab-46b4-a525-2f2e08230f36	f46f2dde-ba75-4234-b729-67c0cd2a3ade	virement	46969.00	279050.00	232081.00	FCFA	Transfert bancaire	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	2025-10-20 02:23:12	2025-10-23 12:36:57
268c9e50-fb9e-427e-8a4f-bf74bd7ccff1	f46f2dde-ba75-4234-b729-67c0cd2a3ade	depot	8066.00	279050.00	287116.00	FCFA	Versement salaire	\N	2025-04-25 02:36:44	2025-10-23 12:36:57
8fc2f49c-1294-4a6d-b470-9ae9ccefcc2a	f46f2dde-ba75-4234-b729-67c0cd2a3ade	depot	48265.00	279050.00	327315.00	FCFA	Dépôt d'espèces	\N	2025-10-11 20:17:00	2025-10-23 12:36:57
2f633470-a966-4fe8-89e5-f139ba496606	f46f2dde-ba75-4234-b729-67c0cd2a3ade	retrait	24387.00	279050.00	254663.00	FCFA	Paiement par carte	\N	2025-09-22 21:59:51	2025-10-23 12:36:57
d8f08099-f5e1-4c58-baa7-ee11c74e18e5	f46f2dde-ba75-4234-b729-67c0cd2a3ade	virement	3373.00	279050.00	275677.00	FCFA	Virement salaire	1eece79a-3f27-456a-8f76-0b4de6cba5e4	2025-09-08 00:52:37	2025-10-23 12:36:57
e38420b0-4ff6-41a5-b662-87146515f1ef	d725e859-df50-4ee3-8ab9-65d82dc7fd71	virement	5079.00	133633.00	128554.00	FCFA	Transfert entre comptes	64203f77-d74d-4752-9e2b-7a1c40547be9	2025-05-02 06:31:30	2025-10-23 12:36:57
b4f7d5fe-5ba8-4cb4-b319-7f2143c7ae60	d725e859-df50-4ee3-8ab9-65d82dc7fd71	retrait	18903.00	133633.00	114730.00	FCFA	Retrait d'espèces	\N	2025-09-18 17:48:11	2025-10-23 12:36:57
8cd25db8-1c95-4874-a4cf-e9ae46fb4553	d725e859-df50-4ee3-8ab9-65d82dc7fd71	retrait	38789.00	133633.00	94844.00	FCFA	Paiement par carte	\N	2025-09-04 22:33:12	2025-10-23 12:36:57
e20f6f84-6df2-485d-a76f-495ab2de7d5a	d725e859-df50-4ee3-8ab9-65d82dc7fd71	virement	48065.00	133633.00	85568.00	FCFA	Virement vers compte	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	2025-05-27 08:01:37	2025-10-23 12:36:57
fd8134b7-eb3b-4f52-a1c1-5998db718c29	d725e859-df50-4ee3-8ab9-65d82dc7fd71	retrait	46794.00	133633.00	86839.00	FCFA	Prélèvement automatique	\N	2025-09-01 08:15:44	2025-10-23 12:36:57
ad5566c3-382a-484d-9620-2353334d7613	d725e859-df50-4ee3-8ab9-65d82dc7fd71	virement	20121.00	133633.00	113512.00	FCFA	Virement vers compte	5cd10916-6dee-48e6-ab78-7995b1f1ce95	2025-09-03 13:51:29	2025-10-23 12:36:57
a7b09edd-899c-4a38-ae0b-5901f241cf3d	d725e859-df50-4ee3-8ab9-65d82dc7fd71	depot	29337.00	133633.00	162970.00	FCFA	Dépôt chèque	\N	2025-08-08 08:17:37	2025-10-23 12:36:57
3bd95df3-3de0-417b-b33e-cc4e10b8ff02	d725e859-df50-4ee3-8ab9-65d82dc7fd71	virement	17851.00	133633.00	115782.00	FCFA	Virement salaire	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	2025-09-13 04:34:19	2025-10-23 12:36:57
83960583-3dd3-4fde-85b8-e6b025eb9d60	801e068b-fdc3-4606-bc83-42d2e3fc4a67	virement	25756.00	443978.00	418222.00	FCFA	Paiement facture	54c98069-cb97-4a48-9c06-c8ed239ef726	2025-08-12 03:03:17	2025-10-23 12:36:57
71b10437-3104-42d7-a9c7-6655fce83c06	801e068b-fdc3-4606-bc83-42d2e3fc4a67	virement	32853.00	443978.00	411125.00	FCFA	Paiement facture	05c0a3e8-eeae-4976-88c2-848aec6bea96	2025-09-01 00:27:11	2025-10-23 12:36:57
25adabab-506f-42cc-b36a-e78036b13ca3	801e068b-fdc3-4606-bc83-42d2e3fc4a67	depot	42734.00	443978.00	486712.00	FCFA	Versement salaire	\N	2025-05-12 02:53:27	2025-10-23 12:36:57
96bbd9ae-1103-42a7-bbee-6a8f3e9719c8	801e068b-fdc3-4606-bc83-42d2e3fc4a67	retrait	17894.00	443978.00	426084.00	FCFA	Retrait guichet	\N	2025-09-17 04:45:01	2025-10-23 12:36:57
ea9187e1-cec4-4140-a4e0-87b3ad936970	801e068b-fdc3-4606-bc83-42d2e3fc4a67	virement	27924.00	443978.00	416054.00	FCFA	Paiement facture	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	2025-07-11 01:55:47	2025-10-23 12:36:57
91b1c53f-f90a-404c-94ab-08ee9de948fc	801e068b-fdc3-4606-bc83-42d2e3fc4a67	retrait	45540.00	443978.00	398438.00	FCFA	Prélèvement automatique	\N	2025-08-14 10:56:56	2025-10-23 12:36:57
4a3551ab-8bfc-4148-88bc-1fc5d2917f8f	aaa991e6-e52e-48b7-ab07-15a4a8203054	virement	5451.00	398862.00	393411.00	FCFA	Virement vers compte	a0123386-5767-4f9f-b457-e0613e9f8725	2025-09-30 01:58:58	2025-10-23 12:36:57
6e80b09f-30fc-4c10-85df-01f202c528d0	aaa991e6-e52e-48b7-ab07-15a4a8203054	retrait	49344.00	398862.00	349518.00	FCFA	Prélèvement automatique	\N	2025-09-05 05:41:31	2025-10-23 12:36:57
df12a053-6ff5-4bb2-8496-8f550f50c127	aaa991e6-e52e-48b7-ab07-15a4a8203054	depot	14510.00	398862.00	413372.00	FCFA	Versement salaire	\N	2025-07-05 09:42:36	2025-10-23 12:36:57
1f16c36e-8076-4716-9eba-b3cfdcb00802	aaa991e6-e52e-48b7-ab07-15a4a8203054	virement	18317.00	398862.00	380545.00	FCFA	Virement vers compte	9987f93d-ac57-4bee-aff6-41c16aebe2b4	2025-05-18 21:09:46	2025-10-23 12:36:57
3c9d0146-0a4c-4fd3-a891-80489a9447e4	aaa991e6-e52e-48b7-ab07-15a4a8203054	retrait	5056.00	398862.00	393806.00	FCFA	Prélèvement automatique	\N	2025-06-23 04:16:44	2025-10-23 12:36:57
271a7f89-6ca0-4855-9a2b-d3b6da4c7bdd	aaa991e6-e52e-48b7-ab07-15a4a8203054	virement	48413.00	398862.00	350449.00	FCFA	Virement vers compte	0c099b4c-0616-44d6-af7a-38ed712edbf0	2025-08-27 05:10:50	2025-10-23 12:36:57
e62cb8c7-6887-4d55-8224-79a964a5135e	aaa991e6-e52e-48b7-ab07-15a4a8203054	depot	41506.00	398862.00	440368.00	FCFA	Dépôt d'espèces	\N	2025-05-18 20:32:10	2025-10-23 12:36:57
5850e07f-04b4-472c-a01e-33280c238cf9	aaa991e6-e52e-48b7-ab07-15a4a8203054	retrait	23317.00	398862.00	375545.00	FCFA	Retrait guichet	\N	2025-07-21 03:28:15	2025-10-23 12:36:57
47c2cfb2-2787-47b9-845a-9bceb056779f	d2a1ed80-e126-493f-b155-2923909ae924	retrait	19273.00	185230.00	165957.00	FCFA	Paiement par carte	\N	2025-05-22 15:23:50	2025-10-23 12:36:58
ada16219-e71c-481d-ba02-38ccff676ae7	d2a1ed80-e126-493f-b155-2923909ae924	retrait	33689.00	185230.00	151541.00	FCFA	Retrait guichet	\N	2025-08-01 15:01:10	2025-10-23 12:36:58
6c6b956b-ce73-4be5-8960-1f12a56f0708	d2a1ed80-e126-493f-b155-2923909ae924	retrait	36339.00	185230.00	148891.00	FCFA	Retrait DAB	\N	2025-08-11 11:28:07	2025-10-23 12:36:58
36930517-bc7b-4f99-a7be-9aeeb1c6d296	d2a1ed80-e126-493f-b155-2923909ae924	depot	35844.00	185230.00	221074.00	FCFA	Dépôt espèces guichet	\N	2025-07-19 23:16:48	2025-10-23 12:36:58
c89c6d71-df65-42e5-9545-f2d07c4f1bae	d2a1ed80-e126-493f-b155-2923909ae924	virement	44074.00	185230.00	141156.00	FCFA	Transfert bancaire	808e915e-a5d8-4751-aaa8-50fe040cde68	2025-07-26 10:56:22	2025-10-23 12:36:58
15ba4d58-e109-4a95-96ec-24ba40872496	d2a1ed80-e126-493f-b155-2923909ae924	depot	34801.00	185230.00	220031.00	FCFA	Versement salaire	\N	2025-07-12 05:38:39	2025-10-23 12:36:58
5b5c5d18-e6c6-46f1-bb0b-1a04c33b3a1f	d2a1ed80-e126-493f-b155-2923909ae924	virement	21277.00	185230.00	163953.00	FCFA	Transfert bancaire	6131421b-d7d7-4f56-8450-582c37486f68	2025-07-26 10:57:27	2025-10-23 12:36:58
aa20ac75-eaa3-44ee-9054-c6ba81b2f847	d2a1ed80-e126-493f-b155-2923909ae924	virement	37574.00	185230.00	147656.00	FCFA	Virement salaire	31fb6207-f59e-425f-bf86-a1085c47b43f	2025-10-08 14:49:51	2025-10-23 12:36:58
1d575567-29ff-43be-8acc-6359bbdf7604	d2a1ed80-e126-493f-b155-2923909ae924	retrait	29802.00	185230.00	155428.00	FCFA	Prélèvement automatique	\N	2025-07-26 08:11:19	2025-10-23 12:36:58
0fc3dc1c-0bf5-4510-8412-1630a2fe9060	d2a1ed80-e126-493f-b155-2923909ae924	retrait	8017.00	185230.00	177213.00	FCFA	Retrait d'espèces	\N	2025-07-20 14:11:47	2025-10-23 12:36:58
9d0acd28-0be0-4fc7-a98c-77f1d3d0feae	d2a1ed80-e126-493f-b155-2923909ae924	retrait	4615.00	185230.00	180615.00	FCFA	Paiement par carte	\N	2025-09-02 23:06:33	2025-10-23 12:36:58
659f89e3-0331-4713-9cd6-6389d1f70dac	d2a1ed80-e126-493f-b155-2923909ae924	depot	21993.00	185230.00	207223.00	FCFA	Virement bancaire entrant	\N	2025-09-07 18:39:22	2025-10-23 12:36:58
8424f573-7bf8-4ec2-b4c6-53f1fd113da8	d2a1ed80-e126-493f-b155-2923909ae924	virement	29637.00	185230.00	155593.00	FCFA	Virement vers compte	c5b06daf-ba43-4954-b2b8-1065dfb122ab	2025-05-15 00:07:09	2025-10-23 12:36:58
d5d56a4f-b8aa-4f08-b08a-25a821be2011	d2a1ed80-e126-493f-b155-2923909ae924	depot	3841.00	185230.00	189071.00	FCFA	Virement bancaire entrant	\N	2025-04-23 21:08:38	2025-10-23 12:36:58
8d60cbf9-a4f9-4afb-990f-8cd09a5c4af8	43543b43-8884-4451-8a39-e16cf1e52d3c	retrait	39427.00	487487.00	448060.00	FCFA	Retrait DAB	\N	2025-06-11 08:02:40	2025-10-23 12:36:58
7c0103ae-4d78-4c65-8e68-357123479c19	43543b43-8884-4451-8a39-e16cf1e52d3c	virement	32200.00	487487.00	455287.00	FCFA	Transfert bancaire	f1e6f840-61c7-4618-bbfd-578d06a2431f	2025-08-28 17:45:11	2025-10-23 12:36:58
e206b9af-c2b5-4235-85b5-a3abfd82d2ff	43543b43-8884-4451-8a39-e16cf1e52d3c	depot	3319.00	487487.00	490806.00	FCFA	Dépôt d'espèces	\N	2025-06-21 21:50:31	2025-10-23 12:36:58
fbbb0450-9f8b-4878-b195-5c154152dc03	43543b43-8884-4451-8a39-e16cf1e52d3c	depot	13877.00	487487.00	501364.00	FCFA	Dépôt d'espèces	\N	2025-10-22 21:05:09	2025-10-23 12:36:58
480e4436-9598-472e-a120-dc0c246445a6	43543b43-8884-4451-8a39-e16cf1e52d3c	retrait	13117.00	487487.00	474370.00	FCFA	Prélèvement automatique	\N	2025-04-28 08:54:44	2025-10-23 12:36:58
5da7fb41-e129-41aa-adf1-332bfc49683a	43543b43-8884-4451-8a39-e16cf1e52d3c	depot	11915.00	487487.00	499402.00	FCFA	Dépôt d'espèces	\N	2025-04-29 10:42:17	2025-10-23 12:36:58
c2841dc2-0b3c-46a7-b7ed-0e37cd1c87d6	0c099b4c-0616-44d6-af7a-38ed712edbf0	depot	42552.00	249269.00	291821.00	FCFA	Dépôt chèque	\N	2025-05-01 10:34:52	2025-10-23 12:36:58
efe18a7c-7a16-4f1a-9241-d95ae9029bec	0c099b4c-0616-44d6-af7a-38ed712edbf0	retrait	27107.00	249269.00	222162.00	FCFA	Retrait guichet	\N	2025-07-13 17:34:02	2025-10-23 12:36:58
dcf89599-3711-4771-b461-a776766b2298	0c099b4c-0616-44d6-af7a-38ed712edbf0	virement	49161.00	249269.00	200108.00	FCFA	Transfert bancaire	d3ba6f50-5b24-4a03-9002-ded93f5697a3	2025-06-11 07:19:51	2025-10-23 12:36:58
c91f7d7c-2ee2-48bb-a6fd-836ca7105360	0c099b4c-0616-44d6-af7a-38ed712edbf0	virement	13427.00	249269.00	235842.00	FCFA	Transfert bancaire	76b21c81-8380-4df8-87ad-4f2fa9ff5159	2025-09-06 05:09:46	2025-10-23 12:36:58
d0277d94-8acf-4708-af52-e688b99ffcf8	0c099b4c-0616-44d6-af7a-38ed712edbf0	depot	45272.00	249269.00	294541.00	FCFA	Versement salaire	\N	2025-08-15 16:43:10	2025-10-23 12:36:58
a2acaa87-3e5b-412a-981d-5af6f3f0ee24	0c099b4c-0616-44d6-af7a-38ed712edbf0	depot	37873.00	249269.00	287142.00	FCFA	Dépôt chèque	\N	2025-07-28 06:54:23	2025-10-23 12:36:58
d85bcd17-aaa5-4cba-9d0c-dc578341f687	0c099b4c-0616-44d6-af7a-38ed712edbf0	retrait	40306.00	249269.00	208963.00	FCFA	Paiement par carte	\N	2025-10-23 01:11:04	2025-10-23 12:36:58
34f6bb85-8cf5-411f-85f4-0c529b831dc3	0c099b4c-0616-44d6-af7a-38ed712edbf0	virement	24141.00	249269.00	225128.00	FCFA	Virement vers compte	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	2025-08-25 21:00:36	2025-10-23 12:36:58
ee5f93a2-3bf2-4f7a-a7db-663a20736626	0c099b4c-0616-44d6-af7a-38ed712edbf0	retrait	1893.00	249269.00	247376.00	FCFA	Retrait DAB	\N	2025-07-22 20:26:40	2025-10-23 12:36:58
35a1c074-726b-44f4-a708-054961959e61	0c099b4c-0616-44d6-af7a-38ed712edbf0	retrait	18954.00	249269.00	230315.00	FCFA	Prélèvement automatique	\N	2025-09-10 09:12:48	2025-10-23 12:36:58
3471db14-2fc6-4192-a38d-a77d87393241	0c099b4c-0616-44d6-af7a-38ed712edbf0	virement	49944.00	249269.00	199325.00	FCFA	Paiement facture	6a3575bc-ab64-4315-8ed7-124955e9c44f	2025-05-09 04:08:02	2025-10-23 12:36:58
cc5421cd-9db9-4f2d-a9d4-76cf1658acc0	0c099b4c-0616-44d6-af7a-38ed712edbf0	virement	36532.00	249269.00	212737.00	FCFA	Virement vers compte	3b545ec9-8048-4c12-a074-df603671d400	2025-07-19 11:11:18	2025-10-23 12:36:58
cf62ddcc-e58c-4eb5-87b0-776be987d845	0c099b4c-0616-44d6-af7a-38ed712edbf0	virement	9682.00	249269.00	239587.00	FCFA	Virement salaire	f712d8d9-57b6-49a4-a8eb-5e04856619a9	2025-06-24 07:53:21	2025-10-23 12:36:58
cc75b5ef-f106-4184-90bc-a5b3d63e4d8f	0c099b4c-0616-44d6-af7a-38ed712edbf0	virement	42921.00	249269.00	206348.00	FCFA	Virement salaire	be33e282-23c2-42e0-8042-11f125606cb1	2025-07-08 13:48:42	2025-10-23 12:36:58
3e562429-a4c7-48fa-b7b0-04ca7f87ee17	0c099b4c-0616-44d6-af7a-38ed712edbf0	retrait	6332.00	249269.00	242937.00	FCFA	Paiement par carte	\N	2025-06-22 00:00:33	2025-10-23 12:36:58
8b894324-2dc5-4211-bc46-a871ecb5285f	f2182e94-c5d0-4b91-8d12-af97e101dd6b	virement	34746.00	385571.00	350825.00	FCFA	Transfert entre comptes	4bf8b802-4714-4aba-a825-d61404c9d50f	2025-08-16 12:28:13	2025-10-23 12:36:58
f5031327-0116-4d06-bb0a-172efdd2eb31	f2182e94-c5d0-4b91-8d12-af97e101dd6b	virement	24305.00	385571.00	361266.00	FCFA	Virement vers compte	727ed0a8-67ac-4066-84fe-a29a0e13bb30	2025-04-30 02:49:41	2025-10-23 12:36:58
6d3e4787-f3b0-4aee-8e1b-74ad0a18918e	f2182e94-c5d0-4b91-8d12-af97e101dd6b	virement	27233.00	385571.00	358338.00	FCFA	Virement salaire	c2b93a8c-ea1e-4b85-8224-c209137135b0	2025-05-09 00:32:06	2025-10-23 12:36:58
4f65b9b6-2a31-479b-9b15-1ca6652cbab1	f2182e94-c5d0-4b91-8d12-af97e101dd6b	retrait	37125.00	385571.00	348446.00	FCFA	Retrait d'espèces	\N	2025-08-24 12:21:54	2025-10-23 12:36:58
46724586-8032-440c-95a3-e6d8c47e3509	f2182e94-c5d0-4b91-8d12-af97e101dd6b	retrait	37102.00	385571.00	348469.00	FCFA	Paiement par carte	\N	2025-07-05 11:00:37	2025-10-23 12:36:58
f9e918e7-c986-4937-aba6-b25344dec711	f2182e94-c5d0-4b91-8d12-af97e101dd6b	retrait	40855.00	385571.00	344716.00	FCFA	Prélèvement automatique	\N	2025-06-21 03:33:26	2025-10-23 12:36:58
0ea151d3-a74a-49e6-90ea-4dbd53d0e76f	f2182e94-c5d0-4b91-8d12-af97e101dd6b	depot	7943.00	385571.00	393514.00	FCFA	Dépôt chèque	\N	2025-05-11 17:07:21	2025-10-23 12:36:58
3dc0c68a-2b4c-44da-abc3-eb5ee649e56e	f2182e94-c5d0-4b91-8d12-af97e101dd6b	depot	26768.00	385571.00	412339.00	FCFA	Dépôt d'espèces	\N	2025-10-04 11:53:49	2025-10-23 12:36:58
32d09ab4-4276-414b-8d60-45a8fa2b613b	f2182e94-c5d0-4b91-8d12-af97e101dd6b	depot	3321.00	385571.00	388892.00	FCFA	Dépôt espèces guichet	\N	2025-05-16 14:52:48	2025-10-23 12:36:58
2d8e6942-747f-42bf-9f9e-cb9065c9f095	f2182e94-c5d0-4b91-8d12-af97e101dd6b	depot	20964.00	385571.00	406535.00	FCFA	Dépôt espèces guichet	\N	2025-06-23 02:04:58	2025-10-23 12:36:58
9990c935-89d8-45be-a27a-a77380d6024e	f2182e94-c5d0-4b91-8d12-af97e101dd6b	retrait	3243.00	385571.00	382328.00	FCFA	Retrait guichet	\N	2025-10-19 02:47:47	2025-10-23 12:36:58
133bd4ba-9cab-4119-af4f-27fe98e2e9ce	f2182e94-c5d0-4b91-8d12-af97e101dd6b	depot	9301.00	385571.00	394872.00	FCFA	Dépôt espèces guichet	\N	2025-08-04 10:38:33	2025-10-23 12:36:58
45ffb7b1-2a82-4cdb-9db6-4514967582fa	232f5785-5fd1-4398-91e2-4f92589e1d8d	retrait	21909.00	345680.00	323771.00	FCFA	Paiement par carte	\N	2025-10-02 06:15:43	2025-10-23 12:36:58
62230fbc-d7e6-4454-8cd2-ae8dba82cad3	232f5785-5fd1-4398-91e2-4f92589e1d8d	virement	13333.00	345680.00	332347.00	FCFA	Transfert bancaire	5930a704-1cad-486a-bb5e-d5ebac8129b9	2025-08-07 11:00:13	2025-10-23 12:36:58
6ed76183-887b-4ada-8691-9546e63a0eef	232f5785-5fd1-4398-91e2-4f92589e1d8d	retrait	7864.00	345680.00	337816.00	FCFA	Retrait DAB	\N	2025-07-02 12:34:21	2025-10-23 12:36:58
7b4fb9ee-8922-4a08-a130-297e2d3875aa	232f5785-5fd1-4398-91e2-4f92589e1d8d	depot	39508.00	345680.00	385188.00	FCFA	Dépôt chèque	\N	2025-05-07 13:54:53	2025-10-23 12:36:58
33582683-6864-4a11-9b2f-6b13653d123c	232f5785-5fd1-4398-91e2-4f92589e1d8d	depot	34274.00	345680.00	379954.00	FCFA	Dépôt d'espèces	\N	2025-09-27 04:36:14	2025-10-23 12:36:58
80afbd61-d73a-4f69-a1dc-13d1e30a101e	232f5785-5fd1-4398-91e2-4f92589e1d8d	depot	26536.00	345680.00	372216.00	FCFA	Dépôt chèque	\N	2025-05-08 21:56:53	2025-10-23 12:36:58
3642a126-8c8c-42cb-92a3-f46dea679cb2	232f5785-5fd1-4398-91e2-4f92589e1d8d	depot	6736.00	345680.00	352416.00	FCFA	Dépôt d'espèces	\N	2025-08-02 02:33:27	2025-10-23 12:36:58
2424da5b-d61a-4cf7-a06f-b24cfffb3201	232f5785-5fd1-4398-91e2-4f92589e1d8d	depot	14534.00	345680.00	360214.00	FCFA	Dépôt d'espèces	\N	2025-07-18 02:00:54	2025-10-23 12:36:58
f01e5b86-b94f-4bcd-9c13-e472ad881d18	232f5785-5fd1-4398-91e2-4f92589e1d8d	depot	10314.00	345680.00	355994.00	FCFA	Dépôt espèces guichet	\N	2025-05-02 09:35:55	2025-10-23 12:36:58
10ddaccc-136d-4eaf-961b-c99308b9b42b	232f5785-5fd1-4398-91e2-4f92589e1d8d	retrait	41240.00	345680.00	304440.00	FCFA	Retrait guichet	\N	2025-07-06 09:23:16	2025-10-23 12:36:58
81b8ac29-ad2c-4b8a-bb17-27414d21f791	232f5785-5fd1-4398-91e2-4f92589e1d8d	retrait	3188.00	345680.00	342492.00	FCFA	Retrait guichet	\N	2025-10-16 08:48:34	2025-10-23 12:36:58
1f399fe7-9a95-4ad7-80f5-025f96b08208	7643d019-9210-424b-b768-667e79ca8da7	virement	24493.00	485706.00	461213.00	FCFA	Transfert bancaire	318d8033-6a1d-4dd6-a669-005de93483d3	2025-07-17 14:21:47	2025-10-23 12:36:58
9a3e1864-faf2-433a-a7d2-4b6090ad6046	7643d019-9210-424b-b768-667e79ca8da7	virement	22862.00	485706.00	462844.00	FCFA	Virement salaire	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	2025-05-11 10:05:32	2025-10-23 12:36:58
d8468ae4-6aa0-4261-8262-fda102396c70	7643d019-9210-424b-b768-667e79ca8da7	retrait	44329.00	485706.00	441377.00	FCFA	Retrait DAB	\N	2025-07-20 09:18:58	2025-10-23 12:36:58
913ffeae-bf6f-4703-b23a-cbf893e267ed	7643d019-9210-424b-b768-667e79ca8da7	depot	12810.00	485706.00	498516.00	FCFA	Dépôt d'espèces	\N	2025-09-29 11:49:58	2025-10-23 12:36:58
b0d5ecdb-8580-4a0c-86eb-cd8a2e00608b	7643d019-9210-424b-b768-667e79ca8da7	retrait	35672.00	485706.00	450034.00	FCFA	Retrait d'espèces	\N	2025-09-27 22:05:58	2025-10-23 12:36:58
67cdc534-21ba-4fea-a0c6-1fe9953547b5	7643d019-9210-424b-b768-667e79ca8da7	depot	29491.00	485706.00	515197.00	FCFA	Versement salaire	\N	2025-06-13 03:23:38	2025-10-23 12:36:58
76dbca45-66fe-40b5-b680-beee0153447f	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	retrait	42668.00	427760.00	385092.00	FCFA	Retrait d'espèces	\N	2025-07-07 23:48:19	2025-10-23 12:36:58
c672b47a-900a-4628-b678-487a64a038d7	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	depot	33702.00	427760.00	461462.00	FCFA	Dépôt espèces guichet	\N	2025-08-24 04:46:39	2025-10-23 12:36:58
31265218-b0cb-4739-bac8-77faa1016730	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	virement	31152.00	427760.00	396608.00	FCFA	Virement vers compte	4e0954f5-1956-40db-b392-7a6ee455c257	2025-08-21 13:49:00	2025-10-23 12:36:58
6410ed4a-33ec-4afd-9dd3-db86c07df5b3	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	virement	23354.00	427760.00	404406.00	FCFA	Transfert entre comptes	bf69dba7-7153-4b9d-885b-f7fa7330e249	2025-08-18 01:11:02	2025-10-23 12:36:58
50c9980e-c27d-4472-9577-9077ec852a71	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	virement	18818.00	427760.00	408942.00	FCFA	Transfert entre comptes	43543b43-8884-4451-8a39-e16cf1e52d3c	2025-10-07 12:26:34	2025-10-23 12:36:58
e244afed-be8f-46e0-8f76-3ef0c6accb10	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	retrait	38506.00	427760.00	389254.00	FCFA	Prélèvement automatique	\N	2025-07-11 12:20:39	2025-10-23 12:36:58
639ff666-c35b-4bb4-92ee-81800b78d1b6	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	depot	16358.00	427760.00	444118.00	FCFA	Dépôt espèces guichet	\N	2025-09-21 09:04:55	2025-10-23 12:36:58
0e4a1a97-d861-42ba-9cc5-9b23db4439bf	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	depot	47053.00	427760.00	474813.00	FCFA	Virement bancaire entrant	\N	2025-05-04 20:23:22	2025-10-23 12:36:58
78ce056e-5323-4d96-a51a-5182df21c71d	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	virement	9820.00	427760.00	417940.00	FCFA	Paiement facture	76b21c81-8380-4df8-87ad-4f2fa9ff5159	2025-08-07 15:19:46	2025-10-23 12:36:58
5a887284-737a-4e5a-b195-a78db95e3440	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	depot	46925.00	427760.00	474685.00	FCFA	Dépôt espèces guichet	\N	2025-07-01 01:15:05	2025-10-23 12:36:58
1cc2d198-d73e-47ff-b3b6-d2b7d2ad9fb0	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	virement	21378.00	427760.00	406382.00	FCFA	Virement salaire	93ec7354-821a-4306-8dcb-5b911268af75	2025-07-06 19:17:37	2025-10-23 12:36:58
af658bee-ba35-4eb6-8b92-a3af93105632	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	virement	5777.00	427760.00	421983.00	FCFA	Virement salaire	dd05cd28-6e89-41fd-8a78-cba1c4607efd	2025-06-19 13:11:27	2025-10-23 12:36:58
3914a9bc-432e-47e8-9d2b-8c55c46ed975	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	virement	24739.00	427760.00	403021.00	FCFA	Virement salaire	82b41651-c63d-4deb-85c6-3c688eddc121	2025-08-16 09:22:07	2025-10-23 12:36:58
f0071bb3-62ba-4296-9fad-15f6d3c98ae0	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	depot	19642.00	393814.00	413456.00	FCFA	Dépôt chèque	\N	2025-06-29 21:27:27	2025-10-23 12:36:58
550d7136-043f-48dd-8965-9a2813e3bed7	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	depot	15398.00	393814.00	409212.00	FCFA	Dépôt d'espèces	\N	2025-07-18 05:39:32	2025-10-23 12:36:58
147ede7b-9278-4b8f-9e92-88c92cf0649b	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	retrait	39793.00	393814.00	354021.00	FCFA	Retrait DAB	\N	2025-09-20 17:30:06	2025-10-23 12:36:58
81edb679-4269-4c13-b730-22d7e2c6bc07	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	depot	25715.00	393814.00	419529.00	FCFA	Versement salaire	\N	2025-09-22 10:52:06	2025-10-23 12:36:58
d603a9d1-706c-49eb-ac0c-e80f2ab9f4e1	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	virement	1373.00	393814.00	392441.00	FCFA	Virement salaire	792c8ff4-749b-469b-95d0-9b98c2283684	2025-07-17 01:34:19	2025-10-23 12:36:58
00e03401-0cd8-4327-80d3-1ff783fcad83	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	depot	12284.00	393814.00	406098.00	FCFA	Dépôt chèque	\N	2025-08-01 18:31:33	2025-10-23 12:36:58
2fec3b7c-dac3-49f5-b4da-8c691872191e	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	depot	47933.00	393814.00	441747.00	FCFA	Versement salaire	\N	2025-07-03 13:09:59	2025-10-23 12:36:58
228163ab-ae72-4824-a73a-1a3d522e1454	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	depot	6741.00	393814.00	400555.00	FCFA	Dépôt chèque	\N	2025-07-06 16:35:59	2025-10-23 12:36:58
b7a6d4dc-90c2-46d1-91d9-10840dac6e11	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	virement	29965.00	393814.00	363849.00	FCFA	Virement salaire	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	2025-05-24 16:06:23	2025-10-23 12:36:58
359a291d-61e5-4911-b324-94ac218d98e5	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	retrait	22668.00	89619.00	66951.00	FCFA	Retrait DAB	\N	2025-08-28 14:08:14	2025-10-23 12:36:58
4f4d4959-00d4-448a-ab59-4ffe91c38bb7	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	virement	21551.00	89619.00	68068.00	FCFA	Transfert entre comptes	1dcc883b-0fa9-48e7-a2bb-6af516dfeb44	2025-06-04 10:36:33	2025-10-23 12:36:58
bae9d4a4-1d76-4adf-82b2-dea98554fe74	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	virement	42651.00	89619.00	46968.00	FCFA	Transfert entre comptes	94b14a72-e4f3-4e5f-ae72-8e6f72e4e901	2025-07-02 19:17:06	2025-10-23 12:36:58
2d67fc0a-094b-41d9-924d-dba62578f6af	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	virement	25196.00	89619.00	64423.00	FCFA	Virement salaire	801e068b-fdc3-4606-bc83-42d2e3fc4a67	2025-08-23 21:28:17	2025-10-23 12:36:58
27723183-b0d7-4c47-bf5c-f2932b463363	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	depot	47209.00	89619.00	136828.00	FCFA	Dépôt espèces guichet	\N	2025-09-14 03:50:33	2025-10-23 12:36:58
e23d3c07-a1a9-4e1a-bbcb-bbdcb8056d0a	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	depot	18417.00	89619.00	108036.00	FCFA	Versement salaire	\N	2025-07-06 10:20:38	2025-10-23 12:36:58
9af5c6e5-9765-49e6-94d5-825a44ff63cf	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	retrait	1709.00	89619.00	87910.00	FCFA	Retrait d'espèces	\N	2025-10-09 21:36:45	2025-10-23 12:36:58
cabecfb9-e8ea-4e38-aad9-23e70d958f1b	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	virement	7574.00	89619.00	82045.00	FCFA	Transfert bancaire	9c0923b4-0a14-4650-8df8-edf426310de6	2025-06-15 05:05:44	2025-10-23 12:36:58
da90f284-4b7f-4e37-91fa-cfbda903c889	4e0954f5-1956-40db-b392-7a6ee455c257	retrait	8291.00	10565.00	2274.00	FCFA	Retrait DAB	\N	2025-10-15 21:06:12	2025-10-23 12:36:58
4850912d-7527-4793-902e-9e72838cfc5e	4e0954f5-1956-40db-b392-7a6ee455c257	depot	25754.00	10565.00	36319.00	FCFA	Dépôt d'espèces	\N	2025-07-14 07:30:40	2025-10-23 12:36:58
c2a4521b-958a-40b1-93e5-3ea8eddc7d74	4e0954f5-1956-40db-b392-7a6ee455c257	virement	33905.00	10565.00	0.00	FCFA	Virement salaire	3014d690-a71d-4cb9-ba59-a6c4fea73558	2025-07-19 23:33:58	2025-10-23 12:36:58
04637004-f1cb-4d19-b338-df37d120dd20	4e0954f5-1956-40db-b392-7a6ee455c257	retrait	17685.00	10565.00	0.00	FCFA	Retrait d'espèces	\N	2025-06-14 15:21:32	2025-10-23 12:36:58
a979b17e-5377-41a4-a218-916649142e63	4e0954f5-1956-40db-b392-7a6ee455c257	virement	8583.00	10565.00	1982.00	FCFA	Paiement facture	65da4070-27f5-40a7-99d9-db64e3163a65	2025-05-15 10:32:40	2025-10-23 12:36:58
ce2bed7d-fa8b-45dc-9957-4f5af739af7c	4e0954f5-1956-40db-b392-7a6ee455c257	depot	7870.00	10565.00	18435.00	FCFA	Versement salaire	\N	2025-06-19 12:07:05	2025-10-23 12:36:58
1f910052-9eae-4cd2-bb0b-3e18de3ea283	4e0954f5-1956-40db-b392-7a6ee455c257	virement	40162.00	10565.00	0.00	FCFA	Transfert entre comptes	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	2025-05-10 03:32:43	2025-10-23 12:36:58
5b141e4f-a2ea-418b-8bb1-6e50b9aaa5c4	4e0954f5-1956-40db-b392-7a6ee455c257	retrait	39759.00	10565.00	0.00	FCFA	Paiement par carte	\N	2025-10-13 05:05:13	2025-10-23 12:36:58
f1482c0f-988d-4a2f-b96d-f9ee86c7d0a7	4e0954f5-1956-40db-b392-7a6ee455c257	depot	44888.00	10565.00	55453.00	FCFA	Dépôt chèque	\N	2025-08-29 02:22:55	2025-10-23 12:36:58
fa29fcdc-cf17-402b-aa82-058094591084	4e0954f5-1956-40db-b392-7a6ee455c257	retrait	21225.00	10565.00	0.00	FCFA	Retrait DAB	\N	2025-06-14 23:49:58	2025-10-23 12:36:58
3c238103-36ce-4095-8fbd-f2e2abbcff9e	4e0954f5-1956-40db-b392-7a6ee455c257	virement	41628.00	10565.00	0.00	FCFA	Transfert bancaire	cb45ecae-4f73-42b2-870b-4f41321c9acd	2025-07-15 07:27:22	2025-10-23 12:36:58
a92a9e72-262b-4001-9d86-22e3be1e422a	4e0954f5-1956-40db-b392-7a6ee455c257	virement	25153.00	10565.00	0.00	FCFA	Virement vers compte	aefad6a9-6ff4-4250-b79c-50f551aaa60e	2025-10-16 11:03:04	2025-10-23 12:36:58
83ff3e50-ad52-4d78-a205-057fe234e626	4e0954f5-1956-40db-b392-7a6ee455c257	virement	12264.00	10565.00	0.00	FCFA	Transfert bancaire	34b84e17-27b4-4080-a77b-3cdb00476a06	2025-08-01 14:56:13	2025-10-23 12:36:58
58aeea59-0ad4-4fee-bdd0-3d6fc6ca39a8	4e0954f5-1956-40db-b392-7a6ee455c257	retrait	47768.00	10565.00	0.00	FCFA	Prélèvement automatique	\N	2025-07-16 13:15:32	2025-10-23 12:36:58
5e6812a1-f69b-4bd8-9306-0775b32f739f	4e0954f5-1956-40db-b392-7a6ee455c257	retrait	32231.00	10565.00	0.00	FCFA	Retrait guichet	\N	2025-08-26 12:16:33	2025-10-23 12:36:58
bfffb7c6-4656-49b0-aa48-cb7ae104b067	473ba79b-f520-481d-82b7-0a94c75586be	depot	41876.00	496613.00	538489.00	FCFA	Dépôt d'espèces	\N	2025-06-06 21:25:52	2025-10-23 12:36:58
1c3dc3f6-3cd7-4d51-9d0a-95afa76d8152	473ba79b-f520-481d-82b7-0a94c75586be	virement	35190.00	496613.00	461423.00	FCFA	Virement salaire	e7088ab6-655b-4317-8cdf-46d3de12e2f0	2025-05-27 07:24:11	2025-10-23 12:36:58
da5955c1-2b88-4c09-aa60-4a7ebd3470a3	473ba79b-f520-481d-82b7-0a94c75586be	retrait	39426.00	496613.00	457187.00	FCFA	Retrait guichet	\N	2025-06-15 07:25:30	2025-10-23 12:36:58
0c89a2f9-e55b-4bdd-a51d-fc0ba98b91cc	473ba79b-f520-481d-82b7-0a94c75586be	virement	13733.00	496613.00	482880.00	FCFA	Paiement facture	93ec7354-821a-4306-8dcb-5b911268af75	2025-07-19 19:03:19	2025-10-23 12:36:58
bcc77ffc-a962-479c-9c2c-511e97c66e0f	473ba79b-f520-481d-82b7-0a94c75586be	virement	20583.00	496613.00	476030.00	FCFA	Transfert entre comptes	f3db8624-1334-47ff-83bb-04592844270f	2025-10-16 12:17:35	2025-10-23 12:36:58
1c7ae7ba-14e1-4455-9e4a-dbff3effa139	473ba79b-f520-481d-82b7-0a94c75586be	depot	48398.00	496613.00	545011.00	FCFA	Dépôt espèces guichet	\N	2025-06-01 01:29:24	2025-10-23 12:36:58
f55f6f32-87aa-47cd-ace6-c3587f848ebf	473ba79b-f520-481d-82b7-0a94c75586be	retrait	30445.00	496613.00	466168.00	FCFA	Retrait DAB	\N	2025-09-29 06:07:20	2025-10-23 12:36:58
cc604da2-36f2-4b0b-ac3b-28b22f44c2fe	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	depot	22715.00	123995.00	146710.00	FCFA	Dépôt espèces guichet	\N	2025-09-04 18:38:29	2025-10-23 12:36:58
fe5e58f3-298a-445d-8077-6c3c82b37f2a	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	retrait	4804.00	123995.00	119191.00	FCFA	Retrait DAB	\N	2025-07-26 07:12:54	2025-10-23 12:36:58
5120fd03-9f2a-4ebb-b6f4-2e6e8c3b5e39	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	virement	42059.00	123995.00	81936.00	FCFA	Virement salaire	801e068b-fdc3-4606-bc83-42d2e3fc4a67	2025-07-12 11:18:14	2025-10-23 12:36:58
10a9cd61-44a1-4313-8283-a3c8d2fb4202	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	depot	13408.00	123995.00	137403.00	FCFA	Virement bancaire entrant	\N	2025-07-16 10:30:45	2025-10-23 12:36:58
bd6c6d16-2bf5-4429-bc38-a0c478a1e624	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	retrait	1742.00	123995.00	122253.00	FCFA	Retrait d'espèces	\N	2025-10-14 19:00:09	2025-10-23 12:36:58
25e052fa-f6fc-49a4-bd47-75e17da5b685	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	virement	44242.00	123995.00	79753.00	FCFA	Paiement facture	df088290-3d37-4591-8571-389b37349b2a	2025-10-18 13:16:41	2025-10-23 12:36:58
23872df9-d3dd-411c-9bde-6a4d79320f56	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	retrait	2385.00	123995.00	121610.00	FCFA	Retrait guichet	\N	2025-07-18 20:45:29	2025-10-23 12:36:58
c19a2f1f-a7f6-4372-a207-798f0466ba6a	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	depot	17721.00	123995.00	141716.00	FCFA	Versement salaire	\N	2025-05-19 07:12:18	2025-10-23 12:36:58
d129f13d-bb84-4f20-9536-8449aa86411f	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	virement	1464.00	123995.00	122531.00	FCFA	Virement vers compte	f61a5805-715d-476c-89ef-33958e3cf001	2025-09-02 06:22:23	2025-10-23 12:36:58
c7b283b6-2594-4470-b745-328c2eba29f1	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	depot	45491.00	123995.00	169486.00	FCFA	Virement bancaire entrant	\N	2025-09-02 12:18:31	2025-10-23 12:36:58
8023c0fa-d3be-4dc6-aa8d-4acca5706169	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	retrait	42449.00	123995.00	81546.00	FCFA	Retrait d'espèces	\N	2025-05-06 06:15:03	2025-10-23 12:36:58
1baffc88-9dfd-4c88-b6c9-55b1e6f6f613	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	depot	8483.00	123995.00	132478.00	FCFA	Versement salaire	\N	2025-08-04 08:58:43	2025-10-23 12:36:58
cbe098d0-a327-4fb4-aeb5-a1565646a003	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	depot	34569.00	123995.00	158564.00	FCFA	Dépôt espèces guichet	\N	2025-10-19 01:27:54	2025-10-23 12:36:58
68052388-0d39-44f7-80f9-8c6fcbe88c53	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	virement	49379.00	123995.00	74616.00	FCFA	Transfert bancaire	2e311570-14e5-403a-a71f-698c77f8454d	2025-10-03 12:05:47	2025-10-23 12:36:58
eca195a2-a69f-4d15-9a0a-a98be8432392	e5fbfcb0-c796-4371-80c6-f78f1038a282	retrait	27960.00	475214.00	447254.00	FCFA	Prélèvement automatique	\N	2025-07-27 02:09:46	2025-10-23 12:36:58
dc816065-9e47-4090-877f-062c71c60831	e5fbfcb0-c796-4371-80c6-f78f1038a282	retrait	16987.00	475214.00	458227.00	FCFA	Retrait d'espèces	\N	2025-08-31 21:55:22	2025-10-23 12:36:58
b2ac3afe-a3a9-4c90-a8b5-bda87ad686f2	e5fbfcb0-c796-4371-80c6-f78f1038a282	virement	44624.00	475214.00	430590.00	FCFA	Transfert entre comptes	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	2025-09-17 06:32:46	2025-10-23 12:36:58
2fb823cb-4176-4287-89e7-b9aadb9b72fb	e5fbfcb0-c796-4371-80c6-f78f1038a282	depot	36986.00	475214.00	512200.00	FCFA	Dépôt chèque	\N	2025-06-29 06:31:13	2025-10-23 12:36:58
8a3c558a-a539-4acf-8fb0-174c16c2f926	e5fbfcb0-c796-4371-80c6-f78f1038a282	virement	32358.00	475214.00	442856.00	FCFA	Virement salaire	61bcb7e8-d7d1-45da-9b25-70fba627d304	2025-06-06 22:25:33	2025-10-23 12:36:58
51a2a9aa-ab54-4771-a6e1-c05f206ba90d	7b3221a6-3b25-4cc8-a934-e795af882682	virement	15051.00	24767.00	9716.00	FCFA	Transfert entre comptes	db289a68-fb56-4357-aa96-60bcaab5608f	2025-07-20 12:28:42	2025-10-23 12:36:58
8e738a3a-8518-4acd-b703-6f8fa3e4e86d	7b3221a6-3b25-4cc8-a934-e795af882682	virement	29250.00	24767.00	0.00	FCFA	Paiement facture	76b21c81-8380-4df8-87ad-4f2fa9ff5159	2025-07-03 08:47:34	2025-10-23 12:36:58
a07fc56c-0cce-4df1-9067-85f7f5c6ee40	7b3221a6-3b25-4cc8-a934-e795af882682	retrait	14114.00	24767.00	10653.00	FCFA	Paiement par carte	\N	2025-09-02 03:25:05	2025-10-23 12:36:58
506682f6-f710-42ba-813b-1e3997ae316a	7b3221a6-3b25-4cc8-a934-e795af882682	virement	45092.00	24767.00	0.00	FCFA	Transfert entre comptes	d725e859-df50-4ee3-8ab9-65d82dc7fd71	2025-05-14 05:17:11	2025-10-23 12:36:58
c2e6e5ca-4f9f-437a-9cd2-c39a4b87f93b	7b3221a6-3b25-4cc8-a934-e795af882682	retrait	15109.00	24767.00	9658.00	FCFA	Retrait DAB	\N	2025-07-01 14:26:37	2025-10-23 12:36:58
4902f82f-6a7d-4f59-860c-5ee388346c39	7b3221a6-3b25-4cc8-a934-e795af882682	virement	26674.00	24767.00	0.00	FCFA	Paiement facture	76b21c81-8380-4df8-87ad-4f2fa9ff5159	2025-05-19 22:00:44	2025-10-23 12:36:58
28e7fd75-442c-466c-9d30-d89ab7d112b6	7b3221a6-3b25-4cc8-a934-e795af882682	depot	22588.00	24767.00	47355.00	FCFA	Virement bancaire entrant	\N	2025-06-01 00:32:05	2025-10-23 12:36:58
b115e7c3-c6f1-4522-b997-da3e5b47cf14	7b3221a6-3b25-4cc8-a934-e795af882682	retrait	35906.00	24767.00	0.00	FCFA	Paiement par carte	\N	2025-09-20 09:12:12	2025-10-23 12:36:58
8a81e360-c150-467e-8053-f1feff0fb110	7b3221a6-3b25-4cc8-a934-e795af882682	retrait	47262.00	24767.00	0.00	FCFA	Paiement par carte	\N	2025-09-23 06:13:21	2025-10-23 12:36:58
a313e95c-176d-409b-bf47-68fdb0d71680	1eece79a-3f27-456a-8f76-0b4de6cba5e4	retrait	12545.00	159512.00	146967.00	FCFA	Paiement par carte	\N	2025-06-18 07:34:12	2025-10-23 12:36:58
47b22d38-dd72-48e6-9a8d-aea3deb1e4bc	1eece79a-3f27-456a-8f76-0b4de6cba5e4	retrait	47724.00	159512.00	111788.00	FCFA	Retrait guichet	\N	2025-06-19 17:07:09	2025-10-23 12:36:58
1773aa56-c880-4b32-ba9d-109f066979be	1eece79a-3f27-456a-8f76-0b4de6cba5e4	retrait	33706.00	159512.00	125806.00	FCFA	Prélèvement automatique	\N	2025-08-04 15:27:53	2025-10-23 12:36:58
ce23f984-170b-4ba2-85fd-55ec9dcdb32d	1eece79a-3f27-456a-8f76-0b4de6cba5e4	depot	19211.00	159512.00	178723.00	FCFA	Virement bancaire entrant	\N	2025-08-28 01:05:56	2025-10-23 12:36:58
973f7b1c-fc35-48e6-87de-a9bd202a2771	1eece79a-3f27-456a-8f76-0b4de6cba5e4	virement	44383.00	159512.00	115129.00	FCFA	Virement salaire	3535c846-b093-454b-9743-84b4b3fa9719	2025-09-05 02:55:55	2025-10-23 12:36:58
c1297772-8722-4704-b33f-af83e48774fc	1eece79a-3f27-456a-8f76-0b4de6cba5e4	virement	6487.00	159512.00	153025.00	FCFA	Paiement facture	f3db8624-1334-47ff-83bb-04592844270f	2025-06-16 12:27:01	2025-10-23 12:36:58
f176bb27-7bff-467e-a682-4c7107c65737	a1f1990b-1819-4977-aaf0-bb14a824daa0	retrait	23016.00	396980.00	373964.00	FCFA	Retrait guichet	\N	2025-06-22 22:08:17	2025-10-23 12:36:58
8c0add0b-e590-43fd-b03f-36ce8ce33535	a1f1990b-1819-4977-aaf0-bb14a824daa0	depot	49885.00	396980.00	446865.00	FCFA	Dépôt espèces guichet	\N	2025-10-07 04:41:53	2025-10-23 12:36:58
e9b647ef-a8a3-4890-ac66-33f947f1f129	a1f1990b-1819-4977-aaf0-bb14a824daa0	virement	40359.00	396980.00	356621.00	FCFA	Transfert bancaire	b26e640d-87a1-49a8-a880-2a2088a4fca0	2025-08-18 10:26:24	2025-10-23 12:36:58
8814629e-89cd-4f76-9316-3ccc730bc48a	a1f1990b-1819-4977-aaf0-bb14a824daa0	retrait	23269.00	396980.00	373711.00	FCFA	Paiement par carte	\N	2025-07-20 09:57:29	2025-10-23 12:36:58
b6cb8838-0db7-4f9f-a617-d5b408af2b97	a1f1990b-1819-4977-aaf0-bb14a824daa0	retrait	15745.00	396980.00	381235.00	FCFA	Retrait d'espèces	\N	2025-09-22 16:18:12	2025-10-23 12:36:58
3cb7a5b8-8585-47ee-8570-b24392a78de7	a1f1990b-1819-4977-aaf0-bb14a824daa0	depot	1395.00	396980.00	398375.00	FCFA	Dépôt chèque	\N	2025-09-03 23:54:26	2025-10-23 12:36:58
502a46f5-9ae2-461f-8f2d-ba737d1d905a	a1f1990b-1819-4977-aaf0-bb14a824daa0	virement	14127.00	396980.00	382853.00	FCFA	Transfert entre comptes	41e95b7c-81f4-4383-8e18-448d1ab5bd48	2025-08-18 08:13:41	2025-10-23 12:36:58
d70f6f74-4aff-4bbe-958d-e317bc28d972	a1f1990b-1819-4977-aaf0-bb14a824daa0	depot	18148.00	396980.00	415128.00	FCFA	Virement bancaire entrant	\N	2025-04-29 16:44:20	2025-10-23 12:36:58
b5b113af-0ffc-4c0b-bbdc-0accad361ee4	a1f1990b-1819-4977-aaf0-bb14a824daa0	depot	22921.00	396980.00	419901.00	FCFA	Dépôt espèces guichet	\N	2025-06-11 00:29:19	2025-10-23 12:36:58
2067198f-583b-418b-a27f-d95a3e39c398	a1f1990b-1819-4977-aaf0-bb14a824daa0	virement	10187.00	396980.00	386793.00	FCFA	Virement vers compte	9b7cf121-0b29-4457-b5ee-acddd651474c	2025-04-24 23:06:40	2025-10-23 12:36:58
43233de7-4fe8-4b71-9fc9-8cd0d89a06d3	a1f1990b-1819-4977-aaf0-bb14a824daa0	retrait	10185.00	396980.00	386795.00	FCFA	Retrait d'espèces	\N	2025-09-20 08:12:38	2025-10-23 12:36:58
5fd04108-c4be-4750-ba20-def678de286e	a1f1990b-1819-4977-aaf0-bb14a824daa0	depot	12797.00	396980.00	409777.00	FCFA	Versement salaire	\N	2025-06-19 16:49:05	2025-10-23 12:36:58
2a1a4d5a-c6c2-41ab-8f14-2b74cf5559e8	1a2a915d-173c-44e7-a655-e29b9a02fd18	virement	37976.00	174764.00	136788.00	FCFA	Transfert bancaire	e7088ab6-655b-4317-8cdf-46d3de12e2f0	2025-06-01 01:22:16	2025-10-23 12:36:58
d6374e07-5ba1-48f8-8aca-d168bd3fe56e	1a2a915d-173c-44e7-a655-e29b9a02fd18	retrait	20025.00	174764.00	154739.00	FCFA	Paiement par carte	\N	2025-09-24 04:33:54	2025-10-23 12:36:58
334377db-5bc5-4e54-a1b5-10341cd59419	1a2a915d-173c-44e7-a655-e29b9a02fd18	depot	42057.00	174764.00	216821.00	FCFA	Dépôt espèces guichet	\N	2025-04-30 01:43:59	2025-10-23 12:36:58
59dc9ea7-69d8-4538-8f8c-226db6b74ec0	1a2a915d-173c-44e7-a655-e29b9a02fd18	depot	27914.00	174764.00	202678.00	FCFA	Virement bancaire entrant	\N	2025-07-29 12:02:52	2025-10-23 12:36:58
289e46e9-0a44-4e4a-9e5e-b9aabdbfffce	1a2a915d-173c-44e7-a655-e29b9a02fd18	retrait	38101.00	174764.00	136663.00	FCFA	Retrait d'espèces	\N	2025-07-15 14:47:13	2025-10-23 12:36:58
ad9ddc94-4cbd-4086-b1bf-1030ca00ffda	8d706bac-d7d8-4172-8d94-d1a8cdf604db	depot	46370.00	333318.00	379688.00	FCFA	Dépôt d'espèces	\N	2025-05-20 19:23:38	2025-10-23 12:36:58
5b93e11a-19a6-41c7-8d61-80f93beb58ca	8d706bac-d7d8-4172-8d94-d1a8cdf604db	depot	32691.00	333318.00	366009.00	FCFA	Dépôt espèces guichet	\N	2025-05-15 21:22:46	2025-10-23 12:36:58
4dc1179d-daec-4e64-be96-0f54816a0320	8d706bac-d7d8-4172-8d94-d1a8cdf604db	virement	34856.00	333318.00	298462.00	FCFA	Transfert bancaire	dbcd0804-e931-4453-9ad5-f978ceebb511	2025-07-20 21:05:49	2025-10-23 12:36:58
99d5f687-40e9-44ec-ad7e-c0d80e0b7b7b	8d706bac-d7d8-4172-8d94-d1a8cdf604db	depot	21925.00	333318.00	355243.00	FCFA	Dépôt espèces guichet	\N	2025-06-17 04:54:18	2025-10-23 12:36:58
d876d0ba-fccf-470d-b16a-68edc61fa327	8d706bac-d7d8-4172-8d94-d1a8cdf604db	retrait	16099.00	333318.00	317219.00	FCFA	Retrait guichet	\N	2025-05-27 05:17:07	2025-10-23 12:36:58
9b41cf81-6942-459b-8133-4bf4a867edf6	8d706bac-d7d8-4172-8d94-d1a8cdf604db	depot	5160.00	333318.00	338478.00	FCFA	Virement bancaire entrant	\N	2025-05-02 09:45:35	2025-10-23 12:36:58
912339ff-1806-4928-b291-4808da6fd0a6	8d706bac-d7d8-4172-8d94-d1a8cdf604db	virement	42202.00	333318.00	291116.00	FCFA	Transfert bancaire	8cc906e8-f49e-48bf-97f7-063a96dd5855	2025-07-31 15:50:49	2025-10-23 12:36:58
32feff1d-e48d-4c7b-8873-72f19695495a	8d706bac-d7d8-4172-8d94-d1a8cdf604db	depot	9165.00	333318.00	342483.00	FCFA	Dépôt espèces guichet	\N	2025-09-22 17:00:35	2025-10-23 12:36:58
f56e7ca9-61b0-426c-87b2-16c7c400a537	3b545ec9-8048-4c12-a074-df603671d400	retrait	5518.00	483714.00	478196.00	FCFA	Retrait guichet	\N	2025-04-26 04:25:34	2025-10-23 12:36:58
1903a906-1ad6-4691-bf58-fbc3d8166e51	3b545ec9-8048-4c12-a074-df603671d400	virement	48181.00	483714.00	435533.00	FCFA	Transfert entre comptes	d3ba6f50-5b24-4a03-9002-ded93f5697a3	2025-09-30 09:43:04	2025-10-23 12:36:58
26b7d02c-7b04-4596-8d9e-72c99747a97a	3b545ec9-8048-4c12-a074-df603671d400	depot	45180.00	483714.00	528894.00	FCFA	Versement salaire	\N	2025-05-16 18:26:24	2025-10-23 12:36:58
f6e7a701-3cd9-419e-bf6d-bf17696909fe	3b545ec9-8048-4c12-a074-df603671d400	depot	42614.00	483714.00	526328.00	FCFA	Dépôt chèque	\N	2025-10-22 00:45:28	2025-10-23 12:36:58
98f1d504-8635-4c9c-8dbb-f52382f04f71	3b545ec9-8048-4c12-a074-df603671d400	virement	4187.00	483714.00	479527.00	FCFA	Transfert bancaire	e88eac49-5c57-48f8-824a-813a7da0fdc3	2025-07-07 14:24:09	2025-10-23 12:36:58
18ac666b-6598-43e0-89df-e0aca4ef6f1d	3b545ec9-8048-4c12-a074-df603671d400	retrait	21335.00	483714.00	462379.00	FCFA	Paiement par carte	\N	2025-06-19 16:42:00	2025-10-23 12:36:58
2fd0f7b9-b62e-403f-b4bb-979078122276	3b545ec9-8048-4c12-a074-df603671d400	depot	36557.00	483714.00	520271.00	FCFA	Dépôt d'espèces	\N	2025-06-07 15:18:00	2025-10-23 12:36:58
4fab58be-1943-4756-9196-1a48b1dd9cd9	3b545ec9-8048-4c12-a074-df603671d400	depot	49886.00	483714.00	533600.00	FCFA	Virement bancaire entrant	\N	2025-07-17 23:42:24	2025-10-23 12:36:58
3e4362b3-4226-4386-8bcb-736da0899de1	3b545ec9-8048-4c12-a074-df603671d400	retrait	7179.00	483714.00	476535.00	FCFA	Retrait d'espèces	\N	2025-08-25 14:23:43	2025-10-23 12:36:58
d7884333-f321-4fd1-8882-6d8c4666dd74	3b545ec9-8048-4c12-a074-df603671d400	depot	49587.00	483714.00	533301.00	FCFA	Dépôt espèces guichet	\N	2025-10-23 04:05:25	2025-10-23 12:36:58
b2136b3e-84dc-4dde-bb26-0e81c531f021	3b545ec9-8048-4c12-a074-df603671d400	virement	40623.00	483714.00	443091.00	FCFA	Transfert bancaire	e7088ab6-655b-4317-8cdf-46d3de12e2f0	2025-07-28 11:49:42	2025-10-23 12:36:58
ee34bac7-6701-494c-a5d1-a5658f367c8c	3b545ec9-8048-4c12-a074-df603671d400	retrait	42392.00	483714.00	441322.00	FCFA	Retrait DAB	\N	2025-09-25 07:07:53	2025-10-23 12:36:58
4169dc70-da97-4d03-9af5-2367ce3ea68a	3b545ec9-8048-4c12-a074-df603671d400	retrait	43529.00	483714.00	440185.00	FCFA	Prélèvement automatique	\N	2025-06-19 18:56:53	2025-10-23 12:36:58
027538e5-22e9-4b1e-9841-9e7a8dba6b10	3b545ec9-8048-4c12-a074-df603671d400	retrait	12560.00	483714.00	471154.00	FCFA	Retrait guichet	\N	2025-06-25 01:20:31	2025-10-23 12:36:58
6187eae7-6d2d-4ccd-9159-cc4b2105fc8c	61bcb7e8-d7d1-45da-9b25-70fba627d304	depot	47378.00	227247.00	274625.00	FCFA	Dépôt d'espèces	\N	2025-09-04 10:45:39	2025-10-23 12:36:58
99e43099-4e3d-4e38-a3b8-e457c2e583c6	61bcb7e8-d7d1-45da-9b25-70fba627d304	retrait	45883.00	227247.00	181364.00	FCFA	Retrait DAB	\N	2025-07-23 16:39:15	2025-10-23 12:36:58
f161cacc-03c4-4903-a937-de4c9d9b8831	61bcb7e8-d7d1-45da-9b25-70fba627d304	retrait	18568.00	227247.00	208679.00	FCFA	Retrait DAB	\N	2025-06-08 23:51:52	2025-10-23 12:36:58
aac3791a-372b-4f30-87e3-362225565bd2	61bcb7e8-d7d1-45da-9b25-70fba627d304	retrait	17236.00	227247.00	210011.00	FCFA	Retrait DAB	\N	2025-09-29 05:00:41	2025-10-23 12:36:58
3d205277-5528-4892-8927-232f62cf86fc	61bcb7e8-d7d1-45da-9b25-70fba627d304	virement	37644.00	227247.00	189603.00	FCFA	Transfert entre comptes	f46f2dde-ba75-4234-b729-67c0cd2a3ade	2025-09-28 09:02:12	2025-10-23 12:36:58
32554031-e485-453c-816a-c9c05a5f07b6	61bcb7e8-d7d1-45da-9b25-70fba627d304	retrait	8297.00	227247.00	218950.00	FCFA	Retrait guichet	\N	2025-06-25 01:15:20	2025-10-23 12:36:58
45a3f267-e5bb-4557-ab8c-63d4358b27fe	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	depot	45041.00	113941.00	158982.00	FCFA	Dépôt d'espèces	\N	2025-08-10 21:06:41	2025-10-23 12:36:58
05b4ca15-2a9a-4082-a16e-a7db3bad32a0	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	retrait	15808.00	113941.00	98133.00	FCFA	Retrait guichet	\N	2025-09-09 22:34:59	2025-10-23 12:36:58
b06f9415-285c-41c4-ad6a-162978f15b0f	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	virement	41566.00	113941.00	72375.00	FCFA	Virement salaire	64203f77-d74d-4752-9e2b-7a1c40547be9	2025-09-12 01:54:52	2025-10-23 12:36:58
11e8e9fc-d1c0-4555-a140-ea2a5e93af86	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	depot	26455.00	113941.00	140396.00	FCFA	Dépôt d'espèces	\N	2025-05-24 01:55:08	2025-10-23 12:36:58
d4b2c0b6-0b31-4f21-aff9-b07ba42d2176	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	retrait	15933.00	113941.00	98008.00	FCFA	Prélèvement automatique	\N	2025-07-25 09:54:40	2025-10-23 12:36:58
f4d75acc-8c75-410d-90e4-651067843870	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	retrait	15001.00	113941.00	98940.00	FCFA	Prélèvement automatique	\N	2025-09-01 15:53:03	2025-10-23 12:36:58
ae7fa75d-b45b-465d-94aa-22c54e81f442	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	depot	28574.00	113941.00	142515.00	FCFA	Dépôt d'espèces	\N	2025-10-15 08:57:30	2025-10-23 12:36:58
55d95a5b-cb13-4802-b987-af54a46a2795	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	virement	36199.00	113941.00	77742.00	FCFA	Transfert entre comptes	4bb7fc9b-13d6-4883-b751-283b753d05ed	2025-06-16 23:02:31	2025-10-23 12:36:58
6d9aed42-9659-477d-8042-024d10166394	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	virement	15526.00	113941.00	98415.00	FCFA	Virement salaire	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	2025-05-31 09:13:41	2025-10-23 12:36:58
c071b80b-4610-4537-b4db-4e7a63e490d5	9c0923b4-0a14-4650-8df8-edf426310de6	depot	31851.00	33137.00	64988.00	FCFA	Dépôt d'espèces	\N	2025-06-04 11:22:51	2025-10-23 12:36:58
37b13a65-3b3e-4d57-8fc7-73d3d14e7769	9c0923b4-0a14-4650-8df8-edf426310de6	depot	5968.00	33137.00	39105.00	FCFA	Dépôt chèque	\N	2025-06-20 19:14:42	2025-10-23 12:36:58
1bbecf98-9bd9-4387-995b-2a8b7b72deaa	9c0923b4-0a14-4650-8df8-edf426310de6	depot	36742.00	33137.00	69879.00	FCFA	Dépôt d'espèces	\N	2025-10-17 19:49:49	2025-10-23 12:36:58
cba1e80d-4422-4a61-856f-6b6d6ef7ab60	9c0923b4-0a14-4650-8df8-edf426310de6	retrait	30206.00	33137.00	2931.00	FCFA	Prélèvement automatique	\N	2025-07-16 10:13:44	2025-10-23 12:36:58
5f113316-2156-4c29-bba1-d76a4a149700	9c0923b4-0a14-4650-8df8-edf426310de6	depot	45417.00	33137.00	78554.00	FCFA	Virement bancaire entrant	\N	2025-08-09 17:51:12	2025-10-23 12:36:58
c8c95c1d-0812-477e-9682-10e6b2660fb2	93ec7354-821a-4306-8dcb-5b911268af75	virement	22874.00	397957.00	375083.00	FCFA	Transfert bancaire	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	2025-10-21 22:08:35	2025-10-23 12:36:58
6437f0fe-8979-4c8c-920b-4e0ea5b6ac75	93ec7354-821a-4306-8dcb-5b911268af75	depot	45908.00	397957.00	443865.00	FCFA	Virement bancaire entrant	\N	2025-09-13 20:38:46	2025-10-23 12:36:58
197f1074-d711-48fd-a412-ccfcf5fcbbeb	93ec7354-821a-4306-8dcb-5b911268af75	depot	29827.00	397957.00	427784.00	FCFA	Virement bancaire entrant	\N	2025-08-13 21:40:01	2025-10-23 12:36:58
bb65d35f-67b1-4520-bce5-2969a4196971	93ec7354-821a-4306-8dcb-5b911268af75	virement	25408.00	397957.00	372549.00	FCFA	Virement salaire	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	2025-05-27 11:39:29	2025-10-23 12:36:58
4150ce93-3cba-4613-a40e-e3ce39e06052	93ec7354-821a-4306-8dcb-5b911268af75	virement	11268.00	397957.00	386689.00	FCFA	Virement vers compte	5097b2e2-ee3c-4043-944d-ba4167071409	2025-05-22 08:08:58	2025-10-23 12:36:58
598c1901-e4f2-428e-acae-53b12ea07f2e	93ec7354-821a-4306-8dcb-5b911268af75	depot	22581.00	397957.00	420538.00	FCFA	Dépôt chèque	\N	2025-09-06 22:58:58	2025-10-23 12:36:58
96e025fe-9100-4611-8ffc-33e2e99aa610	93ec7354-821a-4306-8dcb-5b911268af75	retrait	47994.00	397957.00	349963.00	FCFA	Prélèvement automatique	\N	2025-08-29 07:21:20	2025-10-23 12:36:58
715c0e2f-0460-4260-b743-c6db011dbe85	93ec7354-821a-4306-8dcb-5b911268af75	depot	14381.00	397957.00	412338.00	FCFA	Dépôt chèque	\N	2025-05-12 07:50:57	2025-10-23 12:36:58
f5e1aef1-9bbb-4bb5-9945-1b56ae15f9a4	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	retrait	6484.00	420959.00	414475.00	FCFA	Retrait DAB	\N	2025-08-25 09:26:02	2025-10-23 12:36:58
16b5d2f4-511d-4749-819c-953c4ed9727a	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	retrait	4642.00	420959.00	416317.00	FCFA	Prélèvement automatique	\N	2025-08-26 09:13:46	2025-10-23 12:36:58
2174c9ad-7df3-4ec7-82f9-98a86d5cd6bc	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	retrait	17352.00	420959.00	403607.00	FCFA	Retrait guichet	\N	2025-08-18 15:33:22	2025-10-23 12:36:58
c8fc4090-35c7-4a17-bf73-2434a1a8848b	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	depot	2074.00	420959.00	423033.00	FCFA	Dépôt d'espèces	\N	2025-07-01 11:02:36	2025-10-23 12:36:58
4935aefa-e1ed-486e-846c-c59f274ed6c9	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	retrait	24084.00	420959.00	396875.00	FCFA	Retrait DAB	\N	2025-08-07 04:06:21	2025-10-23 12:36:58
3e9e8264-049f-45d3-aaaa-8f21c2071f2d	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	retrait	3499.00	420959.00	417460.00	FCFA	Retrait DAB	\N	2025-09-05 22:07:11	2025-10-23 12:36:58
a2848691-73a8-43ce-91c5-b1c034904e52	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	virement	31127.00	420959.00	389832.00	FCFA	Virement vers compte	3b545ec9-8048-4c12-a074-df603671d400	2025-08-21 05:27:38	2025-10-23 12:36:58
2cfc5a98-2394-41c9-a70a-ecb938acfd66	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	virement	34338.00	420959.00	386621.00	FCFA	Virement vers compte	d725e859-df50-4ee3-8ab9-65d82dc7fd71	2025-08-21 03:03:28	2025-10-23 12:36:58
77d2b7e8-c275-423e-89d0-87236550ce09	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	depot	8434.00	420959.00	429393.00	FCFA	Virement bancaire entrant	\N	2025-05-25 10:12:16	2025-10-23 12:36:58
8f9d8b14-5c24-4a26-9a5d-463a0f107d40	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	retrait	19693.00	420959.00	401266.00	FCFA	Paiement par carte	\N	2025-06-30 10:10:29	2025-10-23 12:36:58
937b73e0-dad3-44b1-9a30-c0cccd60c134	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	virement	25737.00	420959.00	395222.00	FCFA	Paiement facture	43df68e0-310b-41d1-b272-3e281b325b72	2025-05-20 14:02:05	2025-10-23 12:36:58
a8b38bdc-24d9-483f-9840-b3711c1fcf6e	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	retrait	18261.00	420959.00	402698.00	FCFA	Prélèvement automatique	\N	2025-08-07 19:38:22	2025-10-23 12:36:58
c69a4ff7-1f77-407d-a11b-af25269f0ab9	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	depot	27404.00	420959.00	448363.00	FCFA	Dépôt d'espèces	\N	2025-05-18 14:20:00	2025-10-23 12:36:58
e6df19ac-5044-4222-af23-840901c400d8	2bdeac76-dcb7-4710-9060-e9ca98012722	depot	28789.00	407651.00	436440.00	FCFA	Dépôt chèque	\N	2025-07-25 09:00:16	2025-10-23 12:36:58
35ee1518-c511-47cd-94a1-1d2eaf48f92e	2bdeac76-dcb7-4710-9060-e9ca98012722	virement	25282.00	407651.00	382369.00	FCFA	Virement vers compte	aaa991e6-e52e-48b7-ab07-15a4a8203054	2025-06-26 03:00:17	2025-10-23 12:36:58
c25b74e5-de61-4477-8a47-3b7996b64b73	2bdeac76-dcb7-4710-9060-e9ca98012722	depot	14193.00	407651.00	421844.00	FCFA	Dépôt espèces guichet	\N	2025-10-20 11:36:57	2025-10-23 12:36:58
ec986721-1106-4a23-b42d-24a0889d74bd	2bdeac76-dcb7-4710-9060-e9ca98012722	depot	13287.00	407651.00	420938.00	FCFA	Dépôt d'espèces	\N	2025-08-01 08:46:44	2025-10-23 12:36:58
27c7c8c9-3d45-4816-8fb4-4005420467fa	2bdeac76-dcb7-4710-9060-e9ca98012722	depot	33499.00	407651.00	441150.00	FCFA	Dépôt espèces guichet	\N	2025-07-14 00:26:48	2025-10-23 12:36:58
942485ce-de40-4548-bfa1-69297d68b5a9	2bdeac76-dcb7-4710-9060-e9ca98012722	depot	36742.00	407651.00	444393.00	FCFA	Virement bancaire entrant	\N	2025-10-17 07:59:44	2025-10-23 12:36:58
1375fa74-de64-42a8-ab51-c9b6277b3ffa	2bdeac76-dcb7-4710-9060-e9ca98012722	virement	18304.00	407651.00	389347.00	FCFA	Transfert entre comptes	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	2025-09-23 16:20:12	2025-10-23 12:36:58
36fefca7-2191-4d4c-be32-fcceea2c617c	2bdeac76-dcb7-4710-9060-e9ca98012722	depot	42393.00	407651.00	450044.00	FCFA	Dépôt chèque	\N	2025-09-14 12:39:59	2025-10-23 12:36:58
b5918933-f080-4738-ac4b-ee90e25cce4e	2bdeac76-dcb7-4710-9060-e9ca98012722	retrait	36934.00	407651.00	370717.00	FCFA	Paiement par carte	\N	2025-10-05 18:48:42	2025-10-23 12:36:58
da5f6c43-dba8-47f2-99e4-b6a5e592274d	2bdeac76-dcb7-4710-9060-e9ca98012722	virement	43790.00	407651.00	363861.00	FCFA	Paiement facture	d725e859-df50-4ee3-8ab9-65d82dc7fd71	2025-06-16 12:05:35	2025-10-23 12:36:58
9aa14521-5fc0-4b7f-937c-006d27077c30	2bdeac76-dcb7-4710-9060-e9ca98012722	retrait	45368.00	407651.00	362283.00	FCFA	Prélèvement automatique	\N	2025-08-28 23:29:11	2025-10-23 12:36:58
ffe9e6fe-0afe-42be-a8dc-1bb9ca197bfb	2bdeac76-dcb7-4710-9060-e9ca98012722	retrait	23620.00	407651.00	384031.00	FCFA	Paiement par carte	\N	2025-07-22 10:42:33	2025-10-23 12:36:58
b261ebc5-8d4c-407e-897c-529310f49ee7	2bdeac76-dcb7-4710-9060-e9ca98012722	depot	11973.00	407651.00	419624.00	FCFA	Dépôt chèque	\N	2025-06-11 08:47:30	2025-10-23 12:36:58
ca695c6e-178f-4586-9db3-0c59ef70a86c	792c8ff4-749b-469b-95d0-9b98c2283684	depot	46237.00	300640.00	346877.00	FCFA	Virement bancaire entrant	\N	2025-10-19 23:40:51	2025-10-23 12:36:58
86109935-6514-4b8c-8245-b97cc9b6f97c	792c8ff4-749b-469b-95d0-9b98c2283684	depot	48192.00	300640.00	348832.00	FCFA	Dépôt chèque	\N	2025-08-26 14:55:11	2025-10-23 12:36:58
11807c04-439a-4419-9e64-ddcf3ee8e411	792c8ff4-749b-469b-95d0-9b98c2283684	virement	26202.00	300640.00	274438.00	FCFA	Transfert bancaire	f1e6f840-61c7-4618-bbfd-578d06a2431f	2025-07-18 07:49:45	2025-10-23 12:36:58
a0d96e29-8a5d-4fae-88c7-10bff362bba2	792c8ff4-749b-469b-95d0-9b98c2283684	virement	21047.00	300640.00	279593.00	FCFA	Virement vers compte	0f731b08-109a-4e89-972b-71f8608c0c55	2025-08-24 15:11:06	2025-10-23 12:36:58
d43ba4a7-3367-49a3-8573-56ebe4197e3c	792c8ff4-749b-469b-95d0-9b98c2283684	retrait	3300.00	300640.00	297340.00	FCFA	Retrait DAB	\N	2025-08-07 18:48:17	2025-10-23 12:36:58
101e732f-97fe-4805-b2a2-d08e33ae4791	792c8ff4-749b-469b-95d0-9b98c2283684	retrait	8743.00	300640.00	291897.00	FCFA	Prélèvement automatique	\N	2025-09-11 16:30:45	2025-10-23 12:36:58
8f2c2e1a-e995-433a-bbe8-1eca6095d085	792c8ff4-749b-469b-95d0-9b98c2283684	virement	36448.00	300640.00	264192.00	FCFA	Transfert bancaire	ce352024-ef0a-4c59-a717-07fa503a38dc	2025-08-26 03:47:34	2025-10-23 12:36:58
d9810bc9-0299-4537-8583-4940a06061bb	792c8ff4-749b-469b-95d0-9b98c2283684	depot	9357.00	300640.00	309997.00	FCFA	Dépôt d'espèces	\N	2025-09-04 22:26:35	2025-10-23 12:36:58
41d7536f-9208-4aac-af0a-91a21780420f	792c8ff4-749b-469b-95d0-9b98c2283684	virement	13492.00	300640.00	287148.00	FCFA	Transfert entre comptes	318d8033-6a1d-4dd6-a669-005de93483d3	2025-08-10 04:51:11	2025-10-23 12:36:58
1487d2d6-068e-4472-9ffb-339bb7dac1fd	792c8ff4-749b-469b-95d0-9b98c2283684	retrait	40623.00	300640.00	260017.00	FCFA	Retrait guichet	\N	2025-07-28 21:00:42	2025-10-23 12:36:58
60f47c7b-b247-42dd-a644-8e56e04ad3d6	792c8ff4-749b-469b-95d0-9b98c2283684	virement	19415.00	300640.00	281225.00	FCFA	Virement salaire	d0f4f273-6422-4408-950f-61e6f8d23373	2025-04-27 13:10:07	2025-10-23 12:36:58
774a5cd8-1fcf-4c03-ba63-c11eefc368b6	792c8ff4-749b-469b-95d0-9b98c2283684	retrait	34623.00	300640.00	266017.00	FCFA	Retrait DAB	\N	2025-06-29 03:28:29	2025-10-23 12:36:58
7779fea0-cfd8-485a-9791-e0808dfc1aa7	79f54c28-5af3-42a0-b025-afd541eb8dbf	retrait	13249.00	405571.00	392322.00	FCFA	Retrait DAB	\N	2025-09-09 09:22:06	2025-10-23 12:36:58
23c80d81-56ba-42ec-986c-07f229496d77	79f54c28-5af3-42a0-b025-afd541eb8dbf	virement	1571.00	405571.00	404000.00	FCFA	Paiement facture	887e3007-f4a2-4b73-aee8-c70039319c5f	2025-10-06 03:18:40	2025-10-23 12:36:58
e2d2d868-aef1-4c99-945b-272964d53046	79f54c28-5af3-42a0-b025-afd541eb8dbf	depot	20610.00	405571.00	426181.00	FCFA	Dépôt espèces guichet	\N	2025-06-19 10:15:30	2025-10-23 12:36:58
6f551323-793d-4a0d-b11b-eb4a5615cc56	79f54c28-5af3-42a0-b025-afd541eb8dbf	retrait	6872.00	405571.00	398699.00	FCFA	Retrait DAB	\N	2025-05-07 14:36:43	2025-10-23 12:36:58
1a425ad8-d458-48c4-a46b-d03b89d7fd13	79f54c28-5af3-42a0-b025-afd541eb8dbf	virement	30706.00	405571.00	374865.00	FCFA	Virement salaire	94b14a72-e4f3-4e5f-ae72-8e6f72e4e901	2025-08-20 17:31:30	2025-10-23 12:36:58
4a3adc59-d723-4ba2-b784-a175090c4698	b1ce150f-0fc3-432e-8d5b-a34f6747804a	virement	30280.00	309854.00	279574.00	FCFA	Transfert bancaire	2eab81ba-c2de-4108-9a0e-7ca81af2697c	2025-07-25 11:32:36	2025-10-23 12:36:58
f8e289e4-59e6-40cc-9bb0-36e85008705e	b1ce150f-0fc3-432e-8d5b-a34f6747804a	retrait	25733.00	309854.00	284121.00	FCFA	Retrait DAB	\N	2025-05-21 08:50:28	2025-10-23 12:36:58
64800671-5bc2-4355-bcd0-9844ea111bec	b1ce150f-0fc3-432e-8d5b-a34f6747804a	retrait	48839.00	309854.00	261015.00	FCFA	Retrait d'espèces	\N	2025-09-25 22:31:56	2025-10-23 12:36:58
e39dd4c2-a8dc-4d60-be39-8fb6d108ae37	b1ce150f-0fc3-432e-8d5b-a34f6747804a	depot	10166.00	309854.00	320020.00	FCFA	Versement salaire	\N	2025-09-24 05:07:23	2025-10-23 12:36:58
5f6a5be3-8d5c-49d4-9201-fced7adc9c84	b1ce150f-0fc3-432e-8d5b-a34f6747804a	virement	24966.00	309854.00	284888.00	FCFA	Virement vers compte	3b545ec9-8048-4c12-a074-df603671d400	2025-06-26 09:10:43	2025-10-23 12:36:58
95e5d846-e2e0-4fb7-bb94-10ff1bb59011	b1ce150f-0fc3-432e-8d5b-a34f6747804a	depot	7279.00	309854.00	317133.00	FCFA	Dépôt d'espèces	\N	2025-08-15 21:10:22	2025-10-23 12:36:58
ff313442-3cca-4263-a184-991a13c2f74f	b1ce150f-0fc3-432e-8d5b-a34f6747804a	virement	6560.00	309854.00	303294.00	FCFA	Transfert entre comptes	e4d1caea-baee-4c55-aa8d-8208a299a3f7	2025-05-14 05:21:19	2025-10-23 12:36:58
5c1df1b2-9911-4ae2-bedc-a99628ede0d0	ce34889a-7b15-48e8-9003-f1522cf517f8	virement	44591.00	212023.00	167432.00	FCFA	Paiement facture	2afce742-17e9-45bc-99be-9389a26da3ca	2025-07-14 03:46:25	2025-10-23 12:36:58
b2cd03e8-b798-438a-9bd9-bf0d87a37f44	ce34889a-7b15-48e8-9003-f1522cf517f8	retrait	12738.00	212023.00	199285.00	FCFA	Prélèvement automatique	\N	2025-06-17 05:19:41	2025-10-23 12:36:58
9dd2ff3a-b80c-4494-95bc-1337d9084a4c	ce34889a-7b15-48e8-9003-f1522cf517f8	retrait	37118.00	212023.00	174905.00	FCFA	Prélèvement automatique	\N	2025-05-14 10:47:32	2025-10-23 12:36:58
a550f3e7-afc5-4cd2-a41f-edb99d7d03d5	ce34889a-7b15-48e8-9003-f1522cf517f8	depot	19076.00	212023.00	231099.00	FCFA	Dépôt chèque	\N	2025-06-01 17:48:13	2025-10-23 12:36:58
aec344c8-a8fa-4be7-909c-0cf97c547507	ce34889a-7b15-48e8-9003-f1522cf517f8	depot	49221.00	212023.00	261244.00	FCFA	Virement bancaire entrant	\N	2025-05-26 04:15:54	2025-10-23 12:36:58
8f0e0a7b-3039-4a48-9367-cf367e798fee	ce34889a-7b15-48e8-9003-f1522cf517f8	virement	41392.00	212023.00	170631.00	FCFA	Virement salaire	61bcb7e8-d7d1-45da-9b25-70fba627d304	2025-09-22 21:38:45	2025-10-23 12:36:58
ac6a882f-ef91-4abd-a10e-eb38f0951203	ce34889a-7b15-48e8-9003-f1522cf517f8	retrait	19109.00	212023.00	192914.00	FCFA	Retrait d'espèces	\N	2025-07-06 23:21:37	2025-10-23 12:36:58
56a7899e-1009-4f68-9b02-30f1a6ccb38d	ce34889a-7b15-48e8-9003-f1522cf517f8	retrait	16513.00	212023.00	195510.00	FCFA	Retrait d'espèces	\N	2025-05-20 09:57:33	2025-10-23 12:36:58
a4871b67-fc66-404f-a276-8b62c24a01c2	ce34889a-7b15-48e8-9003-f1522cf517f8	depot	10566.00	212023.00	222589.00	FCFA	Dépôt d'espèces	\N	2025-05-31 01:00:33	2025-10-23 12:36:58
d5b2f5a6-93e4-461f-951f-b04ae789ed4a	ce34889a-7b15-48e8-9003-f1522cf517f8	retrait	24189.00	212023.00	187834.00	FCFA	Retrait DAB	\N	2025-06-25 06:29:58	2025-10-23 12:36:58
74d817c4-aa4d-459b-b8c9-72808b24ae15	ce34889a-7b15-48e8-9003-f1522cf517f8	retrait	49330.00	212023.00	162693.00	FCFA	Paiement par carte	\N	2025-09-26 09:24:05	2025-10-23 12:36:58
cce20851-695e-488e-b960-812b0b8cf433	ce34889a-7b15-48e8-9003-f1522cf517f8	virement	7784.00	212023.00	204239.00	FCFA	Virement salaire	cb45ecae-4f73-42b2-870b-4f41321c9acd	2025-07-29 06:11:06	2025-10-23 12:36:58
005d4b31-59fa-4ae7-9fe6-5b8425b00b86	ce34889a-7b15-48e8-9003-f1522cf517f8	virement	44324.00	212023.00	167699.00	FCFA	Paiement facture	914d5be6-2dc2-4063-8219-1ea664a8b058	2025-06-07 08:48:41	2025-10-23 12:36:58
7d20a3ce-9fe3-460a-b735-392a0adf5aba	d0f4f273-6422-4408-950f-61e6f8d23373	virement	43105.00	421789.00	378684.00	FCFA	Virement salaire	9d8742db-9975-4f0a-aad4-23d2a22203cd	2025-08-09 15:31:51	2025-10-23 12:36:58
dacb820b-bdfe-48ef-a9ef-b8011f7168f0	d0f4f273-6422-4408-950f-61e6f8d23373	depot	20375.00	421789.00	442164.00	FCFA	Dépôt espèces guichet	\N	2025-06-25 11:43:24	2025-10-23 12:36:58
71f6bcfe-e09a-49e1-ac9f-84e183c99d68	d0f4f273-6422-4408-950f-61e6f8d23373	depot	5687.00	421789.00	427476.00	FCFA	Dépôt d'espèces	\N	2025-07-30 07:25:09	2025-10-23 12:36:58
12ca6af2-2fb2-49be-830f-0e31bd8721b4	d0f4f273-6422-4408-950f-61e6f8d23373	virement	46917.00	421789.00	374872.00	FCFA	Transfert entre comptes	9987f93d-ac57-4bee-aff6-41c16aebe2b4	2025-06-10 17:24:11	2025-10-23 12:36:58
f85b98ea-fe15-461c-94a1-9325ac53a9c2	d0f4f273-6422-4408-950f-61e6f8d23373	virement	18675.00	421789.00	403114.00	FCFA	Transfert bancaire	914d5be6-2dc2-4063-8219-1ea664a8b058	2025-07-22 01:34:09	2025-10-23 12:36:58
660c24bd-c6d1-4be3-8ff2-532945db99f9	d0f4f273-6422-4408-950f-61e6f8d23373	virement	28447.00	421789.00	393342.00	FCFA	Paiement facture	d5017ad9-771a-4ec6-8b01-e408480e8116	2025-05-17 12:09:11	2025-10-23 12:36:58
e63c0cba-6ae3-4fb5-8101-b3e10bb5fd17	d0f4f273-6422-4408-950f-61e6f8d23373	virement	10059.00	421789.00	411730.00	FCFA	Paiement facture	aefad6a9-6ff4-4250-b79c-50f551aaa60e	2025-10-06 09:05:28	2025-10-23 12:36:58
5fa5e3e7-8235-4704-8d5c-66ebe3267fba	d0f4f273-6422-4408-950f-61e6f8d23373	retrait	32128.00	421789.00	389661.00	FCFA	Retrait guichet	\N	2025-10-05 12:25:04	2025-10-23 12:36:58
c89f3578-e45f-4c5c-bad1-817bc24640c4	d0f4f273-6422-4408-950f-61e6f8d23373	retrait	21248.00	421789.00	400541.00	FCFA	Retrait DAB	\N	2025-05-13 02:47:07	2025-10-23 12:36:58
7f0fcda2-2631-4827-82bf-57b430d42ddf	d0f4f273-6422-4408-950f-61e6f8d23373	depot	42958.00	421789.00	464747.00	FCFA	Dépôt chèque	\N	2025-05-04 05:16:33	2025-10-23 12:36:58
97ff9f74-2134-47f4-b09c-b7db9c145b0e	d0f4f273-6422-4408-950f-61e6f8d23373	retrait	40836.00	421789.00	380953.00	FCFA	Retrait guichet	\N	2025-10-10 23:22:49	2025-10-23 12:36:58
38180e6e-c4bf-4eb5-b2b1-4fd2dc0e436e	d0f4f273-6422-4408-950f-61e6f8d23373	virement	47125.00	421789.00	374664.00	FCFA	Virement salaire	b26e640d-87a1-49a8-a880-2a2088a4fca0	2025-08-24 09:17:01	2025-10-23 12:36:58
41a8fb6e-56ab-4045-b014-646fdd80a941	d0f4f273-6422-4408-950f-61e6f8d23373	depot	47539.00	421789.00	469328.00	FCFA	Dépôt chèque	\N	2025-06-01 06:05:57	2025-10-23 12:36:58
99f9aace-1a5d-47bf-a0a5-5bc539a733b9	d0f4f273-6422-4408-950f-61e6f8d23373	virement	8286.00	421789.00	413503.00	FCFA	Transfert bancaire	b9fcf39f-cbf6-4e3d-99da-428158581521	2025-08-30 20:46:15	2025-10-23 12:36:58
556fd1ed-1d79-4012-a699-72ba04aa15c9	d0f4f273-6422-4408-950f-61e6f8d23373	depot	13551.00	421789.00	435340.00	FCFA	Dépôt chèque	\N	2025-06-14 07:44:48	2025-10-23 12:36:58
1fa7be85-3c88-4660-8f6a-0bdc8ccc418f	9d8742db-9975-4f0a-aad4-23d2a22203cd	depot	41101.00	106867.00	147968.00	FCFA	Virement bancaire entrant	\N	2025-07-10 21:16:56	2025-10-23 12:36:58
2189ed0e-3e27-457e-a40d-be34764fa796	9d8742db-9975-4f0a-aad4-23d2a22203cd	virement	5002.00	106867.00	101865.00	FCFA	Paiement facture	ac532c01-37b7-44d5-bc6e-148843aaf375	2025-10-09 19:08:04	2025-10-23 12:36:58
3d24ab8a-061e-4772-9d1a-4f87aead5149	9d8742db-9975-4f0a-aad4-23d2a22203cd	virement	40053.00	106867.00	66814.00	FCFA	Virement salaire	37da1638-f10a-4a03-9eb4-9eb960273866	2025-07-29 18:32:56	2025-10-23 12:36:58
e7849d7c-18a9-4bc3-9d9d-4614b9c215ec	9d8742db-9975-4f0a-aad4-23d2a22203cd	retrait	18463.00	106867.00	88404.00	FCFA	Prélèvement automatique	\N	2025-06-08 04:01:27	2025-10-23 12:36:58
271bac2f-bccb-4405-936c-da01755c1413	9d8742db-9975-4f0a-aad4-23d2a22203cd	virement	24177.00	106867.00	82690.00	FCFA	Paiement facture	e4d1caea-baee-4c55-aa8d-8208a299a3f7	2025-05-23 09:52:28	2025-10-23 12:36:58
0d025a56-bbc3-4bab-8315-ff1ab14d0156	9d8742db-9975-4f0a-aad4-23d2a22203cd	depot	27685.00	106867.00	134552.00	FCFA	Dépôt chèque	\N	2025-05-21 03:52:54	2025-10-23 12:36:58
b24b7439-a71a-49db-83ce-595ee2e6c250	9d8742db-9975-4f0a-aad4-23d2a22203cd	virement	5555.00	106867.00	101312.00	FCFA	Transfert bancaire	7bd3be9f-34e2-4eeb-9f78-a68c083c1a96	2025-08-09 10:07:43	2025-10-23 12:36:58
d0830c0a-ecb8-42c4-b4a3-21e92b80f7fe	9d8742db-9975-4f0a-aad4-23d2a22203cd	depot	11066.00	106867.00	117933.00	FCFA	Dépôt d'espèces	\N	2025-05-04 21:05:31	2025-10-23 12:36:58
31fea1e3-524b-4bd7-9cea-bcb1ba2690d9	9d8742db-9975-4f0a-aad4-23d2a22203cd	retrait	21350.00	106867.00	85517.00	FCFA	Retrait d'espèces	\N	2025-06-11 21:45:25	2025-10-23 12:36:58
17c251c5-dc3f-47b3-bc03-58bac1a6eb4d	9d8742db-9975-4f0a-aad4-23d2a22203cd	retrait	44889.00	106867.00	61978.00	FCFA	Paiement par carte	\N	2025-10-10 00:35:18	2025-10-23 12:36:58
a56b264c-870c-4b28-87c6-9560799d9100	9d8742db-9975-4f0a-aad4-23d2a22203cd	virement	19049.00	106867.00	87818.00	FCFA	Virement salaire	849dcfa8-90dd-4efb-befe-4a819d763b77	2025-09-15 08:15:53	2025-10-23 12:36:58
9cae6c7c-61a0-4408-b9aa-0b7c9b4614f1	9d8742db-9975-4f0a-aad4-23d2a22203cd	retrait	16861.00	106867.00	90006.00	FCFA	Prélèvement automatique	\N	2025-09-05 06:25:40	2025-10-23 12:36:58
df7ee6e4-5448-4cd3-88bd-14fa122e6876	9d8742db-9975-4f0a-aad4-23d2a22203cd	depot	22504.00	106867.00	129371.00	FCFA	Versement salaire	\N	2025-07-23 01:59:50	2025-10-23 12:36:58
2045d7cd-52b4-4c45-bb8f-7ca3e53c622f	9d8742db-9975-4f0a-aad4-23d2a22203cd	virement	19209.00	106867.00	87658.00	FCFA	Transfert bancaire	849dcfa8-90dd-4efb-befe-4a819d763b77	2025-07-09 17:57:17	2025-10-23 12:36:58
c0cdacd1-c7c2-43ea-bdd5-64bbf66ff674	9d8742db-9975-4f0a-aad4-23d2a22203cd	virement	32917.00	106867.00	73950.00	FCFA	Paiement facture	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	2025-08-31 16:47:26	2025-10-23 12:36:58
f8ffbb6d-56f5-45c4-b9d2-125604de2d01	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	depot	2895.00	282961.00	285856.00	FCFA	Versement salaire	\N	2025-07-30 07:54:33	2025-10-23 12:36:58
ee825d5e-f926-4338-9960-dce195ef199f	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	depot	38072.00	282961.00	321033.00	FCFA	Dépôt d'espèces	\N	2025-05-28 04:22:59	2025-10-23 12:36:58
8c9e4e77-96f1-48c2-b731-0ef73d78ccf3	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	depot	7634.00	282961.00	290595.00	FCFA	Dépôt d'espèces	\N	2025-08-18 00:26:57	2025-10-23 12:36:58
54f89ddf-cc46-4cdf-801d-42d9e908a40f	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	depot	17725.00	282961.00	300686.00	FCFA	Versement salaire	\N	2025-08-21 03:58:25	2025-10-23 12:36:58
11b05f44-2dba-4419-86ff-af9adfe3e5cc	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	virement	8504.00	282961.00	274457.00	FCFA	Transfert entre comptes	3d77ab88-c4f1-4715-8657-5361aeb99a2c	2025-08-29 00:22:40	2025-10-23 12:36:58
29485c36-6846-4bec-ae04-f966207645ff	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	virement	6187.00	282961.00	276774.00	FCFA	Transfert bancaire	79f54c28-5af3-42a0-b025-afd541eb8dbf	2025-05-05 16:09:48	2025-10-23 12:36:58
e8a68638-1e44-4f49-96b3-6366b5072024	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	virement	25744.00	282961.00	257217.00	FCFA	Paiement facture	168369a2-765d-4e68-9282-e69cf56154cf	2025-06-20 00:14:19	2025-10-23 12:36:58
ad18f6ed-79b7-45c9-8bc0-c261db2a1081	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	virement	40377.00	282961.00	242584.00	FCFA	Paiement facture	318d8033-6a1d-4dd6-a669-005de93483d3	2025-10-21 23:47:52	2025-10-23 12:36:58
7785a761-8430-405b-a57b-6d6280b9a7f6	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	retrait	9228.00	282961.00	273733.00	FCFA	Retrait DAB	\N	2025-08-09 13:42:46	2025-10-23 12:36:58
8ed646d7-b9d3-4fbd-a711-60f86168beb8	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	virement	31656.00	282961.00	251305.00	FCFA	Paiement facture	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	2025-06-23 03:47:33	2025-10-23 12:36:58
496734d6-93bd-496d-9125-a26c6871e786	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	retrait	21378.00	282961.00	261583.00	FCFA	Paiement par carte	\N	2025-05-21 19:07:49	2025-10-23 12:36:58
fd5908d1-5844-4592-9c9a-b85165f9cfb3	57a5b070-a40d-45d9-b0ee-ba32f96383a6	depot	49325.00	324131.00	373456.00	FCFA	Dépôt chèque	\N	2025-05-24 20:42:14	2025-10-23 12:36:58
29f626d0-94c4-43a8-8178-6239a036cbd4	57a5b070-a40d-45d9-b0ee-ba32f96383a6	retrait	45840.00	324131.00	278291.00	FCFA	Retrait guichet	\N	2025-09-17 01:45:07	2025-10-23 12:36:59
16ea0325-0745-4f65-beb1-cec7d6012053	57a5b070-a40d-45d9-b0ee-ba32f96383a6	virement	8129.00	324131.00	316002.00	FCFA	Virement salaire	f1e6f840-61c7-4618-bbfd-578d06a2431f	2025-05-30 07:29:47	2025-10-23 12:36:59
e43a13d8-0613-4ef8-aa8c-9f8c8109781b	57a5b070-a40d-45d9-b0ee-ba32f96383a6	depot	46441.00	324131.00	370572.00	FCFA	Dépôt chèque	\N	2025-05-19 01:33:33	2025-10-23 12:36:59
16fd5ac4-73a5-491a-b00a-2dcadc537f54	57a5b070-a40d-45d9-b0ee-ba32f96383a6	retrait	6672.00	324131.00	317459.00	FCFA	Retrait d'espèces	\N	2025-05-31 18:01:50	2025-10-23 12:36:59
75535ba9-686f-4c90-a79c-dd12645844af	57a5b070-a40d-45d9-b0ee-ba32f96383a6	depot	9951.00	324131.00	334082.00	FCFA	Dépôt d'espèces	\N	2025-07-23 02:42:01	2025-10-23 12:36:59
04ae02c0-c86d-4df6-b743-a98219c00b4c	57a5b070-a40d-45d9-b0ee-ba32f96383a6	depot	6914.00	324131.00	331045.00	FCFA	Versement salaire	\N	2025-04-26 09:31:10	2025-10-23 12:36:59
b7fae628-4319-487c-a54f-549b7ce2f183	2e311570-14e5-403a-a71f-698c77f8454d	retrait	19654.00	439948.00	420294.00	FCFA	Retrait d'espèces	\N	2025-10-12 04:35:06	2025-10-23 12:36:59
425bf80b-1bb3-4652-a112-7a41bcde5e5e	2e311570-14e5-403a-a71f-698c77f8454d	depot	26117.00	439948.00	466065.00	FCFA	Virement bancaire entrant	\N	2025-08-01 18:23:37	2025-10-23 12:36:59
eb6c45c1-0edc-4692-b161-5a919cb37f0c	2e311570-14e5-403a-a71f-698c77f8454d	retrait	12625.00	439948.00	427323.00	FCFA	Retrait guichet	\N	2025-10-18 00:46:02	2025-10-23 12:36:59
b20b6748-6762-4a58-9807-39eb3552832c	2e311570-14e5-403a-a71f-698c77f8454d	retrait	13098.00	439948.00	426850.00	FCFA	Prélèvement automatique	\N	2025-08-10 14:02:22	2025-10-23 12:36:59
8337ef46-40a0-4e80-88a4-492b750de19e	2e311570-14e5-403a-a71f-698c77f8454d	depot	15753.00	439948.00	455701.00	FCFA	Dépôt chèque	\N	2025-09-12 06:05:46	2025-10-23 12:36:59
bf036801-e785-4e2e-bf00-6d72516fa907	2e311570-14e5-403a-a71f-698c77f8454d	virement	38728.00	439948.00	401220.00	FCFA	Paiement facture	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	2025-08-14 07:59:37	2025-10-23 12:36:59
613f4c60-6e0d-4a5c-add5-a563cee527cc	2e311570-14e5-403a-a71f-698c77f8454d	depot	28423.00	439948.00	468371.00	FCFA	Dépôt espèces guichet	\N	2025-09-05 18:53:11	2025-10-23 12:36:59
be9b98fc-b8b2-419d-a147-cac58c809ecd	2e311570-14e5-403a-a71f-698c77f8454d	virement	44261.00	439948.00	395687.00	FCFA	Transfert bancaire	4e9d8251-8bd8-4460-957a-dd1af608920f	2025-05-30 22:26:24	2025-10-23 12:36:59
d7a9db4b-404b-40a2-9040-304e43bd0b74	df088290-3d37-4591-8571-389b37349b2a	depot	15486.00	273540.00	289026.00	FCFA	Dépôt chèque	\N	2025-04-25 18:13:05	2025-10-23 12:36:59
62cae2a7-0db2-4002-a95f-35847b0cff84	df088290-3d37-4591-8571-389b37349b2a	depot	1197.00	273540.00	274737.00	FCFA	Dépôt d'espèces	\N	2025-08-19 17:08:21	2025-10-23 12:36:59
6f54c097-de00-42c1-9276-574a50e7aba1	df088290-3d37-4591-8571-389b37349b2a	virement	11215.00	273540.00	262325.00	FCFA	Transfert entre comptes	9cd12202-7a97-4ff8-907d-67b3f104c6b6	2025-09-07 05:58:49	2025-10-23 12:36:59
a15c7778-7436-4a9a-8c16-3c732822d430	df088290-3d37-4591-8571-389b37349b2a	depot	20828.00	273540.00	294368.00	FCFA	Virement bancaire entrant	\N	2025-07-03 23:24:19	2025-10-23 12:36:59
1575449b-26ad-4d03-b311-be40390a12e3	df088290-3d37-4591-8571-389b37349b2a	virement	4884.00	273540.00	268656.00	FCFA	Virement salaire	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	2025-07-01 22:08:50	2025-10-23 12:36:59
96967a55-f46a-4ea5-ba70-c3144a129e11	df088290-3d37-4591-8571-389b37349b2a	retrait	9650.00	273540.00	263890.00	FCFA	Retrait guichet	\N	2025-08-10 01:01:45	2025-10-23 12:36:59
4a43e18d-69b2-42ad-9852-dfb32025c155	df088290-3d37-4591-8571-389b37349b2a	retrait	6177.00	273540.00	267363.00	FCFA	Retrait d'espèces	\N	2025-05-22 04:36:28	2025-10-23 12:36:59
5c9964d3-c253-40b1-8632-5975a7a3c13b	df088290-3d37-4591-8571-389b37349b2a	depot	30870.00	273540.00	304410.00	FCFA	Dépôt espèces guichet	\N	2025-09-02 15:32:35	2025-10-23 12:36:59
2761313b-ee4b-4802-8867-ec7bb7a65f9f	df088290-3d37-4591-8571-389b37349b2a	retrait	43608.00	273540.00	229932.00	FCFA	Prélèvement automatique	\N	2025-08-10 17:59:07	2025-10-23 12:36:59
ef3e5a3a-da1d-4526-98fb-4795097079c0	df088290-3d37-4591-8571-389b37349b2a	depot	8521.00	273540.00	282061.00	FCFA	Versement salaire	\N	2025-10-16 12:35:13	2025-10-23 12:36:59
f5756bd2-68c2-472b-8165-76545e56b9ae	df088290-3d37-4591-8571-389b37349b2a	depot	20769.00	273540.00	294309.00	FCFA	Dépôt espèces guichet	\N	2025-06-07 21:16:26	2025-10-23 12:36:59
6bf19624-aaea-4dab-b92d-ce094cbcd38b	df088290-3d37-4591-8571-389b37349b2a	retrait	3122.00	273540.00	270418.00	FCFA	Retrait d'espèces	\N	2025-04-29 22:04:09	2025-10-23 12:36:59
25b3b0ad-c98e-423e-8c20-5d632506afee	b30db983-96ad-4f5c-a50c-1637c25f3b46	retrait	12712.00	220146.00	207434.00	FCFA	Retrait DAB	\N	2025-07-13 07:25:41	2025-10-23 12:36:59
48d0335e-4fb9-4781-9785-eb0c4736dd77	b30db983-96ad-4f5c-a50c-1637c25f3b46	retrait	29573.00	220146.00	190573.00	FCFA	Paiement par carte	\N	2025-06-13 16:40:30	2025-10-23 12:36:59
706acfdc-bdcd-4851-8bf3-af9c32f73b52	b30db983-96ad-4f5c-a50c-1637c25f3b46	virement	7519.00	220146.00	212627.00	FCFA	Virement salaire	8a4ca722-53cc-428f-a83a-d84a7f681abf	2025-06-28 21:05:37	2025-10-23 12:36:59
7795163e-c12d-43bc-9f88-ac1ecbaf63b3	b30db983-96ad-4f5c-a50c-1637c25f3b46	retrait	17718.00	220146.00	202428.00	FCFA	Paiement par carte	\N	2025-09-27 07:05:43	2025-10-23 12:36:59
c414b461-9af2-4a5b-a770-5993ddad511f	b30db983-96ad-4f5c-a50c-1637c25f3b46	depot	40810.00	220146.00	260956.00	FCFA	Dépôt d'espèces	\N	2025-04-25 20:41:20	2025-10-23 12:36:59
0f7041a5-87f9-4f0e-9a14-5ec240f8f173	b30db983-96ad-4f5c-a50c-1637c25f3b46	depot	37718.00	220146.00	257864.00	FCFA	Virement bancaire entrant	\N	2025-09-29 03:35:31	2025-10-23 12:36:59
c2e47b6d-fef0-46da-8dec-d7dc1de8126d	b30db983-96ad-4f5c-a50c-1637c25f3b46	retrait	46983.00	220146.00	173163.00	FCFA	Retrait guichet	\N	2025-07-22 08:33:21	2025-10-23 12:36:59
708d36d8-fb3c-4e11-a5ad-bf671330c9c3	b30db983-96ad-4f5c-a50c-1637c25f3b46	virement	12573.00	220146.00	207573.00	FCFA	Transfert entre comptes	93ec7354-821a-4306-8dcb-5b911268af75	2025-06-20 03:48:06	2025-10-23 12:36:59
0bda357e-e7ac-4bbd-bc55-34f940829be6	b30db983-96ad-4f5c-a50c-1637c25f3b46	virement	43576.00	220146.00	176570.00	FCFA	Paiement facture	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	2025-09-01 11:42:10	2025-10-23 12:36:59
dc68ce3f-ca9b-4804-817f-030f5d959138	8af34d52-0c28-48ed-ae2d-87e52f97806a	virement	35944.00	368779.00	332835.00	FCFA	Virement salaire	d5017ad9-771a-4ec6-8b01-e408480e8116	2025-05-29 06:23:11	2025-10-23 12:36:59
b48fdd6b-0ad1-4f45-bc65-29d6f7f6b15b	8af34d52-0c28-48ed-ae2d-87e52f97806a	virement	19508.00	368779.00	349271.00	FCFA	Virement vers compte	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	2025-05-23 21:00:34	2025-10-23 12:36:59
1d76b48d-3b27-4c5b-a952-b5730bdcbbf2	8af34d52-0c28-48ed-ae2d-87e52f97806a	virement	8158.00	368779.00	360621.00	FCFA	Transfert entre comptes	b9dbc5e1-4932-4b18-9442-6fbf74b31327	2025-09-16 22:18:04	2025-10-23 12:36:59
75ea9646-7dd1-40fc-9c14-39b86eaf2e38	8af34d52-0c28-48ed-ae2d-87e52f97806a	retrait	23832.00	368779.00	344947.00	FCFA	Retrait guichet	\N	2025-07-19 11:21:35	2025-10-23 12:36:59
3be3222d-91e8-4bf0-9127-2219376f4942	8af34d52-0c28-48ed-ae2d-87e52f97806a	virement	45724.00	368779.00	323055.00	FCFA	Transfert bancaire	65da4070-27f5-40a7-99d9-db64e3163a65	2025-09-21 17:02:31	2025-10-23 12:36:59
64cfcb79-77c6-4401-93c8-747244031d99	8af34d52-0c28-48ed-ae2d-87e52f97806a	virement	13209.00	368779.00	355570.00	FCFA	Paiement facture	94b4fef5-88d3-4b9a-98c9-1e0c6c697c0a	2025-07-12 09:09:46	2025-10-23 12:36:59
d1243416-282a-4b57-88b1-9867387672c3	8af34d52-0c28-48ed-ae2d-87e52f97806a	retrait	27858.00	368779.00	340921.00	FCFA	Retrait d'espèces	\N	2025-09-14 05:13:36	2025-10-23 12:36:59
fbd3528d-96ef-4cd0-bc00-052ddf02b6ff	8af34d52-0c28-48ed-ae2d-87e52f97806a	depot	33862.00	368779.00	402641.00	FCFA	Versement salaire	\N	2025-08-24 20:44:06	2025-10-23 12:36:59
032abf3a-2f53-4434-ad53-3c802b1e617c	8af34d52-0c28-48ed-ae2d-87e52f97806a	retrait	30042.00	368779.00	338737.00	FCFA	Prélèvement automatique	\N	2025-06-12 22:58:47	2025-10-23 12:36:59
8f06ea45-c776-4f96-afbd-8a0d83539122	8af34d52-0c28-48ed-ae2d-87e52f97806a	depot	44240.00	368779.00	413019.00	FCFA	Versement salaire	\N	2025-09-13 00:22:56	2025-10-23 12:36:59
f86d3a16-1036-42d9-9608-0d1c7d09a599	8af34d52-0c28-48ed-ae2d-87e52f97806a	depot	31031.00	368779.00	399810.00	FCFA	Virement bancaire entrant	\N	2025-08-29 12:09:48	2025-10-23 12:36:59
0c9a5959-0812-4882-812d-b8a06fc9c14d	8af34d52-0c28-48ed-ae2d-87e52f97806a	virement	34895.00	368779.00	333884.00	FCFA	Virement salaire	d3ba6f50-5b24-4a03-9002-ded93f5697a3	2025-09-07 07:40:59	2025-10-23 12:36:59
996a5983-7657-4a2c-90ce-7921c2b390b1	b9fcf39f-cbf6-4e3d-99da-428158581521	depot	41883.00	278647.00	320530.00	FCFA	Versement salaire	\N	2025-07-12 17:16:19	2025-10-23 12:36:59
551c52d7-5b40-4d38-9868-f175dd6eb7d3	b9fcf39f-cbf6-4e3d-99da-428158581521	virement	38087.00	278647.00	240560.00	FCFA	Paiement facture	792c8ff4-749b-469b-95d0-9b98c2283684	2025-06-07 23:45:06	2025-10-23 12:36:59
462a051f-275d-465a-9af7-2ac9958d1fee	b9fcf39f-cbf6-4e3d-99da-428158581521	depot	29736.00	278647.00	308383.00	FCFA	Versement salaire	\N	2025-07-11 12:25:41	2025-10-23 12:36:59
27f3d4d1-6c8b-45d4-8f54-028bcb610673	b9fcf39f-cbf6-4e3d-99da-428158581521	depot	30032.00	278647.00	308679.00	FCFA	Dépôt chèque	\N	2025-06-09 10:25:14	2025-10-23 12:36:59
8ea79147-0020-482f-b50a-c85bd3588aa3	b9fcf39f-cbf6-4e3d-99da-428158581521	retrait	37424.00	278647.00	241223.00	FCFA	Retrait DAB	\N	2025-10-09 06:01:05	2025-10-23 12:36:59
0da7c4ea-b061-4c30-956e-dc02d07939fe	b9fcf39f-cbf6-4e3d-99da-428158581521	depot	21621.00	278647.00	300268.00	FCFA	Dépôt d'espèces	\N	2025-10-22 12:41:22	2025-10-23 12:36:59
a16da8b3-4407-4c1f-a47f-0f263c50ba40	b9fcf39f-cbf6-4e3d-99da-428158581521	virement	3362.00	278647.00	275285.00	FCFA	Transfert bancaire	269d3156-3edd-4bda-99b1-a6cdf48bccdd	2025-06-29 16:22:18	2025-10-23 12:36:59
efc94c22-cba4-47e8-97ce-34cfc1fddb52	b9fcf39f-cbf6-4e3d-99da-428158581521	virement	14838.00	278647.00	263809.00	FCFA	Paiement facture	54c98069-cb97-4a48-9c06-c8ed239ef726	2025-06-15 06:17:17	2025-10-23 12:36:59
7e9d2581-4f47-45bd-856d-1dd300818966	b9fcf39f-cbf6-4e3d-99da-428158581521	depot	23984.00	278647.00	302631.00	FCFA	Versement salaire	\N	2025-07-27 08:55:20	2025-10-23 12:36:59
57238b69-022b-4bad-8a05-c49583df92e9	b9fcf39f-cbf6-4e3d-99da-428158581521	virement	4010.00	278647.00	274637.00	FCFA	Transfert bancaire	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	2025-10-18 21:28:51	2025-10-23 12:36:59
237a0dd5-2db3-4614-abd0-888c4883dfef	968e30c7-1be0-4c05-98ba-5cb8d986a863	retrait	38381.00	331020.00	292639.00	FCFA	Retrait d'espèces	\N	2025-05-09 13:06:25	2025-10-23 12:36:59
2c6ad8bb-cb96-47a0-b5e5-d00d1689289f	968e30c7-1be0-4c05-98ba-5cb8d986a863	retrait	2436.00	331020.00	328584.00	FCFA	Retrait DAB	\N	2025-05-07 08:53:17	2025-10-23 12:36:59
8e9a7875-9752-4912-99c0-edf5680a1a47	968e30c7-1be0-4c05-98ba-5cb8d986a863	virement	4579.00	331020.00	326441.00	FCFA	Transfert entre comptes	4497726b-2732-4f82-ac92-17bdbf1dbca5	2025-04-29 11:25:17	2025-10-23 12:36:59
112c9289-3a1f-4eb5-96fc-1b2dfd3eb121	968e30c7-1be0-4c05-98ba-5cb8d986a863	retrait	46522.00	331020.00	284498.00	FCFA	Retrait d'espèces	\N	2025-07-08 11:28:52	2025-10-23 12:36:59
31d61583-8fb0-4f0e-8755-f4055d3ee9d9	968e30c7-1be0-4c05-98ba-5cb8d986a863	virement	9749.00	331020.00	321271.00	FCFA	Virement salaire	31fb6207-f59e-425f-bf86-a1085c47b43f	2025-08-28 23:04:31	2025-10-23 12:36:59
d15905bd-2d05-4a8f-84dc-de4dac176755	968e30c7-1be0-4c05-98ba-5cb8d986a863	depot	30533.00	331020.00	361553.00	FCFA	Dépôt espèces guichet	\N	2025-08-22 00:25:04	2025-10-23 12:36:59
53de4e34-bc7d-43c1-b21d-ec37fcc2a41a	968e30c7-1be0-4c05-98ba-5cb8d986a863	virement	36381.00	331020.00	294639.00	FCFA	Transfert bancaire	aed8dd64-e196-4321-8ffc-52ce0cc7e7f7	2025-09-18 18:41:51	2025-10-23 12:36:59
aea90907-d524-4b20-9baf-80aaa34ef026	968e30c7-1be0-4c05-98ba-5cb8d986a863	depot	26295.00	331020.00	357315.00	FCFA	Dépôt chèque	\N	2025-06-02 15:47:25	2025-10-23 12:36:59
8b9af3f9-9090-4317-95a9-313ebf2b4a24	968e30c7-1be0-4c05-98ba-5cb8d986a863	virement	41188.00	331020.00	289832.00	FCFA	Paiement facture	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	2025-10-20 03:21:07	2025-10-23 12:36:59
6282535e-8393-41d8-82a9-49997c1d8e16	968e30c7-1be0-4c05-98ba-5cb8d986a863	virement	27510.00	331020.00	303510.00	FCFA	Virement salaire	6b052865-a885-4b74-94d3-9838eadb0208	2025-10-20 02:54:57	2025-10-23 12:36:59
0bcac9d1-cb93-4248-a825-c15db598f756	968e30c7-1be0-4c05-98ba-5cb8d986a863	virement	1681.00	331020.00	329339.00	FCFA	Transfert entre comptes	aed8dd64-e196-4321-8ffc-52ce0cc7e7f7	2025-09-30 20:12:27	2025-10-23 12:36:59
ac4e173c-ab49-4ef4-a67f-8498c5586940	968e30c7-1be0-4c05-98ba-5cb8d986a863	depot	11537.00	331020.00	342557.00	FCFA	Dépôt d'espèces	\N	2025-10-09 04:24:52	2025-10-23 12:36:59
47710c9c-4b94-4111-9f1b-f25eb5d3b0fb	968e30c7-1be0-4c05-98ba-5cb8d986a863	virement	38017.00	331020.00	293003.00	FCFA	Virement salaire	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	2025-08-03 16:52:27	2025-10-23 12:36:59
d06b61fd-a082-405a-8bcf-3b63c69d8b5b	a0123386-5767-4f9f-b457-e0613e9f8725	retrait	12103.00	474190.00	462087.00	FCFA	Paiement par carte	\N	2025-10-06 22:28:59	2025-10-23 12:36:59
412cdd98-aac5-48d6-94f7-ce628c0afe3e	a0123386-5767-4f9f-b457-e0613e9f8725	depot	49987.00	474190.00	524177.00	FCFA	Dépôt d'espèces	\N	2025-10-17 21:29:52	2025-10-23 12:36:59
ac94e302-7c07-47c0-9e83-a9e01568691f	a0123386-5767-4f9f-b457-e0613e9f8725	virement	45931.00	474190.00	428259.00	FCFA	Transfert entre comptes	849dcfa8-90dd-4efb-befe-4a819d763b77	2025-05-23 01:16:22	2025-10-23 12:36:59
cb561b4f-b125-4943-a69d-92ec1c61a100	a0123386-5767-4f9f-b457-e0613e9f8725	retrait	26962.00	474190.00	447228.00	FCFA	Retrait DAB	\N	2025-07-24 02:59:30	2025-10-23 12:36:59
45ef8b05-c75f-4252-a6cc-5edf57d6b423	a0123386-5767-4f9f-b457-e0613e9f8725	virement	46313.00	474190.00	427877.00	FCFA	Transfert entre comptes	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	2025-05-05 05:12:50	2025-10-23 12:36:59
7ccadebe-8cde-42b3-84e1-689a893ab8c1	a0123386-5767-4f9f-b457-e0613e9f8725	virement	30677.00	474190.00	443513.00	FCFA	Paiement facture	4e96181f-e984-42f8-9787-a41a67c90aba	2025-04-29 08:01:18	2025-10-23 12:36:59
c04b412e-ffec-4c63-a1c4-a1d5f5c4ab06	a0123386-5767-4f9f-b457-e0613e9f8725	virement	2069.00	474190.00	472121.00	FCFA	Transfert bancaire	8a4ca722-53cc-428f-a83a-d84a7f681abf	2025-10-20 04:51:43	2025-10-23 12:36:59
233039d9-474e-4cec-ad0e-04b7a827240e	a0123386-5767-4f9f-b457-e0613e9f8725	virement	48980.00	474190.00	425210.00	FCFA	Transfert entre comptes	ad629adb-377a-4725-9f12-556a170ef642	2025-06-27 03:14:47	2025-10-23 12:36:59
c3c419a7-4e93-4cd4-8838-8f56dd30a465	a0123386-5767-4f9f-b457-e0613e9f8725	retrait	22482.00	474190.00	451708.00	FCFA	Retrait guichet	\N	2025-05-20 04:46:14	2025-10-23 12:36:59
236373cc-e37b-4ea8-a35f-ad4ba42fa369	a0123386-5767-4f9f-b457-e0613e9f8725	virement	47353.00	474190.00	426837.00	FCFA	Transfert entre comptes	dd05cd28-6e89-41fd-8a78-cba1c4607efd	2025-05-28 23:48:46	2025-10-23 12:36:59
c61997b1-431f-45a8-a685-575ea0557d19	a0123386-5767-4f9f-b457-e0613e9f8725	depot	34521.00	474190.00	508711.00	FCFA	Dépôt d'espèces	\N	2025-05-11 21:36:36	2025-10-23 12:36:59
33b43ee3-53e3-4504-b5ad-caa106c29309	a0123386-5767-4f9f-b457-e0613e9f8725	retrait	37791.00	474190.00	436399.00	FCFA	Paiement par carte	\N	2025-06-12 03:55:36	2025-10-23 12:36:59
e06feefa-d20c-4924-a9b8-8212499bc566	a0123386-5767-4f9f-b457-e0613e9f8725	depot	36676.00	474190.00	510866.00	FCFA	Dépôt d'espèces	\N	2025-05-14 20:50:48	2025-10-23 12:36:59
841d2f74-510b-47dc-88a8-5876bc92f72a	a0123386-5767-4f9f-b457-e0613e9f8725	virement	39278.00	474190.00	434912.00	FCFA	Transfert bancaire	bc779c73-ecf7-44f0-9794-281f495b5ff5	2025-08-12 00:33:15	2025-10-23 12:36:59
6f5a2f7f-9d04-4c78-b084-630f4bc63ae7	a0123386-5767-4f9f-b457-e0613e9f8725	virement	43342.00	474190.00	430848.00	FCFA	Virement vers compte	61bcb7e8-d7d1-45da-9b25-70fba627d304	2025-07-10 13:22:34	2025-10-23 12:36:59
a1440490-2cef-4b80-ab90-6f54bebd8a36	6b052865-a885-4b74-94d3-9838eadb0208	depot	43706.00	32394.00	76100.00	FCFA	Dépôt chèque	\N	2025-10-22 15:26:11	2025-10-23 12:36:59
4274532a-a3b3-4733-9626-7d2779f74a88	6b052865-a885-4b74-94d3-9838eadb0208	retrait	20766.00	32394.00	11628.00	FCFA	Retrait guichet	\N	2025-06-11 02:38:40	2025-10-23 12:36:59
ad2ca5dd-5fdc-44f5-97c9-880c0e94bcd5	6b052865-a885-4b74-94d3-9838eadb0208	depot	9499.00	32394.00	41893.00	FCFA	Dépôt chèque	\N	2025-09-27 19:45:05	2025-10-23 12:36:59
7ac327c5-eb8e-4099-87bb-6b0d8f563734	6b052865-a885-4b74-94d3-9838eadb0208	retrait	32123.00	32394.00	271.00	FCFA	Retrait guichet	\N	2025-07-07 03:33:14	2025-10-23 12:36:59
d319a6aa-34b3-44ec-bdac-0ae87342b895	6b052865-a885-4b74-94d3-9838eadb0208	retrait	44189.00	32394.00	0.00	FCFA	Paiement par carte	\N	2025-07-21 03:23:30	2025-10-23 12:36:59
eb03c2f6-edd0-46ae-8016-e5e47287def8	6b052865-a885-4b74-94d3-9838eadb0208	virement	44099.00	32394.00	0.00	FCFA	Virement salaire	0f731b08-109a-4e89-972b-71f8608c0c55	2025-07-12 14:19:24	2025-10-23 12:36:59
fd239bd6-1d07-453d-bcd5-01342db47741	6b052865-a885-4b74-94d3-9838eadb0208	depot	17736.00	32394.00	50130.00	FCFA	Dépôt espèces guichet	\N	2025-07-07 11:41:47	2025-10-23 12:36:59
75f18328-ea04-4fb4-a879-48dce10c5794	39ca01df-9037-4f1b-962a-164c3db984f0	retrait	20063.00	482970.00	462907.00	FCFA	Retrait DAB	\N	2025-04-26 15:01:56	2025-10-23 12:36:59
1e62df15-569e-412d-9c02-7431f2aa4b34	39ca01df-9037-4f1b-962a-164c3db984f0	virement	49249.00	482970.00	433721.00	FCFA	Paiement facture	a1f1990b-1819-4977-aaf0-bb14a824daa0	2025-10-07 07:23:29	2025-10-23 12:36:59
0868f08b-3acf-4170-bf81-4c4a0119425f	39ca01df-9037-4f1b-962a-164c3db984f0	depot	33463.00	482970.00	516433.00	FCFA	Dépôt chèque	\N	2025-07-19 06:15:54	2025-10-23 12:36:59
99bba9e0-c1bb-41e0-8093-b3c64a5d1364	39ca01df-9037-4f1b-962a-164c3db984f0	virement	23532.00	482970.00	459438.00	FCFA	Paiement facture	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	2025-07-23 13:32:16	2025-10-23 12:36:59
8d460e07-3a32-4a9d-80a2-41b0454ffe0d	39ca01df-9037-4f1b-962a-164c3db984f0	retrait	2998.00	482970.00	479972.00	FCFA	Prélèvement automatique	\N	2025-06-07 09:04:11	2025-10-23 12:36:59
a6ceaa14-8851-4b35-b265-44883001bef0	3406986a-f161-4a7a-80be-bcdf0e3f2214	depot	39219.00	214655.00	253874.00	FCFA	Versement salaire	\N	2025-06-18 02:51:17	2025-10-23 12:36:59
365a5da9-df37-488b-90a8-92198411c90d	3406986a-f161-4a7a-80be-bcdf0e3f2214	depot	10807.00	214655.00	225462.00	FCFA	Dépôt d'espèces	\N	2025-10-08 17:57:40	2025-10-23 12:36:59
79e012c9-2c2d-45b6-b990-26249efff41a	3406986a-f161-4a7a-80be-bcdf0e3f2214	depot	11949.00	214655.00	226604.00	FCFA	Dépôt d'espèces	\N	2025-05-22 00:17:02	2025-10-23 12:36:59
43ca44de-805f-4de8-b547-7124fd1637f8	3406986a-f161-4a7a-80be-bcdf0e3f2214	virement	42860.00	214655.00	171795.00	FCFA	Transfert entre comptes	24e04f46-72df-4b0e-9024-19c114c552aa	2025-04-27 12:49:34	2025-10-23 12:36:59
1da1e771-034a-4205-a830-47b0db8aad4b	3406986a-f161-4a7a-80be-bcdf0e3f2214	virement	38832.00	214655.00	175823.00	FCFA	Transfert bancaire	13b0280b-a95f-48ee-9c35-9fb3c4786166	2025-07-05 10:58:54	2025-10-23 12:36:59
711511ae-18c9-47b0-bd77-e6ccc5dc0668	3406986a-f161-4a7a-80be-bcdf0e3f2214	virement	45241.00	214655.00	169414.00	FCFA	Paiement facture	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	2025-07-13 12:51:42	2025-10-23 12:36:59
989b6080-1dad-4af8-a0f1-ce4bc8c53b5e	3406986a-f161-4a7a-80be-bcdf0e3f2214	virement	9971.00	214655.00	204684.00	FCFA	Transfert entre comptes	d725e859-df50-4ee3-8ab9-65d82dc7fd71	2025-05-03 18:56:01	2025-10-23 12:36:59
140382e1-9747-4371-942a-ceec21dec70b	3406986a-f161-4a7a-80be-bcdf0e3f2214	virement	34291.00	214655.00	180364.00	FCFA	Virement salaire	9c0923b4-0a14-4650-8df8-edf426310de6	2025-05-20 16:11:31	2025-10-23 12:36:59
04dfc82b-c042-4d00-a96f-8bd2fd22b5ae	3406986a-f161-4a7a-80be-bcdf0e3f2214	retrait	3125.00	214655.00	211530.00	FCFA	Paiement par carte	\N	2025-09-06 23:45:06	2025-10-23 12:36:59
2077729d-23b5-43e5-b20e-8bb98fa51ffb	cccd197c-f331-4647-8abe-dacb9cf26b5d	depot	17719.00	246708.00	264427.00	FCFA	Dépôt chèque	\N	2025-05-05 03:08:12	2025-10-23 12:36:59
53238cd8-d011-4542-91ca-d20be87d4134	cccd197c-f331-4647-8abe-dacb9cf26b5d	virement	24873.00	246708.00	221835.00	FCFA	Virement salaire	94b4fef5-88d3-4b9a-98c9-1e0c6c697c0a	2025-08-10 20:11:40	2025-10-23 12:36:59
a1a4771d-d5df-42a4-8a5d-04263f891671	cccd197c-f331-4647-8abe-dacb9cf26b5d	retrait	3767.00	246708.00	242941.00	FCFA	Retrait guichet	\N	2025-07-07 07:13:10	2025-10-23 12:36:59
260ed080-a532-45a6-b4c7-62051e8a91dd	cccd197c-f331-4647-8abe-dacb9cf26b5d	retrait	5853.00	246708.00	240855.00	FCFA	Retrait guichet	\N	2025-08-20 21:27:24	2025-10-23 12:36:59
98607a9a-e400-465e-b4b7-c472945d84f2	cccd197c-f331-4647-8abe-dacb9cf26b5d	retrait	36438.00	246708.00	210270.00	FCFA	Paiement par carte	\N	2025-04-28 02:02:46	2025-10-23 12:36:59
f9c8ac28-62be-4676-88a7-1189d83c6b62	cccd197c-f331-4647-8abe-dacb9cf26b5d	virement	11569.00	246708.00	235139.00	FCFA	Transfert bancaire	ce352024-ef0a-4c59-a717-07fa503a38dc	2025-09-29 22:01:49	2025-10-23 12:36:59
f7e591d5-944f-4f7e-827d-79e685f1afdc	cccd197c-f331-4647-8abe-dacb9cf26b5d	depot	20644.00	246708.00	267352.00	FCFA	Dépôt chèque	\N	2025-04-25 22:32:48	2025-10-23 12:36:59
b34cec24-efa3-4917-9dd3-003f0aacdaf0	cccd197c-f331-4647-8abe-dacb9cf26b5d	depot	40736.00	246708.00	287444.00	FCFA	Dépôt espèces guichet	\N	2025-07-03 10:03:19	2025-10-23 12:36:59
043e782f-410e-486b-8a91-73e841232c53	cccd197c-f331-4647-8abe-dacb9cf26b5d	depot	26286.00	246708.00	272994.00	FCFA	Dépôt chèque	\N	2025-06-29 12:33:33	2025-10-23 12:36:59
ab1c4ab2-1271-4d70-814d-75330155dfd6	cccd197c-f331-4647-8abe-dacb9cf26b5d	depot	49380.00	246708.00	296088.00	FCFA	Dépôt d'espèces	\N	2025-06-11 14:07:26	2025-10-23 12:36:59
eaeb2392-c033-4c59-ac9d-b1dc60221efa	cccd197c-f331-4647-8abe-dacb9cf26b5d	virement	25795.00	246708.00	220913.00	FCFA	Virement salaire	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	2025-05-03 11:10:17	2025-10-23 12:36:59
cbf51faa-f2b9-49e3-8cce-5b07289f4fda	cccd197c-f331-4647-8abe-dacb9cf26b5d	virement	8851.00	246708.00	237857.00	FCFA	Virement salaire	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	2025-09-27 11:57:03	2025-10-23 12:36:59
96ea53a8-af06-478c-b974-c29cba65d517	cccd197c-f331-4647-8abe-dacb9cf26b5d	virement	22869.00	246708.00	223839.00	FCFA	Transfert bancaire	8a4ca722-53cc-428f-a83a-d84a7f681abf	2025-09-21 15:18:52	2025-10-23 12:36:59
ec5a4248-8850-4a27-b9d5-3713781a0ab9	cccd197c-f331-4647-8abe-dacb9cf26b5d	depot	12362.00	246708.00	259070.00	FCFA	Dépôt d'espèces	\N	2025-08-11 21:32:54	2025-10-23 12:36:59
fc763929-00c1-4bab-b373-f55c6db72a60	cccd197c-f331-4647-8abe-dacb9cf26b5d	depot	23396.00	246708.00	270104.00	FCFA	Virement bancaire entrant	\N	2025-05-22 17:53:09	2025-10-23 12:36:59
136ac6fc-d467-4947-a692-6ec245d55946	cc0d2546-7dab-4d38-a26e-fedf481485db	retrait	34553.00	356885.00	322332.00	FCFA	Retrait DAB	\N	2025-07-19 08:22:15	2025-10-23 12:37:00
33e3ea34-5db6-4b1a-abbc-c53d9168d167	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	virement	3832.00	87869.00	84037.00	FCFA	Virement salaire	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	2025-10-09 11:25:08	2025-10-23 12:36:59
7e53e768-0a8a-4168-9927-6807f138a0f3	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	virement	19499.00	87869.00	68370.00	FCFA	Transfert entre comptes	65a4491c-ce37-4732-aa4f-0de79bc822d1	2025-08-12 18:34:12	2025-10-23 12:36:59
2a107256-1998-46de-a5d5-f547c669a5df	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	retrait	13915.00	87869.00	73954.00	FCFA	Prélèvement automatique	\N	2025-06-27 18:52:38	2025-10-23 12:36:59
d599a269-ad4e-4de5-b45c-dc283fff3576	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	virement	12215.00	87869.00	75654.00	FCFA	Transfert entre comptes	b48602a2-e9d1-487f-9f5d-b8d62e4ced5b	2025-05-14 18:10:45	2025-10-23 12:36:59
dcc6b513-5bda-4710-be10-c67b332f0209	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	retrait	37016.00	87869.00	50853.00	FCFA	Prélèvement automatique	\N	2025-07-10 19:01:43	2025-10-23 12:36:59
8b92de52-0f8e-4ce5-889c-3e5283b67fa0	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	retrait	9257.00	87869.00	78612.00	FCFA	Retrait d'espèces	\N	2025-08-18 05:02:40	2025-10-23 12:36:59
7e64d26f-2eaf-494c-8089-0200e4fa1a37	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	retrait	4671.00	87869.00	83198.00	FCFA	Retrait DAB	\N	2025-05-21 23:57:19	2025-10-23 12:36:59
46184bb6-1206-4442-b87a-b74b775d9398	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	retrait	12021.00	87869.00	75848.00	FCFA	Prélèvement automatique	\N	2025-09-26 08:54:44	2025-10-23 12:36:59
48f4fe3a-3ea3-4cae-919a-744dd4f846f6	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	retrait	4411.00	87869.00	83458.00	FCFA	Retrait DAB	\N	2025-05-24 17:57:32	2025-10-23 12:36:59
1b9e7f6f-a925-46e1-a894-7a631143eae8	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	virement	22941.00	87869.00	64928.00	FCFA	Virement salaire	79fa87c8-8658-4ac8-a54a-53ff2fe252cf	2025-05-08 09:13:00	2025-10-23 12:36:59
90b82be3-1e96-4b7f-8140-cc7ba411d675	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	retrait	16328.00	87869.00	71541.00	FCFA	Prélèvement automatique	\N	2025-08-05 19:42:40	2025-10-23 12:36:59
4547bcac-4a89-4db1-86ff-a128bbd71e72	54d5e886-a7a4-4427-b256-7723400f3c4e	virement	7418.00	99304.00	91886.00	FCFA	Paiement facture	2b138895-6391-4bfe-b137-ca4fa7854a4a	2025-07-25 14:04:31	2025-10-23 12:36:59
6b9c11c8-9702-4bb6-b9aa-32d0a32fe4e7	54d5e886-a7a4-4427-b256-7723400f3c4e	retrait	21234.00	99304.00	78070.00	FCFA	Paiement par carte	\N	2025-10-15 21:29:22	2025-10-23 12:36:59
d728850e-0877-4ebc-ae29-45eda187d1af	54d5e886-a7a4-4427-b256-7723400f3c4e	virement	34284.00	99304.00	65020.00	FCFA	Transfert bancaire	d725e859-df50-4ee3-8ab9-65d82dc7fd71	2025-05-08 21:31:50	2025-10-23 12:36:59
69c842e8-0a22-4243-a6ba-10f12250a947	54d5e886-a7a4-4427-b256-7723400f3c4e	retrait	13594.00	99304.00	85710.00	FCFA	Retrait guichet	\N	2025-07-06 00:51:15	2025-10-23 12:36:59
86766570-a493-45d6-8f98-7292d5508a86	54d5e886-a7a4-4427-b256-7723400f3c4e	virement	7351.00	99304.00	91953.00	FCFA	Paiement facture	4e0954f5-1956-40db-b392-7a6ee455c257	2025-05-10 10:40:00	2025-10-23 12:36:59
2359e153-f303-4f68-9256-ead1fda2bbe1	54d5e886-a7a4-4427-b256-7723400f3c4e	virement	2878.00	99304.00	96426.00	FCFA	Transfert entre comptes	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	2025-08-19 18:11:30	2025-10-23 12:36:59
61281fa2-d90c-468f-b02f-82d72c9bc2ec	54d5e886-a7a4-4427-b256-7723400f3c4e	virement	24410.00	99304.00	74894.00	FCFA	Paiement facture	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	2025-09-02 13:13:22	2025-10-23 12:36:59
a4d7e1cd-572c-45f4-b9ab-e53cfe166155	54d5e886-a7a4-4427-b256-7723400f3c4e	retrait	20347.00	99304.00	78957.00	FCFA	Retrait DAB	\N	2025-08-13 05:29:13	2025-10-23 12:36:59
9de32731-df9a-4a3e-b6d9-b2eb29836c5a	54d5e886-a7a4-4427-b256-7723400f3c4e	depot	46815.00	99304.00	146119.00	FCFA	Dépôt d'espèces	\N	2025-08-04 15:07:10	2025-10-23 12:36:59
97b6e4c9-e86e-49b1-8917-de43976df46c	54d5e886-a7a4-4427-b256-7723400f3c4e	depot	18148.00	99304.00	117452.00	FCFA	Dépôt espèces guichet	\N	2025-10-06 01:54:41	2025-10-23 12:36:59
9e40b7d1-4192-4c40-a6b3-205692f6aed2	54d5e886-a7a4-4427-b256-7723400f3c4e	retrait	2623.00	99304.00	96681.00	FCFA	Retrait guichet	\N	2025-07-04 08:33:18	2025-10-23 12:36:59
33200acf-0823-40b6-9506-d484ce671fd7	54d5e886-a7a4-4427-b256-7723400f3c4e	depot	2610.00	99304.00	101914.00	FCFA	Dépôt espèces guichet	\N	2025-06-06 04:02:47	2025-10-23 12:36:59
adcf1feb-b0aa-4fd6-b072-859355a2f6e6	184d6244-4107-464d-9848-8140c6174183	retrait	6476.00	330360.00	323884.00	FCFA	Retrait guichet	\N	2025-05-11 19:03:00	2025-10-23 12:36:59
ff8f9e7c-7ebf-45f1-a71e-9fe19b370da9	184d6244-4107-464d-9848-8140c6174183	depot	17448.00	330360.00	347808.00	FCFA	Dépôt chèque	\N	2025-06-28 00:42:36	2025-10-23 12:36:59
5b5d4f2a-c63f-483e-b969-c1e72008c142	184d6244-4107-464d-9848-8140c6174183	depot	24679.00	330360.00	355039.00	FCFA	Versement salaire	\N	2025-05-09 00:10:24	2025-10-23 12:36:59
497f7418-3cb5-4f74-ab49-3fd6bd0abcce	184d6244-4107-464d-9848-8140c6174183	retrait	38166.00	330360.00	292194.00	FCFA	Prélèvement automatique	\N	2025-07-06 06:09:41	2025-10-23 12:36:59
8becee9f-1c32-433b-a232-74e1470582fa	184d6244-4107-464d-9848-8140c6174183	virement	13587.00	330360.00	316773.00	FCFA	Virement salaire	64ee33cf-f4ed-4559-ab3c-48bccf04f75f	2025-09-15 14:47:31	2025-10-23 12:36:59
2882a8c6-73af-4c3e-9351-bb5af12be31f	184d6244-4107-464d-9848-8140c6174183	virement	32746.00	330360.00	297614.00	FCFA	Transfert entre comptes	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	2025-05-27 07:44:07	2025-10-23 12:36:59
c78bf4dc-2e82-42bf-8cf3-d2127f46b977	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	retrait	48682.00	102479.00	53797.00	FCFA	Retrait d'espèces	\N	2025-08-01 23:47:37	2025-10-23 12:36:59
02787ffa-c21f-4636-a35b-ffa7c0840183	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	virement	16697.00	102479.00	85782.00	FCFA	Virement vers compte	f1e6f840-61c7-4618-bbfd-578d06a2431f	2025-06-02 23:18:22	2025-10-23 12:36:59
45a70324-3f3d-4cab-a9c1-d4f1569c2230	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	depot	10214.00	102479.00	112693.00	FCFA	Dépôt chèque	\N	2025-06-22 19:52:27	2025-10-23 12:36:59
a130f0a0-a958-4b56-adee-1d2730da6408	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	virement	33304.00	102479.00	69175.00	FCFA	Paiement facture	887e3007-f4a2-4b73-aee8-c70039319c5f	2025-09-28 04:58:05	2025-10-23 12:36:59
f690837c-fc9b-484e-8460-c1c48810b6b4	7541c5c3-2387-4b15-b8d6-bdcfae4cbf45	depot	39585.00	102479.00	142064.00	FCFA	Dépôt chèque	\N	2025-07-24 01:49:59	2025-10-23 12:36:59
a29d8142-dd20-4efa-b48c-88330af45b4b	a03dce74-58f6-42c7-8624-1d21ea760a90	retrait	15857.00	18797.00	2940.00	FCFA	Retrait guichet	\N	2025-07-06 18:09:33	2025-10-23 12:36:59
233f21e8-91ce-43c0-8e9c-8d737762fe55	a03dce74-58f6-42c7-8624-1d21ea760a90	retrait	34682.00	18797.00	0.00	FCFA	Retrait DAB	\N	2025-06-23 14:22:53	2025-10-23 12:36:59
517bf168-0f29-4809-b0fb-dde025451946	a03dce74-58f6-42c7-8624-1d21ea760a90	depot	18581.00	18797.00	37378.00	FCFA	Dépôt chèque	\N	2025-06-20 01:59:14	2025-10-23 12:36:59
2ddad15f-0aaf-433a-81b4-0a67bc717027	a03dce74-58f6-42c7-8624-1d21ea760a90	depot	43883.00	18797.00	62680.00	FCFA	Dépôt chèque	\N	2025-06-25 18:35:08	2025-10-23 12:36:59
894787b3-ef9d-4903-a704-dbaddff8e708	a03dce74-58f6-42c7-8624-1d21ea760a90	virement	39484.00	18797.00	0.00	FCFA	Transfert entre comptes	2b138895-6391-4bfe-b137-ca4fa7854a4a	2025-07-16 16:52:19	2025-10-23 12:36:59
20787570-dff6-4a7f-b3da-8a9773341aec	a03dce74-58f6-42c7-8624-1d21ea760a90	retrait	2009.00	18797.00	16788.00	FCFA	Retrait d'espèces	\N	2025-07-28 16:00:09	2025-10-23 12:36:59
1239d336-fd28-42f5-9c95-0eaed22e1036	a03dce74-58f6-42c7-8624-1d21ea760a90	retrait	36445.00	18797.00	0.00	FCFA	Retrait d'espèces	\N	2025-06-30 07:14:22	2025-10-23 12:36:59
bbb50fe7-8b8d-4a46-a46f-c54439d3e647	a03dce74-58f6-42c7-8624-1d21ea760a90	virement	46220.00	18797.00	0.00	FCFA	Transfert entre comptes	818e8545-fc56-4437-b399-56970df2cc32	2025-05-30 01:26:16	2025-10-23 12:36:59
646ec381-0f1d-401a-9388-5a1d93f6611a	a03dce74-58f6-42c7-8624-1d21ea760a90	depot	32453.00	18797.00	51250.00	FCFA	Dépôt chèque	\N	2025-06-06 04:03:01	2025-10-23 12:36:59
800ee3b7-ab16-419f-a476-10e616bc53f7	a5bad169-7741-4b82-9dde-4803bb629488	virement	6269.00	275160.00	268891.00	FCFA	Transfert bancaire	03991212-82d0-40f8-aade-bd7a07550872	2025-08-02 03:21:09	2025-10-23 12:36:59
a5f5b06e-e67f-4e58-87c5-cb0295e5ff6a	a5bad169-7741-4b82-9dde-4803bb629488	retrait	10295.00	275160.00	264865.00	FCFA	Retrait DAB	\N	2025-09-03 00:23:50	2025-10-23 12:36:59
07f8cbd5-f3e3-4994-a86e-46322a4daa8b	a5bad169-7741-4b82-9dde-4803bb629488	retrait	21028.00	275160.00	254132.00	FCFA	Retrait d'espèces	\N	2025-09-12 18:35:23	2025-10-23 12:36:59
15f7399c-3513-4e16-b26d-78050474d5a5	a5bad169-7741-4b82-9dde-4803bb629488	depot	31311.00	275160.00	306471.00	FCFA	Dépôt d'espèces	\N	2025-06-10 20:08:31	2025-10-23 12:36:59
95b33076-f0d4-4989-9a7f-07fd485b512b	a5bad169-7741-4b82-9dde-4803bb629488	retrait	12886.00	275160.00	262274.00	FCFA	Retrait guichet	\N	2025-07-25 19:09:11	2025-10-23 12:36:59
85bf291c-808d-40ea-b280-1023d61d881e	a5bad169-7741-4b82-9dde-4803bb629488	retrait	45249.00	275160.00	229911.00	FCFA	Retrait d'espèces	\N	2025-06-02 03:40:49	2025-10-23 12:36:59
c986930f-737e-4a01-9a69-2dbd5402adef	a5bad169-7741-4b82-9dde-4803bb629488	retrait	41241.00	275160.00	233919.00	FCFA	Paiement par carte	\N	2025-08-03 21:47:14	2025-10-23 12:36:59
157de0ef-ec96-4fcb-8824-f5b50218a117	a5bad169-7741-4b82-9dde-4803bb629488	depot	15294.00	275160.00	290454.00	FCFA	Dépôt chèque	\N	2025-09-29 20:58:09	2025-10-23 12:36:59
e0615ffd-086f-46c1-b24a-5f45d779c048	a5bad169-7741-4b82-9dde-4803bb629488	virement	37192.00	275160.00	237968.00	FCFA	Virement salaire	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	2025-08-05 08:04:29	2025-10-23 12:36:59
610164ed-f455-451a-9757-692125a461ca	cb45ecae-4f73-42b2-870b-4f41321c9acd	virement	5507.00	490663.00	485156.00	FCFA	Transfert bancaire	269d3156-3edd-4bda-99b1-a6cdf48bccdd	2025-05-12 20:11:34	2025-10-23 12:36:59
465f29ec-ec8a-4571-9b13-7cbd6aeb1286	cb45ecae-4f73-42b2-870b-4f41321c9acd	depot	5257.00	490663.00	495920.00	FCFA	Virement bancaire entrant	\N	2025-09-20 00:21:48	2025-10-23 12:36:59
d24f4ad9-bf04-447d-b4a5-3650e222fb1d	cb45ecae-4f73-42b2-870b-4f41321c9acd	depot	15492.00	490663.00	506155.00	FCFA	Versement salaire	\N	2025-09-27 14:51:59	2025-10-23 12:36:59
d119e49c-1325-4095-bd65-cf89e44b4681	cb45ecae-4f73-42b2-870b-4f41321c9acd	depot	19863.00	490663.00	510526.00	FCFA	Dépôt chèque	\N	2025-09-02 17:25:44	2025-10-23 12:36:59
ddf88784-e28b-4392-b65e-b6a07e998c39	cb45ecae-4f73-42b2-870b-4f41321c9acd	depot	12042.00	490663.00	502705.00	FCFA	Virement bancaire entrant	\N	2025-08-22 19:11:23	2025-10-23 12:36:59
bc944335-c5de-4ddf-a979-5a91310e77fd	cb45ecae-4f73-42b2-870b-4f41321c9acd	virement	36493.00	490663.00	454170.00	FCFA	Virement salaire	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	2025-07-03 04:13:00	2025-10-23 12:36:59
8a27bb76-8e1e-4856-b0c2-2f8087ddd1c3	4bb7fc9b-13d6-4883-b751-283b753d05ed	retrait	34342.00	151689.00	117347.00	FCFA	Retrait d'espèces	\N	2025-06-28 22:15:58	2025-10-23 12:36:59
6a8eec27-6d72-411d-85f6-4d638b86f26a	4bb7fc9b-13d6-4883-b751-283b753d05ed	virement	11539.00	151689.00	140150.00	FCFA	Virement salaire	31fb6207-f59e-425f-bf86-a1085c47b43f	2025-07-01 21:07:36	2025-10-23 12:36:59
ff46e9c9-beb4-4a00-86b2-286b6d0a674d	4bb7fc9b-13d6-4883-b751-283b753d05ed	depot	23300.00	151689.00	174989.00	FCFA	Dépôt d'espèces	\N	2025-10-05 23:57:28	2025-10-23 12:36:59
dacc3d01-93de-421b-ad22-179604b1f369	4bb7fc9b-13d6-4883-b751-283b753d05ed	retrait	37154.00	151689.00	114535.00	FCFA	Prélèvement automatique	\N	2025-04-26 23:34:18	2025-10-23 12:36:59
e7bf563d-fa2a-45f3-bae0-348250c4541e	4bb7fc9b-13d6-4883-b751-283b753d05ed	virement	9602.00	151689.00	142087.00	FCFA	Paiement facture	5d3634bb-39ae-4beb-a70d-3f7ac49f03cf	2025-08-23 15:37:22	2025-10-23 12:36:59
80b85157-8a8d-49e5-8f5f-be9988c7b80d	4bb7fc9b-13d6-4883-b751-283b753d05ed	depot	34819.00	151689.00	186508.00	FCFA	Virement bancaire entrant	\N	2025-05-02 13:53:44	2025-10-23 12:36:59
6165e843-908a-47ae-8a22-caa3e56585d3	4bb7fc9b-13d6-4883-b751-283b753d05ed	virement	12382.00	151689.00	139307.00	FCFA	Virement salaire	ac532c01-37b7-44d5-bc6e-148843aaf375	2025-08-08 04:14:04	2025-10-23 12:36:59
f070bd37-f4ca-410b-af1d-f308a3ce9f3f	4bb7fc9b-13d6-4883-b751-283b753d05ed	virement	21970.00	151689.00	129719.00	FCFA	Transfert entre comptes	cc0d2546-7dab-4d38-a26e-fedf481485db	2025-08-23 11:38:46	2025-10-23 12:36:59
715fdf0d-8e2e-454b-af1a-f8e1b002fd51	4bb7fc9b-13d6-4883-b751-283b753d05ed	depot	18421.00	151689.00	170110.00	FCFA	Dépôt espèces guichet	\N	2025-09-14 01:54:17	2025-10-23 12:36:59
f124beca-1c20-4cc9-bb14-34ea02f9f1be	4bb7fc9b-13d6-4883-b751-283b753d05ed	retrait	31069.00	151689.00	120620.00	FCFA	Retrait DAB	\N	2025-10-19 00:35:21	2025-10-23 12:36:59
7cdfae02-ca8e-470d-b04f-e5db460f81a4	4bb7fc9b-13d6-4883-b751-283b753d05ed	depot	8368.00	151689.00	160057.00	FCFA	Versement salaire	\N	2025-10-11 04:32:19	2025-10-23 12:36:59
de8e6f75-be13-48c7-a68b-90a0495b6dc0	34b84e17-27b4-4080-a77b-3cdb00476a06	depot	23050.00	449873.00	472923.00	FCFA	Dépôt espèces guichet	\N	2025-04-30 14:32:43	2025-10-23 12:36:59
62cf8d3a-bd4e-4f83-87c9-a0b99e2ce7fa	34b84e17-27b4-4080-a77b-3cdb00476a06	virement	20820.00	449873.00	429053.00	FCFA	Transfert bancaire	2afce742-17e9-45bc-99be-9389a26da3ca	2025-08-16 20:57:22	2025-10-23 12:36:59
99ca8208-b018-430d-bb51-4283d0d1dfa7	34b84e17-27b4-4080-a77b-3cdb00476a06	depot	36560.00	449873.00	486433.00	FCFA	Dépôt chèque	\N	2025-06-08 07:24:11	2025-10-23 12:36:59
b3be8ac0-8c49-49f1-8ce4-2d98a696aefe	34b84e17-27b4-4080-a77b-3cdb00476a06	virement	45357.00	449873.00	404516.00	FCFA	Virement vers compte	e88eac49-5c57-48f8-824a-813a7da0fdc3	2025-07-08 16:45:43	2025-10-23 12:36:59
29bd22cc-3990-4a12-99dc-5a2c8775feff	34b84e17-27b4-4080-a77b-3cdb00476a06	retrait	4574.00	449873.00	445299.00	FCFA	Retrait DAB	\N	2025-09-07 07:56:55	2025-10-23 12:36:59
08ec9437-7f13-48f2-bd78-34d06ce5ab4b	34b84e17-27b4-4080-a77b-3cdb00476a06	virement	23107.00	449873.00	426766.00	FCFA	Virement vers compte	0b052b84-a33e-44e8-90f7-d9d1bfe27464	2025-08-15 00:41:13	2025-10-23 12:36:59
49dc8eec-bb8d-4eb8-8442-bbb5d3c447bd	34b84e17-27b4-4080-a77b-3cdb00476a06	depot	44850.00	449873.00	494723.00	FCFA	Virement bancaire entrant	\N	2025-07-22 03:31:36	2025-10-23 12:36:59
1fe0a618-dd32-4dd2-ae43-eef7c0a35621	34b84e17-27b4-4080-a77b-3cdb00476a06	virement	22744.00	449873.00	427129.00	FCFA	Transfert entre comptes	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	2025-07-15 13:12:35	2025-10-23 12:36:59
2a54aa98-e208-45cc-802f-2edf4e3e81e0	34b84e17-27b4-4080-a77b-3cdb00476a06	retrait	24586.00	449873.00	425287.00	FCFA	Retrait guichet	\N	2025-08-31 05:39:12	2025-10-23 12:36:59
f2fdd977-63ce-4441-aa9c-888bc47d087b	34b84e17-27b4-4080-a77b-3cdb00476a06	depot	16573.00	449873.00	466446.00	FCFA	Dépôt chèque	\N	2025-06-04 23:10:37	2025-10-23 12:36:59
567d899e-67b6-478e-b2f7-ee6e212dc441	34b84e17-27b4-4080-a77b-3cdb00476a06	virement	41238.00	449873.00	408635.00	FCFA	Transfert entre comptes	64203f77-d74d-4752-9e2b-7a1c40547be9	2025-08-10 03:01:55	2025-10-23 12:36:59
6b69fd03-4a5f-42ce-b212-fb63881e0d99	34b84e17-27b4-4080-a77b-3cdb00476a06	virement	30744.00	449873.00	419129.00	FCFA	Virement vers compte	df088290-3d37-4591-8571-389b37349b2a	2025-07-17 21:57:50	2025-10-23 12:36:59
c417d4ea-7091-4c04-b097-21e129d9bc92	d5017ad9-771a-4ec6-8b01-e408480e8116	retrait	22411.00	30557.00	8146.00	FCFA	Retrait guichet	\N	2025-09-13 02:47:18	2025-10-23 12:36:59
71a4f581-a929-488e-89d3-ea7ca4784053	d5017ad9-771a-4ec6-8b01-e408480e8116	depot	32076.00	30557.00	62633.00	FCFA	Virement bancaire entrant	\N	2025-06-21 15:48:10	2025-10-23 12:36:59
f0b49ceb-1fca-4824-bb74-c0662c0c8702	d5017ad9-771a-4ec6-8b01-e408480e8116	virement	32380.00	30557.00	0.00	FCFA	Virement vers compte	24e04f46-72df-4b0e-9024-19c114c552aa	2025-06-03 20:46:01	2025-10-23 12:36:59
033843fb-7900-4b40-9cc1-0b3b83537cf0	d5017ad9-771a-4ec6-8b01-e408480e8116	retrait	6370.00	30557.00	24187.00	FCFA	Retrait DAB	\N	2025-05-18 09:58:41	2025-10-23 12:36:59
e9d5db3e-f5b7-425c-ab3a-b990403810d4	d5017ad9-771a-4ec6-8b01-e408480e8116	virement	38804.00	30557.00	0.00	FCFA	Paiement facture	bc151b8f-a172-41b6-ab05-310ca341ebf3	2025-05-20 06:15:29	2025-10-23 12:36:59
a06fb8d7-f958-4b80-98f5-b64d7b912f6c	d5017ad9-771a-4ec6-8b01-e408480e8116	depot	4684.00	30557.00	35241.00	FCFA	Dépôt d'espèces	\N	2025-07-11 03:06:59	2025-10-23 12:36:59
5c43cf9c-3204-4094-86b7-2b7e319d184b	d5017ad9-771a-4ec6-8b01-e408480e8116	retrait	1770.00	30557.00	28787.00	FCFA	Retrait d'espèces	\N	2025-06-14 04:37:29	2025-10-23 12:36:59
cbfd3705-d012-4c34-a65d-d8b98d943816	d5017ad9-771a-4ec6-8b01-e408480e8116	retrait	43738.00	30557.00	0.00	FCFA	Prélèvement automatique	\N	2025-05-25 09:18:34	2025-10-23 12:36:59
c160866f-e30f-4239-bc25-cb967ac50ec6	d5017ad9-771a-4ec6-8b01-e408480e8116	virement	15461.00	30557.00	15096.00	FCFA	Virement vers compte	184d6244-4107-464d-9848-8140c6174183	2025-10-02 17:43:21	2025-10-23 12:36:59
965cb68a-1864-47da-a0cf-25ae035987b6	d5017ad9-771a-4ec6-8b01-e408480e8116	retrait	46805.00	30557.00	0.00	FCFA	Retrait d'espèces	\N	2025-09-12 17:39:48	2025-10-23 12:36:59
def37bd9-ad61-4321-a6ec-6be5911966b0	d5017ad9-771a-4ec6-8b01-e408480e8116	retrait	28107.00	30557.00	2450.00	FCFA	Prélèvement automatique	\N	2025-05-10 07:16:31	2025-10-23 12:36:59
992f7783-677e-4788-9076-56791d6794a3	d5017ad9-771a-4ec6-8b01-e408480e8116	virement	11019.00	30557.00	19538.00	FCFA	Paiement facture	43df68e0-310b-41d1-b272-3e281b325b72	2025-09-19 00:20:15	2025-10-23 12:36:59
3c4d6041-1b7a-4104-922d-ab65c655ce25	d5017ad9-771a-4ec6-8b01-e408480e8116	depot	32073.00	30557.00	62630.00	FCFA	Dépôt espèces guichet	\N	2025-07-13 01:03:14	2025-10-23 12:36:59
2dea41ba-8486-4ef5-86f5-2177597088ee	d5017ad9-771a-4ec6-8b01-e408480e8116	virement	48217.00	30557.00	0.00	FCFA	Virement vers compte	087d0d47-8377-4f2f-82a8-6acbc6e148f1	2025-04-27 16:39:05	2025-10-23 12:36:59
ca2de348-85d4-4f8f-ab9d-e310bfe81718	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	virement	23788.00	58652.00	34864.00	FCFA	Virement vers compte	c2b93a8c-ea1e-4b85-8224-c209137135b0	2025-04-28 17:10:40	2025-10-23 12:36:59
ea7a6f03-5fac-4801-8585-f7139d7f739c	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	virement	44336.00	58652.00	14316.00	FCFA	Virement vers compte	6131421b-d7d7-4f56-8450-582c37486f68	2025-05-31 02:43:51	2025-10-23 12:36:59
d894c711-8d28-4485-a9cd-5b6f4b230c99	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	depot	10614.00	58652.00	69266.00	FCFA	Versement salaire	\N	2025-08-03 19:21:45	2025-10-23 12:36:59
a0687306-3c3b-483d-8ca5-28e87ea7ee1c	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	virement	17397.00	58652.00	41255.00	FCFA	Virement salaire	c2b93a8c-ea1e-4b85-8224-c209137135b0	2025-09-06 02:08:23	2025-10-23 12:36:59
bcf212a7-65c0-4660-961b-bfe2403796d1	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	virement	48552.00	58652.00	10100.00	FCFA	Virement vers compte	ce34889a-7b15-48e8-9003-f1522cf517f8	2025-05-08 16:54:09	2025-10-23 12:36:59
d4898480-25fa-47e4-9df8-135273a3cdff	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	depot	30957.00	58652.00	89609.00	FCFA	Versement salaire	\N	2025-05-04 22:24:50	2025-10-23 12:36:59
26e548c4-e9fc-4e7b-b1a8-b4601168b9cb	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	depot	7211.00	58652.00	65863.00	FCFA	Virement bancaire entrant	\N	2025-08-13 14:59:23	2025-10-23 12:36:59
92623454-484a-42af-8a9a-f22821f9fd85	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	virement	4335.00	58652.00	54317.00	FCFA	Transfert bancaire	e5fbfcb0-c796-4371-80c6-f78f1038a282	2025-06-20 19:36:15	2025-10-23 12:36:59
133921b6-aab8-42e7-8c1e-da1ee7b76f8b	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	virement	24782.00	58652.00	33870.00	FCFA	Virement vers compte	808e915e-a5d8-4751-aaa8-50fe040cde68	2025-09-17 03:40:19	2025-10-23 12:36:59
7c9ca861-a3ac-4035-94db-cc30dac2eacf	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	retrait	34833.00	58652.00	23819.00	FCFA	Retrait d'espèces	\N	2025-05-11 08:07:45	2025-10-23 12:36:59
69b04f93-d64a-44f0-bde5-f1c0abce95fd	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	virement	37705.00	58652.00	20947.00	FCFA	Virement salaire	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	2025-06-13 07:11:18	2025-10-23 12:36:59
ad8fb928-4278-4bb8-be7a-4967fd2d4d31	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	depot	31761.00	58652.00	90413.00	FCFA	Dépôt espèces guichet	\N	2025-08-31 12:52:58	2025-10-23 12:36:59
6b2644d4-39d6-4119-b652-69539643b95a	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	virement	40054.00	58652.00	18598.00	FCFA	Transfert bancaire	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	2025-06-29 07:50:32	2025-10-23 12:36:59
4fb86ffc-774a-461e-9bc5-36a818c23a9e	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	depot	31108.00	58652.00	89760.00	FCFA	Versement salaire	\N	2025-07-31 15:32:02	2025-10-23 12:36:59
c0c6b6c9-fe9a-4ef3-8d97-8ed2657227a3	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	virement	3311.00	58652.00	55341.00	FCFA	Paiement facture	cccd197c-f331-4647-8abe-dacb9cf26b5d	2025-05-03 05:39:22	2025-10-23 12:36:59
dc6c88f8-23a2-41f8-8d10-ed648760a308	a90e1a63-43fd-4956-af04-b3458780ca97	depot	3421.00	30464.00	33885.00	FCFA	Dépôt chèque	\N	2025-10-20 06:38:09	2025-10-23 12:36:59
ef7a40af-c440-49ff-91a9-3a48cfb3f6a4	a90e1a63-43fd-4956-af04-b3458780ca97	virement	31944.00	30464.00	0.00	FCFA	Transfert bancaire	ce352024-ef0a-4c59-a717-07fa503a38dc	2025-09-21 17:06:48	2025-10-23 12:36:59
f12a5851-3526-4b5c-9181-a653f4f09f4b	a90e1a63-43fd-4956-af04-b3458780ca97	retrait	19876.00	30464.00	10588.00	FCFA	Retrait guichet	\N	2025-07-12 23:55:23	2025-10-23 12:36:59
681db2b1-f04a-4cd1-85a8-186374df572a	a90e1a63-43fd-4956-af04-b3458780ca97	retrait	39053.00	30464.00	0.00	FCFA	Prélèvement automatique	\N	2025-05-28 12:56:41	2025-10-23 12:36:59
fe53684a-2d19-4736-a0fd-6b51b62b1157	a90e1a63-43fd-4956-af04-b3458780ca97	retrait	44486.00	30464.00	0.00	FCFA	Retrait d'espèces	\N	2025-09-02 03:05:18	2025-10-23 12:36:59
5d7586c1-0abe-4a8c-a622-6e7250b739b9	a90e1a63-43fd-4956-af04-b3458780ca97	depot	31510.00	30464.00	61974.00	FCFA	Dépôt chèque	\N	2025-05-24 09:26:47	2025-10-23 12:36:59
236e8bc1-1709-4bba-949f-94143292b84e	a90e1a63-43fd-4956-af04-b3458780ca97	depot	14031.00	30464.00	44495.00	FCFA	Virement bancaire entrant	\N	2025-05-21 06:09:00	2025-10-23 12:36:59
2fd944e5-9e55-4746-a238-d8e2a5507c92	a90e1a63-43fd-4956-af04-b3458780ca97	virement	47180.00	30464.00	0.00	FCFA	Transfert bancaire	6b052865-a885-4b74-94d3-9838eadb0208	2025-07-07 18:45:41	2025-10-23 12:36:59
aa176864-fbeb-4531-9c2a-255e2664b73d	a90e1a63-43fd-4956-af04-b3458780ca97	virement	27128.00	30464.00	3336.00	FCFA	Transfert bancaire	cc0d2546-7dab-4d38-a26e-fedf481485db	2025-08-03 21:54:20	2025-10-23 12:36:59
220633f0-bd4c-4251-b1d4-015ae72a9916	a90e1a63-43fd-4956-af04-b3458780ca97	depot	37924.00	30464.00	68388.00	FCFA	Dépôt espèces guichet	\N	2025-04-25 20:06:36	2025-10-23 12:36:59
d7cf6c38-74a8-43e1-a7f9-8a57662ce9e3	a90e1a63-43fd-4956-af04-b3458780ca97	virement	16663.00	30464.00	13801.00	FCFA	Virement vers compte	12a1bcc9-6ded-4708-8db3-3ebeb5632e08	2025-07-17 23:18:58	2025-10-23 12:36:59
d4f64b41-7efb-426a-a844-3c900eacb653	a90e1a63-43fd-4956-af04-b3458780ca97	depot	23718.00	30464.00	54182.00	FCFA	Dépôt espèces guichet	\N	2025-06-21 05:44:51	2025-10-23 12:36:59
48a2926d-ae07-49ff-b8df-874f03c1e2de	a90e1a63-43fd-4956-af04-b3458780ca97	retrait	46281.00	30464.00	0.00	FCFA	Retrait d'espèces	\N	2025-10-11 03:03:36	2025-10-23 12:36:59
96a5fd52-adcb-4249-a671-53506956f6ed	6c92b373-c286-44a2-94a3-cf8cf3479100	retrait	32968.00	372762.00	339794.00	FCFA	Prélèvement automatique	\N	2025-07-24 14:10:31	2025-10-23 12:36:59
46585420-9a32-45a4-971f-fbdc16fa6e22	6c92b373-c286-44a2-94a3-cf8cf3479100	depot	1311.00	372762.00	374073.00	FCFA	Versement salaire	\N	2025-09-07 18:08:22	2025-10-23 12:36:59
2b29de84-b2e9-4db8-8e3f-75201884575f	6c92b373-c286-44a2-94a3-cf8cf3479100	retrait	34763.00	372762.00	337999.00	FCFA	Retrait d'espèces	\N	2025-05-02 17:42:11	2025-10-23 12:36:59
4c29b688-da5c-4c88-a242-ef4874deca4d	6c92b373-c286-44a2-94a3-cf8cf3479100	depot	20989.00	372762.00	393751.00	FCFA	Dépôt chèque	\N	2025-05-08 16:38:09	2025-10-23 12:36:59
d667a6d8-ce6f-4e4b-86d0-ac3574156a74	6c92b373-c286-44a2-94a3-cf8cf3479100	retrait	36521.00	372762.00	336241.00	FCFA	Paiement par carte	\N	2025-08-10 13:49:00	2025-10-23 12:36:59
453b8c00-323c-4ca0-a33e-872d408ebcaf	6c92b373-c286-44a2-94a3-cf8cf3479100	retrait	45729.00	372762.00	327033.00	FCFA	Prélèvement automatique	\N	2025-09-27 00:39:53	2025-10-23 12:36:59
410d8442-0aa0-4214-a5ec-0f60dbd0d845	6c92b373-c286-44a2-94a3-cf8cf3479100	retrait	37612.00	372762.00	335150.00	FCFA	Retrait DAB	\N	2025-08-05 08:26:08	2025-10-23 12:36:59
e88ba4bd-1406-4095-8096-663375ea9e71	6c92b373-c286-44a2-94a3-cf8cf3479100	retrait	23581.00	372762.00	349181.00	FCFA	Prélèvement automatique	\N	2025-08-02 23:07:36	2025-10-23 12:36:59
19023c77-8a48-4b7a-a6e1-3c76580116c5	6c92b373-c286-44a2-94a3-cf8cf3479100	depot	36281.00	372762.00	409043.00	FCFA	Dépôt chèque	\N	2025-07-19 20:50:17	2025-10-23 12:36:59
8a000621-538a-49d3-ab7b-9fb661e648b0	6c92b373-c286-44a2-94a3-cf8cf3479100	retrait	7826.00	372762.00	364936.00	FCFA	Prélèvement automatique	\N	2025-06-16 18:29:29	2025-10-23 12:36:59
6b3fe0da-c394-49c8-bc6b-6b1686e4bc5e	6c92b373-c286-44a2-94a3-cf8cf3479100	depot	22398.00	372762.00	395160.00	FCFA	Dépôt chèque	\N	2025-07-23 22:56:52	2025-10-23 12:36:59
5d5e15cb-d02b-43a8-b44a-92e490d679b3	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	retrait	47679.00	468625.00	420946.00	FCFA	Prélèvement automatique	\N	2025-08-07 08:54:09	2025-10-23 12:36:59
ba6736b8-d222-4d47-b713-f5911746b15d	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	depot	46954.00	468625.00	515579.00	FCFA	Versement salaire	\N	2025-06-05 15:59:50	2025-10-23 12:36:59
326f3596-1e28-48d8-88df-f6fc52c2f919	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	retrait	31580.00	468625.00	437045.00	FCFA	Retrait guichet	\N	2025-06-10 19:36:10	2025-10-23 12:36:59
ce47b9e3-9471-42f3-99d7-b93ba312371f	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	retrait	30486.00	468625.00	438139.00	FCFA	Retrait guichet	\N	2025-08-25 02:03:48	2025-10-23 12:36:59
c8e3db8a-7d90-4f7c-9aed-12cd5aa5af8f	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	retrait	3329.00	468625.00	465296.00	FCFA	Paiement par carte	\N	2025-10-14 05:00:00	2025-10-23 12:36:59
1eed59d1-f806-490f-b2e1-b026553495f8	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	virement	35345.00	468625.00	433280.00	FCFA	Transfert bancaire	57a5b070-a40d-45d9-b0ee-ba32f96383a6	2025-05-27 20:12:24	2025-10-23 12:36:59
2e5e153e-c653-4bac-a3f8-97863a311cab	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	retrait	32312.00	468625.00	436313.00	FCFA	Retrait guichet	\N	2025-07-19 00:31:21	2025-10-23 12:36:59
8e932f56-11df-4393-80bd-9cd466599b3c	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	retrait	39751.00	468625.00	428874.00	FCFA	Prélèvement automatique	\N	2025-06-10 06:18:14	2025-10-23 12:36:59
3dc0f408-d94c-4c09-b827-42baec217af5	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	retrait	12953.00	468625.00	455672.00	FCFA	Paiement par carte	\N	2025-08-06 10:16:04	2025-10-23 12:36:59
cd7e0c8a-f1f7-41d2-a20d-de184033661a	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	virement	46657.00	468625.00	421968.00	FCFA	Virement salaire	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	2025-06-21 06:44:26	2025-10-23 12:36:59
604d1411-3ae7-4818-9a49-cd840d2d5c72	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	virement	14657.00	468625.00	453968.00	FCFA	Transfert entre comptes	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	2025-07-04 05:42:09	2025-10-23 12:36:59
962f414c-5c3d-41e2-8ac1-d87ed5bdbc4b	c5b06daf-ba43-4954-b2b8-1065dfb122ab	retrait	25432.00	74183.00	48751.00	FCFA	Retrait guichet	\N	2025-07-29 06:10:02	2025-10-23 12:36:59
7e286052-54bb-4308-af09-cf95e880bd84	c5b06daf-ba43-4954-b2b8-1065dfb122ab	retrait	23696.00	74183.00	50487.00	FCFA	Prélèvement automatique	\N	2025-08-10 17:01:39	2025-10-23 12:36:59
6efa0ba4-4ec2-4042-aa6f-7cef00ece1de	c5b06daf-ba43-4954-b2b8-1065dfb122ab	virement	11586.00	74183.00	62597.00	FCFA	Virement vers compte	cc0d2546-7dab-4d38-a26e-fedf481485db	2025-07-22 21:14:01	2025-10-23 12:36:59
d6ec53f0-5b89-4bca-80eb-269d9f6e53b8	c5b06daf-ba43-4954-b2b8-1065dfb122ab	depot	34559.00	74183.00	108742.00	FCFA	Virement bancaire entrant	\N	2025-05-04 05:52:41	2025-10-23 12:36:59
1112dd3e-d02f-49ee-a856-0f92544d838f	c5b06daf-ba43-4954-b2b8-1065dfb122ab	depot	21816.00	74183.00	95999.00	FCFA	Dépôt chèque	\N	2025-09-26 00:04:08	2025-10-23 12:36:59
61e68ca7-0313-4a2f-bc69-c29b8d796b9c	c5b06daf-ba43-4954-b2b8-1065dfb122ab	depot	1937.00	74183.00	76120.00	FCFA	Dépôt chèque	\N	2025-05-03 23:20:56	2025-10-23 12:36:59
e8136855-e86b-4bd2-8557-23760af08529	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	retrait	23913.00	320094.00	296181.00	FCFA	Prélèvement automatique	\N	2025-05-19 04:14:17	2025-10-23 12:36:59
7a410797-87d9-4689-837c-dc9c4194f165	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	virement	20361.00	320094.00	299733.00	FCFA	Transfert bancaire	e774b1e8-095f-4684-a770-c420e32f477a	2025-06-06 20:20:53	2025-10-23 12:36:59
ec497368-929d-48f2-9474-15e217251510	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	retrait	12105.00	320094.00	307989.00	FCFA	Retrait guichet	\N	2025-07-22 13:33:01	2025-10-23 12:36:59
2db94b8c-1e90-4cf4-9aef-546795d8bb84	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	depot	32192.00	320094.00	352286.00	FCFA	Versement salaire	\N	2025-10-23 00:09:06	2025-10-23 12:36:59
f47c4369-6f98-4389-b483-87f6f0a40286	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	depot	17313.00	320094.00	337407.00	FCFA	Versement salaire	\N	2025-06-12 20:34:00	2025-10-23 12:36:59
b4cc2672-3c81-43f6-8cc1-fda1a18c621c	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	virement	44509.00	320094.00	275585.00	FCFA	Virement salaire	4bb7fc9b-13d6-4883-b751-283b753d05ed	2025-10-08 18:54:27	2025-10-23 12:36:59
404eaa0d-033f-4f41-98b3-089c85fd1050	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	retrait	40597.00	320094.00	279497.00	FCFA	Retrait d'espèces	\N	2025-08-02 06:50:43	2025-10-23 12:36:59
3b395df3-9813-423b-bb1b-5487724c9cfe	3c56e2a4-d8a0-41d5-9887-0c82e5e9e07b	retrait	9403.00	320094.00	310691.00	FCFA	Retrait guichet	\N	2025-09-09 07:09:03	2025-10-23 12:36:59
b4c5461d-e24a-402e-bf97-c14f12258340	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	depot	4683.00	138344.00	143027.00	FCFA	Dépôt espèces guichet	\N	2025-06-07 17:45:19	2025-10-23 12:36:59
8860a278-d30f-4912-9e8a-d454a80a8396	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	retrait	17105.00	138344.00	121239.00	FCFA	Paiement par carte	\N	2025-09-22 00:30:13	2025-10-23 12:36:59
d9bf9809-c00b-4412-b377-5c3cef2c7683	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	retrait	42616.00	138344.00	95728.00	FCFA	Retrait guichet	\N	2025-05-19 21:16:45	2025-10-23 12:36:59
434f9a37-422c-447a-883a-7632f89dffa8	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	depot	6863.00	138344.00	145207.00	FCFA	Dépôt chèque	\N	2025-05-19 11:18:11	2025-10-23 12:36:59
10bc586a-04ce-4b09-8552-f02dda046354	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	depot	39073.00	138344.00	177417.00	FCFA	Virement bancaire entrant	\N	2025-05-30 02:34:55	2025-10-23 12:36:59
c02ad42d-ba1a-4967-b4d9-f41f1637cfa0	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	depot	19742.00	138344.00	158086.00	FCFA	Dépôt espèces guichet	\N	2025-05-22 21:40:44	2025-10-23 12:36:59
bdf67bba-a8f2-4193-80ec-48a308185986	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	depot	16584.00	138344.00	154928.00	FCFA	Dépôt espèces guichet	\N	2025-09-18 03:39:18	2025-10-23 12:36:59
dd40fdd6-d63c-4cf6-b8cb-39fcd5b3dac4	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	retrait	36844.00	138344.00	101500.00	FCFA	Retrait DAB	\N	2025-07-12 19:47:12	2025-10-23 12:36:59
1401995b-016a-4e15-95d3-515e9ce7bb1e	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	virement	17934.00	138344.00	120410.00	FCFA	Paiement facture	849dcfa8-90dd-4efb-befe-4a819d763b77	2025-06-28 23:07:24	2025-10-23 12:36:59
2f9063c2-25fa-458f-b300-add037180436	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	depot	32050.00	138344.00	170394.00	FCFA	Dépôt d'espèces	\N	2025-06-09 03:28:23	2025-10-23 12:36:59
4273cb21-4d99-44b0-8942-886f3f843327	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	virement	9517.00	138344.00	128827.00	FCFA	Transfert bancaire	8cc906e8-f49e-48bf-97f7-063a96dd5855	2025-05-13 15:43:25	2025-10-23 12:36:59
53cf57c4-1a9c-4645-9630-0d2d38742283	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	depot	7399.00	138344.00	145743.00	FCFA	Dépôt d'espèces	\N	2025-09-22 06:57:58	2025-10-23 12:36:59
5d7c0d55-79b6-4057-8ae7-4018fde4979c	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	retrait	45157.00	138344.00	93187.00	FCFA	Prélèvement automatique	\N	2025-10-02 11:44:07	2025-10-23 12:36:59
7f7e5533-4209-4fea-8fb9-467b8502c6bc	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	depot	29308.00	138344.00	167652.00	FCFA	Dépôt d'espèces	\N	2025-10-18 15:05:19	2025-10-23 12:36:59
e0b42d35-dc5e-4f50-9450-bbe68f32c26d	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	depot	39943.00	1381.00	41324.00	FCFA	Versement salaire	\N	2025-05-12 01:24:53	2025-10-23 12:36:59
2f27253f-5425-4ff1-8391-c56512c5f4fb	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	depot	44755.00	1381.00	46136.00	FCFA	Dépôt espèces guichet	\N	2025-04-29 14:21:10	2025-10-23 12:36:59
4054ba8b-b02b-4d39-b410-94fd5c1fab15	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	retrait	48951.00	1381.00	0.00	FCFA	Prélèvement automatique	\N	2025-09-26 02:25:29	2025-10-23 12:36:59
e8a584e4-fa13-4f53-96d6-52e39dd139e1	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	retrait	35305.00	1381.00	0.00	FCFA	Retrait guichet	\N	2025-10-08 20:54:34	2025-10-23 12:36:59
81eb079d-36fe-488b-82e8-6cadcf730894	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	virement	26094.00	1381.00	0.00	FCFA	Transfert bancaire	05c0a3e8-eeae-4976-88c2-848aec6bea96	2025-09-16 10:05:24	2025-10-23 12:36:59
3c7b8f81-4e64-4cc0-a087-da30cfeffa2d	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	depot	15398.00	1381.00	16779.00	FCFA	Virement bancaire entrant	\N	2025-07-05 07:17:22	2025-10-23 12:36:59
58c36c74-9196-4b56-80aa-7a8489eb041e	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	virement	9473.00	1381.00	0.00	FCFA	Paiement facture	ce34889a-7b15-48e8-9003-f1522cf517f8	2025-08-03 02:26:07	2025-10-23 12:36:59
59ca3298-3e28-4094-af5f-c546b41df13d	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	virement	16750.00	1381.00	0.00	FCFA	Paiement facture	03991212-82d0-40f8-aade-bd7a07550872	2025-06-07 20:11:01	2025-10-23 12:36:59
ba075937-e5e8-4883-b7bf-d85c5ed4fccd	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	depot	19814.00	1381.00	21195.00	FCFA	Dépôt chèque	\N	2025-10-15 09:19:59	2025-10-23 12:36:59
914968b7-b6fa-4a6b-8c4e-f7ecbe896aab	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	depot	40861.00	206130.00	246991.00	FCFA	Virement bancaire entrant	\N	2025-09-17 21:39:29	2025-10-23 12:36:59
bd2c23ed-6bc8-4b71-9c88-08d6e4b1e443	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	depot	44133.00	206130.00	250263.00	FCFA	Versement salaire	\N	2025-08-12 07:15:28	2025-10-23 12:36:59
c4efe86a-01b3-4ddf-8f7a-1b8863f83f14	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	virement	16056.00	206130.00	190074.00	FCFA	Paiement facture	ce352024-ef0a-4c59-a717-07fa503a38dc	2025-08-19 16:39:03	2025-10-23 12:36:59
cf6af30e-7db3-4f0d-a1d6-055df3a94fd6	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	virement	43762.00	206130.00	162368.00	FCFA	Transfert entre comptes	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	2025-09-30 12:54:55	2025-10-23 12:36:59
98c42364-fdc0-4dce-abf5-d6cd1f25c122	98fa1b64-3a31-46f1-bf02-26b2ae8eb2e1	retrait	16396.00	206130.00	189734.00	FCFA	Retrait d'espèces	\N	2025-08-10 05:18:25	2025-10-23 12:36:59
7c5e0763-b7ac-4798-98af-35cd50bb39fc	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	virement	45473.00	383574.00	338101.00	FCFA	Virement salaire	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	2025-07-18 08:42:27	2025-10-23 12:36:59
7b8d7474-32ec-4d58-a8f4-082db931af9d	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	depot	28663.00	383574.00	412237.00	FCFA	Dépôt espèces guichet	\N	2025-07-21 07:20:29	2025-10-23 12:36:59
188c7bc9-2164-4d4c-9727-25acf6223eb9	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	depot	34581.00	383574.00	418155.00	FCFA	Versement salaire	\N	2025-10-09 16:31:24	2025-10-23 12:36:59
ec72f75e-f6b3-4d0d-bb8e-15a8492dd0ed	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	virement	35018.00	383574.00	348556.00	FCFA	Virement vers compte	916bbfef-cee4-457b-a001-da8e5b0be63d	2025-10-12 01:00:42	2025-10-23 12:36:59
17fd6f00-2924-4e85-b9ac-97622af1762a	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	retrait	37744.00	383574.00	345830.00	FCFA	Paiement par carte	\N	2025-08-17 15:02:18	2025-10-23 12:36:59
da54a899-6511-43cc-8063-eb7796dff670	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	retrait	2001.00	383574.00	381573.00	FCFA	Retrait d'espèces	\N	2025-06-24 15:45:30	2025-10-23 12:36:59
4dbc8936-9d69-4922-89ea-44272e574d81	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	virement	37591.00	383574.00	345983.00	FCFA	Virement vers compte	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	2025-10-19 04:06:40	2025-10-23 12:36:59
a8ec9753-a446-4dc6-8318-edb7f175c654	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	depot	26253.00	383574.00	409827.00	FCFA	Virement bancaire entrant	\N	2025-10-16 03:43:21	2025-10-23 12:36:59
593aee53-2e5f-4bd8-a094-98e683e622bd	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	virement	48134.00	383574.00	335440.00	FCFA	Transfert bancaire	5f5f316c-0963-43fc-b6d4-599439e88c6f	2025-10-19 13:58:10	2025-10-23 12:36:59
aa595641-813b-4c23-a3e8-87344419fa8b	05c0a3e8-eeae-4976-88c2-848aec6bea96	depot	21508.00	221442.00	242950.00	FCFA	Dépôt chèque	\N	2025-05-07 01:40:17	2025-10-23 12:36:59
0cd75708-364a-4845-b127-efe2bb079192	05c0a3e8-eeae-4976-88c2-848aec6bea96	depot	15083.00	221442.00	236525.00	FCFA	Dépôt chèque	\N	2025-08-14 06:08:58	2025-10-23 12:36:59
65db5b54-e062-44aa-afa4-6401da250324	05c0a3e8-eeae-4976-88c2-848aec6bea96	depot	44870.00	221442.00	266312.00	FCFA	Versement salaire	\N	2025-10-16 22:35:28	2025-10-23 12:36:59
3753fb8e-c536-42c9-877a-4a6e28ea8e9d	05c0a3e8-eeae-4976-88c2-848aec6bea96	retrait	44225.00	221442.00	177217.00	FCFA	Retrait DAB	\N	2025-07-03 18:20:51	2025-10-23 12:36:59
5abbb816-73c5-4b21-9191-9a6aa61d5423	05c0a3e8-eeae-4976-88c2-848aec6bea96	virement	46951.00	221442.00	174491.00	FCFA	Virement vers compte	c7cca6e7-9120-40e6-b0a2-2d86941c73f5	2025-08-12 17:15:56	2025-10-23 12:36:59
4006bbdf-eb19-4415-b74f-b5e7065f937d	05c0a3e8-eeae-4976-88c2-848aec6bea96	depot	13412.00	221442.00	234854.00	FCFA	Virement bancaire entrant	\N	2025-06-01 01:57:10	2025-10-23 12:36:59
3beb12ec-5e1c-4774-a926-b67825bdb468	05c0a3e8-eeae-4976-88c2-848aec6bea96	retrait	15397.00	221442.00	206045.00	FCFA	Retrait d'espèces	\N	2025-07-11 16:01:26	2025-10-23 12:36:59
a978b60b-4328-47fa-b43f-60bbeab610fb	05c0a3e8-eeae-4976-88c2-848aec6bea96	retrait	16583.00	221442.00	204859.00	FCFA	Prélèvement automatique	\N	2025-07-20 16:28:48	2025-10-23 12:36:59
d86c7f01-1d58-4f5c-a152-62e232b49bfb	05c0a3e8-eeae-4976-88c2-848aec6bea96	virement	15803.00	221442.00	205639.00	FCFA	Transfert entre comptes	0006e5f7-4df5-46a5-8f9e-90089c5ea052	2025-09-05 15:38:25	2025-10-23 12:36:59
5f925258-9756-44d1-9f50-33341343f0dd	05c0a3e8-eeae-4976-88c2-848aec6bea96	retrait	9303.00	221442.00	212139.00	FCFA	Paiement par carte	\N	2025-06-12 00:53:19	2025-10-23 12:36:59
9a487755-a589-4a0b-b909-11031822021e	b26e640d-87a1-49a8-a880-2a2088a4fca0	depot	15561.00	432007.00	447568.00	FCFA	Dépôt espèces guichet	\N	2025-05-20 14:49:47	2025-10-23 12:36:59
c5f89c8e-5e12-4b15-a622-df100723544c	b26e640d-87a1-49a8-a880-2a2088a4fca0	depot	25908.00	432007.00	457915.00	FCFA	Dépôt chèque	\N	2025-04-28 04:32:46	2025-10-23 12:36:59
4a6de9cf-3103-4fbc-ab4a-7aa901d3541c	b26e640d-87a1-49a8-a880-2a2088a4fca0	depot	25979.00	432007.00	457986.00	FCFA	Versement salaire	\N	2025-09-10 04:06:58	2025-10-23 12:36:59
f19bca00-8e0d-4f6c-a2f3-57097d67e71a	b26e640d-87a1-49a8-a880-2a2088a4fca0	depot	23812.00	432007.00	455819.00	FCFA	Dépôt d'espèces	\N	2025-09-12 06:17:07	2025-10-23 12:36:59
1626d43e-a9ea-4d1c-b298-65d1c4b0bb95	b26e640d-87a1-49a8-a880-2a2088a4fca0	retrait	44746.00	432007.00	387261.00	FCFA	Prélèvement automatique	\N	2025-06-04 06:52:31	2025-10-23 12:36:59
f6e7232c-0940-4a87-8ebf-2fb2e39d9e26	b26e640d-87a1-49a8-a880-2a2088a4fca0	retrait	37363.00	432007.00	394644.00	FCFA	Retrait d'espèces	\N	2025-06-01 20:33:34	2025-10-23 12:36:59
2f2666bd-213c-46e3-9ef5-80f3ac828e80	b26e640d-87a1-49a8-a880-2a2088a4fca0	depot	3737.00	432007.00	435744.00	FCFA	Dépôt espèces guichet	\N	2025-10-10 16:15:32	2025-10-23 12:36:59
cc267ffb-44e1-4820-98f9-d6acfb5fce53	b26e640d-87a1-49a8-a880-2a2088a4fca0	virement	37197.00	432007.00	394810.00	FCFA	Virement salaire	3badd48d-41cc-4d4c-abfa-55dd1b3e0c1e	2025-05-05 12:07:10	2025-10-23 12:36:59
5ccf1ada-bd58-4273-9746-0cc0cf0e138b	b26e640d-87a1-49a8-a880-2a2088a4fca0	depot	32522.00	432007.00	464529.00	FCFA	Dépôt espèces guichet	\N	2025-10-12 18:56:37	2025-10-23 12:36:59
37182ea8-ae34-4ab9-a2de-643b9b028f25	b26e640d-87a1-49a8-a880-2a2088a4fca0	retrait	27958.00	432007.00	404049.00	FCFA	Paiement par carte	\N	2025-06-20 13:21:38	2025-10-23 12:36:59
7862e54c-43b0-4f63-9d75-cd967190ce4d	b26e640d-87a1-49a8-a880-2a2088a4fca0	retrait	20388.00	432007.00	411619.00	FCFA	Paiement par carte	\N	2025-05-12 21:48:05	2025-10-23 12:36:59
c5daebef-c919-47a9-940d-fed2d777a3b7	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	virement	40590.00	114653.00	74063.00	FCFA	Virement vers compte	a5bad169-7741-4b82-9dde-4803bb629488	2025-07-15 21:22:23	2025-10-23 12:36:59
6918af92-51c8-4418-a132-58368834fbfe	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	retrait	18114.00	114653.00	96539.00	FCFA	Retrait guichet	\N	2025-06-25 16:36:44	2025-10-23 12:36:59
0dd5ac77-bcd8-45c9-b593-00a77801c370	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	virement	31889.00	114653.00	82764.00	FCFA	Transfert bancaire	8d706bac-d7d8-4172-8d94-d1a8cdf604db	2025-06-18 01:45:04	2025-10-23 12:36:59
6f2b8916-9535-4ea2-aef0-ef13d634199b	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	retrait	14870.00	114653.00	99783.00	FCFA	Retrait d'espèces	\N	2025-05-30 15:30:47	2025-10-23 12:36:59
2e2eebe0-0848-4ac8-bc39-e1042fe6411b	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	retrait	8049.00	114653.00	106604.00	FCFA	Retrait DAB	\N	2025-09-23 01:29:17	2025-10-23 12:36:59
8b2fc703-b1c6-402c-b57f-079eda84ceb8	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	virement	36825.00	114653.00	77828.00	FCFA	Paiement facture	f61a5805-715d-476c-89ef-33958e3cf001	2025-10-06 08:27:44	2025-10-23 12:36:59
5da236ad-650b-4798-9991-970b215cc0f4	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	virement	24908.00	114653.00	89745.00	FCFA	Virement vers compte	f2182e94-c5d0-4b91-8d12-af97e101dd6b	2025-07-09 02:17:30	2025-10-23 12:36:59
cb1fa024-69ca-4741-829d-de508f7bdc77	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	virement	34743.00	114653.00	79910.00	FCFA	Virement vers compte	9d8742db-9975-4f0a-aad4-23d2a22203cd	2025-05-12 05:49:41	2025-10-23 12:36:59
3d7c693a-cb9c-48f3-90e3-ab7a25cf433e	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	retrait	26411.00	114653.00	88242.00	FCFA	Retrait d'espèces	\N	2025-08-07 12:05:22	2025-10-23 12:36:59
c1c73bfb-a844-4fde-acbb-af92e1e7cd17	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	retrait	40500.00	114653.00	74153.00	FCFA	Retrait DAB	\N	2025-05-24 22:09:00	2025-10-23 12:36:59
a8f9c8fd-6b7d-4af3-af2c-d858aef7a8ac	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	retrait	30030.00	114653.00	84623.00	FCFA	Retrait guichet	\N	2025-06-14 05:33:34	2025-10-23 12:36:59
0fda6622-bec4-491e-adf4-d66a6ecf7224	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	retrait	24918.00	114653.00	89735.00	FCFA	Prélèvement automatique	\N	2025-06-22 21:27:34	2025-10-23 12:36:59
de8b8eb6-b66a-4bf1-990c-4a50592ff009	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	virement	14950.00	114653.00	99703.00	FCFA	Paiement facture	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	2025-10-06 21:43:57	2025-10-23 12:36:59
a8d76219-9c62-4e6e-b368-4eaa5a7e30f9	c2b93a8c-ea1e-4b85-8224-c209137135b0	virement	28307.00	143077.00	114770.00	FCFA	Virement vers compte	bc151b8f-a172-41b6-ab05-310ca341ebf3	2025-07-12 14:11:05	2025-10-23 12:36:59
b634365a-5044-4024-9d7c-79cc619d069a	c2b93a8c-ea1e-4b85-8224-c209137135b0	retrait	33231.00	143077.00	109846.00	FCFA	Retrait DAB	\N	2025-06-18 05:35:42	2025-10-23 12:36:59
a852b685-7342-4a75-9f8a-5a0bd6614482	c2b93a8c-ea1e-4b85-8224-c209137135b0	virement	6453.00	143077.00	136624.00	FCFA	Paiement facture	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	2025-06-22 12:29:16	2025-10-23 12:36:59
67ba53e6-3b4a-4f81-b772-68bbb46f430b	c2b93a8c-ea1e-4b85-8224-c209137135b0	virement	25571.00	143077.00	117506.00	FCFA	Transfert entre comptes	03991212-82d0-40f8-aade-bd7a07550872	2025-09-28 23:10:11	2025-10-23 12:36:59
9173d92d-f06c-4b93-ae64-dea495118f18	c2b93a8c-ea1e-4b85-8224-c209137135b0	virement	38119.00	143077.00	104958.00	FCFA	Virement salaire	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	2025-09-24 06:22:44	2025-10-23 12:36:59
a5ea2697-2475-4666-ad6a-409a51ca1068	c2b93a8c-ea1e-4b85-8224-c209137135b0	depot	4531.00	143077.00	147608.00	FCFA	Dépôt chèque	\N	2025-08-09 21:23:57	2025-10-23 12:36:59
1c87e8d0-1a59-46da-9c79-25cb2379dc83	c2b93a8c-ea1e-4b85-8224-c209137135b0	retrait	5273.00	143077.00	137804.00	FCFA	Retrait DAB	\N	2025-05-10 10:59:43	2025-10-23 12:36:59
6b86de2d-5c45-4485-a2d6-4df12309fdec	c2b93a8c-ea1e-4b85-8224-c209137135b0	virement	36584.00	143077.00	106493.00	FCFA	Virement vers compte	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	2025-10-23 07:32:52	2025-10-23 12:36:59
26237acc-79ab-4598-ab3b-8bf2a31811a3	c2b93a8c-ea1e-4b85-8224-c209137135b0	virement	44333.00	143077.00	98744.00	FCFA	Transfert bancaire	be33e282-23c2-42e0-8042-11f125606cb1	2025-05-28 17:47:00	2025-10-23 12:36:59
0e22944c-a858-4318-a762-d91971d1c43f	c2b93a8c-ea1e-4b85-8224-c209137135b0	depot	19042.00	143077.00	162119.00	FCFA	Versement salaire	\N	2025-06-06 07:59:55	2025-10-23 12:36:59
4fbf0411-5c92-4e77-a106-1607eb42f1da	c2b93a8c-ea1e-4b85-8224-c209137135b0	virement	26502.00	143077.00	116575.00	FCFA	Transfert entre comptes	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	2025-07-23 17:11:35	2025-10-23 12:36:59
b24924e2-9416-4746-99df-ae6b70c10936	a175ac58-1dc5-4041-b54b-19f48d3900a8	retrait	38701.00	125328.00	86627.00	FCFA	Prélèvement automatique	\N	2025-08-31 20:37:58	2025-10-23 12:36:59
b1fd872a-1db7-4882-9074-7db675e6862e	a175ac58-1dc5-4041-b54b-19f48d3900a8	depot	31847.00	125328.00	157175.00	FCFA	Versement salaire	\N	2025-04-29 08:49:26	2025-10-23 12:36:59
6e15881b-b92d-4474-8d12-9e681bc7d50a	a175ac58-1dc5-4041-b54b-19f48d3900a8	retrait	20160.00	125328.00	105168.00	FCFA	Paiement par carte	\N	2025-10-16 02:20:59	2025-10-23 12:36:59
fb3228c1-4c05-4f0a-b45c-eb3ff951c92b	a175ac58-1dc5-4041-b54b-19f48d3900a8	retrait	35037.00	125328.00	90291.00	FCFA	Retrait guichet	\N	2025-04-28 16:32:57	2025-10-23 12:36:59
dce0c366-f911-419c-8e95-50789378f0f8	a175ac58-1dc5-4041-b54b-19f48d3900a8	retrait	3905.00	125328.00	121423.00	FCFA	Retrait DAB	\N	2025-10-14 10:57:32	2025-10-23 12:36:59
b411e1dd-725a-4961-93c4-f4d61dfd6ed0	a175ac58-1dc5-4041-b54b-19f48d3900a8	retrait	29128.00	125328.00	96200.00	FCFA	Retrait DAB	\N	2025-08-01 04:32:32	2025-10-23 12:36:59
9601ca86-a158-423d-8262-19ae146ae285	a175ac58-1dc5-4041-b54b-19f48d3900a8	depot	17268.00	125328.00	142596.00	FCFA	Virement bancaire entrant	\N	2025-09-27 22:42:06	2025-10-23 12:36:59
006dadaa-e0d0-49f4-9c72-8cda2f5cec25	a175ac58-1dc5-4041-b54b-19f48d3900a8	depot	49861.00	125328.00	175189.00	FCFA	Versement salaire	\N	2025-07-27 11:17:09	2025-10-23 12:36:59
0a3c2644-6dee-4ca3-b515-53b12cc2afdb	a175ac58-1dc5-4041-b54b-19f48d3900a8	virement	28863.00	125328.00	96465.00	FCFA	Paiement facture	9cd12202-7a97-4ff8-907d-67b3f104c6b6	2025-08-13 19:07:15	2025-10-23 12:36:59
d9c3490f-07cf-4100-ab1f-0cad79299443	a175ac58-1dc5-4041-b54b-19f48d3900a8	retrait	42676.00	125328.00	82652.00	FCFA	Retrait DAB	\N	2025-06-13 03:53:25	2025-10-23 12:36:59
d34de4be-439f-4444-99a0-d235c9dccecd	a175ac58-1dc5-4041-b54b-19f48d3900a8	retrait	27780.00	125328.00	97548.00	FCFA	Retrait d'espèces	\N	2025-05-27 04:45:51	2025-10-23 12:36:59
2b1571d2-a72d-49ca-905d-7bdbe7b38e46	a175ac58-1dc5-4041-b54b-19f48d3900a8	depot	43894.00	125328.00	169222.00	FCFA	Versement salaire	\N	2025-07-08 05:58:15	2025-10-23 12:36:59
c01aa1e8-61b6-4b66-a7f1-59d1bf9a71ed	9b7cf121-0b29-4457-b5ee-acddd651474c	retrait	28036.00	475091.00	447055.00	FCFA	Prélèvement automatique	\N	2025-07-15 17:08:19	2025-10-23 12:36:59
df7db361-d43a-496e-99f5-d5c05d3305ce	9b7cf121-0b29-4457-b5ee-acddd651474c	retrait	41003.00	475091.00	434088.00	FCFA	Retrait guichet	\N	2025-10-04 13:37:15	2025-10-23 12:36:59
0c61fccd-c79c-43a0-832e-db41e4e779f1	9b7cf121-0b29-4457-b5ee-acddd651474c	depot	36638.00	475091.00	511729.00	FCFA	Versement salaire	\N	2025-04-24 20:04:33	2025-10-23 12:36:59
3fad5b46-db9b-4f38-8d8f-e0294199857f	9b7cf121-0b29-4457-b5ee-acddd651474c	virement	4244.00	475091.00	470847.00	FCFA	Virement salaire	fe405432-6112-461d-87cd-a720335c4092	2025-07-22 18:32:16	2025-10-23 12:36:59
1c195140-66a1-4a17-bc50-bd15751fbec2	9b7cf121-0b29-4457-b5ee-acddd651474c	depot	30599.00	475091.00	505690.00	FCFA	Versement salaire	\N	2025-05-26 01:56:58	2025-10-23 12:36:59
a4b0ede2-3d0f-4fa8-a767-30984a8a6836	9b7cf121-0b29-4457-b5ee-acddd651474c	retrait	7563.00	475091.00	467528.00	FCFA	Retrait guichet	\N	2025-05-20 11:33:18	2025-10-23 12:36:59
acaeb397-c741-4881-8df4-c6d47ecda372	9b7cf121-0b29-4457-b5ee-acddd651474c	virement	44085.00	475091.00	431006.00	FCFA	Transfert bancaire	7643d019-9210-424b-b768-667e79ca8da7	2025-08-21 01:21:24	2025-10-23 12:36:59
34887d00-bb80-4b35-bea2-9b17bb960f1d	9b7cf121-0b29-4457-b5ee-acddd651474c	depot	41714.00	475091.00	516805.00	FCFA	Versement salaire	\N	2025-08-26 16:50:31	2025-10-23 12:36:59
ec89e944-8f54-4401-8b1a-5fc3579770f1	9b7cf121-0b29-4457-b5ee-acddd651474c	retrait	42938.00	475091.00	432153.00	FCFA	Retrait d'espèces	\N	2025-05-11 09:58:59	2025-10-23 12:36:59
4145b34a-1f6f-4438-9426-6070c3850f63	9b7cf121-0b29-4457-b5ee-acddd651474c	retrait	14488.00	475091.00	460603.00	FCFA	Prélèvement automatique	\N	2025-09-07 19:14:33	2025-10-23 12:36:59
a2e92c23-a084-4540-8c7a-3019754a61a4	9b7cf121-0b29-4457-b5ee-acddd651474c	depot	27943.00	475091.00	503034.00	FCFA	Dépôt espèces guichet	\N	2025-09-30 13:45:12	2025-10-23 12:36:59
ff29d8d7-d94c-457a-b34c-166499868d65	9b7cf121-0b29-4457-b5ee-acddd651474c	retrait	13371.00	475091.00	461720.00	FCFA	Retrait DAB	\N	2025-04-26 07:12:37	2025-10-23 12:36:59
58b30fcc-f26d-4eee-afd0-b3f4f9092325	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	depot	25156.00	83570.00	108726.00	FCFA	Virement bancaire entrant	\N	2025-06-13 16:11:23	2025-10-23 12:36:59
1e005115-1a2d-49cc-b864-3e4eae20f816	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	retrait	35895.00	83570.00	47675.00	FCFA	Retrait d'espèces	\N	2025-07-25 01:19:10	2025-10-23 12:37:00
f78b82dd-e941-4b52-8db4-e53e89dc115c	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	virement	16697.00	83570.00	66873.00	FCFA	Virement vers compte	39ca01df-9037-4f1b-962a-164c3db984f0	2025-07-02 07:23:50	2025-10-23 12:37:00
75af7882-d7fd-4a3f-b596-ba5d184b5e4a	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	virement	46229.00	83570.00	37341.00	FCFA	Paiement facture	91ad4baf-0c30-4dc8-b74b-db1edc6bff66	2025-09-19 20:40:27	2025-10-23 12:37:00
f8fe0d3f-1ef1-4090-8dd1-eb0612ce7cd9	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	depot	4281.00	83570.00	87851.00	FCFA	Dépôt chèque	\N	2025-05-14 17:02:47	2025-10-23 12:37:00
529b864d-b86a-495c-8cd6-3db923bf2a7f	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	depot	16981.00	83570.00	100551.00	FCFA	Dépôt chèque	\N	2025-10-14 18:34:29	2025-10-23 12:37:00
5265fdff-7ffd-4cd6-bbb7-251b2603519e	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	depot	10040.00	83570.00	93610.00	FCFA	Dépôt d'espèces	\N	2025-08-01 11:20:48	2025-10-23 12:37:00
e6a3962e-acf5-4c06-99d7-541565dc8c8c	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	virement	12490.00	83570.00	71080.00	FCFA	Transfert entre comptes	b03a8338-5679-4ed1-9ba5-d4a4cf3ff31d	2025-07-09 04:40:49	2025-10-23 12:37:00
4a2bf721-718e-4d0d-abf1-7cc489016d3f	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	virement	17498.00	83570.00	66072.00	FCFA	Transfert entre comptes	c2b93a8c-ea1e-4b85-8224-c209137135b0	2025-08-20 01:29:15	2025-10-23 12:37:00
a6e7f27e-7407-4014-8800-9ed25050b83d	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	retrait	36053.00	83570.00	47517.00	FCFA	Prélèvement automatique	\N	2025-05-23 23:40:16	2025-10-23 12:37:00
95e35da1-ee4a-46c6-8b11-b6761dee2e49	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	depot	49330.00	83570.00	132900.00	FCFA	Dépôt espèces guichet	\N	2025-05-31 00:36:53	2025-10-23 12:37:00
4e2f87ee-9f7a-4e51-a8cc-c93d0f9d06c4	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	depot	36097.00	83570.00	119667.00	FCFA	Versement salaire	\N	2025-07-22 11:57:23	2025-10-23 12:37:00
396eb338-2800-4690-a21d-823f86602d2a	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	depot	31688.00	83570.00	115258.00	FCFA	Versement salaire	\N	2025-05-13 12:46:07	2025-10-23 12:37:00
aadc05a1-9057-46d8-b9aa-fb2fd540f55c	727ed0a8-67ac-4066-84fe-a29a0e13bb30	retrait	38959.00	70368.00	31409.00	FCFA	Retrait guichet	\N	2025-09-19 14:09:19	2025-10-23 12:37:00
261e797f-18d3-4c67-9354-97ce136c98c5	727ed0a8-67ac-4066-84fe-a29a0e13bb30	virement	45880.00	70368.00	24488.00	FCFA	Paiement facture	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	2025-05-11 00:51:59	2025-10-23 12:37:00
6d79a1fd-0ae8-4d15-be31-2acb5d8339c0	727ed0a8-67ac-4066-84fe-a29a0e13bb30	depot	24225.00	70368.00	94593.00	FCFA	Dépôt chèque	\N	2025-07-08 12:03:03	2025-10-23 12:37:00
a767ddd2-86b2-43c2-ae73-6c7ccd4d79ce	727ed0a8-67ac-4066-84fe-a29a0e13bb30	retrait	32157.00	70368.00	38211.00	FCFA	Prélèvement automatique	\N	2025-05-14 02:24:48	2025-10-23 12:37:00
a36e035f-2bd1-4edc-9538-8ffc3d77d212	727ed0a8-67ac-4066-84fe-a29a0e13bb30	retrait	6822.00	70368.00	63546.00	FCFA	Retrait DAB	\N	2025-06-25 09:34:03	2025-10-23 12:37:00
014ea1f1-13bc-49e0-aca3-80cc763a41f7	727ed0a8-67ac-4066-84fe-a29a0e13bb30	depot	38700.00	70368.00	109068.00	FCFA	Virement bancaire entrant	\N	2025-08-05 14:39:04	2025-10-23 12:37:00
4213d717-61c6-4c06-a149-a9c3c3b83f0a	727ed0a8-67ac-4066-84fe-a29a0e13bb30	virement	40979.00	70368.00	29389.00	FCFA	Transfert entre comptes	76b21c81-8380-4df8-87ad-4f2fa9ff5159	2025-08-30 00:38:56	2025-10-23 12:37:00
60b62f18-20b4-48be-a733-8a570ddb2e0c	727ed0a8-67ac-4066-84fe-a29a0e13bb30	virement	24031.00	70368.00	46337.00	FCFA	Transfert entre comptes	9cd12202-7a97-4ff8-907d-67b3f104c6b6	2025-05-24 02:43:40	2025-10-23 12:37:00
77ddb221-de0b-4e77-99e7-3acbe5e2da03	727ed0a8-67ac-4066-84fe-a29a0e13bb30	retrait	19790.00	70368.00	50578.00	FCFA	Retrait d'espèces	\N	2025-06-02 06:22:37	2025-10-23 12:37:00
4b41bea0-6c60-4634-a13c-3eb768f0dba3	727ed0a8-67ac-4066-84fe-a29a0e13bb30	retrait	36887.00	70368.00	33481.00	FCFA	Retrait d'espèces	\N	2025-07-09 05:19:10	2025-10-23 12:37:00
f4317622-6dca-4560-892b-a7ce23b7fd1c	727ed0a8-67ac-4066-84fe-a29a0e13bb30	depot	13997.00	70368.00	84365.00	FCFA	Dépôt d'espèces	\N	2025-10-15 02:55:14	2025-10-23 12:37:00
cfd8401f-fb1e-4953-9366-f866c55e4945	727ed0a8-67ac-4066-84fe-a29a0e13bb30	retrait	23299.00	70368.00	47069.00	FCFA	Retrait DAB	\N	2025-05-19 10:58:52	2025-10-23 12:37:00
cfed7cc2-5f20-4411-9703-37489fb541b4	727ed0a8-67ac-4066-84fe-a29a0e13bb30	retrait	39800.00	70368.00	30568.00	FCFA	Retrait guichet	\N	2025-07-10 10:27:46	2025-10-23 12:37:00
9d8e91e6-61a5-4e83-8c33-7cd5b38e4205	727ed0a8-67ac-4066-84fe-a29a0e13bb30	virement	7886.00	70368.00	62482.00	FCFA	Transfert bancaire	5cd10916-6dee-48e6-ab78-7995b1f1ce95	2025-10-02 10:25:59	2025-10-23 12:37:00
0356de13-ac73-49fc-a3ec-c0a8210f7ae3	727ed0a8-67ac-4066-84fe-a29a0e13bb30	retrait	10202.00	70368.00	60166.00	FCFA	Retrait d'espèces	\N	2025-05-16 21:16:55	2025-10-23 12:37:00
9d88e014-1a03-4687-8597-fb105e9150d3	b3c57074-cab3-490f-9d70-3da5066332f6	retrait	43570.00	325326.00	281756.00	FCFA	Retrait guichet	\N	2025-07-01 18:57:46	2025-10-23 12:37:00
6ad7007a-0a62-4b95-917a-a69016a621df	b3c57074-cab3-490f-9d70-3da5066332f6	depot	1758.00	325326.00	327084.00	FCFA	Virement bancaire entrant	\N	2025-05-22 14:57:11	2025-10-23 12:37:00
2f93e51f-2407-4e2c-b72d-d179cdb945d2	b3c57074-cab3-490f-9d70-3da5066332f6	retrait	15532.00	325326.00	309794.00	FCFA	Retrait guichet	\N	2025-08-17 22:42:15	2025-10-23 12:37:00
4691e359-dc16-4bbd-8f80-4dc0148693fe	b3c57074-cab3-490f-9d70-3da5066332f6	retrait	18911.00	325326.00	306415.00	FCFA	Retrait guichet	\N	2025-05-29 02:51:44	2025-10-23 12:37:00
736e7db0-2e47-4dca-9c74-dfb4fbab5389	b3c57074-cab3-490f-9d70-3da5066332f6	virement	38877.00	325326.00	286449.00	FCFA	Transfert bancaire	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	2025-09-21 21:54:55	2025-10-23 12:37:00
8be75220-3c99-41d0-8a1e-2f20a5b7aad2	b3c57074-cab3-490f-9d70-3da5066332f6	depot	16053.00	325326.00	341379.00	FCFA	Dépôt espèces guichet	\N	2025-10-11 12:16:33	2025-10-23 12:37:00
a7816395-fafd-4c57-a98c-1d3a7d7501b3	b3c57074-cab3-490f-9d70-3da5066332f6	retrait	22802.00	325326.00	302524.00	FCFA	Prélèvement automatique	\N	2025-10-03 13:31:32	2025-10-23 12:37:00
0f04f73f-597e-43a5-a0e0-6ab6ef481cb2	b3c57074-cab3-490f-9d70-3da5066332f6	virement	6127.00	325326.00	319199.00	FCFA	Virement vers compte	82b41651-c63d-4deb-85c6-3c688eddc121	2025-10-02 17:36:52	2025-10-23 12:37:00
4c99791c-2304-4ad4-8d08-57f3172ace50	b3c57074-cab3-490f-9d70-3da5066332f6	depot	14320.00	325326.00	339646.00	FCFA	Virement bancaire entrant	\N	2025-07-25 09:11:17	2025-10-23 12:37:00
3cc2fbfa-1bdd-4e67-ae5a-e59ebcd69add	b3c57074-cab3-490f-9d70-3da5066332f6	virement	41089.00	325326.00	284237.00	FCFA	Transfert bancaire	d3ba6f50-5b24-4a03-9002-ded93f5697a3	2025-08-22 06:53:51	2025-10-23 12:37:00
d5d54615-a765-4f6d-ac01-d62c6abe0213	b3c57074-cab3-490f-9d70-3da5066332f6	depot	43181.00	325326.00	368507.00	FCFA	Virement bancaire entrant	\N	2025-07-16 11:50:15	2025-10-23 12:37:00
59987870-fe8b-4962-b865-2c8c7e45c7a6	b3c57074-cab3-490f-9d70-3da5066332f6	depot	28347.00	325326.00	353673.00	FCFA	Versement salaire	\N	2025-06-06 04:19:55	2025-10-23 12:37:00
0b128ae8-51c6-4a64-bad7-20f7a54e625c	b3c57074-cab3-490f-9d70-3da5066332f6	retrait	37343.00	325326.00	287983.00	FCFA	Retrait d'espèces	\N	2025-07-25 04:56:59	2025-10-23 12:37:00
39c6a4a3-5d20-494c-b008-5e7541017d92	b3c57074-cab3-490f-9d70-3da5066332f6	depot	28120.00	325326.00	353446.00	FCFA	Dépôt d'espèces	\N	2025-06-17 07:51:57	2025-10-23 12:37:00
163f34d8-07d0-4ebe-98bd-128ab1b0f014	b3c57074-cab3-490f-9d70-3da5066332f6	virement	47968.00	325326.00	277358.00	FCFA	Paiement facture	2afce742-17e9-45bc-99be-9389a26da3ca	2025-08-28 18:29:46	2025-10-23 12:37:00
6aff6fc1-f17c-4322-908a-8c5e7347a332	5cd10916-6dee-48e6-ab78-7995b1f1ce95	retrait	28292.00	100000.00	71708.00	FCFA	Retrait d'espèces	\N	2025-06-25 11:11:34	2025-10-23 12:37:00
ff1fa493-f8e6-48ae-ae65-cfbb2c905e17	5cd10916-6dee-48e6-ab78-7995b1f1ce95	depot	29018.00	100000.00	129018.00	FCFA	Dépôt espèces guichet	\N	2025-08-19 09:05:48	2025-10-23 12:37:00
351a3959-a4ba-4e5e-970b-eddc6fa4d00f	5cd10916-6dee-48e6-ab78-7995b1f1ce95	virement	15477.00	100000.00	84523.00	FCFA	Paiement facture	b26e640d-87a1-49a8-a880-2a2088a4fca0	2025-09-01 19:38:51	2025-10-23 12:37:00
3314f56e-c077-4645-af23-a8124014d618	5cd10916-6dee-48e6-ab78-7995b1f1ce95	depot	23759.00	100000.00	123759.00	FCFA	Dépôt chèque	\N	2025-10-21 13:54:54	2025-10-23 12:37:00
36647803-192f-4c23-9cf0-65ae7919a770	5cd10916-6dee-48e6-ab78-7995b1f1ce95	virement	40451.00	100000.00	59549.00	FCFA	Virement salaire	0b052b84-a33e-44e8-90f7-d9d1bfe27464	2025-05-18 02:10:28	2025-10-23 12:37:00
9bcbcdd6-958f-4ee9-b694-79c94dfcd3a3	5cd10916-6dee-48e6-ab78-7995b1f1ce95	virement	45019.00	100000.00	54981.00	FCFA	Transfert entre comptes	4e96181f-e984-42f8-9787-a41a67c90aba	2025-08-12 16:52:12	2025-10-23 12:37:00
e417af51-5e3d-43ad-8073-bca7c86c607e	2b138895-6391-4bfe-b137-ca4fa7854a4a	retrait	32723.00	10000.00	0.00	FCFA	Retrait d'espèces	\N	2025-09-05 16:14:27	2025-10-23 12:37:00
baf97c7f-3bf4-4b36-9929-0786c4c7c61e	2b138895-6391-4bfe-b137-ca4fa7854a4a	retrait	8709.00	10000.00	1291.00	FCFA	Retrait d'espèces	\N	2025-06-01 19:44:17	2025-10-23 12:37:00
4997332f-ce64-4821-8593-80f58d1b626c	2b138895-6391-4bfe-b137-ca4fa7854a4a	retrait	49331.00	10000.00	0.00	FCFA	Paiement par carte	\N	2025-07-11 08:14:37	2025-10-23 12:37:00
3850b61b-b332-4ffb-99a2-a09239c4c515	2b138895-6391-4bfe-b137-ca4fa7854a4a	retrait	17549.00	10000.00	0.00	FCFA	Retrait d'espèces	\N	2025-09-01 17:23:28	2025-10-23 12:37:00
fdff4049-58b7-4cdb-bca2-d3deb2e5b010	2b138895-6391-4bfe-b137-ca4fa7854a4a	depot	16220.00	10000.00	26220.00	FCFA	Virement bancaire entrant	\N	2025-08-06 02:20:58	2025-10-23 12:37:00
4a339827-e276-4117-ac3b-a71605e2de2d	2b138895-6391-4bfe-b137-ca4fa7854a4a	virement	2136.00	10000.00	7864.00	FCFA	Virement vers compte	4bb7fc9b-13d6-4883-b751-283b753d05ed	2025-08-18 12:24:23	2025-10-23 12:37:00
7219f3cc-7ebc-41df-8f0e-73788028874d	2b138895-6391-4bfe-b137-ca4fa7854a4a	retrait	30242.00	10000.00	0.00	FCFA	Retrait guichet	\N	2025-08-03 05:11:28	2025-10-23 12:37:00
2bdf1f18-4658-48a5-87a3-fea06145763f	2b138895-6391-4bfe-b137-ca4fa7854a4a	virement	25313.00	10000.00	0.00	FCFA	Virement salaire	03991212-82d0-40f8-aade-bd7a07550872	2025-08-19 17:55:25	2025-10-23 12:37:00
0e24a05c-2d5e-46d2-a17a-2ecff0c31ebe	3014d690-a71d-4cb9-ba59-a6c4fea73558	retrait	9846.00	25000.00	15154.00	FCFA	Retrait d'espèces	\N	2025-09-18 08:21:03	2025-10-23 12:37:00
53afffcf-4363-4023-96bb-d63d0a5f3f3f	3014d690-a71d-4cb9-ba59-a6c4fea73558	retrait	45020.00	25000.00	0.00	FCFA	Retrait d'espèces	\N	2025-04-24 22:47:01	2025-10-23 12:37:00
df4c2367-d558-4371-b87a-0928b0b6eb54	3014d690-a71d-4cb9-ba59-a6c4fea73558	virement	9554.00	25000.00	15446.00	FCFA	Transfert bancaire	d0f4f273-6422-4408-950f-61e6f8d23373	2025-09-15 18:12:18	2025-10-23 12:37:00
6af68313-caca-4b2b-86f5-becc4a4cacf4	3014d690-a71d-4cb9-ba59-a6c4fea73558	virement	10710.00	25000.00	14290.00	FCFA	Virement vers compte	e88eac49-5c57-48f8-824a-813a7da0fdc3	2025-09-26 15:48:10	2025-10-23 12:37:00
5c8e67e9-2511-42aa-a239-13f64e3c516b	3014d690-a71d-4cb9-ba59-a6c4fea73558	virement	18349.00	25000.00	6651.00	FCFA	Transfert bancaire	aefad6a9-6ff4-4250-b79c-50f551aaa60e	2025-06-19 13:58:50	2025-10-23 12:37:00
bfa0f0c0-1be6-41a1-944c-adaa9c42986a	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	virement	12724.00	84833.00	72109.00	FCFA	Virement vers compte	093dd33b-052d-4191-9176-9120502bd3b0	2025-06-17 15:11:09	2025-10-23 12:37:00
e8701d08-2a17-4901-a760-de5c57b47e91	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	depot	49909.00	84833.00	134742.00	FCFA	Dépôt d'espèces	\N	2025-09-05 19:25:13	2025-10-23 12:37:00
2ffca39a-7f71-4b61-90a5-fdac6541acae	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	retrait	22579.00	84833.00	62254.00	FCFA	Prélèvement automatique	\N	2025-07-05 13:18:07	2025-10-23 12:37:00
dee9795b-6e95-497c-a170-9a667b950c8b	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	retrait	27670.00	84833.00	57163.00	FCFA	Prélèvement automatique	\N	2025-05-21 10:26:49	2025-10-23 12:37:00
64e86b8d-58b0-40f0-bb31-94118051765d	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	virement	7332.00	84833.00	77501.00	FCFA	Transfert bancaire	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	2025-07-12 06:26:01	2025-10-23 12:37:00
81e8b035-81a7-4a96-8fd3-ff68ee06248c	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	virement	14848.00	84833.00	69985.00	FCFA	Virement salaire	801e068b-fdc3-4606-bc83-42d2e3fc4a67	2025-08-12 09:42:29	2025-10-23 12:37:00
d6d3df57-7f2b-4511-845a-a311ca71f4e4	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	virement	6023.00	84833.00	78810.00	FCFA	Virement salaire	df088290-3d37-4591-8571-389b37349b2a	2025-05-14 20:07:28	2025-10-23 12:37:00
8dc1ae7a-7b80-4867-a987-410937f04027	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	depot	17191.00	84833.00	102024.00	FCFA	Virement bancaire entrant	\N	2025-09-18 05:42:49	2025-10-23 12:37:00
4a060c59-9c09-41ac-a3a8-9ae1bba04f1e	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	virement	19049.00	84833.00	65784.00	FCFA	Virement vers compte	808e915e-a5d8-4751-aaa8-50fe040cde68	2025-10-09 20:53:03	2025-10-23 12:37:00
8bc94920-5e92-4cff-a762-769f3facb850	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	retrait	17776.00	84833.00	67057.00	FCFA	Retrait d'espèces	\N	2025-10-04 19:41:23	2025-10-23 12:37:00
096aaddd-092d-4370-939b-7b76f8d16723	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	depot	1200.00	84833.00	86033.00	FCFA	Dépôt d'espèces	\N	2025-10-16 05:32:37	2025-10-23 12:37:00
03063bbd-0974-4891-8d1d-f7c14155cc57	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	retrait	27295.00	84833.00	57538.00	FCFA	Paiement par carte	\N	2025-07-08 15:32:09	2025-10-23 12:37:00
c424fbee-692c-4c66-8319-05af4ffa79af	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	retrait	11394.00	84833.00	73439.00	FCFA	Retrait d'espèces	\N	2025-08-13 00:14:47	2025-10-23 12:37:00
4a95b585-72c6-4745-bdb5-d19d54f2ce45	914d5be6-2dc2-4063-8219-1ea664a8b058	retrait	39535.00	458476.00	418941.00	FCFA	Retrait guichet	\N	2025-05-21 08:45:17	2025-10-23 12:37:00
06926a9a-ffbb-4db3-9575-a0a4cb543122	914d5be6-2dc2-4063-8219-1ea664a8b058	depot	38188.00	458476.00	496664.00	FCFA	Dépôt espèces guichet	\N	2025-07-02 15:44:48	2025-10-23 12:37:00
52c0eba7-dbfb-47c5-8be1-2ca2dacfcdf0	914d5be6-2dc2-4063-8219-1ea664a8b058	depot	26812.00	458476.00	485288.00	FCFA	Dépôt chèque	\N	2025-05-18 15:47:05	2025-10-23 12:37:00
ad483c12-38b7-45c3-8742-a474cb257f5a	914d5be6-2dc2-4063-8219-1ea664a8b058	depot	44218.00	458476.00	502694.00	FCFA	Dépôt chèque	\N	2025-07-11 15:25:06	2025-10-23 12:37:00
5ac8e431-9c87-4334-9ee4-354e34b1d9fa	914d5be6-2dc2-4063-8219-1ea664a8b058	depot	49493.00	458476.00	507969.00	FCFA	Versement salaire	\N	2025-05-09 10:52:47	2025-10-23 12:37:00
c2f35062-c560-4091-ab02-674697e786cc	914d5be6-2dc2-4063-8219-1ea664a8b058	depot	3889.00	458476.00	462365.00	FCFA	Dépôt chèque	\N	2025-07-03 07:51:47	2025-10-23 12:37:00
99543ccc-ca18-41ce-a481-c76567fcc1e3	914d5be6-2dc2-4063-8219-1ea664a8b058	virement	19674.00	458476.00	438802.00	FCFA	Paiement facture	3406986a-f161-4a7a-80be-bcdf0e3f2214	2025-08-27 19:26:51	2025-10-23 12:37:00
281f37f4-5d1e-4ea2-ad58-8663bc3de764	914d5be6-2dc2-4063-8219-1ea664a8b058	virement	49939.00	458476.00	408537.00	FCFA	Virement vers compte	a03dce74-58f6-42c7-8624-1d21ea760a90	2025-05-13 15:54:29	2025-10-23 12:37:00
050f78fc-05ff-4b55-8ee6-89328c3cf7a5	914d5be6-2dc2-4063-8219-1ea664a8b058	depot	40262.00	458476.00	498738.00	FCFA	Virement bancaire entrant	\N	2025-10-21 18:13:40	2025-10-23 12:37:00
1ff8391e-5a3a-4380-b84a-ee24c379a4ca	914d5be6-2dc2-4063-8219-1ea664a8b058	retrait	18352.00	458476.00	440124.00	FCFA	Retrait DAB	\N	2025-05-24 05:59:50	2025-10-23 12:37:00
27fb9acb-6161-484c-bf60-e3e33c00da90	914d5be6-2dc2-4063-8219-1ea664a8b058	depot	5752.00	458476.00	464228.00	FCFA	Dépôt chèque	\N	2025-09-07 17:30:33	2025-10-23 12:37:00
8d0f72ad-3ea7-4e5a-987e-c75aeba91aa6	914d5be6-2dc2-4063-8219-1ea664a8b058	virement	13243.00	458476.00	445233.00	FCFA	Transfert bancaire	37da1638-f10a-4a03-9eb4-9eb960273866	2025-06-15 18:24:21	2025-10-23 12:37:00
ffaef1b8-cc8a-41ac-8203-14cf35ac4aa1	914d5be6-2dc2-4063-8219-1ea664a8b058	virement	9430.00	458476.00	449046.00	FCFA	Virement vers compte	8cc906e8-f49e-48bf-97f7-063a96dd5855	2025-08-15 04:21:14	2025-10-23 12:37:00
5aaa3b5b-8645-42d0-b728-80b357a1d488	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	virement	20265.00	296843.00	276578.00	FCFA	Paiement facture	d725e859-df50-4ee3-8ab9-65d82dc7fd71	2025-06-09 10:01:19	2025-10-23 12:37:00
212afcd7-87a6-4adb-a9fc-28758afd0667	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	virement	15353.00	296843.00	281490.00	FCFA	Virement vers compte	b30db983-96ad-4f5c-a50c-1637c25f3b46	2025-05-07 14:29:59	2025-10-23 12:37:00
c9eb5139-7116-488a-bd44-f0f8f7c5b3c6	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	retrait	39031.00	296843.00	257812.00	FCFA	Prélèvement automatique	\N	2025-07-31 11:17:39	2025-10-23 12:37:00
d36ed040-7847-4a60-a6b7-ccafe33aaa5d	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	virement	49182.00	296843.00	247661.00	FCFA	Virement salaire	968e30c7-1be0-4c05-98ba-5cb8d986a863	2025-05-26 02:26:23	2025-10-23 12:37:00
7fa369d7-7192-48ce-8b32-86b6540dcee6	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	virement	3655.00	296843.00	293188.00	FCFA	Paiement facture	cccd197c-f331-4647-8abe-dacb9cf26b5d	2025-07-28 12:33:02	2025-10-23 12:37:00
203f159a-90cb-4528-84f0-d54b8f379ded	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	virement	6467.00	296843.00	290376.00	FCFA	Virement salaire	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	2025-05-28 12:01:55	2025-10-23 12:37:00
8e406b46-c497-435f-a5ec-942764631fad	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	depot	46395.00	296843.00	343238.00	FCFA	Dépôt d'espèces	\N	2025-10-08 00:53:14	2025-10-23 12:37:00
52eef8a8-83e9-4f1b-926e-5afb2f9bf2c8	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	retrait	7268.00	296843.00	289575.00	FCFA	Retrait guichet	\N	2025-09-11 23:47:17	2025-10-23 12:37:00
a991acb0-84d6-447f-a923-6ed03b09b1b9	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	retrait	42769.00	296843.00	254074.00	FCFA	Retrait d'espèces	\N	2025-08-25 22:07:32	2025-10-23 12:37:00
4e644d96-9652-4726-b080-eca29f66f816	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	retrait	21659.00	296843.00	275184.00	FCFA	Prélèvement automatique	\N	2025-04-29 00:45:34	2025-10-23 12:37:00
fb2399e0-90d7-493f-b242-1055848be602	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	depot	28464.00	296843.00	325307.00	FCFA	Virement bancaire entrant	\N	2025-08-24 04:57:51	2025-10-23 12:37:00
447c1e92-b4ab-412b-bb3a-88a633767308	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	depot	11014.00	296843.00	307857.00	FCFA	Virement bancaire entrant	\N	2025-09-13 20:41:58	2025-10-23 12:37:00
3483cd6b-3aa5-47f0-b7d4-2cfd63ef73d4	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	retrait	47785.00	296843.00	249058.00	FCFA	Retrait DAB	\N	2025-06-30 04:17:30	2025-10-23 12:37:00
6713fef4-1b10-4c9b-90fb-6ce1c7c76a97	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	virement	11661.00	296843.00	285182.00	FCFA	Virement salaire	f3db8624-1334-47ff-83bb-04592844270f	2025-09-23 14:04:59	2025-10-23 12:37:00
9f2ac6fa-ce87-4232-b27b-3ffcd6f5749c	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	retrait	9687.00	411815.00	402128.00	FCFA	Retrait d'espèces	\N	2025-06-26 13:52:29	2025-10-23 12:37:00
f0bcca02-9505-48b1-ad3d-b8e3f0f298ec	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	depot	3218.00	411815.00	415033.00	FCFA	Versement salaire	\N	2025-07-13 08:24:12	2025-10-23 12:37:00
7027bf42-334c-438e-83b8-d3a443fb416c	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	depot	40278.00	411815.00	452093.00	FCFA	Dépôt espèces guichet	\N	2025-04-26 10:43:23	2025-10-23 12:37:00
0cf8f009-7bb0-4eda-8e58-d696456b891d	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	retrait	18059.00	411815.00	393756.00	FCFA	Paiement par carte	\N	2025-06-28 05:15:32	2025-10-23 12:37:00
0c4d9019-d46f-49c5-85da-02b6686a6065	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	virement	9025.00	411815.00	402790.00	FCFA	Transfert bancaire	db289a68-fb56-4357-aa96-60bcaab5608f	2025-06-14 20:01:18	2025-10-23 12:37:00
8588ef8e-e13a-4a16-8fb2-bfd1d8d7b93e	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	depot	46676.00	411815.00	458491.00	FCFA	Dépôt d'espèces	\N	2025-04-24 13:49:32	2025-10-23 12:37:00
bb1b9923-c410-41e5-b551-d0b7570574be	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	retrait	30071.00	411815.00	381744.00	FCFA	Retrait d'espèces	\N	2025-10-22 02:29:33	2025-10-23 12:37:00
dbe9606a-c420-43bc-a85a-56590cd03e7c	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	retrait	5393.00	411815.00	406422.00	FCFA	Prélèvement automatique	\N	2025-07-31 19:14:02	2025-10-23 12:37:00
322ad677-f462-4570-aab0-721fb6f7f5bf	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	depot	21083.00	411815.00	432898.00	FCFA	Versement salaire	\N	2025-09-20 15:39:57	2025-10-23 12:37:00
b1486bec-832d-4cdb-8294-aae1c9569991	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	depot	38461.00	411815.00	450276.00	FCFA	Dépôt d'espèces	\N	2025-09-11 19:43:33	2025-10-23 12:37:00
60096e62-9f91-4b67-ae17-7d76f64939ea	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	retrait	6202.00	411815.00	405613.00	FCFA	Retrait d'espèces	\N	2025-05-09 11:38:59	2025-10-23 12:37:00
a1777518-cece-470e-89a1-ece3420a181f	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	virement	28374.00	411815.00	383441.00	FCFA	Transfert entre comptes	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	2025-07-08 22:14:18	2025-10-23 12:37:00
aef58594-52fa-459e-b004-3d12273545cc	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	retrait	45097.00	411815.00	366718.00	FCFA	Prélèvement automatique	\N	2025-10-02 23:29:56	2025-10-23 12:37:00
656831fc-c7c7-45b3-ba67-9787fef96056	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	virement	9119.00	411815.00	402696.00	FCFA	Transfert entre comptes	4e0954f5-1956-40db-b392-7a6ee455c257	2025-07-09 21:10:50	2025-10-23 12:37:00
ec3f58bf-47f1-4b3b-a202-1f3749192a48	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	retrait	20431.00	411815.00	391384.00	FCFA	Retrait DAB	\N	2025-08-09 08:17:51	2025-10-23 12:37:00
622de683-c275-4368-b523-74526ba53021	da2856ae-33c2-4d43-959c-2eb0fa7dcffd	depot	38304.00	144774.00	183078.00	FCFA	Virement bancaire entrant	\N	2025-09-09 22:54:26	2025-10-23 12:37:00
b7c8031f-6eba-4a59-b5aa-26e1625315c6	da2856ae-33c2-4d43-959c-2eb0fa7dcffd	depot	9598.00	144774.00	154372.00	FCFA	Dépôt chèque	\N	2025-07-16 09:50:16	2025-10-23 12:37:00
e4f0abd1-92f0-4f5e-92ff-dbd4ba67138b	da2856ae-33c2-4d43-959c-2eb0fa7dcffd	virement	3981.00	144774.00	140793.00	FCFA	Transfert entre comptes	232f5785-5fd1-4398-91e2-4f92589e1d8d	2025-05-14 14:53:21	2025-10-23 12:37:00
23179140-a3bf-4af8-9d1f-6be33516f016	da2856ae-33c2-4d43-959c-2eb0fa7dcffd	depot	47907.00	144774.00	192681.00	FCFA	Dépôt chèque	\N	2025-09-16 02:18:57	2025-10-23 12:37:00
c2220a7d-94dc-408b-b179-0a134c508c32	da2856ae-33c2-4d43-959c-2eb0fa7dcffd	virement	37196.00	144774.00	107578.00	FCFA	Virement vers compte	4e96181f-e984-42f8-9787-a41a67c90aba	2025-07-27 22:22:21	2025-10-23 12:37:00
99008d81-087c-43dd-a568-4d82385a05d3	da2856ae-33c2-4d43-959c-2eb0fa7dcffd	virement	13794.00	144774.00	130980.00	FCFA	Transfert bancaire	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	2025-07-29 01:31:23	2025-10-23 12:37:00
320d1d78-9fb7-421b-8ebe-f536b0ba4cd0	da2856ae-33c2-4d43-959c-2eb0fa7dcffd	virement	49229.00	144774.00	95545.00	FCFA	Paiement facture	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	2025-07-24 14:54:08	2025-10-23 12:37:00
691c4180-9f50-450c-81dc-94b51eb236ca	da2856ae-33c2-4d43-959c-2eb0fa7dcffd	virement	44989.00	144774.00	99785.00	FCFA	Transfert entre comptes	4e0954f5-1956-40db-b392-7a6ee455c257	2025-09-09 10:51:11	2025-10-23 12:37:00
f9b734b5-9604-493d-9b5f-0ea447f7d96d	da2856ae-33c2-4d43-959c-2eb0fa7dcffd	retrait	37328.00	144774.00	107446.00	FCFA	Prélèvement automatique	\N	2025-09-29 08:13:44	2025-10-23 12:37:00
8b4ba87e-718c-43b9-bf85-cfa1a39ff1c9	da2856ae-33c2-4d43-959c-2eb0fa7dcffd	retrait	3354.00	144774.00	141420.00	FCFA	Prélèvement automatique	\N	2025-05-23 03:16:16	2025-10-23 12:37:00
174c424f-7bda-447a-8509-e4a82d9ef460	31fb6207-f59e-425f-bf86-a1085c47b43f	depot	39540.00	419130.00	458670.00	FCFA	Versement salaire	\N	2025-08-14 03:35:25	2025-10-23 12:37:00
90eb5ec3-e3b5-4b2e-ae49-e962f916cac7	31fb6207-f59e-425f-bf86-a1085c47b43f	depot	7515.00	419130.00	426645.00	FCFA	Dépôt chèque	\N	2025-10-11 12:05:49	2025-10-23 12:37:00
f9129518-5132-4129-a75f-07b077a9ec11	31fb6207-f59e-425f-bf86-a1085c47b43f	retrait	35740.00	419130.00	383390.00	FCFA	Paiement par carte	\N	2025-07-22 16:13:17	2025-10-23 12:37:00
9070083f-fccc-4f31-ad9c-bd795a4667aa	31fb6207-f59e-425f-bf86-a1085c47b43f	virement	44359.00	419130.00	374771.00	FCFA	Paiement facture	093dd33b-052d-4191-9176-9120502bd3b0	2025-08-28 20:47:05	2025-10-23 12:37:00
5ede8e5e-c5bf-4045-9bc1-752cee4f2e78	31fb6207-f59e-425f-bf86-a1085c47b43f	virement	36097.00	419130.00	383033.00	FCFA	Transfert bancaire	f3db8624-1334-47ff-83bb-04592844270f	2025-07-15 22:38:48	2025-10-23 12:37:00
cabaab5a-c9c2-4daf-a39d-98f8f300f49c	31fb6207-f59e-425f-bf86-a1085c47b43f	depot	6268.00	419130.00	425398.00	FCFA	Versement salaire	\N	2025-09-25 21:52:35	2025-10-23 12:37:00
5a2de935-d78d-4f6c-abf2-ae4fadb41752	31fb6207-f59e-425f-bf86-a1085c47b43f	depot	7838.00	419130.00	426968.00	FCFA	Dépôt espèces guichet	\N	2025-09-19 05:11:12	2025-10-23 12:37:00
1a71bab0-4787-4796-85f1-655851153866	31fb6207-f59e-425f-bf86-a1085c47b43f	retrait	33831.00	419130.00	385299.00	FCFA	Prélèvement automatique	\N	2025-07-21 07:46:09	2025-10-23 12:37:00
3346e654-aa5f-4395-9f3b-1f32861b3592	31fb6207-f59e-425f-bf86-a1085c47b43f	depot	11865.00	419130.00	430995.00	FCFA	Dépôt espèces guichet	\N	2025-06-30 19:21:36	2025-10-23 12:37:00
e05a867e-9117-40ea-a00d-d5a0a5e917c6	31fb6207-f59e-425f-bf86-a1085c47b43f	virement	44175.00	419130.00	374955.00	FCFA	Transfert entre comptes	bf69dba7-7153-4b9d-885b-f7fa7330e249	2025-06-18 03:49:28	2025-10-23 12:37:00
1b7f233a-69c1-4683-9362-08280dd7a878	818e8545-fc56-4437-b399-56970df2cc32	virement	14514.00	331404.00	316890.00	FCFA	Virement salaire	a90e1a63-43fd-4956-af04-b3458780ca97	2025-07-29 09:50:39	2025-10-23 12:37:00
52c20c2d-e735-4e70-b50d-4d8072479578	818e8545-fc56-4437-b399-56970df2cc32	retrait	20900.00	331404.00	310504.00	FCFA	Paiement par carte	\N	2025-09-16 08:04:21	2025-10-23 12:37:00
da1eeb7e-5f72-498c-b3d4-9a6d2b85b3aa	818e8545-fc56-4437-b399-56970df2cc32	depot	9056.00	331404.00	340460.00	FCFA	Virement bancaire entrant	\N	2025-10-03 02:58:06	2025-10-23 12:37:00
f173d872-5e99-4b88-8bdf-0e1588b02691	818e8545-fc56-4437-b399-56970df2cc32	depot	18745.00	331404.00	350149.00	FCFA	Dépôt chèque	\N	2025-06-13 16:23:09	2025-10-23 12:37:00
876e3fa7-5da8-4662-a84e-a4d122e52993	818e8545-fc56-4437-b399-56970df2cc32	depot	10722.00	331404.00	342126.00	FCFA	Versement salaire	\N	2025-07-13 05:38:12	2025-10-23 12:37:00
9b0b5dc6-b7b8-417a-90e5-d6785099b29f	818e8545-fc56-4437-b399-56970df2cc32	depot	28253.00	331404.00	359657.00	FCFA	Dépôt chèque	\N	2025-10-15 01:53:14	2025-10-23 12:37:00
25a61691-fce6-41fd-8808-4b1b3042633c	818e8545-fc56-4437-b399-56970df2cc32	virement	37766.00	331404.00	293638.00	FCFA	Virement vers compte	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	2025-04-26 17:22:32	2025-10-23 12:37:00
0963f978-edfb-4d66-8efc-05d555abe304	818e8545-fc56-4437-b399-56970df2cc32	retrait	22580.00	331404.00	308824.00	FCFA	Retrait guichet	\N	2025-04-25 19:17:44	2025-10-23 12:37:00
90d14e70-1952-42a0-bf6e-f593e75da85a	818e8545-fc56-4437-b399-56970df2cc32	retrait	18443.00	331404.00	312961.00	FCFA	Retrait d'espèces	\N	2025-05-08 09:55:12	2025-10-23 12:37:00
326975f2-97b5-4788-8b0d-223c86779f77	818e8545-fc56-4437-b399-56970df2cc32	retrait	17736.00	331404.00	313668.00	FCFA	Paiement par carte	\N	2025-08-16 04:51:07	2025-10-23 12:37:00
f3ec94fc-88ad-4888-b507-6364ec1bfdac	818e8545-fc56-4437-b399-56970df2cc32	virement	25358.00	331404.00	306046.00	FCFA	Virement salaire	afffc156-c61b-4b68-9c62-2a3812714585	2025-09-07 05:04:10	2025-10-23 12:37:00
ebec38f5-1203-43df-b553-91e09dfd81f6	818e8545-fc56-4437-b399-56970df2cc32	depot	1885.00	331404.00	333289.00	FCFA	Dépôt d'espèces	\N	2025-09-25 00:27:53	2025-10-23 12:37:00
b7b52061-5d59-491e-8af0-eae7a4f32483	818e8545-fc56-4437-b399-56970df2cc32	depot	4407.00	331404.00	335811.00	FCFA	Dépôt espèces guichet	\N	2025-06-08 12:19:05	2025-10-23 12:37:00
c7083667-b5c8-4776-b7b7-2085fec0d593	03991212-82d0-40f8-aade-bd7a07550872	depot	20750.00	470849.00	491599.00	FCFA	Versement salaire	\N	2025-08-23 10:15:35	2025-10-23 12:37:00
74e5fbf4-bf32-4a32-aed9-cd79b23b2187	03991212-82d0-40f8-aade-bd7a07550872	depot	18829.00	470849.00	489678.00	FCFA	Dépôt espèces guichet	\N	2025-09-29 09:43:50	2025-10-23 12:37:00
424f88b8-b471-4950-8d28-52bc77c0b504	03991212-82d0-40f8-aade-bd7a07550872	retrait	16705.00	470849.00	454144.00	FCFA	Prélèvement automatique	\N	2025-06-20 13:47:07	2025-10-23 12:37:00
3c7c1670-62c9-4a30-9fb7-7bf85c09ab0f	03991212-82d0-40f8-aade-bd7a07550872	retrait	29685.00	470849.00	441164.00	FCFA	Retrait DAB	\N	2025-09-28 20:23:51	2025-10-23 12:37:00
d1164e27-4b05-4975-85f4-f90cd411b681	03991212-82d0-40f8-aade-bd7a07550872	virement	38042.00	470849.00	432807.00	FCFA	Paiement facture	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	2025-09-08 22:01:02	2025-10-23 12:37:00
38badadb-e060-4395-8eca-df4dc2ecea5a	03991212-82d0-40f8-aade-bd7a07550872	virement	27754.00	470849.00	443095.00	FCFA	Transfert entre comptes	473ba79b-f520-481d-82b7-0a94c75586be	2025-06-08 09:07:16	2025-10-23 12:37:00
0473f330-3fbe-49ad-b403-82a8883f8f74	03991212-82d0-40f8-aade-bd7a07550872	retrait	12970.00	470849.00	457879.00	FCFA	Paiement par carte	\N	2025-08-25 17:44:23	2025-10-23 12:37:00
b2c5bd9a-c450-482e-a453-c8a3860d7070	03991212-82d0-40f8-aade-bd7a07550872	retrait	49070.00	470849.00	421779.00	FCFA	Retrait DAB	\N	2025-08-30 10:15:16	2025-10-23 12:37:00
c3530c8a-b93e-49c1-8e6f-b474cd42aef8	03991212-82d0-40f8-aade-bd7a07550872	virement	36581.00	470849.00	434268.00	FCFA	Virement salaire	37da1638-f10a-4a03-9eb4-9eb960273866	2025-09-24 01:56:14	2025-10-23 12:37:00
d1a1c330-0d46-49e8-9eb8-b372d6c89890	03991212-82d0-40f8-aade-bd7a07550872	depot	35654.00	470849.00	506503.00	FCFA	Dépôt chèque	\N	2025-06-03 12:59:12	2025-10-23 12:37:00
d5823202-7cd5-4c9a-af3b-7285c751aaf8	03991212-82d0-40f8-aade-bd7a07550872	retrait	15527.00	470849.00	455322.00	FCFA	Prélèvement automatique	\N	2025-07-02 12:24:13	2025-10-23 12:37:00
a9c7015e-195a-4649-b2b8-6ed5210a41b2	03991212-82d0-40f8-aade-bd7a07550872	retrait	19915.00	470849.00	450934.00	FCFA	Paiement par carte	\N	2025-08-25 05:22:57	2025-10-23 12:37:00
2ba8314b-6aac-45f1-81ac-328eb2dd8ab7	03991212-82d0-40f8-aade-bd7a07550872	retrait	28925.00	470849.00	441924.00	FCFA	Retrait d'espèces	\N	2025-07-02 17:21:41	2025-10-23 12:37:00
39766222-5c65-45ef-b657-7b08416dd0ef	03991212-82d0-40f8-aade-bd7a07550872	depot	2030.00	470849.00	472879.00	FCFA	Dépôt chèque	\N	2025-07-08 20:38:05	2025-10-23 12:37:00
d50c5858-4ebe-407c-a371-6d18d6222e07	02e98a52-78e0-4f7e-a6e9-289e19f7a3f8	virement	5856.00	151492.00	145636.00	FCFA	Transfert entre comptes	f564d3ae-c6e1-4c1b-8796-150c1c1d0a64	2025-09-17 12:33:09	2025-10-23 12:37:00
c62dc3d8-0fae-435c-b2ae-17beb3d1de5f	02e98a52-78e0-4f7e-a6e9-289e19f7a3f8	virement	4393.00	151492.00	147099.00	FCFA	Transfert entre comptes	be33e282-23c2-42e0-8042-11f125606cb1	2025-08-09 16:17:36	2025-10-23 12:37:00
b2a0a084-031a-496e-9427-466a96ea6877	02e98a52-78e0-4f7e-a6e9-289e19f7a3f8	retrait	25573.00	151492.00	125919.00	FCFA	Retrait d'espèces	\N	2025-06-30 00:15:16	2025-10-23 12:37:00
c3632b0e-30d7-454f-ada5-cad3c556fe83	02e98a52-78e0-4f7e-a6e9-289e19f7a3f8	virement	38329.00	151492.00	113163.00	FCFA	Virement salaire	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	2025-07-24 08:38:05	2025-10-23 12:37:00
777a13a5-4c76-4961-82b9-f1d92c05af4c	02e98a52-78e0-4f7e-a6e9-289e19f7a3f8	retrait	33662.00	151492.00	117830.00	FCFA	Retrait DAB	\N	2025-04-29 20:07:24	2025-10-23 12:37:00
d91054ef-7fdc-485d-9e0d-1c26882ae6ee	02e98a52-78e0-4f7e-a6e9-289e19f7a3f8	virement	13560.00	151492.00	137932.00	FCFA	Virement vers compte	af23b369-6d2d-416a-9f80-93ac47b6dde3	2025-05-24 19:44:30	2025-10-23 12:37:00
44b6a9c2-dfa2-41c9-b459-52e2c92f1b78	af23b369-6d2d-416a-9f80-93ac47b6dde3	depot	17622.00	449522.00	467144.00	FCFA	Versement salaire	\N	2025-07-05 01:30:38	2025-10-23 12:37:00
17c60f91-56cb-4db1-b1b5-24512d0c1da4	af23b369-6d2d-416a-9f80-93ac47b6dde3	virement	10247.00	449522.00	439275.00	FCFA	Virement salaire	edc37cd9-41c0-44ba-a8a4-f7da20914b48	2025-09-16 19:49:22	2025-10-23 12:37:00
9ab45d3b-ee91-46c7-8f43-c971c8886c53	af23b369-6d2d-416a-9f80-93ac47b6dde3	retrait	37575.00	449522.00	411947.00	FCFA	Retrait guichet	\N	2025-08-11 13:45:19	2025-10-23 12:37:00
145e7fa2-b033-4ed5-8951-761d1e3fa194	af23b369-6d2d-416a-9f80-93ac47b6dde3	retrait	19613.00	449522.00	429909.00	FCFA	Prélèvement automatique	\N	2025-07-22 20:40:29	2025-10-23 12:37:00
957c84a1-85f2-4281-be19-e2b54961cf47	af23b369-6d2d-416a-9f80-93ac47b6dde3	depot	9303.00	449522.00	458825.00	FCFA	Dépôt espèces guichet	\N	2025-05-25 09:00:38	2025-10-23 12:37:00
dca294e3-31da-46df-ab20-edc669d976b9	af23b369-6d2d-416a-9f80-93ac47b6dde3	retrait	16046.00	449522.00	433476.00	FCFA	Paiement par carte	\N	2025-09-08 02:46:29	2025-10-23 12:37:00
4d53995c-8aa2-4029-93bf-9fa223707697	af23b369-6d2d-416a-9f80-93ac47b6dde3	depot	17414.00	449522.00	466936.00	FCFA	Versement salaire	\N	2025-06-13 12:12:15	2025-10-23 12:37:00
3f5a109a-e52e-4edf-9fb1-94dbbb8f45f2	af23b369-6d2d-416a-9f80-93ac47b6dde3	retrait	11740.00	449522.00	437782.00	FCFA	Retrait guichet	\N	2025-04-26 04:44:51	2025-10-23 12:37:00
1bdf064b-94f2-4abb-95b8-e79690e36ee4	af23b369-6d2d-416a-9f80-93ac47b6dde3	virement	41060.00	449522.00	408462.00	FCFA	Transfert entre comptes	4bc9a980-1950-4ed8-9b41-bbb0a53a929c	2025-05-09 02:04:11	2025-10-23 12:37:00
ca3b6a62-53bd-4abd-926e-d07b49192d06	af23b369-6d2d-416a-9f80-93ac47b6dde3	virement	9770.00	449522.00	439752.00	FCFA	Transfert bancaire	e575ca40-926e-4fe2-9c4a-0af557a58c64	2025-05-10 02:58:16	2025-10-23 12:37:00
09f43dc0-e9f1-4f19-945d-9bd328f70517	1b7cd94f-0234-49b8-9971-c35f0b951189	virement	26941.00	194611.00	167670.00	FCFA	Transfert entre comptes	a1f1990b-1819-4977-aaf0-bb14a824daa0	2025-05-20 04:35:04	2025-10-23 12:37:00
381be974-25f9-4633-9d35-4fdcdd5334f2	1b7cd94f-0234-49b8-9971-c35f0b951189	retrait	13402.00	194611.00	181209.00	FCFA	Prélèvement automatique	\N	2025-09-15 00:13:15	2025-10-23 12:37:00
bbecf009-6b15-4406-9021-44fb23b52818	1b7cd94f-0234-49b8-9971-c35f0b951189	virement	11044.00	194611.00	183567.00	FCFA	Transfert bancaire	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	2025-09-10 08:01:25	2025-10-23 12:37:00
1c5e4592-e845-4ae6-9f93-49f5e4c00ba6	1b7cd94f-0234-49b8-9971-c35f0b951189	depot	37264.00	194611.00	231875.00	FCFA	Virement bancaire entrant	\N	2025-08-05 08:53:53	2025-10-23 12:37:00
d4119808-951c-4264-82ec-02b02dd906ab	1b7cd94f-0234-49b8-9971-c35f0b951189	depot	3610.00	194611.00	198221.00	FCFA	Dépôt d'espèces	\N	2025-07-29 23:13:32	2025-10-23 12:37:00
be72c0b3-969d-407f-b95a-51d8516b71d8	1b7cd94f-0234-49b8-9971-c35f0b951189	virement	8597.00	194611.00	186014.00	FCFA	Virement vers compte	2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	2025-05-24 23:34:43	2025-10-23 12:37:00
2252e1b3-a72e-4246-9e51-64817991d53e	1b7cd94f-0234-49b8-9971-c35f0b951189	depot	26793.00	194611.00	221404.00	FCFA	Virement bancaire entrant	\N	2025-10-07 00:20:10	2025-10-23 12:37:00
c391deff-7fac-47e9-90e7-0afafc199c56	1b7cd94f-0234-49b8-9971-c35f0b951189	virement	20163.00	194611.00	174448.00	FCFA	Paiement facture	3406986a-f161-4a7a-80be-bcdf0e3f2214	2025-08-23 01:41:30	2025-10-23 12:37:00
c9bfd2e5-e7d2-4ff9-81c8-97eebf42ce19	e88eac49-5c57-48f8-824a-813a7da0fdc3	virement	44653.00	470426.00	425773.00	FCFA	Virement salaire	7f1efa9d-d4d7-40ff-ad77-c49e8db26274	2025-05-12 10:12:31	2025-10-23 12:37:00
536e1405-a557-4fa6-9e93-949a40977fd5	e88eac49-5c57-48f8-824a-813a7da0fdc3	depot	22222.00	470426.00	492648.00	FCFA	Versement salaire	\N	2025-09-09 12:02:54	2025-10-23 12:37:00
cbb9d3e8-f4f4-426e-90f6-ebf7996d0ce1	e88eac49-5c57-48f8-824a-813a7da0fdc3	virement	46228.00	470426.00	424198.00	FCFA	Paiement facture	db289a68-fb56-4357-aa96-60bcaab5608f	2025-09-21 14:25:26	2025-10-23 12:37:00
dde113ac-d081-4102-b588-556d3334c6e7	e88eac49-5c57-48f8-824a-813a7da0fdc3	depot	49771.00	470426.00	520197.00	FCFA	Virement bancaire entrant	\N	2025-10-09 00:40:25	2025-10-23 12:37:00
2ba09e61-8de8-4cbb-86aa-36744d689001	e88eac49-5c57-48f8-824a-813a7da0fdc3	virement	1550.00	470426.00	468876.00	FCFA	Virement vers compte	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	2025-05-31 09:58:31	2025-10-23 12:37:00
d035797a-078b-454e-9613-fb42199087bb	8cc906e8-f49e-48bf-97f7-063a96dd5855	virement	9018.00	280830.00	271812.00	FCFA	Transfert entre comptes	2eab81ba-c2de-4108-9a0e-7ca81af2697c	2025-06-23 08:43:09	2025-10-23 12:37:00
abb9e8de-6f2b-4227-a77c-40e05419530d	8cc906e8-f49e-48bf-97f7-063a96dd5855	depot	18276.00	280830.00	299106.00	FCFA	Dépôt espèces guichet	\N	2025-04-27 00:43:04	2025-10-23 12:37:00
c3b6b1fe-ebf5-40e1-ac64-51c5b5e7cc3d	8cc906e8-f49e-48bf-97f7-063a96dd5855	retrait	14315.00	280830.00	266515.00	FCFA	Retrait d'espèces	\N	2025-07-12 05:03:08	2025-10-23 12:37:00
d737698e-9104-4901-9a99-751c9ba8abbc	8cc906e8-f49e-48bf-97f7-063a96dd5855	depot	31543.00	280830.00	312373.00	FCFA	Virement bancaire entrant	\N	2025-10-18 03:01:22	2025-10-23 12:37:00
b09f1321-dcca-4154-b679-5f5fc49a89d5	8cc906e8-f49e-48bf-97f7-063a96dd5855	depot	7599.00	280830.00	288429.00	FCFA	Virement bancaire entrant	\N	2025-08-16 13:46:30	2025-10-23 12:37:00
d303bf8e-86e4-40a7-98c0-9f703670d95a	8cc906e8-f49e-48bf-97f7-063a96dd5855	virement	4854.00	280830.00	275976.00	FCFA	Virement salaire	4497726b-2732-4f82-ac92-17bdbf1dbca5	2025-09-29 23:37:43	2025-10-23 12:37:00
0600efa6-3a05-492c-a2b2-a5546305022b	8cc906e8-f49e-48bf-97f7-063a96dd5855	retrait	23075.00	280830.00	257755.00	FCFA	Prélèvement automatique	\N	2025-09-09 12:30:06	2025-10-23 12:37:00
6b34d849-f6dc-4fdc-b0a9-226a64875b34	8cc906e8-f49e-48bf-97f7-063a96dd5855	virement	49243.00	280830.00	231587.00	FCFA	Transfert entre comptes	e5fbfcb0-c796-4371-80c6-f78f1038a282	2025-09-08 23:36:22	2025-10-23 12:37:00
40513e10-1d1f-4453-b1a3-dadd764bb7d5	8cc906e8-f49e-48bf-97f7-063a96dd5855	depot	1340.00	280830.00	282170.00	FCFA	Versement salaire	\N	2025-07-28 22:58:28	2025-10-23 12:37:00
df604e2a-9354-4075-944e-8e14e3130c7f	8cc906e8-f49e-48bf-97f7-063a96dd5855	virement	37327.00	280830.00	243503.00	FCFA	Transfert entre comptes	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	2025-04-25 10:30:06	2025-10-23 12:37:00
6ba1f33f-a68b-470e-ad5e-ddf48e2bbc55	8cc906e8-f49e-48bf-97f7-063a96dd5855	retrait	8370.00	280830.00	272460.00	FCFA	Retrait d'espèces	\N	2025-04-30 06:46:26	2025-10-23 12:37:00
4ab96cac-d374-479a-86dc-45ded462c313	8cc906e8-f49e-48bf-97f7-063a96dd5855	virement	1797.00	280830.00	279033.00	FCFA	Virement salaire	dd05cd28-6e89-41fd-8a78-cba1c4607efd	2025-06-27 04:32:13	2025-10-23 12:37:00
effc4f6e-b86c-4aec-abe8-965f5844e4ab	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	depot	10729.00	140962.00	151691.00	FCFA	Dépôt chèque	\N	2025-07-05 21:00:55	2025-10-23 12:37:00
9cf4d08e-02b0-4614-a6f3-8d0428e0b776	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	virement	47496.00	140962.00	93466.00	FCFA	Virement salaire	34b84e17-27b4-4080-a77b-3cdb00476a06	2025-06-29 18:36:10	2025-10-23 12:37:00
72e69dc2-2fe5-4350-86b2-84f3b727011f	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	retrait	4856.00	140962.00	136106.00	FCFA	Paiement par carte	\N	2025-05-29 11:29:05	2025-10-23 12:37:00
3d807ce9-2cf0-46f1-b888-7c33f93a1b7a	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	retrait	32777.00	140962.00	108185.00	FCFA	Paiement par carte	\N	2025-07-15 03:29:16	2025-10-23 12:37:00
6f742ce7-8ed8-4774-a776-20a1ca961d91	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	retrait	41737.00	140962.00	99225.00	FCFA	Retrait d'espèces	\N	2025-07-14 16:37:15	2025-10-23 12:37:00
12eecbd1-2a12-44fd-a0b2-20f23bdd9030	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	retrait	29407.00	140962.00	111555.00	FCFA	Prélèvement automatique	\N	2025-08-16 19:26:44	2025-10-23 12:37:00
6fa885ab-f3e3-4d00-9b46-186bc0579913	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	depot	11467.00	140962.00	152429.00	FCFA	Versement salaire	\N	2025-06-09 13:56:46	2025-10-23 12:37:00
a7b46d1b-a9ef-4e30-bda3-e2bdb003ca8b	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	retrait	47916.00	140962.00	93046.00	FCFA	Retrait guichet	\N	2025-08-21 07:23:12	2025-10-23 12:37:00
ddc56b07-1fc2-43b9-b444-6ddcebac37a2	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	virement	26236.00	140962.00	114726.00	FCFA	Transfert bancaire	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	2025-08-10 12:43:33	2025-10-23 12:37:00
626db762-b623-4967-8213-15235267cb78	fe405432-6112-461d-87cd-a720335c4092	retrait	2360.00	88184.00	85824.00	FCFA	Paiement par carte	\N	2025-06-05 17:39:33	2025-10-23 12:37:00
5aded69e-1c3c-4227-8615-5286c5e5219b	fe405432-6112-461d-87cd-a720335c4092	depot	16876.00	88184.00	105060.00	FCFA	Dépôt d'espèces	\N	2025-07-26 14:42:35	2025-10-23 12:37:00
2fadb78d-f163-409a-9f2e-eb474a9b1340	fe405432-6112-461d-87cd-a720335c4092	depot	20105.00	88184.00	108289.00	FCFA	Dépôt espèces guichet	\N	2025-07-12 12:24:32	2025-10-23 12:37:00
4ec7018e-c357-40d9-86d2-1724525b854d	fe405432-6112-461d-87cd-a720335c4092	retrait	19465.00	88184.00	68719.00	FCFA	Retrait guichet	\N	2025-07-02 23:27:29	2025-10-23 12:37:00
c584712c-9163-4387-99ff-5070cad532f5	fe405432-6112-461d-87cd-a720335c4092	retrait	48071.00	88184.00	40113.00	FCFA	Prélèvement automatique	\N	2025-05-10 18:05:39	2025-10-23 12:37:00
e98a204f-6a0c-4a7e-a76f-9c1dc0210cc4	fe405432-6112-461d-87cd-a720335c4092	virement	16501.00	88184.00	71683.00	FCFA	Virement vers compte	2e311570-14e5-403a-a71f-698c77f8454d	2025-08-18 09:20:38	2025-10-23 12:37:00
ac4dfee8-dac3-4357-a867-df60ef078d83	fe405432-6112-461d-87cd-a720335c4092	depot	34242.00	88184.00	122426.00	FCFA	Dépôt d'espèces	\N	2025-07-03 20:07:45	2025-10-23 12:37:00
001877ac-9cca-49c5-8c80-fcc888d51da7	fe405432-6112-461d-87cd-a720335c4092	retrait	29221.00	88184.00	58963.00	FCFA	Prélèvement automatique	\N	2025-09-13 08:39:24	2025-10-23 12:37:00
bd304447-430c-44f1-835b-ee4834195ab9	fe405432-6112-461d-87cd-a720335c4092	retrait	41217.00	88184.00	46967.00	FCFA	Retrait guichet	\N	2025-09-16 10:04:45	2025-10-23 12:37:00
e2a4b977-7db0-4b59-87ff-49e2d5732564	fe405432-6112-461d-87cd-a720335c4092	virement	3391.00	88184.00	84793.00	FCFA	Transfert bancaire	afffc156-c61b-4b68-9c62-2a3812714585	2025-09-04 23:51:32	2025-10-23 12:37:00
1c8e1ba0-f234-4d9a-ba80-b9aa3266af57	fe405432-6112-461d-87cd-a720335c4092	retrait	11474.00	88184.00	76710.00	FCFA	Retrait DAB	\N	2025-06-13 22:25:43	2025-10-23 12:37:00
d9eaef74-ede7-407a-8441-b33faf566a2e	fe405432-6112-461d-87cd-a720335c4092	depot	4885.00	88184.00	93069.00	FCFA	Dépôt espèces guichet	\N	2025-07-03 01:28:22	2025-10-23 12:37:00
2eb2b37d-e018-451e-89ec-f8e18b1cf9b5	fe405432-6112-461d-87cd-a720335c4092	depot	29645.00	88184.00	117829.00	FCFA	Dépôt chèque	\N	2025-07-29 03:54:51	2025-10-23 12:37:00
23e9857d-58d3-49a1-8d92-c2f9e57ac1f2	168369a2-765d-4e68-9282-e69cf56154cf	retrait	6983.00	489025.00	482042.00	FCFA	Retrait d'espèces	\N	2025-09-04 13:50:01	2025-10-23 12:37:00
e469895e-360d-42a1-b469-f662ff8e4338	168369a2-765d-4e68-9282-e69cf56154cf	depot	25624.00	489025.00	514649.00	FCFA	Dépôt espèces guichet	\N	2025-08-09 07:05:01	2025-10-23 12:37:00
2fcd114b-51f0-4435-abad-381f414e4bdc	168369a2-765d-4e68-9282-e69cf56154cf	retrait	6660.00	489025.00	482365.00	FCFA	Retrait DAB	\N	2025-07-06 15:29:37	2025-10-23 12:37:00
f6672ab6-5b2e-4639-8988-038726fe5154	168369a2-765d-4e68-9282-e69cf56154cf	depot	21542.00	489025.00	510567.00	FCFA	Versement salaire	\N	2025-09-11 09:49:47	2025-10-23 12:37:00
0fa57a1f-c1ab-4db0-8fd1-caba077204a6	168369a2-765d-4e68-9282-e69cf56154cf	depot	15630.00	489025.00	504655.00	FCFA	Versement salaire	\N	2025-07-20 23:34:26	2025-10-23 12:37:00
983c9a43-c984-4ea7-8fc2-567b48cd4702	168369a2-765d-4e68-9282-e69cf56154cf	depot	24526.00	489025.00	513551.00	FCFA	Versement salaire	\N	2025-05-18 18:30:14	2025-10-23 12:37:00
578a7826-97db-4003-b628-c1c4651e2410	168369a2-765d-4e68-9282-e69cf56154cf	retrait	19778.00	489025.00	469247.00	FCFA	Paiement par carte	\N	2025-06-23 18:40:13	2025-10-23 12:37:00
2be1e9af-41a1-4e72-95d1-cf25fbafd649	168369a2-765d-4e68-9282-e69cf56154cf	depot	10530.00	489025.00	499555.00	FCFA	Virement bancaire entrant	\N	2025-08-17 23:18:08	2025-10-23 12:37:00
b1719169-07d8-4e30-9ba3-a4888e62caf8	168369a2-765d-4e68-9282-e69cf56154cf	virement	9175.00	489025.00	479850.00	FCFA	Virement salaire	8d706bac-d7d8-4172-8d94-d1a8cdf604db	2025-05-05 10:42:58	2025-10-23 12:37:00
8378a8ec-d16e-495a-ba45-7abe7947666b	168369a2-765d-4e68-9282-e69cf56154cf	retrait	2354.00	489025.00	486671.00	FCFA	Retrait guichet	\N	2025-09-14 06:19:29	2025-10-23 12:37:00
dabaef2e-c7af-4922-adca-6204d4c0a360	4339b8f2-e315-454a-b86f-e35bde749370	retrait	1393.00	56103.00	54710.00	FCFA	Prélèvement automatique	\N	2025-06-19 09:20:32	2025-10-23 12:37:00
525e5818-c5c6-46dd-9e98-2a7cabba2445	4339b8f2-e315-454a-b86f-e35bde749370	virement	44795.00	56103.00	11308.00	FCFA	Transfert entre comptes	e5fbfcb0-c796-4371-80c6-f78f1038a282	2025-08-29 20:55:40	2025-10-23 12:37:00
3e461000-5287-4170-b049-2e9699929884	4339b8f2-e315-454a-b86f-e35bde749370	virement	2579.00	56103.00	53524.00	FCFA	Virement salaire	31fb6207-f59e-425f-bf86-a1085c47b43f	2025-04-25 06:58:07	2025-10-23 12:37:00
ea4d0605-3b60-4cc0-8cc2-b5be76fcff6b	4339b8f2-e315-454a-b86f-e35bde749370	depot	25642.00	56103.00	81745.00	FCFA	Versement salaire	\N	2025-05-08 01:16:02	2025-10-23 12:37:00
4f31fe7c-c722-45f1-b57a-45daf646ad0a	4339b8f2-e315-454a-b86f-e35bde749370	virement	30718.00	56103.00	25385.00	FCFA	Transfert bancaire	b9dbc5e1-4932-4b18-9442-6fbf74b31327	2025-05-09 15:00:17	2025-10-23 12:37:00
e16be9a9-3001-4665-b4b8-0d5df703b489	4339b8f2-e315-454a-b86f-e35bde749370	virement	11609.00	56103.00	44494.00	FCFA	Virement salaire	12a1bcc9-6ded-4708-8db3-3ebeb5632e08	2025-10-18 03:21:03	2025-10-23 12:37:00
c6afb61c-a94e-4523-818e-b30bfb441245	4339b8f2-e315-454a-b86f-e35bde749370	retrait	7579.00	56103.00	48524.00	FCFA	Retrait d'espèces	\N	2025-08-21 17:44:55	2025-10-23 12:37:00
cac390a1-9984-4d0c-b01f-2faef74da986	4339b8f2-e315-454a-b86f-e35bde749370	retrait	11733.00	56103.00	44370.00	FCFA	Prélèvement automatique	\N	2025-10-10 05:01:13	2025-10-23 12:37:00
9b47b107-fef8-4610-b38d-57ea4d16a2b2	4339b8f2-e315-454a-b86f-e35bde749370	depot	8270.00	56103.00	64373.00	FCFA	Dépôt espèces guichet	\N	2025-05-22 09:00:30	2025-10-23 12:37:00
3166e224-e285-4983-ab5e-0e1133ea1253	4339b8f2-e315-454a-b86f-e35bde749370	depot	1693.00	56103.00	57796.00	FCFA	Dépôt espèces guichet	\N	2025-09-16 04:38:03	2025-10-23 12:37:00
d9e550c5-5ad2-4d02-85c7-4bd32067b525	4339b8f2-e315-454a-b86f-e35bde749370	retrait	49843.00	56103.00	6260.00	FCFA	Paiement par carte	\N	2025-07-26 07:07:57	2025-10-23 12:37:00
9dfd65fd-e1c3-4f7e-be6d-00abecbc570e	4339b8f2-e315-454a-b86f-e35bde749370	virement	31405.00	56103.00	24698.00	FCFA	Paiement facture	dbcd0804-e931-4453-9ad5-f978ceebb511	2025-09-30 12:14:54	2025-10-23 12:37:00
bbe928f4-08d5-424b-847d-2dc3c8ab1e12	4339b8f2-e315-454a-b86f-e35bde749370	depot	32647.00	56103.00	88750.00	FCFA	Virement bancaire entrant	\N	2025-09-17 22:17:13	2025-10-23 12:37:00
752a0d84-a419-46df-befe-b454e033c5f9	4339b8f2-e315-454a-b86f-e35bde749370	depot	2699.00	56103.00	58802.00	FCFA	Virement bancaire entrant	\N	2025-05-06 06:44:28	2025-10-23 12:37:00
1cde4886-6325-440a-bd69-2ff6e43c861d	edc37cd9-41c0-44ba-a8a4-f7da20914b48	virement	41367.00	367542.00	326175.00	FCFA	Transfert entre comptes	914d5be6-2dc2-4063-8219-1ea664a8b058	2025-06-22 10:27:25	2025-10-23 12:37:00
49eae7e6-548d-44db-8e1a-7a537fa7eb19	edc37cd9-41c0-44ba-a8a4-f7da20914b48	virement	34670.00	367542.00	332872.00	FCFA	Virement vers compte	a03dce74-58f6-42c7-8624-1d21ea760a90	2025-08-26 08:51:53	2025-10-23 12:37:00
1f1fa1e9-df5c-48f5-9ed4-d62fc3c84504	edc37cd9-41c0-44ba-a8a4-f7da20914b48	depot	12203.00	367542.00	379745.00	FCFA	Dépôt d'espèces	\N	2025-05-02 16:01:43	2025-10-23 12:37:00
b6a56c55-a942-405b-a092-b1ac53c6a577	edc37cd9-41c0-44ba-a8a4-f7da20914b48	virement	45333.00	367542.00	322209.00	FCFA	Paiement facture	b30db983-96ad-4f5c-a50c-1637c25f3b46	2025-06-23 14:42:39	2025-10-23 12:37:00
7954f19a-ecb5-4449-840f-55f6bb645113	edc37cd9-41c0-44ba-a8a4-f7da20914b48	depot	7515.00	367542.00	375057.00	FCFA	Dépôt d'espèces	\N	2025-09-01 14:21:23	2025-10-23 12:37:00
0448e5f3-88b9-49d7-839d-4b32450dc7a0	edc37cd9-41c0-44ba-a8a4-f7da20914b48	retrait	5242.00	367542.00	362300.00	FCFA	Retrait guichet	\N	2025-07-02 05:35:37	2025-10-23 12:37:00
eefaed76-d142-4cef-8df8-296a764b4d1d	edc37cd9-41c0-44ba-a8a4-f7da20914b48	retrait	34251.00	367542.00	333291.00	FCFA	Paiement par carte	\N	2025-09-19 18:47:36	2025-10-23 12:37:00
410a9f08-ba1d-40f8-a351-6f50d1c43de9	edc37cd9-41c0-44ba-a8a4-f7da20914b48	virement	34870.00	367542.00	332672.00	FCFA	Paiement facture	4e0954f5-1956-40db-b392-7a6ee455c257	2025-08-23 04:47:38	2025-10-23 12:37:00
b108eae4-a044-48c5-b19b-c2dc19641542	edc37cd9-41c0-44ba-a8a4-f7da20914b48	depot	4095.00	367542.00	371637.00	FCFA	Dépôt chèque	\N	2025-10-10 23:00:55	2025-10-23 12:37:00
a8ef6939-c9c2-403a-bf76-c2be2dacbd8f	edc37cd9-41c0-44ba-a8a4-f7da20914b48	virement	38672.00	367542.00	328870.00	FCFA	Transfert bancaire	4497726b-2732-4f82-ac92-17bdbf1dbca5	2025-10-22 02:55:12	2025-10-23 12:37:00
2d9e4caa-835a-4813-bf52-ed6349bb781f	edc37cd9-41c0-44ba-a8a4-f7da20914b48	retrait	44707.00	367542.00	322835.00	FCFA	Retrait DAB	\N	2025-08-07 01:36:55	2025-10-23 12:37:00
f3876f32-e376-488c-94bb-3e99b35ee346	edc37cd9-41c0-44ba-a8a4-f7da20914b48	depot	7526.00	367542.00	375068.00	FCFA	Dépôt espèces guichet	\N	2025-07-03 04:13:34	2025-10-23 12:37:00
560cfb8e-904b-4a80-8b84-e5e38f94ecfe	edc37cd9-41c0-44ba-a8a4-f7da20914b48	depot	31739.00	367542.00	399281.00	FCFA	Virement bancaire entrant	\N	2025-05-06 14:25:17	2025-10-23 12:37:00
babef0ba-e145-49be-a205-59a6cf9458e5	edc37cd9-41c0-44ba-a8a4-f7da20914b48	retrait	13116.00	367542.00	354426.00	FCFA	Retrait d'espèces	\N	2025-07-24 13:15:13	2025-10-23 12:37:00
1b7d70cd-157e-4e26-b974-e8032993524c	edc37cd9-41c0-44ba-a8a4-f7da20914b48	virement	44952.00	367542.00	322590.00	FCFA	Virement vers compte	f46f2dde-ba75-4234-b729-67c0cd2a3ade	2025-05-11 15:05:34	2025-10-23 12:37:00
5709b427-a6ba-4ae7-98c2-bbaad15b8f5b	ac532c01-37b7-44d5-bc6e-148843aaf375	retrait	14531.00	404914.00	390383.00	FCFA	Paiement par carte	\N	2025-07-29 06:57:18	2025-10-23 12:37:00
44107070-cce7-4a8f-ab6a-870e1f879c0f	ac532c01-37b7-44d5-bc6e-148843aaf375	depot	38755.00	404914.00	443669.00	FCFA	Virement bancaire entrant	\N	2025-10-02 07:46:31	2025-10-23 12:37:00
56ee14fc-07c0-4145-b11f-50db248b5edd	ac532c01-37b7-44d5-bc6e-148843aaf375	depot	14361.00	404914.00	419275.00	FCFA	Dépôt d'espèces	\N	2025-08-29 22:07:39	2025-10-23 12:37:00
b81721c6-2595-409e-8d4d-13473cb45d6c	ac532c01-37b7-44d5-bc6e-148843aaf375	retrait	43577.00	404914.00	361337.00	FCFA	Retrait DAB	\N	2025-10-18 05:45:52	2025-10-23 12:37:00
4b1291ba-e841-463e-88a6-cbaf3a1a6afb	ac532c01-37b7-44d5-bc6e-148843aaf375	depot	14176.00	404914.00	419090.00	FCFA	Virement bancaire entrant	\N	2025-06-11 03:28:27	2025-10-23 12:37:00
2af1650d-3796-4aad-a4c9-1bcd4d79c49c	ac532c01-37b7-44d5-bc6e-148843aaf375	virement	34244.00	404914.00	370670.00	FCFA	Transfert entre comptes	8af34d52-0c28-48ed-ae2d-87e52f97806a	2025-09-15 15:34:10	2025-10-23 12:37:00
31d6e189-8a08-461b-a20a-974e45a0e334	ac532c01-37b7-44d5-bc6e-148843aaf375	retrait	15454.00	404914.00	389460.00	FCFA	Paiement par carte	\N	2025-05-18 01:59:11	2025-10-23 12:37:00
3274a3df-5023-4cba-87a2-7cd7fcf181f9	ac532c01-37b7-44d5-bc6e-148843aaf375	virement	7860.00	404914.00	397054.00	FCFA	Paiement facture	28a8f0a8-46fa-4589-96fb-a4bf01b6df29	2025-09-20 05:41:52	2025-10-23 12:37:00
a0ad86e8-9dcf-45b6-b591-a57c831a87c4	ac532c01-37b7-44d5-bc6e-148843aaf375	depot	35805.00	404914.00	440719.00	FCFA	Versement salaire	\N	2025-06-20 07:59:19	2025-10-23 12:37:00
28b04d1b-e1cf-49ae-9a23-03073131cae4	ac532c01-37b7-44d5-bc6e-148843aaf375	retrait	39543.00	404914.00	365371.00	FCFA	Retrait DAB	\N	2025-05-01 00:20:19	2025-10-23 12:37:00
94e85dbb-68a6-4942-bc5f-394275e02b56	ac532c01-37b7-44d5-bc6e-148843aaf375	virement	14834.00	404914.00	390080.00	FCFA	Transfert bancaire	a90e1a63-43fd-4956-af04-b3458780ca97	2025-07-05 01:45:50	2025-10-23 12:37:00
ac6df72e-926d-4c22-a5c1-f00190e0573d	ac532c01-37b7-44d5-bc6e-148843aaf375	depot	9678.00	404914.00	414592.00	FCFA	Virement bancaire entrant	\N	2025-07-25 07:45:39	2025-10-23 12:37:00
55ebac63-dea5-4718-b41b-1df74ff943f4	ac532c01-37b7-44d5-bc6e-148843aaf375	depot	45125.00	404914.00	450039.00	FCFA	Dépôt d'espèces	\N	2025-09-10 20:32:37	2025-10-23 12:37:00
198a2976-5862-4dfe-90b5-e26adc26ce82	087d0d47-8377-4f2f-82a8-6acbc6e148f1	virement	29424.00	222966.00	193542.00	FCFA	Paiement facture	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	2025-06-01 00:41:20	2025-10-23 12:37:00
e71548ed-1ab4-4579-acd7-6af49496e114	087d0d47-8377-4f2f-82a8-6acbc6e148f1	retrait	8360.00	222966.00	214606.00	FCFA	Retrait DAB	\N	2025-06-22 22:17:58	2025-10-23 12:37:00
2caa5982-f917-4e80-9369-23505b300a08	087d0d47-8377-4f2f-82a8-6acbc6e148f1	retrait	25297.00	222966.00	197669.00	FCFA	Retrait d'espèces	\N	2025-08-21 05:46:38	2025-10-23 12:37:00
3282fa85-b85d-4ca3-8dda-84d00eb06698	087d0d47-8377-4f2f-82a8-6acbc6e148f1	depot	36678.00	222966.00	259644.00	FCFA	Dépôt d'espèces	\N	2025-07-18 11:27:57	2025-10-23 12:37:00
d44590d0-5704-4bf6-aafd-da0a37950d67	087d0d47-8377-4f2f-82a8-6acbc6e148f1	retrait	13866.00	222966.00	209100.00	FCFA	Prélèvement automatique	\N	2025-09-19 23:31:36	2025-10-23 12:37:00
a13c4817-f51e-44fb-a371-24ff42f01503	087d0d47-8377-4f2f-82a8-6acbc6e148f1	depot	16889.00	222966.00	239855.00	FCFA	Virement bancaire entrant	\N	2025-06-06 04:17:27	2025-10-23 12:37:00
0e6767cd-1f92-425d-9847-98fd4810264f	087d0d47-8377-4f2f-82a8-6acbc6e148f1	retrait	36317.00	222966.00	186649.00	FCFA	Retrait DAB	\N	2025-06-09 05:58:27	2025-10-23 12:37:00
4f1c43c2-da82-47b2-9ecb-166bf64b9b59	087d0d47-8377-4f2f-82a8-6acbc6e148f1	depot	8663.00	222966.00	231629.00	FCFA	Dépôt d'espèces	\N	2025-06-08 23:16:27	2025-10-23 12:37:00
17ba04b7-4177-4c9b-b515-42335d56428b	087d0d47-8377-4f2f-82a8-6acbc6e148f1	retrait	27760.00	222966.00	195206.00	FCFA	Prélèvement automatique	\N	2025-07-04 15:47:34	2025-10-23 12:37:00
e52d2e55-069b-4c8c-b286-739d1c92c55a	087d0d47-8377-4f2f-82a8-6acbc6e148f1	depot	4987.00	222966.00	227953.00	FCFA	Dépôt d'espèces	\N	2025-06-05 22:46:24	2025-10-23 12:37:00
b44c2c3b-f9b4-4ed0-8e3f-5ebc449659aa	087d0d47-8377-4f2f-82a8-6acbc6e148f1	depot	14354.00	222966.00	237320.00	FCFA	Virement bancaire entrant	\N	2025-05-02 09:56:36	2025-10-23 12:37:00
78235a3e-45fb-45d5-93af-f71368627052	087d0d47-8377-4f2f-82a8-6acbc6e148f1	depot	32158.00	222966.00	255124.00	FCFA	Dépôt chèque	\N	2025-06-29 14:17:47	2025-10-23 12:37:00
dfd51456-7cf1-4052-ae92-eeb8845b629b	087d0d47-8377-4f2f-82a8-6acbc6e148f1	retrait	21945.00	222966.00	201021.00	FCFA	Retrait d'espèces	\N	2025-08-19 22:24:24	2025-10-23 12:37:00
eff4f90a-4f6b-4250-869d-970d048ae2df	087d0d47-8377-4f2f-82a8-6acbc6e148f1	depot	27026.00	222966.00	249992.00	FCFA	Virement bancaire entrant	\N	2025-08-17 15:26:51	2025-10-23 12:37:00
0d64edb4-b4be-401d-9b25-1c2c0612f310	087d0d47-8377-4f2f-82a8-6acbc6e148f1	retrait	26810.00	222966.00	196156.00	FCFA	Retrait DAB	\N	2025-10-07 08:43:31	2025-10-23 12:37:00
6e0e8006-3fba-4bfb-9fb3-0b92ab1dead6	cc0d2546-7dab-4d38-a26e-fedf481485db	retrait	30822.00	356885.00	326063.00	FCFA	Paiement par carte	\N	2025-06-10 20:37:49	2025-10-23 12:37:00
64f6e956-9ed6-4243-9025-ed1b5271914d	cc0d2546-7dab-4d38-a26e-fedf481485db	virement	1647.00	356885.00	355238.00	FCFA	Virement salaire	bc151b8f-a172-41b6-ab05-310ca341ebf3	2025-09-26 06:50:02	2025-10-23 12:37:00
aa0a4a4a-4316-4945-9cd3-f9a055c1122e	cc0d2546-7dab-4d38-a26e-fedf481485db	virement	47124.00	356885.00	309761.00	FCFA	Virement salaire	8a4ca722-53cc-428f-a83a-d84a7f681abf	2025-07-05 16:23:27	2025-10-23 12:37:00
0b116e6f-1863-449b-93e4-2e032d0134de	cc0d2546-7dab-4d38-a26e-fedf481485db	depot	40555.00	356885.00	397440.00	FCFA	Virement bancaire entrant	\N	2025-06-17 06:33:00	2025-10-23 12:37:00
7c9fcdb3-1988-48e4-81f4-ea124038bfd1	cc0d2546-7dab-4d38-a26e-fedf481485db	virement	16291.00	356885.00	340594.00	FCFA	Transfert bancaire	94b4fef5-88d3-4b9a-98c9-1e0c6c697c0a	2025-07-03 12:02:38	2025-10-23 12:37:00
96c26d12-4e61-4c57-870a-c8d5fbe7dacf	cc0d2546-7dab-4d38-a26e-fedf481485db	retrait	11012.00	356885.00	345873.00	FCFA	Retrait guichet	\N	2025-04-26 17:20:40	2025-10-23 12:37:00
e3ed094b-1af8-46ac-8341-639cd120dd69	cc0d2546-7dab-4d38-a26e-fedf481485db	retrait	15606.00	356885.00	341279.00	FCFA	Retrait guichet	\N	2025-09-10 20:30:45	2025-10-23 12:37:00
7d411167-31d1-4523-bfde-43fad9c568d5	cc0d2546-7dab-4d38-a26e-fedf481485db	virement	6220.00	356885.00	350665.00	FCFA	Virement salaire	43df68e0-310b-41d1-b272-3e281b325b72	2025-10-04 16:37:26	2025-10-23 12:37:00
87c347c7-b4c0-410f-9620-a94be4d7e669	08360cab-6365-4da0-80a5-721ba954e61c	retrait	7266.00	457054.00	449788.00	FCFA	Retrait DAB	\N	2025-06-04 00:09:56	2025-10-23 12:37:00
c67f9d5c-cf44-4db7-bfae-010ba42d6119	08360cab-6365-4da0-80a5-721ba954e61c	depot	21789.00	457054.00	478843.00	FCFA	Dépôt espèces guichet	\N	2025-09-04 11:09:54	2025-10-23 12:37:00
12976615-1ab1-46ce-b996-3b421915784c	08360cab-6365-4da0-80a5-721ba954e61c	retrait	4102.00	457054.00	452952.00	FCFA	Prélèvement automatique	\N	2025-08-21 10:00:05	2025-10-23 12:37:00
3bbdf74c-5d1e-49fd-8235-f81beb6cc962	08360cab-6365-4da0-80a5-721ba954e61c	depot	9054.00	457054.00	466108.00	FCFA	Dépôt d'espèces	\N	2025-09-06 17:30:01	2025-10-23 12:37:00
4568f4c3-4875-4b6e-9f56-b9a42fa56717	08360cab-6365-4da0-80a5-721ba954e61c	retrait	21527.00	457054.00	435527.00	FCFA	Paiement par carte	\N	2025-08-18 23:00:17	2025-10-23 12:37:00
ce19a20e-676c-4c63-ae2c-821db269a2b4	08360cab-6365-4da0-80a5-721ba954e61c	depot	37973.00	457054.00	495027.00	FCFA	Versement salaire	\N	2025-09-26 19:40:10	2025-10-23 12:37:00
d03be726-ae33-4b47-88e4-01e09e236171	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	retrait	24722.00	115235.00	90513.00	FCFA	Prélèvement automatique	\N	2025-09-14 09:46:46	2025-10-23 12:37:00
5989ef53-3eed-4582-9612-87e1a177a923	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	virement	18446.00	115235.00	96789.00	FCFA	Virement salaire	edc37cd9-41c0-44ba-a8a4-f7da20914b48	2025-06-10 14:09:40	2025-10-23 12:37:00
dd2f042d-4b3e-42b7-8ede-e557d7db10b4	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	retrait	17000.00	115235.00	98235.00	FCFA	Paiement par carte	\N	2025-09-16 14:04:05	2025-10-23 12:37:00
bc5bfae3-23c5-4bd0-847f-6a5c5acafcc5	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	virement	29903.00	115235.00	85332.00	FCFA	Transfert bancaire	f959068a-63bd-46ee-a42c-59d124c48cf6	2025-10-01 01:42:19	2025-10-23 12:37:00
d331233f-c42b-4642-b783-968eee5b6b12	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	virement	29095.00	115235.00	86140.00	FCFA	Transfert entre comptes	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	2025-06-28 09:46:27	2025-10-23 12:37:00
59e53ac4-bf51-4f92-bd60-6555c7a6c0e5	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	depot	29735.00	115235.00	144970.00	FCFA	Versement salaire	\N	2025-09-14 09:22:51	2025-10-23 12:37:00
3949050c-0790-499b-825e-280a6117820b	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	retrait	24461.00	115235.00	90774.00	FCFA	Retrait DAB	\N	2025-08-24 03:59:48	2025-10-23 12:37:00
d11a8ecb-186b-4aa5-a694-5c0a5b6b80fd	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	retrait	37482.00	115235.00	77753.00	FCFA	Retrait DAB	\N	2025-06-15 21:17:57	2025-10-23 12:37:00
0c88f6cc-019a-4113-89b6-bddad2091ef7	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	virement	14856.00	115235.00	100379.00	FCFA	Virement vers compte	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	2025-08-28 11:36:58	2025-10-23 12:37:00
596293b1-7f1d-480f-990e-ecb7c5d06490	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	depot	33642.00	115235.00	148877.00	FCFA	Dépôt d'espèces	\N	2025-08-02 08:19:39	2025-10-23 12:37:00
56b79dfe-f049-4c0c-ad66-8834c1b96165	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	virement	31841.00	115235.00	83394.00	FCFA	Virement salaire	08360cab-6365-4da0-80a5-721ba954e61c	2025-07-06 05:30:34	2025-10-23 12:37:00
e7f4399c-b6a6-4c19-9de4-23ab8d9ec41b	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	virement	34679.00	115235.00	80556.00	FCFA	Paiement facture	2b138895-6391-4bfe-b137-ca4fa7854a4a	2025-09-15 11:06:32	2025-10-23 12:37:00
05cea3cd-7c24-4c66-a668-15ce947b162b	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	depot	43024.00	293565.00	336589.00	FCFA	Dépôt d'espèces	\N	2025-07-26 00:44:59	2025-10-23 12:37:00
446f3bb6-51b8-4a65-a522-933940796364	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	virement	10920.00	293565.00	282645.00	FCFA	Transfert bancaire	b3c57074-cab3-490f-9d70-3da5066332f6	2025-10-22 16:35:37	2025-10-23 12:37:00
0f5ad8c5-402d-45e3-9de5-8aaadbf08d02	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	depot	21056.00	293565.00	314621.00	FCFA	Dépôt d'espèces	\N	2025-06-27 00:18:42	2025-10-23 12:37:00
d556e745-f0e4-45d0-945f-53c4cb583195	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	virement	27213.00	293565.00	266352.00	FCFA	Transfert entre comptes	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	2025-08-22 20:26:55	2025-10-23 12:37:00
2c53e1e0-d9b4-400f-85e5-c64a5b730934	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	depot	42540.00	293565.00	336105.00	FCFA	Versement salaire	\N	2025-06-23 15:18:22	2025-10-23 12:37:00
4133bbe1-c67b-476f-8bac-414a196e47be	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	depot	39060.00	293565.00	332625.00	FCFA	Dépôt d'espèces	\N	2025-10-09 20:41:19	2025-10-23 12:37:00
f2bb45ad-e862-443e-aff2-5a79608b85c7	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	retrait	42079.00	293565.00	251486.00	FCFA	Prélèvement automatique	\N	2025-08-18 06:25:58	2025-10-23 12:37:00
092dd639-7bbb-4f47-8fc9-d6eef7acfc7d	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	retrait	44861.00	293565.00	248704.00	FCFA	Prélèvement automatique	\N	2025-10-20 12:16:56	2025-10-23 12:37:00
15937772-a462-4166-8584-a02bf25f8279	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	virement	31785.00	293565.00	261780.00	FCFA	Paiement facture	e575ca40-926e-4fe2-9c4a-0af557a58c64	2025-09-03 12:24:44	2025-10-23 12:37:00
2acc6dfc-0c5c-4981-9dcb-af33170480b1	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	virement	2809.00	293565.00	290756.00	FCFA	Virement vers compte	af23b369-6d2d-416a-9f80-93ac47b6dde3	2025-08-08 17:24:12	2025-10-23 12:37:00
e6002bf1-db3d-450e-9db9-759312980292	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	retrait	25466.00	293565.00	268099.00	FCFA	Retrait DAB	\N	2025-05-07 19:03:30	2025-10-23 12:37:00
b86aebde-55de-415a-a96b-c9ccad7492c4	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	virement	13428.00	293565.00	280137.00	FCFA	Transfert entre comptes	add2482a-de00-41d8-a772-cd4ef6546baa	2025-05-06 18:11:58	2025-10-23 12:37:00
5ec7f7e8-0079-435d-980c-67a30e6a33c6	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	retrait	46412.00	293565.00	247153.00	FCFA	Paiement par carte	\N	2025-07-23 06:36:35	2025-10-23 12:37:00
cc0cdbdd-6f5d-4aec-a0a3-ed27ac8f4d12	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	virement	17846.00	293565.00	275719.00	FCFA	Virement vers compte	5cd10916-6dee-48e6-ab78-7995b1f1ce95	2025-08-13 07:30:53	2025-10-23 12:37:00
2b866f19-03e3-4565-bb91-b0f7785526da	43df68e0-310b-41d1-b272-3e281b325b72	depot	21448.00	448094.00	469542.00	FCFA	Virement bancaire entrant	\N	2025-05-11 15:49:43	2025-10-23 12:37:00
f8bd61e0-0284-4fd8-8fca-37ff243371e4	43df68e0-310b-41d1-b272-3e281b325b72	depot	39354.00	448094.00	487448.00	FCFA	Virement bancaire entrant	\N	2025-06-28 08:41:38	2025-10-23 12:37:00
c33f9b16-3aaf-4065-947a-d64528b3059c	43df68e0-310b-41d1-b272-3e281b325b72	virement	17472.00	448094.00	430622.00	FCFA	Virement salaire	79fa87c8-8658-4ac8-a54a-53ff2fe252cf	2025-10-10 08:42:18	2025-10-23 12:37:00
915aecde-3b0d-4bd4-8363-e97e36b57e5f	43df68e0-310b-41d1-b272-3e281b325b72	depot	4828.00	448094.00	452922.00	FCFA	Dépôt espèces guichet	\N	2025-09-10 07:27:33	2025-10-23 12:37:00
bc225a82-2bfe-4689-aed5-21b18b1293ab	43df68e0-310b-41d1-b272-3e281b325b72	virement	10901.00	448094.00	437193.00	FCFA	Transfert entre comptes	168369a2-765d-4e68-9282-e69cf56154cf	2025-07-27 17:56:27	2025-10-23 12:37:00
c9ef512e-d22c-4062-8f94-3f6ea0428c41	43df68e0-310b-41d1-b272-3e281b325b72	depot	24074.00	448094.00	472168.00	FCFA	Virement bancaire entrant	\N	2025-06-29 12:48:10	2025-10-23 12:37:00
44692766-a272-429b-a4f2-f0e9a002811b	43df68e0-310b-41d1-b272-3e281b325b72	retrait	38232.00	448094.00	409862.00	FCFA	Retrait d'espèces	\N	2025-05-13 22:06:40	2025-10-23 12:37:00
d1cbfae1-c902-412d-b694-94b99ac0a152	43df68e0-310b-41d1-b272-3e281b325b72	retrait	17219.00	448094.00	430875.00	FCFA	Retrait d'espèces	\N	2025-06-01 09:37:07	2025-10-23 12:37:00
3c2a364f-cef5-4eab-b523-a18cb982fd7f	43df68e0-310b-41d1-b272-3e281b325b72	depot	16165.00	448094.00	464259.00	FCFA	Versement salaire	\N	2025-06-12 02:04:51	2025-10-23 12:37:00
9dbba25b-355c-44fa-931d-98d50299e93d	43df68e0-310b-41d1-b272-3e281b325b72	retrait	8776.00	448094.00	439318.00	FCFA	Retrait d'espèces	\N	2025-10-10 22:52:12	2025-10-23 12:37:00
904d0d14-4dce-46e6-88c3-5b7e8cfc941b	43df68e0-310b-41d1-b272-3e281b325b72	retrait	31574.00	448094.00	416520.00	FCFA	Paiement par carte	\N	2025-05-22 04:17:04	2025-10-23 12:37:00
fd485e5f-4ccc-4e5a-bbea-e556e7ada994	43df68e0-310b-41d1-b272-3e281b325b72	depot	1727.00	448094.00	449821.00	FCFA	Dépôt chèque	\N	2025-06-11 23:49:50	2025-10-23 12:37:00
7c8df036-8238-447f-9332-c7d863c87368	2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	depot	49828.00	210217.00	260045.00	FCFA	Dépôt d'espèces	\N	2025-08-11 09:56:31	2025-10-23 12:37:00
87570911-4adc-4035-8a8f-e6bbd95a9410	2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	retrait	41188.00	210217.00	169029.00	FCFA	Retrait DAB	\N	2025-05-30 12:24:48	2025-10-23 12:37:00
fa15bd54-25e4-4f98-a11d-00859b7fb3a1	2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	depot	9555.00	210217.00	219772.00	FCFA	Dépôt espèces guichet	\N	2025-04-25 17:30:12	2025-10-23 12:37:00
ff9148fa-d28a-406e-a61f-d291033f10ae	2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	virement	13096.00	210217.00	197121.00	FCFA	Paiement facture	818e8545-fc56-4437-b399-56970df2cc32	2025-07-27 02:03:32	2025-10-23 12:37:00
808e3167-9e87-4389-8c2b-21eef79f8177	2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	retrait	39188.00	210217.00	171029.00	FCFA	Retrait DAB	\N	2025-08-21 00:28:19	2025-10-23 12:37:00
0758a1a9-9607-4925-b965-ac75d1960634	2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	depot	17141.00	210217.00	227358.00	FCFA	Dépôt chèque	\N	2025-10-06 20:21:41	2025-10-23 12:37:00
7d88a3ce-c034-4173-8928-695eb877ca7b	2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	retrait	30775.00	210217.00	179442.00	FCFA	Retrait DAB	\N	2025-08-01 01:55:45	2025-10-23 12:37:00
7ac7ad96-c596-465f-81d1-7c8bb9cfd07e	2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	retrait	31732.00	210217.00	178485.00	FCFA	Prélèvement automatique	\N	2025-06-13 10:03:47	2025-10-23 12:37:00
f3a41680-a64e-4209-bbd5-9132b252dc2e	2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	virement	9844.00	210217.00	200373.00	FCFA	Transfert entre comptes	c5b06daf-ba43-4954-b2b8-1065dfb122ab	2025-06-08 06:14:28	2025-10-23 12:37:00
e52347bc-d83a-4c89-9625-82377a982343	2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	retrait	15091.00	210217.00	195126.00	FCFA	Retrait DAB	\N	2025-06-15 23:33:55	2025-10-23 12:37:00
4dfa9304-5f81-4f05-a119-629338c2006f	2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	depot	30286.00	210217.00	240503.00	FCFA	Virement bancaire entrant	\N	2025-09-11 02:46:30	2025-10-23 12:37:00
4ad761c2-3f83-424a-8ad4-dde56312bc7c	2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	retrait	8976.00	210217.00	201241.00	FCFA	Paiement par carte	\N	2025-08-08 08:13:37	2025-10-23 12:37:00
8d448ec3-a6c6-4216-b5cb-80244e199625	2a7cb1ff-9d63-47d0-af40-ea9b23cfbf40	depot	34424.00	210217.00	244641.00	FCFA	Dépôt espèces guichet	\N	2025-06-02 16:58:11	2025-10-23 12:37:00
11147dd8-f93b-41e3-b4f9-8a5496c1a847	d3ba6f50-5b24-4a03-9002-ded93f5697a3	retrait	28721.00	266338.00	237617.00	FCFA	Paiement par carte	\N	2025-09-02 20:58:38	2025-10-23 12:37:00
2074850d-139c-45de-8fa9-2895ce5faaba	d3ba6f50-5b24-4a03-9002-ded93f5697a3	depot	5011.00	266338.00	271349.00	FCFA	Virement bancaire entrant	\N	2025-10-08 21:34:36	2025-10-23 12:37:00
e40c5b6d-3d5c-4808-919b-91af91b14bfc	d3ba6f50-5b24-4a03-9002-ded93f5697a3	virement	35350.00	266338.00	230988.00	FCFA	Transfert bancaire	f2182e94-c5d0-4b91-8d12-af97e101dd6b	2025-09-28 03:49:40	2025-10-23 12:37:00
82b778eb-a930-478f-9ad3-6cbd025bba8d	d3ba6f50-5b24-4a03-9002-ded93f5697a3	depot	29610.00	266338.00	295948.00	FCFA	Virement bancaire entrant	\N	2025-08-25 16:31:33	2025-10-23 12:37:00
33ef0ddd-9719-487e-b1de-d0d80b27a5ea	d3ba6f50-5b24-4a03-9002-ded93f5697a3	retrait	2725.00	266338.00	263613.00	FCFA	Paiement par carte	\N	2025-05-30 12:40:26	2025-10-23 12:37:01
6c5eb5dd-b80c-4810-8a67-3232e937d7f6	d3ba6f50-5b24-4a03-9002-ded93f5697a3	retrait	46860.00	266338.00	219478.00	FCFA	Retrait guichet	\N	2025-06-29 18:13:40	2025-10-23 12:37:01
1e02e265-6557-4199-ae15-4b191d8f2877	d3ba6f50-5b24-4a03-9002-ded93f5697a3	virement	40000.00	266338.00	226338.00	FCFA	Transfert entre comptes	db289a68-fb56-4357-aa96-60bcaab5608f	2025-09-21 00:32:57	2025-10-23 12:37:01
fb64080a-cb4e-412c-bb8c-0e124c279a30	d3ba6f50-5b24-4a03-9002-ded93f5697a3	virement	1069.00	266338.00	265269.00	FCFA	Transfert bancaire	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	2025-05-01 11:08:36	2025-10-23 12:37:01
5f68a1d9-2fff-44c4-baab-5d76d6dff9fe	d3ba6f50-5b24-4a03-9002-ded93f5697a3	depot	37206.00	266338.00	303544.00	FCFA	Versement salaire	\N	2025-09-08 23:01:34	2025-10-23 12:37:01
73c17525-842e-4b99-9e90-53db8c070216	d3ba6f50-5b24-4a03-9002-ded93f5697a3	depot	31684.00	266338.00	298022.00	FCFA	Virement bancaire entrant	\N	2025-04-23 12:55:34	2025-10-23 12:37:01
2123a812-b79a-4615-b70b-3a34c8b67829	d3ba6f50-5b24-4a03-9002-ded93f5697a3	virement	24890.00	266338.00	241448.00	FCFA	Paiement facture	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	2025-05-28 14:36:12	2025-10-23 12:37:01
a44fb5da-cc5b-45fb-a530-402cce912866	d3ba6f50-5b24-4a03-9002-ded93f5697a3	retrait	4755.00	266338.00	261583.00	FCFA	Paiement par carte	\N	2025-10-12 22:57:48	2025-10-23 12:37:01
2c170701-28a7-4bf9-81f1-c2235e9eba94	d3ba6f50-5b24-4a03-9002-ded93f5697a3	retrait	40762.00	266338.00	225576.00	FCFA	Retrait d'espèces	\N	2025-04-28 00:57:02	2025-10-23 12:37:01
6bd948ff-938c-41fc-a80a-60c94f15d5c8	d3ba6f50-5b24-4a03-9002-ded93f5697a3	depot	30601.00	266338.00	296939.00	FCFA	Dépôt espèces guichet	\N	2025-07-26 22:44:39	2025-10-23 12:37:01
9320289b-9d7d-40a1-8674-15e7b82c6e20	d3ba6f50-5b24-4a03-9002-ded93f5697a3	retrait	40495.00	266338.00	225843.00	FCFA	Paiement par carte	\N	2025-10-16 15:24:49	2025-10-23 12:37:01
2310e2f2-c942-48e7-a800-376fc58856b6	6a3575bc-ab64-4315-8ed7-124955e9c44f	depot	42363.00	348093.00	390456.00	FCFA	Dépôt espèces guichet	\N	2025-07-24 01:52:48	2025-10-23 12:37:01
877ed71c-b63e-45c6-a7f7-58e17c750c31	6a3575bc-ab64-4315-8ed7-124955e9c44f	depot	12275.00	348093.00	360368.00	FCFA	Dépôt chèque	\N	2025-05-30 01:49:36	2025-10-23 12:37:01
4032367c-755b-43e6-bf07-8aa582f84d6f	6a3575bc-ab64-4315-8ed7-124955e9c44f	depot	16056.00	348093.00	364149.00	FCFA	Dépôt chèque	\N	2025-06-08 09:01:41	2025-10-23 12:37:01
ee02e64c-4d99-4d18-be22-b1990cee67b5	6a3575bc-ab64-4315-8ed7-124955e9c44f	virement	27370.00	348093.00	320723.00	FCFA	Virement salaire	0b052b84-a33e-44e8-90f7-d9d1bfe27464	2025-07-07 18:28:59	2025-10-23 12:37:01
315cab08-2860-4213-86d4-dea8caa6eba3	6a3575bc-ab64-4315-8ed7-124955e9c44f	depot	19820.00	348093.00	367913.00	FCFA	Versement salaire	\N	2025-05-23 13:24:27	2025-10-23 12:37:01
9dff1185-db1b-447e-8517-5786a5d283d1	6a3575bc-ab64-4315-8ed7-124955e9c44f	depot	42206.00	348093.00	390299.00	FCFA	Versement salaire	\N	2025-04-29 22:07:22	2025-10-23 12:37:01
bca42b9c-9173-4619-b1f1-9e443084c636	6a3575bc-ab64-4315-8ed7-124955e9c44f	depot	34671.00	348093.00	382764.00	FCFA	Dépôt espèces guichet	\N	2025-07-14 18:25:41	2025-10-23 12:37:01
198cf22e-34bf-4145-9c52-56b2ef222774	6a3575bc-ab64-4315-8ed7-124955e9c44f	virement	12210.00	348093.00	335883.00	FCFA	Virement salaire	2f53ae60-3c7c-4dee-a02c-cad51068f96c	2025-10-02 15:45:36	2025-10-23 12:37:01
725c76cd-6f0c-4c83-8e39-8295bac4a6e0	6a3575bc-ab64-4315-8ed7-124955e9c44f	retrait	25498.00	348093.00	322595.00	FCFA	Retrait DAB	\N	2025-08-22 22:37:00	2025-10-23 12:37:01
8810c2a9-95d0-4962-8124-bc84b83055fb	6a3575bc-ab64-4315-8ed7-124955e9c44f	retrait	18897.00	348093.00	329196.00	FCFA	Retrait guichet	\N	2025-06-04 01:17:13	2025-10-23 12:37:01
082e93b2-7824-4a94-859a-9f2e6912c697	6a3575bc-ab64-4315-8ed7-124955e9c44f	depot	33297.00	348093.00	381390.00	FCFA	Dépôt espèces guichet	\N	2025-07-29 04:11:31	2025-10-23 12:37:01
a9323447-31c8-4a6d-8f6e-2b70abb71d0c	6a3575bc-ab64-4315-8ed7-124955e9c44f	virement	15451.00	348093.00	332642.00	FCFA	Paiement facture	94b4fef5-88d3-4b9a-98c9-1e0c6c697c0a	2025-06-13 20:48:45	2025-10-23 12:37:01
e13e48fc-2328-419b-afb7-ad288bfe9fad	6a3575bc-ab64-4315-8ed7-124955e9c44f	virement	34775.00	348093.00	313318.00	FCFA	Transfert bancaire	8d706bac-d7d8-4172-8d94-d1a8cdf604db	2025-10-01 07:33:20	2025-10-23 12:37:01
eeaa69bd-65f7-46bc-83c7-79bbba912a94	6a3575bc-ab64-4315-8ed7-124955e9c44f	depot	18171.00	348093.00	366264.00	FCFA	Virement bancaire entrant	\N	2025-09-03 14:03:25	2025-10-23 12:37:01
9dc1758f-cb2c-46b9-8114-26abecff5665	6a3575bc-ab64-4315-8ed7-124955e9c44f	virement	31225.00	348093.00	316868.00	FCFA	Transfert entre comptes	1eece79a-3f27-456a-8f76-0b4de6cba5e4	2025-07-02 21:09:29	2025-10-23 12:37:01
0d31b930-1c00-4e99-aaf8-cc4045360753	318d8033-6a1d-4dd6-a669-005de93483d3	retrait	21263.00	255138.00	233875.00	FCFA	Retrait d'espèces	\N	2025-08-13 13:15:05	2025-10-23 12:37:01
1c311c48-906c-47ec-8828-f718570d2adf	318d8033-6a1d-4dd6-a669-005de93483d3	depot	24626.00	255138.00	279764.00	FCFA	Virement bancaire entrant	\N	2025-07-10 12:43:44	2025-10-23 12:37:01
f6c3aaf7-b37b-488e-8699-e7640dc229ad	318d8033-6a1d-4dd6-a669-005de93483d3	retrait	11400.00	255138.00	243738.00	FCFA	Paiement par carte	\N	2025-07-11 17:04:52	2025-10-23 12:37:01
9b621be8-af43-4b4c-96b7-f85263e5e526	318d8033-6a1d-4dd6-a669-005de93483d3	virement	41897.00	255138.00	213241.00	FCFA	Paiement facture	65da4070-27f5-40a7-99d9-db64e3163a65	2025-08-05 23:54:02	2025-10-23 12:37:01
b23bb0b6-ccb9-49b0-87c0-bd139fc4c83a	318d8033-6a1d-4dd6-a669-005de93483d3	virement	14878.00	255138.00	240260.00	FCFA	Transfert entre comptes	d2a1ed80-e126-493f-b155-2923909ae924	2025-05-23 23:57:51	2025-10-23 12:37:01
c207ddd4-25ef-4fb7-8deb-c0d357a6d67b	318d8033-6a1d-4dd6-a669-005de93483d3	virement	41384.00	255138.00	213754.00	FCFA	Virement vers compte	e88eac49-5c57-48f8-824a-813a7da0fdc3	2025-08-29 17:54:03	2025-10-23 12:37:01
6f37ab55-d3fa-41a4-affd-71eecfedcdcc	9987f93d-ac57-4bee-aff6-41c16aebe2b4	depot	10399.00	229065.00	239464.00	FCFA	Dépôt chèque	\N	2025-05-02 14:18:05	2025-10-23 12:37:01
e83c650e-8ea3-4afe-8195-827e61f3ef6b	9987f93d-ac57-4bee-aff6-41c16aebe2b4	depot	15774.00	229065.00	244839.00	FCFA	Dépôt espèces guichet	\N	2025-06-30 22:41:17	2025-10-23 12:37:01
60f16e39-b080-4a9c-8c3b-19c7937571a7	9987f93d-ac57-4bee-aff6-41c16aebe2b4	depot	47698.00	229065.00	276763.00	FCFA	Dépôt espèces guichet	\N	2025-06-17 16:51:40	2025-10-23 12:37:01
0c3d6678-a4a7-4e0b-b9ef-1ede1440aa4a	9987f93d-ac57-4bee-aff6-41c16aebe2b4	virement	23432.00	229065.00	205633.00	FCFA	Paiement facture	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	2025-07-15 21:05:17	2025-10-23 12:37:01
7f41dc39-d56d-4207-8701-9a0363646f3e	9987f93d-ac57-4bee-aff6-41c16aebe2b4	retrait	33831.00	229065.00	195234.00	FCFA	Retrait DAB	\N	2025-05-29 04:37:35	2025-10-23 12:37:01
a757afb0-ca86-44f1-a2ec-094f5600d6c8	9987f93d-ac57-4bee-aff6-41c16aebe2b4	depot	35575.00	229065.00	264640.00	FCFA	Dépôt espèces guichet	\N	2025-09-13 18:10:18	2025-10-23 12:37:01
d410a7dd-4c54-428b-9a3b-4d8b77cdce14	9987f93d-ac57-4bee-aff6-41c16aebe2b4	virement	38746.00	229065.00	190319.00	FCFA	Transfert bancaire	7d62dcaf-92f9-4c85-8582-67c5e1abdfc7	2025-09-27 23:46:48	2025-10-23 12:37:01
05a0e872-6bf3-426d-bc1e-5f14922a1114	9987f93d-ac57-4bee-aff6-41c16aebe2b4	retrait	40873.00	229065.00	188192.00	FCFA	Retrait d'espèces	\N	2025-10-07 08:36:03	2025-10-23 12:37:01
5a70b4a1-5bb6-470d-8081-e4d7722660e1	9987f93d-ac57-4bee-aff6-41c16aebe2b4	retrait	8329.00	229065.00	220736.00	FCFA	Paiement par carte	\N	2025-06-07 00:33:34	2025-10-23 12:37:01
13357e18-b1c3-466e-a98b-1d9f60490d81	9987f93d-ac57-4bee-aff6-41c16aebe2b4	virement	20742.00	229065.00	208323.00	FCFA	Transfert bancaire	57a5b070-a40d-45d9-b0ee-ba32f96383a6	2025-09-18 03:13:34	2025-10-23 12:37:01
905938c2-a06f-473c-a41b-56bcfb1f1f20	9987f93d-ac57-4bee-aff6-41c16aebe2b4	retrait	39370.00	229065.00	189695.00	FCFA	Retrait d'espèces	\N	2025-10-03 05:08:29	2025-10-23 12:37:01
42968fd7-4ef4-43b9-9068-6645b6e76bc8	9987f93d-ac57-4bee-aff6-41c16aebe2b4	virement	25864.00	229065.00	203201.00	FCFA	Paiement facture	2eab81ba-c2de-4108-9a0e-7ca81af2697c	2025-04-27 13:00:59	2025-10-23 12:37:01
7120e64b-c23d-40c8-b4f8-4d0c3013c957	9987f93d-ac57-4bee-aff6-41c16aebe2b4	depot	29156.00	229065.00	258221.00	FCFA	Dépôt espèces guichet	\N	2025-10-02 04:55:57	2025-10-23 12:37:01
84a94535-ef97-4d9b-b436-ca7c00253561	9987f93d-ac57-4bee-aff6-41c16aebe2b4	retrait	7587.00	229065.00	221478.00	FCFA	Paiement par carte	\N	2025-09-28 14:40:16	2025-10-23 12:37:01
b03fec84-e185-44fb-b77c-7750184a3ec7	849dcfa8-90dd-4efb-befe-4a819d763b77	retrait	7371.00	21302.00	13931.00	FCFA	Prélèvement automatique	\N	2025-10-10 23:41:53	2025-10-23 12:37:01
61a95cb2-18f9-4095-a75e-d086587ffb30	849dcfa8-90dd-4efb-befe-4a819d763b77	virement	7450.00	21302.00	13852.00	FCFA	Virement salaire	318d8033-6a1d-4dd6-a669-005de93483d3	2025-09-29 10:56:35	2025-10-23 12:37:01
abce04b1-7c9a-4fdc-9567-2fbccb876274	849dcfa8-90dd-4efb-befe-4a819d763b77	depot	3701.00	21302.00	25003.00	FCFA	Versement salaire	\N	2025-05-26 23:26:26	2025-10-23 12:37:01
120f3fa5-7501-4a59-9569-41f786814275	849dcfa8-90dd-4efb-befe-4a819d763b77	retrait	38872.00	21302.00	0.00	FCFA	Paiement par carte	\N	2025-05-16 18:48:16	2025-10-23 12:37:01
83df84e8-d9de-4fee-9dee-33bf59b865aa	849dcfa8-90dd-4efb-befe-4a819d763b77	retrait	22292.00	21302.00	0.00	FCFA	Retrait d'espèces	\N	2025-05-21 15:58:00	2025-10-23 12:37:01
54234862-8e85-4c33-ba72-1609d31d7a06	849dcfa8-90dd-4efb-befe-4a819d763b77	retrait	15387.00	21302.00	5915.00	FCFA	Retrait DAB	\N	2025-10-10 10:43:13	2025-10-23 12:37:01
050c88bc-0220-472a-8b8a-cb108cac492a	849dcfa8-90dd-4efb-befe-4a819d763b77	retrait	9609.00	21302.00	11693.00	FCFA	Retrait DAB	\N	2025-08-19 07:35:47	2025-10-23 12:37:01
22ef2d20-df02-4021-86d7-4fff70622833	849dcfa8-90dd-4efb-befe-4a819d763b77	retrait	18625.00	21302.00	2677.00	FCFA	Retrait d'espèces	\N	2025-08-27 15:42:49	2025-10-23 12:37:01
036cd241-2c05-41ad-bb6c-1846eac4689e	849dcfa8-90dd-4efb-befe-4a819d763b77	retrait	24862.00	21302.00	0.00	FCFA	Retrait DAB	\N	2025-07-30 22:49:27	2025-10-23 12:37:01
212ceb39-5e4d-477e-b096-fc293a36e14a	849dcfa8-90dd-4efb-befe-4a819d763b77	depot	7557.00	21302.00	28859.00	FCFA	Versement salaire	\N	2025-09-20 19:31:27	2025-10-23 12:37:01
8fc42139-a078-4334-b3c1-fef61209fcf4	849dcfa8-90dd-4efb-befe-4a819d763b77	retrait	36088.00	21302.00	0.00	FCFA	Retrait d'espèces	\N	2025-04-24 07:32:02	2025-10-23 12:37:01
3bef5337-b901-4a8b-9dca-98abddef8fc6	849dcfa8-90dd-4efb-befe-4a819d763b77	virement	6816.00	21302.00	14486.00	FCFA	Virement vers compte	34b84e17-27b4-4080-a77b-3cdb00476a06	2025-06-10 22:48:09	2025-10-23 12:37:01
5b2d9cf2-eff5-4e38-9c14-c1a3a02ce5a8	4497726b-2732-4f82-ac92-17bdbf1dbca5	depot	42223.00	79632.00	121855.00	FCFA	Versement salaire	\N	2025-08-01 06:04:12	2025-10-23 12:37:01
06939e4d-14d8-458e-8f17-4da5539ab39c	4497726b-2732-4f82-ac92-17bdbf1dbca5	retrait	23319.00	79632.00	56313.00	FCFA	Retrait guichet	\N	2025-04-24 17:34:23	2025-10-23 12:37:01
54438cce-0f70-45fe-b7a3-cff3ef7f7353	4497726b-2732-4f82-ac92-17bdbf1dbca5	retrait	24127.00	79632.00	55505.00	FCFA	Prélèvement automatique	\N	2025-06-15 21:13:34	2025-10-23 12:37:01
ed1000c7-2fe5-4546-b358-cc285e1ea554	4497726b-2732-4f82-ac92-17bdbf1dbca5	depot	21041.00	79632.00	100673.00	FCFA	Dépôt d'espèces	\N	2025-05-15 16:15:59	2025-10-23 12:37:01
68a3c376-37ca-4a6a-a972-1d274169ec55	4497726b-2732-4f82-ac92-17bdbf1dbca5	virement	26207.00	79632.00	53425.00	FCFA	Transfert entre comptes	6c92b373-c286-44a2-94a3-cf8cf3479100	2025-10-04 14:37:52	2025-10-23 12:37:01
9402a1dd-aa6f-4f33-b9f5-e08a0366cfd3	4497726b-2732-4f82-ac92-17bdbf1dbca5	depot	28319.00	79632.00	107951.00	FCFA	Dépôt d'espèces	\N	2025-05-31 19:53:15	2025-10-23 12:37:01
c71d7284-3e64-4f4d-9a4c-4763586cf57a	4497726b-2732-4f82-ac92-17bdbf1dbca5	virement	19192.00	79632.00	60440.00	FCFA	Virement salaire	6b052865-a885-4b74-94d3-9838eadb0208	2025-10-05 09:48:51	2025-10-23 12:37:01
20ec347a-6074-482b-afbb-c74dc701efa6	4497726b-2732-4f82-ac92-17bdbf1dbca5	retrait	32899.00	79632.00	46733.00	FCFA	Prélèvement automatique	\N	2025-10-06 04:01:13	2025-10-23 12:37:01
581a306e-bb6e-4e8d-a21a-3cfab2f29330	4497726b-2732-4f82-ac92-17bdbf1dbca5	retrait	5923.00	79632.00	73709.00	FCFA	Retrait guichet	\N	2025-09-09 07:31:54	2025-10-23 12:37:01
5f4cc51b-8f27-4902-9da1-c8f5611a8d27	4497726b-2732-4f82-ac92-17bdbf1dbca5	virement	5651.00	79632.00	73981.00	FCFA	Transfert entre comptes	916bbfef-cee4-457b-a001-da8e5b0be63d	2025-06-22 14:43:20	2025-10-23 12:37:01
6ac964b2-220c-4c55-9287-04075fb00f61	4497726b-2732-4f82-ac92-17bdbf1dbca5	retrait	46713.00	79632.00	32919.00	FCFA	Retrait d'espèces	\N	2025-05-31 23:23:30	2025-10-23 12:37:01
8e73016b-1d24-4212-bccc-c61555d017bb	4497726b-2732-4f82-ac92-17bdbf1dbca5	retrait	28783.00	79632.00	50849.00	FCFA	Retrait d'espèces	\N	2025-04-28 11:12:23	2025-10-23 12:37:01
1d06b176-a924-4aa2-9b1e-fa7731d49636	4497726b-2732-4f82-ac92-17bdbf1dbca5	retrait	17418.00	79632.00	62214.00	FCFA	Retrait d'espèces	\N	2025-05-22 05:58:46	2025-10-23 12:37:01
77c5dcb4-1866-4201-92b3-bc85cac9d8a6	4497726b-2732-4f82-ac92-17bdbf1dbca5	virement	42749.00	79632.00	36883.00	FCFA	Paiement facture	232f5785-5fd1-4398-91e2-4f92589e1d8d	2025-10-09 19:17:50	2025-10-23 12:37:01
e35e4f25-1e85-439b-b723-b736757f163c	4497726b-2732-4f82-ac92-17bdbf1dbca5	depot	34825.00	79632.00	114457.00	FCFA	Versement salaire	\N	2025-07-27 22:30:10	2025-10-23 12:37:01
1e2e649b-277b-4eb8-af45-dba28e61e002	9cd12202-7a97-4ff8-907d-67b3f104c6b6	virement	28878.00	428457.00	399579.00	FCFA	Virement vers compte	a0123386-5767-4f9f-b457-e0613e9f8725	2025-09-08 02:02:45	2025-10-23 12:37:01
77873b16-51f4-4564-8cee-54cde0a525c3	9cd12202-7a97-4ff8-907d-67b3f104c6b6	virement	6598.00	428457.00	421859.00	FCFA	Virement vers compte	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	2025-06-04 15:41:51	2025-10-23 12:37:01
a3300c71-5fa7-41d3-9718-df2392327acc	9cd12202-7a97-4ff8-907d-67b3f104c6b6	retrait	38311.00	428457.00	390146.00	FCFA	Retrait DAB	\N	2025-05-05 08:16:58	2025-10-23 12:37:01
03cb1f20-f8b2-4c52-9cd7-72795a88d0bb	9cd12202-7a97-4ff8-907d-67b3f104c6b6	depot	42303.00	428457.00	470760.00	FCFA	Virement bancaire entrant	\N	2025-05-08 16:23:56	2025-10-23 12:37:01
8d9b367c-5348-4205-bab7-27a033fa28db	9cd12202-7a97-4ff8-907d-67b3f104c6b6	retrait	36454.00	428457.00	392003.00	FCFA	Retrait d'espèces	\N	2025-10-17 04:52:28	2025-10-23 12:37:01
1fc251b9-7018-4e3c-86cd-57c6aa946cf0	9cd12202-7a97-4ff8-907d-67b3f104c6b6	depot	23635.00	428457.00	452092.00	FCFA	Virement bancaire entrant	\N	2025-06-09 00:19:54	2025-10-23 12:37:01
6413f113-4196-4bdb-9569-739a88373bcb	9cd12202-7a97-4ff8-907d-67b3f104c6b6	virement	34065.00	428457.00	394392.00	FCFA	Transfert entre comptes	65a4491c-ce37-4732-aa4f-0de79bc822d1	2025-10-23 03:43:48	2025-10-23 12:37:01
dfbaa079-f166-4add-82be-27f6e5d425f3	9cd12202-7a97-4ff8-907d-67b3f104c6b6	depot	8195.00	428457.00	436652.00	FCFA	Dépôt espèces guichet	\N	2025-05-08 05:18:04	2025-10-23 12:37:01
1db509ce-cd66-4c19-b7cf-7aa0564a5b2b	9cd12202-7a97-4ff8-907d-67b3f104c6b6	virement	43949.00	428457.00	384508.00	FCFA	Virement vers compte	4bc9a980-1950-4ed8-9b41-bbb0a53a929c	2025-07-15 12:47:29	2025-10-23 12:37:01
e78617a0-49ee-4519-bde5-291edbbf0015	9cd12202-7a97-4ff8-907d-67b3f104c6b6	virement	20894.00	428457.00	407563.00	FCFA	Transfert bancaire	9c0923b4-0a14-4650-8df8-edf426310de6	2025-09-03 10:13:31	2025-10-23 12:37:01
354e6690-a7d8-4f99-90dd-2ec029fa33af	9cd12202-7a97-4ff8-907d-67b3f104c6b6	retrait	14714.00	428457.00	413743.00	FCFA	Prélèvement automatique	\N	2025-08-24 21:43:24	2025-10-23 12:37:01
29c547db-4e0d-46a8-91d2-79dc2884b5c0	9cd12202-7a97-4ff8-907d-67b3f104c6b6	virement	45314.00	428457.00	383143.00	FCFA	Transfert bancaire	79fa87c8-8658-4ac8-a54a-53ff2fe252cf	2025-08-31 05:56:25	2025-10-23 12:37:01
71d86dc9-27bc-424c-9472-56ad75df72bb	9cd12202-7a97-4ff8-907d-67b3f104c6b6	depot	1055.00	428457.00	429512.00	FCFA	Dépôt espèces guichet	\N	2025-06-09 11:42:15	2025-10-23 12:37:01
cb15e760-f475-44d7-8373-767341e3e7fd	9cd12202-7a97-4ff8-907d-67b3f104c6b6	virement	5843.00	428457.00	422614.00	FCFA	Transfert entre comptes	f959068a-63bd-46ee-a42c-59d124c48cf6	2025-06-06 06:08:41	2025-10-23 12:37:01
bc50edc7-7eef-462d-b526-fc453d60fee4	9cd12202-7a97-4ff8-907d-67b3f104c6b6	retrait	27827.00	428457.00	400630.00	FCFA	Paiement par carte	\N	2025-05-25 00:04:49	2025-10-23 12:37:01
b5868a67-44d2-4bfb-acad-a5e49346c5c7	2eab81ba-c2de-4108-9a0e-7ca81af2697c	virement	28288.00	297800.00	269512.00	FCFA	Virement salaire	4e0954f5-1956-40db-b392-7a6ee455c257	2025-05-14 13:41:42	2025-10-23 12:37:01
78a02020-2b5f-42b9-b07b-195aee4dc8dc	2eab81ba-c2de-4108-9a0e-7ca81af2697c	virement	47547.00	297800.00	250253.00	FCFA	Virement salaire	add2482a-de00-41d8-a772-cd4ef6546baa	2025-09-18 09:17:28	2025-10-23 12:37:01
718d99a0-03b5-4d7f-8239-061e4141320d	2eab81ba-c2de-4108-9a0e-7ca81af2697c	depot	14290.00	297800.00	312090.00	FCFA	Dépôt chèque	\N	2025-08-04 18:39:19	2025-10-23 12:37:01
c09f10a5-f76b-4cbc-891d-73d0ea787103	2eab81ba-c2de-4108-9a0e-7ca81af2697c	virement	14282.00	297800.00	283518.00	FCFA	Paiement facture	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	2025-08-10 19:14:33	2025-10-23 12:37:01
ae779e3c-5d05-4006-8311-117c9b7c073c	2eab81ba-c2de-4108-9a0e-7ca81af2697c	depot	49384.00	297800.00	347184.00	FCFA	Dépôt d'espèces	\N	2025-09-12 15:23:57	2025-10-23 12:37:01
91dc9645-8695-4721-9fc0-9593815b7064	2eab81ba-c2de-4108-9a0e-7ca81af2697c	virement	15925.00	297800.00	281875.00	FCFA	Paiement facture	146ccb9b-b2be-4ae4-b58b-21c739bfe95c	2025-06-30 16:56:24	2025-10-23 12:37:01
cb681b99-ae76-4a75-83c2-e474ebb1be7e	2eab81ba-c2de-4108-9a0e-7ca81af2697c	virement	25998.00	297800.00	271802.00	FCFA	Transfert entre comptes	4bf8b802-4714-4aba-a825-d61404c9d50f	2025-06-27 18:18:46	2025-10-23 12:37:01
80ea89be-0bb1-4efe-83a1-30131543f411	2eab81ba-c2de-4108-9a0e-7ca81af2697c	virement	6739.00	297800.00	291061.00	FCFA	Virement vers compte	6b052865-a885-4b74-94d3-9838eadb0208	2025-10-08 22:25:06	2025-10-23 12:37:01
4ac94a59-3be4-4f11-a93c-5c79b232a2eb	2eab81ba-c2de-4108-9a0e-7ca81af2697c	virement	38550.00	297800.00	259250.00	FCFA	Transfert entre comptes	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	2025-08-09 06:15:11	2025-10-23 12:37:01
496744ff-ce6e-4e0a-a52a-48c006fdfb11	2eab81ba-c2de-4108-9a0e-7ca81af2697c	retrait	10569.00	297800.00	287231.00	FCFA	Paiement par carte	\N	2025-08-31 00:25:07	2025-10-23 12:37:01
94269b68-64aa-473a-af43-418c46236be9	2eab81ba-c2de-4108-9a0e-7ca81af2697c	depot	45218.00	297800.00	343018.00	FCFA	Dépôt chèque	\N	2025-05-28 01:12:44	2025-10-23 12:37:01
ffd63d3d-be8d-40ac-97a0-383b8d33f3bd	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	virement	40298.00	135818.00	95520.00	FCFA	Transfert entre comptes	03991212-82d0-40f8-aade-bd7a07550872	2025-08-22 22:43:44	2025-10-23 12:37:01
57dfe8b1-2ee8-4a6c-8537-976c98b92c99	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	virement	18038.00	135818.00	117780.00	FCFA	Paiement facture	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	2025-04-30 08:57:18	2025-10-23 12:37:01
35d29bae-2101-41a9-aa77-8cc6d9f82a15	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	retrait	5819.00	135818.00	129999.00	FCFA	Retrait guichet	\N	2025-06-02 22:32:28	2025-10-23 12:37:01
4161dc09-79b0-4aec-88fe-6a4d8a4efb4d	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	retrait	41515.00	135818.00	94303.00	FCFA	Retrait DAB	\N	2025-06-17 06:17:05	2025-10-23 12:37:01
9f51a1a6-b11d-4ad0-a127-3ebefa80ef5a	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	retrait	15303.00	135818.00	120515.00	FCFA	Retrait guichet	\N	2025-08-19 08:45:06	2025-10-23 12:37:01
c84901a9-3192-4f9c-aa87-a2953e8d8f1e	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	virement	35059.00	135818.00	100759.00	FCFA	Virement salaire	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	2025-10-23 01:43:46	2025-10-23 12:37:01
1751d5c2-ff3e-43fb-8bcd-7f5f42b85247	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	virement	16409.00	135818.00	119409.00	FCFA	Virement salaire	2f53ae60-3c7c-4dee-a02c-cad51068f96c	2025-09-19 18:35:49	2025-10-23 12:37:01
f59b2155-c1eb-4f09-9e80-e947c1b3b156	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	depot	31621.00	135818.00	167439.00	FCFA	Versement salaire	\N	2025-08-22 00:00:03	2025-10-23 12:37:01
b064e925-e065-4b9c-88a0-08c1e1e0dcec	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	virement	42992.00	135818.00	92826.00	FCFA	Transfert bancaire	9987f93d-ac57-4bee-aff6-41c16aebe2b4	2025-05-21 17:57:21	2025-10-23 12:37:01
0b8aa64f-bba4-46d9-8dfc-ddaef5797bce	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	retrait	7769.00	135818.00	128049.00	FCFA	Retrait DAB	\N	2025-08-04 02:56:18	2025-10-23 12:37:01
a8b20519-52cc-4e4c-ae46-414f1735b558	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	retrait	5215.00	135818.00	130603.00	FCFA	Retrait DAB	\N	2025-09-23 04:24:05	2025-10-23 12:37:01
ec254836-dd7a-48e0-8988-b97e290c281f	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	retrait	8997.00	135818.00	126821.00	FCFA	Retrait guichet	\N	2025-08-23 04:10:11	2025-10-23 12:37:01
42cde294-adb5-40f9-bf30-5e63747bdd47	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	depot	8690.00	135818.00	144508.00	FCFA	Dépôt espèces guichet	\N	2025-10-17 11:50:14	2025-10-23 12:37:01
509fbc65-818b-4dc5-9ad6-531f46945cf7	4f6a44a5-082b-4a67-a0b7-3eae9da2d045	retrait	49174.00	353232.00	304058.00	FCFA	Prélèvement automatique	\N	2025-06-17 13:04:47	2025-10-23 12:37:01
6380f1f2-e729-4e44-86ed-0835fac39889	4f6a44a5-082b-4a67-a0b7-3eae9da2d045	virement	27378.00	353232.00	325854.00	FCFA	Virement salaire	2afce742-17e9-45bc-99be-9389a26da3ca	2025-07-15 15:44:48	2025-10-23 12:37:01
c8022452-95ca-4feb-85e6-79cb0bbdbee0	4f6a44a5-082b-4a67-a0b7-3eae9da2d045	retrait	9151.00	353232.00	344081.00	FCFA	Paiement par carte	\N	2025-09-01 07:00:07	2025-10-23 12:37:01
deeee031-745a-4b45-b76f-319823094820	4f6a44a5-082b-4a67-a0b7-3eae9da2d045	depot	48690.00	353232.00	401922.00	FCFA	Dépôt chèque	\N	2025-07-23 12:32:39	2025-10-23 12:37:01
8983f228-9b30-41cd-8045-54590295b8e6	4f6a44a5-082b-4a67-a0b7-3eae9da2d045	virement	23914.00	353232.00	329318.00	FCFA	Virement salaire	7bd3be9f-34e2-4eeb-9f78-a68c083c1a96	2025-05-10 21:11:18	2025-10-23 12:37:01
f792c381-b82b-4c09-a198-9a732ffe773d	4f6a44a5-082b-4a67-a0b7-3eae9da2d045	virement	37824.00	353232.00	315408.00	FCFA	Virement salaire	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	2025-08-09 13:19:13	2025-10-23 12:37:01
aa9a24d3-e1e5-43a0-a260-992ffcac1b98	4f6a44a5-082b-4a67-a0b7-3eae9da2d045	depot	40376.00	353232.00	393608.00	FCFA	Dépôt espèces guichet	\N	2025-07-06 11:54:35	2025-10-23 12:37:01
1d8cf741-80eb-41d8-a669-a2bde21ba576	4f6a44a5-082b-4a67-a0b7-3eae9da2d045	depot	33426.00	353232.00	386658.00	FCFA	Dépôt chèque	\N	2025-09-20 19:25:07	2025-10-23 12:37:01
4db1c9af-e4a0-4312-a402-79dad8b3f448	4f6a44a5-082b-4a67-a0b7-3eae9da2d045	virement	17016.00	353232.00	336216.00	FCFA	Virement vers compte	f1e6f840-61c7-4618-bbfd-578d06a2431f	2025-05-14 04:28:28	2025-10-23 12:37:01
41fc7b11-5ff7-437a-b774-318bd7e5daca	4f6a44a5-082b-4a67-a0b7-3eae9da2d045	depot	9473.00	353232.00	362705.00	FCFA	Dépôt espèces guichet	\N	2025-10-16 07:09:58	2025-10-23 12:37:01
fecef3a7-1446-489b-b19e-00dfba98d17b	4f6a44a5-082b-4a67-a0b7-3eae9da2d045	retrait	23427.00	353232.00	329805.00	FCFA	Paiement par carte	\N	2025-09-29 11:29:20	2025-10-23 12:37:01
d28e84e3-5e36-4ef2-b53a-c7d5cd152233	3535c846-b093-454b-9743-84b4b3fa9719	retrait	30701.00	43498.00	12797.00	FCFA	Paiement par carte	\N	2025-06-29 05:39:55	2025-10-23 12:37:01
8d2756ac-e917-428d-a0bc-c99d298dd21d	3535c846-b093-454b-9743-84b4b3fa9719	virement	45682.00	43498.00	0.00	FCFA	Virement vers compte	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	2025-08-28 20:34:17	2025-10-23 12:37:01
38af766b-c278-46f8-941e-03e4f53b2e43	3535c846-b093-454b-9743-84b4b3fa9719	virement	14196.00	43498.00	29302.00	FCFA	Transfert bancaire	dbcd0804-e931-4453-9ad5-f978ceebb511	2025-06-27 18:15:12	2025-10-23 12:37:01
7627c19b-8444-453f-b8d4-be8f584a1daa	3535c846-b093-454b-9743-84b4b3fa9719	retrait	36983.00	43498.00	6515.00	FCFA	Prélèvement automatique	\N	2025-06-30 07:27:21	2025-10-23 12:37:01
22be7007-4de5-4df1-b043-bb85abee7a18	3535c846-b093-454b-9743-84b4b3fa9719	retrait	48951.00	43498.00	0.00	FCFA	Retrait DAB	\N	2025-07-28 02:50:52	2025-10-23 12:37:01
5f662851-4283-40d7-966e-cff470c2a538	3535c846-b093-454b-9743-84b4b3fa9719	retrait	30553.00	43498.00	12945.00	FCFA	Paiement par carte	\N	2025-09-30 05:00:47	2025-10-23 12:37:01
e74c3430-9592-40ca-8721-1c7e47d4e513	3535c846-b093-454b-9743-84b4b3fa9719	virement	12691.00	43498.00	30807.00	FCFA	Virement vers compte	d3ba6f50-5b24-4a03-9002-ded93f5697a3	2025-05-23 17:39:47	2025-10-23 12:37:01
eeb62d44-e7b1-4c2b-8df3-a1779c769d71	3535c846-b093-454b-9743-84b4b3fa9719	depot	32663.00	43498.00	76161.00	FCFA	Dépôt d'espèces	\N	2025-07-23 09:58:04	2025-10-23 12:37:01
6e1277f0-d814-4102-9892-74cd5fe9ea57	3535c846-b093-454b-9743-84b4b3fa9719	retrait	40132.00	43498.00	3366.00	FCFA	Paiement par carte	\N	2025-06-10 06:43:30	2025-10-23 12:37:01
fc85aef9-ea3d-4cfd-9aec-2e1dcb9c7b47	94b14a72-e4f3-4e5f-ae72-8e6f72e4e901	retrait	37915.00	115452.00	77537.00	FCFA	Retrait d'espèces	\N	2025-06-26 08:34:54	2025-10-23 12:37:01
ce5f56fa-9da4-426b-be7d-4a6dface073c	94b14a72-e4f3-4e5f-ae72-8e6f72e4e901	retrait	13011.00	115452.00	102441.00	FCFA	Retrait guichet	\N	2025-05-29 18:48:31	2025-10-23 12:37:01
7a0cf623-c672-4c8b-9ae8-09cdbf100cc3	94b14a72-e4f3-4e5f-ae72-8e6f72e4e901	depot	12239.00	115452.00	127691.00	FCFA	Virement bancaire entrant	\N	2025-06-10 00:47:29	2025-10-23 12:37:01
0460c979-f67c-4af7-b60e-0780e631713d	94b14a72-e4f3-4e5f-ae72-8e6f72e4e901	depot	31416.00	115452.00	146868.00	FCFA	Dépôt chèque	\N	2025-08-30 01:21:11	2025-10-23 12:37:01
56555814-f484-4fce-ab8d-9dc8d05312ac	94b14a72-e4f3-4e5f-ae72-8e6f72e4e901	depot	15692.00	115452.00	131144.00	FCFA	Dépôt espèces guichet	\N	2025-07-17 19:55:03	2025-10-23 12:37:01
f7f5b4d0-cc8c-494d-a6bd-e63fec057990	94b14a72-e4f3-4e5f-ae72-8e6f72e4e901	depot	21699.00	115452.00	137151.00	FCFA	Virement bancaire entrant	\N	2025-06-28 09:13:45	2025-10-23 12:37:01
e5b2c711-831c-4056-aad8-5b4b86ed8505	94b14a72-e4f3-4e5f-ae72-8e6f72e4e901	retrait	8216.00	115452.00	107236.00	FCFA	Retrait guichet	\N	2025-08-14 17:38:48	2025-10-23 12:37:01
8e4cf314-694e-4a56-af66-070a21812c44	94b14a72-e4f3-4e5f-ae72-8e6f72e4e901	virement	18179.00	115452.00	97273.00	FCFA	Transfert bancaire	79f54c28-5af3-42a0-b025-afd541eb8dbf	2025-08-13 09:03:24	2025-10-23 12:37:01
9fec0e85-7783-4231-913c-948d9b4a1057	e7088ab6-655b-4317-8cdf-46d3de12e2f0	virement	6629.00	467657.00	461028.00	FCFA	Virement vers compte	37da1638-f10a-4a03-9eb4-9eb960273866	2025-07-27 01:08:55	2025-10-23 12:37:01
3d807686-fc97-4a9b-a793-aa640c1483c9	e7088ab6-655b-4317-8cdf-46d3de12e2f0	virement	20900.00	467657.00	446757.00	FCFA	Virement vers compte	f2182e94-c5d0-4b91-8d12-af97e101dd6b	2025-06-08 00:48:33	2025-10-23 12:37:01
22aeff5b-3ae8-4848-8cd0-0b7badbaf744	e7088ab6-655b-4317-8cdf-46d3de12e2f0	retrait	1437.00	467657.00	466220.00	FCFA	Retrait guichet	\N	2025-05-13 01:49:09	2025-10-23 12:37:01
e2918a4d-618b-4c7f-918e-22536ed50d3c	e7088ab6-655b-4317-8cdf-46d3de12e2f0	depot	40428.00	467657.00	508085.00	FCFA	Dépôt d'espèces	\N	2025-08-13 05:24:40	2025-10-23 12:37:01
6f9db0d7-42d5-4272-bcdc-5ef52e4128df	e7088ab6-655b-4317-8cdf-46d3de12e2f0	virement	33642.00	467657.00	434015.00	FCFA	Paiement facture	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	2025-09-02 22:09:39	2025-10-23 12:37:01
537b4bbc-1265-4962-9d48-a45436eed678	e7088ab6-655b-4317-8cdf-46d3de12e2f0	virement	26552.00	467657.00	441105.00	FCFA	Virement salaire	cf267d38-1c95-41a9-8ff2-12e53b0a2bdb	2025-10-17 22:44:23	2025-10-23 12:37:01
1875e8e8-8423-4379-8460-fb39ff4a5896	e7088ab6-655b-4317-8cdf-46d3de12e2f0	retrait	8584.00	467657.00	459073.00	FCFA	Paiement par carte	\N	2025-07-14 11:22:39	2025-10-23 12:37:01
e6b043ac-315f-4b35-b9e3-f69cc414912f	e7088ab6-655b-4317-8cdf-46d3de12e2f0	virement	25337.00	467657.00	442320.00	FCFA	Virement vers compte	8cc906e8-f49e-48bf-97f7-063a96dd5855	2025-10-17 10:57:12	2025-10-23 12:37:01
f13cf3b2-53e9-4401-9188-834a73c350ce	e7088ab6-655b-4317-8cdf-46d3de12e2f0	virement	4563.00	467657.00	463094.00	FCFA	Transfert entre comptes	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	2025-09-24 01:56:03	2025-10-23 12:37:01
a3607bac-cfbc-47d4-bf84-db7a2561f8f7	e7088ab6-655b-4317-8cdf-46d3de12e2f0	virement	19951.00	467657.00	447706.00	FCFA	Transfert bancaire	ce352024-ef0a-4c59-a717-07fa503a38dc	2025-08-18 14:30:09	2025-10-23 12:37:01
436c39de-999d-4771-902b-f50d59e23f3b	41e95b7c-81f4-4383-8e18-448d1ab5bd48	depot	8713.00	130370.00	139083.00	FCFA	Virement bancaire entrant	\N	2025-04-30 18:07:32	2025-10-23 12:37:01
3eb0ec25-210d-4735-8412-b7f527814261	41e95b7c-81f4-4383-8e18-448d1ab5bd48	retrait	46843.00	130370.00	83527.00	FCFA	Paiement par carte	\N	2025-06-07 15:20:46	2025-10-23 12:37:01
52d1ac15-3411-4352-b29d-97299a59f54f	41e95b7c-81f4-4383-8e18-448d1ab5bd48	virement	44738.00	130370.00	85632.00	FCFA	Transfert entre comptes	0f731b08-109a-4e89-972b-71f8608c0c55	2025-05-02 04:51:11	2025-10-23 12:37:01
636ab8c0-9d99-483e-bd25-5b60b8786ff3	41e95b7c-81f4-4383-8e18-448d1ab5bd48	virement	20826.00	130370.00	109544.00	FCFA	Transfert bancaire	2afce742-17e9-45bc-99be-9389a26da3ca	2025-04-29 00:48:10	2025-10-23 12:37:01
7217cc99-8621-4d56-81a0-82634235f65f	41e95b7c-81f4-4383-8e18-448d1ab5bd48	retrait	48777.00	130370.00	81593.00	FCFA	Paiement par carte	\N	2025-05-06 07:21:13	2025-10-23 12:37:01
b70379fe-652b-4174-8cf5-0c6a632fb158	41e95b7c-81f4-4383-8e18-448d1ab5bd48	depot	33157.00	130370.00	163527.00	FCFA	Virement bancaire entrant	\N	2025-09-03 13:46:41	2025-10-23 12:37:01
93f3ac3c-f160-4777-8a6b-d7ceac325852	41e95b7c-81f4-4383-8e18-448d1ab5bd48	retrait	4927.00	130370.00	125443.00	FCFA	Prélèvement automatique	\N	2025-07-07 10:33:55	2025-10-23 12:37:01
657c3c9a-44df-4d9d-93f3-6d6c16d6aae0	41e95b7c-81f4-4383-8e18-448d1ab5bd48	retrait	24808.00	130370.00	105562.00	FCFA	Retrait d'espèces	\N	2025-04-26 19:20:13	2025-10-23 12:37:01
aa38b94e-5354-42b0-8285-9627f5af95e1	41e95b7c-81f4-4383-8e18-448d1ab5bd48	virement	26062.00	130370.00	104308.00	FCFA	Virement vers compte	e5fbfcb0-c796-4371-80c6-f78f1038a282	2025-09-11 21:27:27	2025-10-23 12:37:01
5b4f43e6-4abc-47a9-aa96-559dcdda2cc6	41e95b7c-81f4-4383-8e18-448d1ab5bd48	retrait	43125.00	130370.00	87245.00	FCFA	Prélèvement automatique	\N	2025-05-26 06:18:22	2025-10-23 12:37:01
b3799efb-d99c-4a43-8d4b-e42af43d9825	22398797-8a57-4530-b835-7193f3b0fca0	depot	46909.00	215798.00	262707.00	FCFA	Versement salaire	\N	2025-05-24 23:08:42	2025-10-23 12:37:01
c8983a45-2ab2-4d51-b4d6-89e311c45712	22398797-8a57-4530-b835-7193f3b0fca0	retrait	21754.00	215798.00	194044.00	FCFA	Retrait d'espèces	\N	2025-05-08 06:43:59	2025-10-23 12:37:01
2d1b3767-daec-4f9c-9986-39c86a6e8fe2	22398797-8a57-4530-b835-7193f3b0fca0	retrait	6569.00	215798.00	209229.00	FCFA	Retrait d'espèces	\N	2025-09-05 07:21:11	2025-10-23 12:37:01
9029c9cd-bf0c-48d3-8a96-27e6125df6a6	22398797-8a57-4530-b835-7193f3b0fca0	retrait	23015.00	215798.00	192783.00	FCFA	Prélèvement automatique	\N	2025-06-17 09:51:21	2025-10-23 12:37:01
1318b603-c2c0-4c55-8983-036cd44ea7ef	22398797-8a57-4530-b835-7193f3b0fca0	retrait	11329.00	215798.00	204469.00	FCFA	Retrait d'espèces	\N	2025-09-28 10:59:17	2025-10-23 12:37:01
385e8e80-7176-4c42-bb2e-4bda127c5a70	22398797-8a57-4530-b835-7193f3b0fca0	retrait	28604.00	215798.00	187194.00	FCFA	Paiement par carte	\N	2025-06-09 21:24:33	2025-10-23 12:37:01
38914f54-d218-4b79-b65a-4d5064dc4b18	22398797-8a57-4530-b835-7193f3b0fca0	virement	5201.00	215798.00	210597.00	FCFA	Virement salaire	37da1638-f10a-4a03-9eb4-9eb960273866	2025-05-06 14:57:22	2025-10-23 12:37:01
54221199-b6dd-44e4-b516-f718588850c3	22398797-8a57-4530-b835-7193f3b0fca0	virement	26287.00	215798.00	189511.00	FCFA	Virement salaire	a90e1a63-43fd-4956-af04-b3458780ca97	2025-08-06 07:30:15	2025-10-23 12:37:01
96901fc6-7b59-4e1d-beba-0544851af835	22398797-8a57-4530-b835-7193f3b0fca0	retrait	11785.00	215798.00	204013.00	FCFA	Paiement par carte	\N	2025-07-06 15:36:49	2025-10-23 12:37:01
b3e36288-23d2-4575-8929-12290823db8b	22398797-8a57-4530-b835-7193f3b0fca0	virement	18406.00	215798.00	197392.00	FCFA	Transfert entre comptes	12a1bcc9-6ded-4708-8db3-3ebeb5632e08	2025-08-25 06:21:50	2025-10-23 12:37:01
a73fa0be-b641-4b8b-88ca-51a54c7b966b	22398797-8a57-4530-b835-7193f3b0fca0	depot	31024.00	215798.00	246822.00	FCFA	Virement bancaire entrant	\N	2025-07-19 02:57:12	2025-10-23 12:37:01
4618af78-000c-4119-8bb6-d8cb1245e321	22398797-8a57-4530-b835-7193f3b0fca0	retrait	23672.00	215798.00	192126.00	FCFA	Retrait d'espèces	\N	2025-08-29 18:05:48	2025-10-23 12:37:01
4d7f0bb4-164f-4297-a169-236611f51752	22398797-8a57-4530-b835-7193f3b0fca0	virement	17263.00	215798.00	198535.00	FCFA	Virement vers compte	0b7246d3-cd3d-4162-952a-709242caabaf	2025-09-20 09:18:20	2025-10-23 12:37:01
9ef5149e-f2a9-465c-8617-9d907a5304c2	22398797-8a57-4530-b835-7193f3b0fca0	retrait	6859.00	215798.00	208939.00	FCFA	Retrait DAB	\N	2025-08-17 14:04:48	2025-10-23 12:37:01
32ad84ac-6402-432a-bf46-d8cddf32ffca	22398797-8a57-4530-b835-7193f3b0fca0	virement	49500.00	215798.00	166298.00	FCFA	Virement salaire	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	2025-06-13 07:25:31	2025-10-23 12:37:01
5a782a7d-8456-46a9-9cc4-f1d54da6f72d	afffc156-c61b-4b68-9c62-2a3812714585	virement	38834.00	340814.00	301980.00	FCFA	Paiement facture	3badd48d-41cc-4d4c-abfa-55dd1b3e0c1e	2025-08-05 21:02:00	2025-10-23 12:37:01
f2aa8bbf-a778-4936-a872-3e50b3c27600	afffc156-c61b-4b68-9c62-2a3812714585	depot	45416.00	340814.00	386230.00	FCFA	Versement salaire	\N	2025-09-08 19:21:04	2025-10-23 12:37:01
99b05a89-7d5c-4bd4-a935-84423af03529	afffc156-c61b-4b68-9c62-2a3812714585	retrait	25755.00	340814.00	315059.00	FCFA	Retrait d'espèces	\N	2025-06-12 16:52:34	2025-10-23 12:37:01
2ebe93c1-5d39-4227-a413-8fa79d034a12	afffc156-c61b-4b68-9c62-2a3812714585	virement	14038.00	340814.00	326776.00	FCFA	Paiement facture	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	2025-04-25 17:03:26	2025-10-23 12:37:01
769c87b9-81c5-4ae0-9530-6157b09600d8	afffc156-c61b-4b68-9c62-2a3812714585	retrait	14626.00	340814.00	326188.00	FCFA	Paiement par carte	\N	2025-07-04 22:31:48	2025-10-23 12:37:01
64c9f78a-4962-416c-be03-021877c262f1	afffc156-c61b-4b68-9c62-2a3812714585	retrait	35217.00	340814.00	305597.00	FCFA	Paiement par carte	\N	2025-09-13 09:01:18	2025-10-23 12:37:01
1c05e914-9d99-4f8a-b6bd-c3a1132eaf01	afffc156-c61b-4b68-9c62-2a3812714585	retrait	44840.00	340814.00	295974.00	FCFA	Retrait DAB	\N	2025-07-11 22:50:59	2025-10-23 12:37:01
113db845-0849-44ce-8ba2-c2d0404b08c9	afffc156-c61b-4b68-9c62-2a3812714585	depot	5391.00	340814.00	346205.00	FCFA	Versement salaire	\N	2025-09-23 03:40:34	2025-10-23 12:37:01
3733a31e-08ba-4b01-bf33-d731ac804d24	afffc156-c61b-4b68-9c62-2a3812714585	retrait	19150.00	340814.00	321664.00	FCFA	Prélèvement automatique	\N	2025-06-08 06:38:28	2025-10-23 12:37:01
53d07598-2dea-4b7d-8ee2-9f9812f7bb19	afffc156-c61b-4b68-9c62-2a3812714585	virement	43738.00	340814.00	297076.00	FCFA	Paiement facture	ac532c01-37b7-44d5-bc6e-148843aaf375	2025-05-17 10:56:36	2025-10-23 12:37:01
c79772af-2f35-4335-986f-b0f03580acf8	afffc156-c61b-4b68-9c62-2a3812714585	retrait	42727.00	340814.00	298087.00	FCFA	Retrait d'espèces	\N	2025-06-06 07:02:09	2025-10-23 12:37:01
2aee681f-904e-49f7-907d-a7a4c396ecaa	afffc156-c61b-4b68-9c62-2a3812714585	retrait	7416.00	340814.00	333398.00	FCFA	Prélèvement automatique	\N	2025-07-01 02:37:36	2025-10-23 12:37:01
e8e29a1a-7bcb-48bd-940d-108dd1ae8d0f	afffc156-c61b-4b68-9c62-2a3812714585	retrait	32700.00	340814.00	308114.00	FCFA	Paiement par carte	\N	2025-10-06 20:42:38	2025-10-23 12:37:01
7a0fcedd-c77e-414b-b945-b758bbd2b4b0	c7cca6e7-9120-40e6-b0a2-2d86941c73f5	depot	29986.00	84715.00	114701.00	FCFA	Versement salaire	\N	2025-10-15 12:49:27	2025-10-23 12:37:01
7dd851c2-231e-4c31-bf80-f2c15e77d8dd	c7cca6e7-9120-40e6-b0a2-2d86941c73f5	depot	22775.00	84715.00	107490.00	FCFA	Dépôt d'espèces	\N	2025-04-24 00:23:48	2025-10-23 12:37:01
fbed3015-87d7-451e-9cf0-79b6a632f115	c7cca6e7-9120-40e6-b0a2-2d86941c73f5	retrait	19243.00	84715.00	65472.00	FCFA	Retrait DAB	\N	2025-07-23 09:02:20	2025-10-23 12:37:01
1ee1f4db-eeb7-491f-b996-42ced8a7435d	c7cca6e7-9120-40e6-b0a2-2d86941c73f5	depot	43104.00	84715.00	127819.00	FCFA	Dépôt d'espèces	\N	2025-06-10 18:50:34	2025-10-23 12:37:01
c0abe8b4-bd53-4452-ac04-71b2a1341cdd	c7cca6e7-9120-40e6-b0a2-2d86941c73f5	retrait	2304.00	84715.00	82411.00	FCFA	Retrait DAB	\N	2025-09-20 07:48:24	2025-10-23 12:37:01
c39e23d9-89a9-41f3-a9bf-deab6a583cca	c7cca6e7-9120-40e6-b0a2-2d86941c73f5	depot	9971.00	84715.00	94686.00	FCFA	Virement bancaire entrant	\N	2025-07-13 12:25:00	2025-10-23 12:37:01
815c349e-e696-426e-8758-e7b15562fcd9	c7cca6e7-9120-40e6-b0a2-2d86941c73f5	virement	46140.00	84715.00	38575.00	FCFA	Paiement facture	d2a1ed80-e126-493f-b155-2923909ae924	2025-06-19 13:47:37	2025-10-23 12:37:01
2870aa7e-52d4-47eb-bc00-f3c0e61f39da	c7cca6e7-9120-40e6-b0a2-2d86941c73f5	virement	49598.00	84715.00	35117.00	FCFA	Transfert entre comptes	65da4070-27f5-40a7-99d9-db64e3163a65	2025-10-06 14:15:27	2025-10-23 12:37:01
27f69390-b592-4a02-b941-b801cd7ff8a6	c7cca6e7-9120-40e6-b0a2-2d86941c73f5	retrait	22322.00	84715.00	62393.00	FCFA	Prélèvement automatique	\N	2025-06-10 19:13:12	2025-10-23 12:37:01
d4ed2ede-d5db-4043-b6f9-c3609e92bf3f	c7cca6e7-9120-40e6-b0a2-2d86941c73f5	depot	41982.00	84715.00	126697.00	FCFA	Versement salaire	\N	2025-10-23 00:19:45	2025-10-23 12:37:01
ed7c425a-c14d-48da-98e5-a0f123f13c07	c7cca6e7-9120-40e6-b0a2-2d86941c73f5	depot	37317.00	84715.00	122032.00	FCFA	Dépôt espèces guichet	\N	2025-06-09 04:13:34	2025-10-23 12:37:01
a68897e5-e874-4aa0-acf1-82ee926130dd	0f731b08-109a-4e89-972b-71f8608c0c55	depot	42479.00	358106.00	400585.00	FCFA	Dépôt chèque	\N	2025-08-22 17:50:43	2025-10-23 12:37:01
0c6ccac2-21da-428e-a48a-8d6126bbff25	0f731b08-109a-4e89-972b-71f8608c0c55	retrait	42357.00	358106.00	315749.00	FCFA	Prélèvement automatique	\N	2025-05-13 03:53:54	2025-10-23 12:37:01
7838ce10-4ff1-46ac-b67c-005c5ba5ad00	0f731b08-109a-4e89-972b-71f8608c0c55	depot	20207.00	358106.00	378313.00	FCFA	Virement bancaire entrant	\N	2025-04-24 23:03:12	2025-10-23 12:37:01
77f97815-8e28-43d9-acf6-170b77c0d04d	0f731b08-109a-4e89-972b-71f8608c0c55	depot	14305.00	358106.00	372411.00	FCFA	Virement bancaire entrant	\N	2025-06-01 05:49:34	2025-10-23 12:37:01
50574f9b-0d2b-4c5c-8d73-718746700e5b	0f731b08-109a-4e89-972b-71f8608c0c55	virement	37602.00	358106.00	320504.00	FCFA	Transfert bancaire	61bcb7e8-d7d1-45da-9b25-70fba627d304	2025-10-05 15:32:28	2025-10-23 12:37:01
d0b31dde-f730-470e-8bd3-703bc527c619	0f731b08-109a-4e89-972b-71f8608c0c55	virement	49120.00	358106.00	308986.00	FCFA	Paiement facture	03991212-82d0-40f8-aade-bd7a07550872	2025-05-09 00:19:56	2025-10-23 12:37:01
bdad1f85-5ea2-4eef-a28c-66647d9f5dd8	0f731b08-109a-4e89-972b-71f8608c0c55	virement	11065.00	358106.00	347041.00	FCFA	Paiement facture	ce34889a-7b15-48e8-9003-f1522cf517f8	2025-08-04 22:06:00	2025-10-23 12:37:01
475bf8d8-b228-4472-afa0-6669c392e244	0f731b08-109a-4e89-972b-71f8608c0c55	depot	14224.00	358106.00	372330.00	FCFA	Dépôt d'espèces	\N	2025-09-15 02:16:26	2025-10-23 12:37:01
e75b6cc0-5efb-403c-85e6-683be8fa33da	0f731b08-109a-4e89-972b-71f8608c0c55	retrait	9570.00	358106.00	348536.00	FCFA	Retrait d'espèces	\N	2025-08-12 11:20:29	2025-10-23 12:37:01
8d55b91d-555a-4c12-84ea-ea6e8e2bf05a	0f731b08-109a-4e89-972b-71f8608c0c55	virement	39805.00	358106.00	318301.00	FCFA	Virement salaire	0b7246d3-cd3d-4162-952a-709242caabaf	2025-05-27 19:19:09	2025-10-23 12:37:01
c00f37fd-7914-49aa-97f2-2b63f39c9b6e	0f731b08-109a-4e89-972b-71f8608c0c55	depot	1769.00	358106.00	359875.00	FCFA	Dépôt espèces guichet	\N	2025-07-28 06:16:40	2025-10-23 12:37:01
6efe721c-fd86-462d-9242-e5e76262e696	0f731b08-109a-4e89-972b-71f8608c0c55	virement	7813.00	358106.00	350293.00	FCFA	Transfert bancaire	0c099b4c-0616-44d6-af7a-38ed712edbf0	2025-07-24 03:10:53	2025-10-23 12:37:01
a6b457c4-4cf2-4593-bdf4-91975ce1c423	76b21c81-8380-4df8-87ad-4f2fa9ff5159	retrait	38756.00	246027.00	207271.00	FCFA	Retrait d'espèces	\N	2025-08-13 07:58:49	2025-10-23 12:37:01
f3216673-4315-4dcf-b4ef-cadc11f0fb5b	76b21c81-8380-4df8-87ad-4f2fa9ff5159	depot	5742.00	246027.00	251769.00	FCFA	Dépôt chèque	\N	2025-08-05 09:23:54	2025-10-23 12:37:01
e6aa301f-2555-4187-ba14-3416073f05b3	76b21c81-8380-4df8-87ad-4f2fa9ff5159	virement	32172.00	246027.00	213855.00	FCFA	Transfert bancaire	61bcb7e8-d7d1-45da-9b25-70fba627d304	2025-06-05 20:01:29	2025-10-23 12:37:01
157b27b8-79c3-406c-be95-3544db4e9672	76b21c81-8380-4df8-87ad-4f2fa9ff5159	depot	11014.00	246027.00	257041.00	FCFA	Dépôt d'espèces	\N	2025-07-17 20:54:43	2025-10-23 12:37:01
0d770b4d-8355-4a0d-bad2-f45c70a758b1	76b21c81-8380-4df8-87ad-4f2fa9ff5159	virement	4175.00	246027.00	241852.00	FCFA	Virement salaire	0b7246d3-cd3d-4162-952a-709242caabaf	2025-09-03 17:26:02	2025-10-23 12:37:01
2b85931a-dcd3-486f-81dc-cd0320ce4d71	76b21c81-8380-4df8-87ad-4f2fa9ff5159	virement	12541.00	246027.00	233486.00	FCFA	Paiement facture	2bdeac76-dcb7-4710-9060-e9ca98012722	2025-05-02 20:49:49	2025-10-23 12:37:01
92a9681e-427e-445e-87aa-ab95b78becf4	76b21c81-8380-4df8-87ad-4f2fa9ff5159	virement	46152.00	246027.00	199875.00	FCFA	Transfert bancaire	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	2025-06-22 03:58:30	2025-10-23 12:37:01
690124af-5a24-4f5d-870d-cd34ac2ae524	76b21c81-8380-4df8-87ad-4f2fa9ff5159	depot	25958.00	246027.00	271985.00	FCFA	Dépôt espèces guichet	\N	2025-06-23 20:41:04	2025-10-23 12:37:01
3df8a082-3732-479f-8e82-43c146974132	76b21c81-8380-4df8-87ad-4f2fa9ff5159	retrait	17177.00	246027.00	228850.00	FCFA	Paiement par carte	\N	2025-10-18 18:50:54	2025-10-23 12:37:01
ccd5a989-b8be-4d2c-87c3-509f9ecdf5f0	76b21c81-8380-4df8-87ad-4f2fa9ff5159	depot	31389.00	246027.00	277416.00	FCFA	Versement salaire	\N	2025-05-04 13:42:35	2025-10-23 12:37:01
6ef02263-5ee3-42a5-9a2d-c8fdedf5543a	887e3007-f4a2-4b73-aee8-c70039319c5f	retrait	30525.00	166144.00	135619.00	FCFA	Retrait DAB	\N	2025-07-27 21:36:34	2025-10-23 12:37:02
a192ec07-f344-4a5f-916c-13214065a390	e4d1caea-baee-4c55-aa8d-8208a299a3f7	retrait	24815.00	462242.00	437427.00	FCFA	Prélèvement automatique	\N	2025-08-12 22:41:47	2025-10-23 12:37:01
d4c2ea88-603e-4ad6-84ab-38353e8bd254	e4d1caea-baee-4c55-aa8d-8208a299a3f7	depot	30978.00	462242.00	493220.00	FCFA	Virement bancaire entrant	\N	2025-07-02 05:08:22	2025-10-23 12:37:01
84ea25db-ac0b-496b-a2d8-f39ddb7d945d	e4d1caea-baee-4c55-aa8d-8208a299a3f7	retrait	24884.00	462242.00	437358.00	FCFA	Paiement par carte	\N	2025-05-16 23:28:08	2025-10-23 12:37:01
5cbf7481-e8bb-416a-9b6a-e9fae3937823	e4d1caea-baee-4c55-aa8d-8208a299a3f7	retrait	15840.00	462242.00	446402.00	FCFA	Retrait d'espèces	\N	2025-06-07 07:23:37	2025-10-23 12:37:01
23c4f60e-36d9-4519-800f-e89270f91326	e4d1caea-baee-4c55-aa8d-8208a299a3f7	retrait	1087.00	462242.00	461155.00	FCFA	Retrait guichet	\N	2025-08-22 00:30:41	2025-10-23 12:37:01
90dba407-9919-4813-8e22-92307721abe4	bc779c73-ecf7-44f0-9794-281f495b5ff5	virement	41626.00	447105.00	405479.00	FCFA	Transfert bancaire	727ed0a8-67ac-4066-84fe-a29a0e13bb30	2025-08-08 01:19:18	2025-10-23 12:37:01
6f396335-2135-4325-adf6-b05704a043a4	bc779c73-ecf7-44f0-9794-281f495b5ff5	retrait	36731.00	447105.00	410374.00	FCFA	Retrait d'espèces	\N	2025-08-08 04:10:40	2025-10-23 12:37:01
004b19fd-48d3-4a3c-bec1-755288cf6bcc	bc779c73-ecf7-44f0-9794-281f495b5ff5	depot	46366.00	447105.00	493471.00	FCFA	Dépôt d'espèces	\N	2025-06-10 03:25:48	2025-10-23 12:37:01
c50d0204-1906-43b3-acad-d7061efb778f	bc779c73-ecf7-44f0-9794-281f495b5ff5	virement	9311.00	447105.00	437794.00	FCFA	Transfert bancaire	f3db8624-1334-47ff-83bb-04592844270f	2025-07-15 17:28:12	2025-10-23 12:37:01
76a4ee98-9543-40d6-883c-e1de8b2fd93f	bc779c73-ecf7-44f0-9794-281f495b5ff5	retrait	22111.00	447105.00	424994.00	FCFA	Prélèvement automatique	\N	2025-08-30 06:05:50	2025-10-23 12:37:01
9c546986-9edc-4c04-8462-d11bf89b107a	bc779c73-ecf7-44f0-9794-281f495b5ff5	depot	44172.00	447105.00	491277.00	FCFA	Dépôt chèque	\N	2025-09-27 03:47:01	2025-10-23 12:37:01
9ed7e86a-9c3c-4109-9442-6a8f8b003758	bc779c73-ecf7-44f0-9794-281f495b5ff5	depot	32158.00	447105.00	479263.00	FCFA	Versement salaire	\N	2025-06-16 14:34:17	2025-10-23 12:37:01
21a30c4d-8fae-4d75-adac-61ec2783b367	bc779c73-ecf7-44f0-9794-281f495b5ff5	virement	3990.00	447105.00	443115.00	FCFA	Paiement facture	c5b06daf-ba43-4954-b2b8-1065dfb122ab	2025-05-24 21:07:15	2025-10-23 12:37:01
6030d4f3-1109-4ca8-9d78-96edf5a6216b	bc779c73-ecf7-44f0-9794-281f495b5ff5	depot	2530.00	447105.00	449635.00	FCFA	Dépôt espèces guichet	\N	2025-07-03 01:02:34	2025-10-23 12:37:01
1812a07d-7a1b-47bc-a3cd-2a21eaaee018	bc779c73-ecf7-44f0-9794-281f495b5ff5	virement	37724.00	447105.00	409381.00	FCFA	Transfert entre comptes	e774b1e8-095f-4684-a770-c420e32f477a	2025-06-29 12:43:55	2025-10-23 12:37:01
82c42e91-c927-42f9-8397-62c4cbd04469	bc779c73-ecf7-44f0-9794-281f495b5ff5	retrait	8087.00	447105.00	439018.00	FCFA	Retrait guichet	\N	2025-09-30 00:23:12	2025-10-23 12:37:01
5e151226-8070-4dae-abd8-23facf508fbf	f1e6f840-61c7-4618-bbfd-578d06a2431f	retrait	13048.00	326480.00	313432.00	FCFA	Prélèvement automatique	\N	2025-04-25 02:38:36	2025-10-23 12:37:01
494b1bed-0f6c-444b-b12f-acbcc7285b0a	f1e6f840-61c7-4618-bbfd-578d06a2431f	retrait	40742.00	326480.00	285738.00	FCFA	Retrait guichet	\N	2025-06-26 23:07:07	2025-10-23 12:37:01
7ff6f5d4-6c28-4083-8468-f85d8eae759e	f1e6f840-61c7-4618-bbfd-578d06a2431f	depot	18050.00	326480.00	344530.00	FCFA	Versement salaire	\N	2025-06-26 22:48:58	2025-10-23 12:37:01
bff4c859-d1ff-45a4-a3e4-5907c38478ad	f1e6f840-61c7-4618-bbfd-578d06a2431f	virement	43013.00	326480.00	283467.00	FCFA	Virement vers compte	2f53ae60-3c7c-4dee-a02c-cad51068f96c	2025-05-22 11:26:05	2025-10-23 12:37:01
8d6b110d-60d9-429e-a9a3-d60a0c81241f	f1e6f840-61c7-4618-bbfd-578d06a2431f	depot	35337.00	326480.00	361817.00	FCFA	Versement salaire	\N	2025-07-04 23:42:54	2025-10-23 12:37:01
768b7371-2fec-44fa-ab65-40c067d5c489	f1e6f840-61c7-4618-bbfd-578d06a2431f	retrait	19175.00	326480.00	307305.00	FCFA	Retrait DAB	\N	2025-10-04 03:02:25	2025-10-23 12:37:01
a1a7d0be-e732-49d1-9f2f-5bb91bc54946	f1e6f840-61c7-4618-bbfd-578d06a2431f	virement	44156.00	326480.00	282324.00	FCFA	Virement vers compte	3badd48d-41cc-4d4c-abfa-55dd1b3e0c1e	2025-06-29 15:55:24	2025-10-23 12:37:01
a1701459-2924-4913-941b-8b7568e6fe26	f1e6f840-61c7-4618-bbfd-578d06a2431f	retrait	45727.00	326480.00	280753.00	FCFA	Prélèvement automatique	\N	2025-08-16 18:28:08	2025-10-23 12:37:01
e2ef61ec-8806-4840-aee8-fb15d98c2017	f1e6f840-61c7-4618-bbfd-578d06a2431f	virement	9015.00	326480.00	317465.00	FCFA	Virement salaire	31fb6207-f59e-425f-bf86-a1085c47b43f	2025-08-13 11:26:18	2025-10-23 12:37:01
5ae4f504-143c-4698-b951-893723158653	f1e6f840-61c7-4618-bbfd-578d06a2431f	depot	11613.00	326480.00	338093.00	FCFA	Dépôt d'espèces	\N	2025-05-22 21:25:28	2025-10-23 12:37:01
b9639c2f-0944-46ba-be6d-f1debe43893e	f1e6f840-61c7-4618-bbfd-578d06a2431f	depot	33719.00	326480.00	360199.00	FCFA	Versement salaire	\N	2025-06-16 03:35:14	2025-10-23 12:37:01
8a707b0d-3364-48f2-9d49-ba3edc3d8150	f1e6f840-61c7-4618-bbfd-578d06a2431f	depot	47845.00	326480.00	374325.00	FCFA	Dépôt chèque	\N	2025-05-04 18:36:46	2025-10-23 12:37:01
2d8b0234-037f-44d3-8e19-30479ad73f86	5097b2e2-ee3c-4043-944d-ba4167071409	retrait	13242.00	363609.00	350367.00	FCFA	Retrait d'espèces	\N	2025-04-30 09:57:25	2025-10-23 12:37:01
d6ba568f-b80b-42c2-b722-aec5d8b45554	5097b2e2-ee3c-4043-944d-ba4167071409	virement	39317.00	363609.00	324292.00	FCFA	Transfert bancaire	2b138895-6391-4bfe-b137-ca4fa7854a4a	2025-05-07 23:48:17	2025-10-23 12:37:01
e58624e2-6a0b-4a29-a991-bf0fe403bc70	5097b2e2-ee3c-4043-944d-ba4167071409	virement	1672.00	363609.00	361937.00	FCFA	Paiement facture	bc779c73-ecf7-44f0-9794-281f495b5ff5	2025-10-06 20:47:26	2025-10-23 12:37:01
68960e07-cbb6-46c3-b18f-bf0105ff191b	5097b2e2-ee3c-4043-944d-ba4167071409	depot	43264.00	363609.00	406873.00	FCFA	Versement salaire	\N	2025-10-09 03:44:47	2025-10-23 12:37:01
011cbd69-db89-4e3f-8fd1-573694d52602	5097b2e2-ee3c-4043-944d-ba4167071409	virement	16884.00	363609.00	346725.00	FCFA	Transfert entre comptes	61bcb7e8-d7d1-45da-9b25-70fba627d304	2025-07-04 07:14:04	2025-10-23 12:37:01
755998be-cb42-4d47-b592-0ce6b7ad19f6	5097b2e2-ee3c-4043-944d-ba4167071409	depot	35739.00	363609.00	399348.00	FCFA	Virement bancaire entrant	\N	2025-06-19 10:55:00	2025-10-23 12:37:01
cc76dc12-ac6b-407b-92c5-89354832b34d	5097b2e2-ee3c-4043-944d-ba4167071409	virement	20649.00	363609.00	342960.00	FCFA	Virement salaire	e5fbfcb0-c796-4371-80c6-f78f1038a282	2025-07-26 18:24:33	2025-10-23 12:37:01
21fe7f45-8e75-423d-b8aa-5c834e08c60a	5097b2e2-ee3c-4043-944d-ba4167071409	virement	24602.00	363609.00	339007.00	FCFA	Virement vers compte	b30db983-96ad-4f5c-a50c-1637c25f3b46	2025-06-12 04:14:33	2025-10-23 12:37:01
00d3faf6-2b79-43de-a755-b55b4a44e733	5097b2e2-ee3c-4043-944d-ba4167071409	depot	32041.00	363609.00	395650.00	FCFA	Dépôt chèque	\N	2025-09-10 09:44:58	2025-10-23 12:37:01
b6ef14aa-3699-405c-8f37-3614561609bb	5097b2e2-ee3c-4043-944d-ba4167071409	virement	27095.00	363609.00	336514.00	FCFA	Virement vers compte	64ee33cf-f4ed-4559-ab3c-48bccf04f75f	2025-09-19 01:35:01	2025-10-23 12:37:01
4182bbd3-d90d-486b-9789-034da2c5e909	5097b2e2-ee3c-4043-944d-ba4167071409	retrait	20215.00	363609.00	343394.00	FCFA	Retrait d'espèces	\N	2025-06-23 11:31:36	2025-10-23 12:37:01
dbf47c1a-5b3b-41de-a2b3-025294368803	5097b2e2-ee3c-4043-944d-ba4167071409	virement	7735.00	363609.00	355874.00	FCFA	Transfert entre comptes	5930a704-1cad-486a-bb5e-d5ebac8129b9	2025-09-20 21:34:41	2025-10-23 12:37:01
e88689d1-3980-4689-861b-3288c8f8c806	5097b2e2-ee3c-4043-944d-ba4167071409	depot	30858.00	363609.00	394467.00	FCFA	Dépôt chèque	\N	2025-08-31 08:19:34	2025-10-23 12:37:01
84615d5c-2eb6-4bfc-9688-8397cb4c652d	5097b2e2-ee3c-4043-944d-ba4167071409	virement	19770.00	363609.00	343839.00	FCFA	Paiement facture	4e96181f-e984-42f8-9787-a41a67c90aba	2025-08-29 12:14:45	2025-10-23 12:37:01
61c9e16e-3d62-4bff-95d8-1220ad96f7fa	3d77ab88-c4f1-4715-8657-5361aeb99a2c	virement	22618.00	400329.00	377711.00	FCFA	Virement salaire	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	2025-06-15 06:57:43	2025-10-23 12:37:01
8998be52-8a81-45fe-ae68-8d1c507b0b5e	3d77ab88-c4f1-4715-8657-5361aeb99a2c	virement	31950.00	400329.00	368379.00	FCFA	Transfert entre comptes	2afce742-17e9-45bc-99be-9389a26da3ca	2025-09-17 14:07:12	2025-10-23 12:37:01
1276bcce-d49f-4991-8d2a-1ba901ffa0ed	3d77ab88-c4f1-4715-8657-5361aeb99a2c	retrait	18165.00	400329.00	382164.00	FCFA	Paiement par carte	\N	2025-07-06 13:07:45	2025-10-23 12:37:01
33ee1fa3-dc76-4850-b70e-34f9af00a526	3d77ab88-c4f1-4715-8657-5361aeb99a2c	depot	39465.00	400329.00	439794.00	FCFA	Versement salaire	\N	2025-07-02 17:44:04	2025-10-23 12:37:01
89f4c327-cfa2-4f68-9101-e8f60c363c88	3d77ab88-c4f1-4715-8657-5361aeb99a2c	retrait	15848.00	400329.00	384481.00	FCFA	Paiement par carte	\N	2025-08-13 17:45:32	2025-10-23 12:37:01
bb245863-0015-432e-9947-d920f3a1a991	3d77ab88-c4f1-4715-8657-5361aeb99a2c	retrait	24922.00	400329.00	375407.00	FCFA	Retrait d'espèces	\N	2025-05-03 13:03:32	2025-10-23 12:37:01
558fefc8-e51a-4363-bb38-9eb5b2523537	3d77ab88-c4f1-4715-8657-5361aeb99a2c	retrait	49722.00	400329.00	350607.00	FCFA	Prélèvement automatique	\N	2025-09-11 23:58:10	2025-10-23 12:37:01
0d85e62f-4f45-4350-b27e-a20a86a4c5a9	ad629adb-377a-4725-9f12-556a170ef642	depot	28153.00	74072.00	102225.00	FCFA	Dépôt chèque	\N	2025-07-14 14:23:14	2025-10-23 12:37:01
47d25d85-4124-48b0-bddb-c3fcb67a2a55	ad629adb-377a-4725-9f12-556a170ef642	retrait	44650.00	74072.00	29422.00	FCFA	Prélèvement automatique	\N	2025-05-19 22:05:42	2025-10-23 12:37:01
fd9fbd7e-5eb9-44cd-9d29-5f585933e591	ad629adb-377a-4725-9f12-556a170ef642	depot	15280.00	74072.00	89352.00	FCFA	Dépôt espèces guichet	\N	2025-05-14 16:45:23	2025-10-23 12:37:01
4133344c-a18a-465b-bfc3-c2fcc830f5af	ad629adb-377a-4725-9f12-556a170ef642	virement	14867.00	74072.00	59205.00	FCFA	Paiement facture	3d77ab88-c4f1-4715-8657-5361aeb99a2c	2025-04-25 03:27:08	2025-10-23 12:37:01
314c2fef-3293-4417-83ef-bbd9aa63af17	ad629adb-377a-4725-9f12-556a170ef642	retrait	23524.00	74072.00	50548.00	FCFA	Retrait d'espèces	\N	2025-07-27 14:34:19	2025-10-23 12:37:01
985c446e-0bc2-4587-bd33-e8aafbc7076c	ad629adb-377a-4725-9f12-556a170ef642	virement	4857.00	74072.00	69215.00	FCFA	Transfert entre comptes	914d5be6-2dc2-4063-8219-1ea664a8b058	2025-07-03 06:05:09	2025-10-23 12:37:01
8693d766-d2ed-447e-87a5-a80a8d57a358	ad629adb-377a-4725-9f12-556a170ef642	retrait	37321.00	74072.00	36751.00	FCFA	Retrait DAB	\N	2025-08-24 19:19:57	2025-10-23 12:37:01
c87fb5f2-2c4c-4682-a3fa-661bb5ab5e0e	ad629adb-377a-4725-9f12-556a170ef642	retrait	34369.00	74072.00	39703.00	FCFA	Retrait DAB	\N	2025-07-17 08:58:51	2025-10-23 12:37:01
0fd3aa5e-cc08-4c87-bc07-043f7d7fccc7	ad629adb-377a-4725-9f12-556a170ef642	virement	35729.00	74072.00	38343.00	FCFA	Transfert bancaire	5930a704-1cad-486a-bb5e-d5ebac8129b9	2025-10-03 04:21:34	2025-10-23 12:37:01
dc6c382a-34dc-42da-aa18-3c415d6b7ddf	ad629adb-377a-4725-9f12-556a170ef642	depot	17847.00	74072.00	91919.00	FCFA	Virement bancaire entrant	\N	2025-09-05 20:47:55	2025-10-23 12:37:01
1bfe9455-9d36-47a7-9000-8afa7da77fb4	ad629adb-377a-4725-9f12-556a170ef642	depot	37764.00	74072.00	111836.00	FCFA	Dépôt espèces guichet	\N	2025-07-21 09:41:07	2025-10-23 12:37:01
a34ebf73-c77b-4d5e-bd33-54bed9ccabbe	ad629adb-377a-4725-9f12-556a170ef642	depot	38243.00	74072.00	112315.00	FCFA	Dépôt d'espèces	\N	2025-07-31 17:01:56	2025-10-23 12:37:01
6c802952-84ac-4828-a631-fa6ea3582b04	269d3156-3edd-4bda-99b1-a6cdf48bccdd	retrait	49765.00	138706.00	88941.00	FCFA	Retrait guichet	\N	2025-06-03 18:40:25	2025-10-23 12:37:01
48847c13-4a17-4393-b0b1-a989cbcf5c7f	269d3156-3edd-4bda-99b1-a6cdf48bccdd	virement	6246.00	138706.00	132460.00	FCFA	Virement salaire	6a9ff2e1-64a9-47b9-9bb5-f0c123187bfe	2025-07-30 02:46:12	2025-10-23 12:37:01
aadbfbe8-c6ce-4be6-b247-9dc1eaa17189	269d3156-3edd-4bda-99b1-a6cdf48bccdd	retrait	25490.00	138706.00	113216.00	FCFA	Retrait guichet	\N	2025-10-16 15:09:25	2025-10-23 12:37:01
bbe0e760-1941-47b7-b31b-f4536a2195b0	269d3156-3edd-4bda-99b1-a6cdf48bccdd	depot	36723.00	138706.00	175429.00	FCFA	Dépôt d'espèces	\N	2025-08-07 00:45:12	2025-10-23 12:37:01
0ac1a05c-aac5-4478-9872-f4b24239ab75	269d3156-3edd-4bda-99b1-a6cdf48bccdd	depot	30992.00	138706.00	169698.00	FCFA	Virement bancaire entrant	\N	2025-09-10 22:35:39	2025-10-23 12:37:01
5798348a-fac4-40ee-acc7-8c4aa0e58b0a	269d3156-3edd-4bda-99b1-a6cdf48bccdd	depot	41111.00	138706.00	179817.00	FCFA	Versement salaire	\N	2025-07-27 00:27:59	2025-10-23 12:37:01
401a9f47-1bde-42eb-aae5-d67fa032dac3	269d3156-3edd-4bda-99b1-a6cdf48bccdd	virement	13529.00	138706.00	125177.00	FCFA	Virement vers compte	edc37cd9-41c0-44ba-a8a4-f7da20914b48	2025-05-29 14:46:53	2025-10-23 12:37:01
448b85ed-2cc5-4bf7-a7d5-4a4b9dd09555	269d3156-3edd-4bda-99b1-a6cdf48bccdd	retrait	23487.00	138706.00	115219.00	FCFA	Retrait d'espèces	\N	2025-09-15 10:56:49	2025-10-23 12:37:01
4c383a24-6623-436b-bf88-16424f029f96	269d3156-3edd-4bda-99b1-a6cdf48bccdd	retrait	32102.00	138706.00	106604.00	FCFA	Prélèvement automatique	\N	2025-04-25 21:46:38	2025-10-23 12:37:01
068a4040-371a-4939-83f3-9bcb5ad6bf4d	269d3156-3edd-4bda-99b1-a6cdf48bccdd	depot	31798.00	138706.00	170504.00	FCFA	Versement salaire	\N	2025-05-15 15:51:48	2025-10-23 12:37:01
0e8c0786-0cbe-4e21-bdda-5d1717d760ae	269d3156-3edd-4bda-99b1-a6cdf48bccdd	depot	25787.00	138706.00	164493.00	FCFA	Dépôt espèces guichet	\N	2025-08-18 05:06:52	2025-10-23 12:37:01
0f1588e5-8896-4bd5-bc7b-8fe1d0f5b57b	269d3156-3edd-4bda-99b1-a6cdf48bccdd	retrait	33875.00	138706.00	104831.00	FCFA	Retrait DAB	\N	2025-08-08 18:52:03	2025-10-23 12:37:01
5324b429-e071-467b-95e0-1f9c7fee1b1e	e575ca40-926e-4fe2-9c4a-0af557a58c64	depot	28418.00	489745.00	518163.00	FCFA	Dépôt espèces guichet	\N	2025-06-06 06:40:12	2025-10-23 12:37:01
36f74907-094f-4229-9779-567566d2d6fa	e575ca40-926e-4fe2-9c4a-0af557a58c64	virement	19988.00	489745.00	469757.00	FCFA	Paiement facture	a5bad169-7741-4b82-9dde-4803bb629488	2025-08-07 00:21:58	2025-10-23 12:37:01
015e4762-6e4f-4bc7-bd94-4dd6dbe6d5aa	e575ca40-926e-4fe2-9c4a-0af557a58c64	depot	41612.00	489745.00	531357.00	FCFA	Dépôt espèces guichet	\N	2025-08-22 02:01:33	2025-10-23 12:37:01
d298584a-8b7c-4608-8413-9e520cf859ff	e575ca40-926e-4fe2-9c4a-0af557a58c64	retrait	8912.00	489745.00	480833.00	FCFA	Retrait d'espèces	\N	2025-06-19 12:51:12	2025-10-23 12:37:01
e3c53de3-1deb-496e-a3f3-2ae171eecc7c	e575ca40-926e-4fe2-9c4a-0af557a58c64	retrait	9164.00	489745.00	480581.00	FCFA	Retrait guichet	\N	2025-06-23 12:41:10	2025-10-23 12:37:01
6d7b5986-d7ac-43f2-b490-3d85c5a2f7c9	e575ca40-926e-4fe2-9c4a-0af557a58c64	retrait	18496.00	489745.00	471249.00	FCFA	Prélèvement automatique	\N	2025-08-05 00:41:59	2025-10-23 12:37:01
7317ab9b-a8f8-4001-bb37-57334b9a880c	e575ca40-926e-4fe2-9c4a-0af557a58c64	depot	15182.00	489745.00	504927.00	FCFA	Dépôt espèces guichet	\N	2025-09-16 10:48:09	2025-10-23 12:37:01
270afbda-bdfe-4339-af6e-0d79bae900e2	e575ca40-926e-4fe2-9c4a-0af557a58c64	retrait	9760.00	489745.00	479985.00	FCFA	Retrait d'espèces	\N	2025-09-21 07:41:12	2025-10-23 12:37:01
8e09474e-425f-434b-b320-fef7137eaf4e	e575ca40-926e-4fe2-9c4a-0af557a58c64	virement	31232.00	489745.00	458513.00	FCFA	Transfert bancaire	e4d1caea-baee-4c55-aa8d-8208a299a3f7	2025-08-03 09:17:15	2025-10-23 12:37:01
5b36f2c0-ac57-4db3-abcf-154a1e6f3f6b	e575ca40-926e-4fe2-9c4a-0af557a58c64	retrait	15209.00	489745.00	474536.00	FCFA	Paiement par carte	\N	2025-07-05 06:27:18	2025-10-23 12:37:01
985fbe3a-fad4-456b-b22f-6564811cb95b	e575ca40-926e-4fe2-9c4a-0af557a58c64	depot	10744.00	489745.00	500489.00	FCFA	Dépôt espèces guichet	\N	2025-04-29 20:26:54	2025-10-23 12:37:01
d74d7167-a171-4293-b0f2-0e9d7584d5a7	e575ca40-926e-4fe2-9c4a-0af557a58c64	virement	37200.00	489745.00	452545.00	FCFA	Paiement facture	9cd12202-7a97-4ff8-907d-67b3f104c6b6	2025-08-16 02:13:55	2025-10-23 12:37:01
6c7f387a-e9e4-4f89-a479-361382e182ad	808e915e-a5d8-4751-aaa8-50fe040cde68	virement	9467.00	476823.00	467356.00	FCFA	Virement salaire	e575ca40-926e-4fe2-9c4a-0af557a58c64	2025-06-20 17:17:03	2025-10-23 12:37:01
1c489880-6af6-463c-9669-be1916fd7a15	808e915e-a5d8-4751-aaa8-50fe040cde68	virement	27603.00	476823.00	449220.00	FCFA	Virement salaire	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	2025-08-10 11:35:06	2025-10-23 12:37:01
c765f4e3-bdee-4785-a064-4f171c695353	808e915e-a5d8-4751-aaa8-50fe040cde68	virement	4609.00	476823.00	472214.00	FCFA	Transfert bancaire	03991212-82d0-40f8-aade-bd7a07550872	2025-06-18 22:38:38	2025-10-23 12:37:01
61ca8dda-d138-4efd-b03e-1f02dc781e88	808e915e-a5d8-4751-aaa8-50fe040cde68	retrait	2559.00	476823.00	474264.00	FCFA	Paiement par carte	\N	2025-07-15 03:03:50	2025-10-23 12:37:01
ef128626-09df-42e8-9cfb-71aa4815b6f9	808e915e-a5d8-4751-aaa8-50fe040cde68	depot	32245.00	476823.00	509068.00	FCFA	Dépôt espèces guichet	\N	2025-04-28 08:14:55	2025-10-23 12:37:01
716bfef1-d733-4e89-a7ce-7b0115134369	808e915e-a5d8-4751-aaa8-50fe040cde68	depot	49801.00	476823.00	526624.00	FCFA	Versement salaire	\N	2025-10-11 14:54:29	2025-10-23 12:37:01
9eaa5f19-4dd6-47cc-8308-cdbe43388226	808e915e-a5d8-4751-aaa8-50fe040cde68	virement	30743.00	476823.00	446080.00	FCFA	Virement vers compte	94b14a72-e4f3-4e5f-ae72-8e6f72e4e901	2025-04-27 07:55:28	2025-10-23 12:37:01
2570878e-4dd3-42d7-8a0c-7658442a14ea	808e915e-a5d8-4751-aaa8-50fe040cde68	virement	41685.00	476823.00	435138.00	FCFA	Virement salaire	7b3221a6-3b25-4cc8-a934-e795af882682	2025-05-26 00:00:36	2025-10-23 12:37:01
42033065-defc-4d2e-acac-cf091721607a	808e915e-a5d8-4751-aaa8-50fe040cde68	retrait	25200.00	476823.00	451623.00	FCFA	Retrait d'espèces	\N	2025-09-13 09:50:09	2025-10-23 12:37:01
f380ee76-3c33-4aad-8258-e67d83dfe19f	808e915e-a5d8-4751-aaa8-50fe040cde68	depot	49466.00	476823.00	526289.00	FCFA	Virement bancaire entrant	\N	2025-07-02 19:04:48	2025-10-23 12:37:01
15430e05-0a92-4a09-9f0a-1104fef1bbd2	808e915e-a5d8-4751-aaa8-50fe040cde68	retrait	14090.00	476823.00	462733.00	FCFA	Prélèvement automatique	\N	2025-07-18 14:32:49	2025-10-23 12:37:01
ca51d2ae-7ee4-4740-9662-4545a7f7c17f	027e5061-71c4-4a85-af3a-32a651974095	virement	40366.00	23354.00	0.00	FCFA	Transfert bancaire	34b84e17-27b4-4080-a77b-3cdb00476a06	2025-09-15 01:18:36	2025-10-23 12:37:01
05ef5b70-79eb-435c-ae75-b9b511e9521d	027e5061-71c4-4a85-af3a-32a651974095	depot	38370.00	23354.00	61724.00	FCFA	Dépôt espèces guichet	\N	2025-07-24 11:31:15	2025-10-23 12:37:01
8fc677fc-dd24-4408-be14-457173d0caff	027e5061-71c4-4a85-af3a-32a651974095	virement	38087.00	23354.00	0.00	FCFA	Paiement facture	cc0d2546-7dab-4d38-a26e-fedf481485db	2025-07-30 22:42:27	2025-10-23 12:37:01
aecdc1cc-1dd7-4d4f-ac03-a933649f0645	027e5061-71c4-4a85-af3a-32a651974095	retrait	15811.00	23354.00	7543.00	FCFA	Retrait guichet	\N	2025-07-27 00:30:25	2025-10-23 12:37:01
3ca27539-af11-49f0-b762-7f6d06aacce8	027e5061-71c4-4a85-af3a-32a651974095	virement	1747.00	23354.00	21607.00	FCFA	Virement vers compte	12a1bcc9-6ded-4708-8db3-3ebeb5632e08	2025-09-07 13:23:42	2025-10-23 12:37:01
d9d522c2-f14c-4dc9-a083-b8e31eb4e9ba	027e5061-71c4-4a85-af3a-32a651974095	retrait	23231.00	23354.00	123.00	FCFA	Retrait guichet	\N	2025-04-26 09:06:31	2025-10-23 12:37:01
10b70e8b-a82c-4375-9be7-904347e3ec86	027e5061-71c4-4a85-af3a-32a651974095	virement	44646.00	23354.00	0.00	FCFA	Transfert entre comptes	ac532c01-37b7-44d5-bc6e-148843aaf375	2025-06-16 14:10:57	2025-10-23 12:37:01
97e64ef8-1574-43f5-b982-47737b6cecce	027e5061-71c4-4a85-af3a-32a651974095	retrait	5947.00	23354.00	17407.00	FCFA	Paiement par carte	\N	2025-09-18 11:27:29	2025-10-23 12:37:01
c970f659-2861-462d-ae71-5a4ac1707752	027e5061-71c4-4a85-af3a-32a651974095	retrait	42021.00	23354.00	0.00	FCFA	Prélèvement automatique	\N	2025-10-18 07:55:39	2025-10-23 12:37:01
7348ccee-5286-4f3d-9d3b-63122c356ea2	027e5061-71c4-4a85-af3a-32a651974095	depot	1301.00	23354.00	24655.00	FCFA	Dépôt chèque	\N	2025-07-28 02:20:28	2025-10-23 12:37:01
4f74009e-3be9-40e4-b575-48aaafbc30b9	027e5061-71c4-4a85-af3a-32a651974095	virement	12921.00	23354.00	10433.00	FCFA	Transfert bancaire	65da4070-27f5-40a7-99d9-db64e3163a65	2025-08-17 19:59:18	2025-10-23 12:37:01
8f95317d-726f-4470-a10c-e5f2cd94e39f	027e5061-71c4-4a85-af3a-32a651974095	depot	32204.00	23354.00	55558.00	FCFA	Versement salaire	\N	2025-07-25 03:10:04	2025-10-23 12:37:01
21d24618-c843-436a-a0bf-aad353e5fa01	ac230aec-8c74-4964-ad30-44dbe9e58cc6	virement	14270.00	157187.00	142917.00	FCFA	Transfert entre comptes	720b3789-49c5-4ccc-b8af-be59906bc1d3	2025-05-03 15:39:48	2025-10-23 12:37:02
5ef6d84e-96fd-4d82-a2ab-c185ce286be4	ac230aec-8c74-4964-ad30-44dbe9e58cc6	depot	39609.00	157187.00	196796.00	FCFA	Dépôt chèque	\N	2025-05-14 23:37:43	2025-10-23 12:37:02
dcdfc642-0b57-4885-a950-86e4c29e867e	ac230aec-8c74-4964-ad30-44dbe9e58cc6	depot	22349.00	157187.00	179536.00	FCFA	Dépôt d'espèces	\N	2025-08-08 07:41:32	2025-10-23 12:37:02
cdb5b4b2-5d59-4827-801c-8f3ae1d3a1bc	ac230aec-8c74-4964-ad30-44dbe9e58cc6	depot	16189.00	157187.00	173376.00	FCFA	Dépôt d'espèces	\N	2025-09-19 11:38:18	2025-10-23 12:37:02
b43ab256-2156-4a0a-839b-81126a275c93	ac230aec-8c74-4964-ad30-44dbe9e58cc6	virement	36470.00	157187.00	120717.00	FCFA	Paiement facture	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	2025-09-04 19:51:16	2025-10-23 12:37:02
3c9520dd-4cbe-442c-95a2-7202039ed230	ac230aec-8c74-4964-ad30-44dbe9e58cc6	depot	33957.00	157187.00	191144.00	FCFA	Dépôt d'espèces	\N	2025-07-08 20:26:56	2025-10-23 12:37:02
c80b66e9-6484-42b6-8c04-3571ca21615c	ac230aec-8c74-4964-ad30-44dbe9e58cc6	depot	26899.00	157187.00	184086.00	FCFA	Versement salaire	\N	2025-10-12 10:56:20	2025-10-23 12:37:02
299c65ae-4dec-4234-8ef9-54a25cf35294	ac230aec-8c74-4964-ad30-44dbe9e58cc6	depot	33497.00	157187.00	190684.00	FCFA	Dépôt espèces guichet	\N	2025-06-06 06:23:27	2025-10-23 12:37:02
376db0b2-89a7-44c3-bfc3-02bb23127e98	ac230aec-8c74-4964-ad30-44dbe9e58cc6	depot	45526.00	157187.00	202713.00	FCFA	Dépôt chèque	\N	2025-09-21 17:08:10	2025-10-23 12:37:02
21df6a00-b43d-4f3d-bf24-85c873b30d5f	ac230aec-8c74-4964-ad30-44dbe9e58cc6	depot	45220.00	157187.00	202407.00	FCFA	Virement bancaire entrant	\N	2025-09-07 03:11:32	2025-10-23 12:37:02
99451a22-6582-4d1e-acdd-2c27d94311d5	ac230aec-8c74-4964-ad30-44dbe9e58cc6	retrait	8801.00	157187.00	148386.00	FCFA	Prélèvement automatique	\N	2025-09-19 12:41:53	2025-10-23 12:37:02
e74bb5d7-bb07-4873-9bef-92f062b099ea	ac230aec-8c74-4964-ad30-44dbe9e58cc6	depot	25815.00	157187.00	183002.00	FCFA	Dépôt chèque	\N	2025-05-05 15:07:05	2025-10-23 12:37:02
7b53d423-1b16-4ab1-ba7c-3b0fc6835865	ac230aec-8c74-4964-ad30-44dbe9e58cc6	depot	19711.00	157187.00	176898.00	FCFA	Versement salaire	\N	2025-06-18 09:09:02	2025-10-23 12:37:02
0f7a5a28-61c8-47c7-b998-37ee76741d44	ac230aec-8c74-4964-ad30-44dbe9e58cc6	retrait	16556.00	157187.00	140631.00	FCFA	Retrait guichet	\N	2025-06-02 16:31:33	2025-10-23 12:37:02
bb0b9c18-2394-4ab7-b90f-a18cd27a9faa	0b7246d3-cd3d-4162-952a-709242caabaf	virement	40591.00	8255.00	0.00	FCFA	Paiement facture	087d0d47-8377-4f2f-82a8-6acbc6e148f1	2025-07-16 05:30:16	2025-10-23 12:37:02
acc87853-b9e1-430c-bde7-9d5a4776bd79	0b7246d3-cd3d-4162-952a-709242caabaf	virement	2022.00	8255.00	6233.00	FCFA	Transfert entre comptes	9c0923b4-0a14-4650-8df8-edf426310de6	2025-09-22 12:42:01	2025-10-23 12:37:02
423299a5-0af2-4f74-a10d-72117b951f08	0b7246d3-cd3d-4162-952a-709242caabaf	retrait	40882.00	8255.00	0.00	FCFA	Retrait guichet	\N	2025-06-11 01:15:51	2025-10-23 12:37:02
76c8743f-a43e-4842-8087-a8800ea17660	0b7246d3-cd3d-4162-952a-709242caabaf	retrait	36585.00	8255.00	0.00	FCFA	Retrait guichet	\N	2025-10-02 03:18:09	2025-10-23 12:37:02
3685ff5f-0ce9-4bd1-a981-b70e723ad9fc	0b7246d3-cd3d-4162-952a-709242caabaf	virement	20960.00	8255.00	0.00	FCFA	Transfert entre comptes	f1e6f840-61c7-4618-bbfd-578d06a2431f	2025-09-25 02:40:40	2025-10-23 12:37:02
4bbfdd77-4c35-4b7d-9c82-194a1b2db8e7	0b7246d3-cd3d-4162-952a-709242caabaf	virement	14474.00	8255.00	0.00	FCFA	Virement vers compte	916bbfef-cee4-457b-a001-da8e5b0be63d	2025-08-21 00:12:04	2025-10-23 12:37:02
a89205dd-4f8d-4a82-8377-4c8a26bc8b42	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	depot	34220.00	363214.00	397434.00	FCFA	Virement bancaire entrant	\N	2025-06-08 04:04:04	2025-10-23 12:37:02
88209da1-a8d6-4042-b536-c634359f7073	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	depot	30247.00	363214.00	393461.00	FCFA	Dépôt chèque	\N	2025-10-08 14:03:54	2025-10-23 12:37:02
eadd869b-7be2-4f35-9f59-4620306b0fbc	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	depot	49327.00	363214.00	412541.00	FCFA	Versement salaire	\N	2025-08-10 01:07:07	2025-10-23 12:37:02
f4702d0c-380e-4814-83da-486bc0f24910	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	virement	40763.00	363214.00	322451.00	FCFA	Transfert bancaire	e4ad8455-8e84-4a67-873f-6392338ba743	2025-05-06 01:09:16	2025-10-23 12:37:02
843d7dec-2c3e-4e12-b9d3-0f2ac6391d7d	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	virement	48200.00	363214.00	315014.00	FCFA	Virement salaire	41e95b7c-81f4-4383-8e18-448d1ab5bd48	2025-09-07 02:21:38	2025-10-23 12:37:02
4602b329-9fd6-4c51-a9f6-7bc97af32b4b	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	virement	49271.00	363214.00	313943.00	FCFA	Virement salaire	914d5be6-2dc2-4063-8219-1ea664a8b058	2025-04-25 00:28:31	2025-10-23 12:37:02
632c359a-d0be-41c3-a288-d8af3c164540	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	virement	20827.00	363214.00	342387.00	FCFA	Virement vers compte	b30db983-96ad-4f5c-a50c-1637c25f3b46	2025-10-04 13:12:23	2025-10-23 12:37:02
180d0028-0b37-42bd-ba48-8d9abb51484d	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	depot	3161.00	363214.00	366375.00	FCFA	Dépôt chèque	\N	2025-08-06 03:39:37	2025-10-23 12:37:02
08d27d5c-cf01-4556-b8e6-83b0ea81bc97	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	virement	18275.00	363214.00	344939.00	FCFA	Transfert bancaire	d2a1ed80-e126-493f-b155-2923909ae924	2025-09-07 00:25:52	2025-10-23 12:37:02
ed8db974-6efb-47de-b7b9-6c6e3f245c9d	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	virement	45659.00	363214.00	317555.00	FCFA	Virement vers compte	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	2025-08-19 07:15:32	2025-10-23 12:37:02
81bcbfc1-7a79-4982-a2ef-311a3ad480a9	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	depot	46723.00	363214.00	409937.00	FCFA	Virement bancaire entrant	\N	2025-09-01 08:42:18	2025-10-23 12:37:02
ab60fd88-65f4-41e5-aea2-3b617d86ca8d	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	virement	27594.00	363214.00	335620.00	FCFA	Virement vers compte	13b0280b-a95f-48ee-9c35-9fb3c4786166	2025-04-28 08:40:37	2025-10-23 12:37:02
3b926ca1-0b27-4c24-8e97-fd5b0cd17ecc	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	virement	39800.00	363214.00	323414.00	FCFA	Transfert entre comptes	6131421b-d7d7-4f56-8450-582c37486f68	2025-09-09 22:54:46	2025-10-23 12:37:02
64c802a4-224e-4717-aaa5-f5c052ec28de	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	retrait	48781.00	363214.00	314433.00	FCFA	Retrait guichet	\N	2025-05-12 21:00:59	2025-10-23 12:37:02
5e0c0dd6-067f-4150-b7d1-170c75192154	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	retrait	12630.00	363214.00	350584.00	FCFA	Retrait DAB	\N	2025-10-06 10:09:27	2025-10-23 12:37:02
7a253f39-927e-46cd-a7d0-23425346cc76	b6facec9-8829-4da5-a631-d1f5680d2f75	retrait	36010.00	481323.00	445313.00	FCFA	Paiement par carte	\N	2025-08-24 06:18:43	2025-10-23 12:37:02
7e584213-929c-45cb-905b-b4d5f0ad0d9d	b6facec9-8829-4da5-a631-d1f5680d2f75	retrait	4507.00	481323.00	476816.00	FCFA	Retrait guichet	\N	2025-09-08 01:44:15	2025-10-23 12:37:02
db1543f6-db62-4069-8337-a6e263dd161a	b6facec9-8829-4da5-a631-d1f5680d2f75	retrait	36585.00	481323.00	444738.00	FCFA	Prélèvement automatique	\N	2025-05-13 04:32:18	2025-10-23 12:37:02
3abc6808-b9b1-4f25-a655-eea3b5b67571	b6facec9-8829-4da5-a631-d1f5680d2f75	depot	32133.00	481323.00	513456.00	FCFA	Virement bancaire entrant	\N	2025-05-15 01:59:36	2025-10-23 12:37:02
fa1f7583-3b99-4db7-8ca5-efb2eae1d500	b6facec9-8829-4da5-a631-d1f5680d2f75	depot	37562.00	481323.00	518885.00	FCFA	Virement bancaire entrant	\N	2025-07-15 19:56:49	2025-10-23 12:37:02
c0e64596-8aac-4b9c-8fc3-13525236e7c7	b6facec9-8829-4da5-a631-d1f5680d2f75	retrait	3822.00	481323.00	477501.00	FCFA	Paiement par carte	\N	2025-09-30 16:57:00	2025-10-23 12:37:02
83477c17-0517-4172-a92a-99517d16a579	b6facec9-8829-4da5-a631-d1f5680d2f75	retrait	27297.00	481323.00	454026.00	FCFA	Retrait DAB	\N	2025-08-11 21:53:58	2025-10-23 12:37:02
9e6fedb7-07db-489e-838e-ad7057dcfa15	b6facec9-8829-4da5-a631-d1f5680d2f75	depot	21930.00	481323.00	503253.00	FCFA	Virement bancaire entrant	\N	2025-09-09 00:23:52	2025-10-23 12:37:02
d01c0662-afcf-42db-a8c3-0197dd4bc006	b6facec9-8829-4da5-a631-d1f5680d2f75	virement	38605.00	481323.00	442718.00	FCFA	Transfert bancaire	5d3634bb-39ae-4beb-a70d-3f7ac49f03cf	2025-07-04 16:36:21	2025-10-23 12:37:02
e0fa3800-002e-47a2-acba-0ae9380fc108	b6facec9-8829-4da5-a631-d1f5680d2f75	depot	9332.00	481323.00	490655.00	FCFA	Virement bancaire entrant	\N	2025-09-07 05:07:03	2025-10-23 12:37:02
f27aee08-06d4-4f81-aa0e-950197e3252b	79fa87c8-8658-4ac8-a54a-53ff2fe252cf	depot	44275.00	22040.00	66315.00	FCFA	Dépôt d'espèces	\N	2025-07-08 07:36:16	2025-10-23 12:37:02
d2e9c058-89da-4d52-beb7-d1603735352d	79fa87c8-8658-4ac8-a54a-53ff2fe252cf	depot	13040.00	22040.00	35080.00	FCFA	Dépôt chèque	\N	2025-05-14 03:36:26	2025-10-23 12:37:02
3b560dd5-e01b-4f50-922d-9f15643d2b93	79fa87c8-8658-4ac8-a54a-53ff2fe252cf	virement	37794.00	22040.00	0.00	FCFA	Transfert entre comptes	801e068b-fdc3-4606-bc83-42d2e3fc4a67	2025-07-05 18:26:15	2025-10-23 12:37:02
0ed43db1-33f7-4ac2-ab97-9c480e94f283	79fa87c8-8658-4ac8-a54a-53ff2fe252cf	depot	6383.00	22040.00	28423.00	FCFA	Dépôt chèque	\N	2025-09-26 11:25:45	2025-10-23 12:37:02
d628a57c-219e-4686-80ba-c23c5b05ee7f	79fa87c8-8658-4ac8-a54a-53ff2fe252cf	retrait	36278.00	22040.00	0.00	FCFA	Retrait guichet	\N	2025-10-16 11:09:05	2025-10-23 12:37:02
b0c32061-d944-4d60-9a55-8ae560fbd2e1	79fa87c8-8658-4ac8-a54a-53ff2fe252cf	depot	31428.00	22040.00	53468.00	FCFA	Dépôt chèque	\N	2025-08-07 05:47:25	2025-10-23 12:37:02
b8354af2-08b8-4ae6-aaa8-0555595ba898	79fa87c8-8658-4ac8-a54a-53ff2fe252cf	virement	24977.00	22040.00	0.00	FCFA	Transfert entre comptes	d2a1ed80-e126-493f-b155-2923909ae924	2025-06-22 02:07:53	2025-10-23 12:37:02
f50739bf-1af6-485e-a840-dc803ca04ce6	79fa87c8-8658-4ac8-a54a-53ff2fe252cf	retrait	39973.00	22040.00	0.00	FCFA	Prélèvement automatique	\N	2025-07-11 15:15:14	2025-10-23 12:37:02
e93f1c5e-29a0-4982-8788-159a3da9e1c0	79fa87c8-8658-4ac8-a54a-53ff2fe252cf	virement	7396.00	22040.00	14644.00	FCFA	Virement vers compte	4bb7fc9b-13d6-4883-b751-283b753d05ed	2025-10-11 23:00:08	2025-10-23 12:37:02
fd16edb5-34c0-487a-b9d5-e0ba7a411ed3	79fa87c8-8658-4ac8-a54a-53ff2fe252cf	virement	26053.00	22040.00	0.00	FCFA	Virement vers compte	ce352024-ef0a-4c59-a717-07fa503a38dc	2025-07-18 19:02:58	2025-10-23 12:37:02
0c3f74e7-e4ca-4858-b0d4-6af43dd551c6	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	retrait	15435.00	433209.00	417774.00	FCFA	Retrait guichet	\N	2025-08-21 22:30:05	2025-10-23 12:37:02
605a1fd6-4023-48e1-993b-f2d78ee1bd6a	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	depot	17531.00	433209.00	450740.00	FCFA	Versement salaire	\N	2025-07-25 20:04:47	2025-10-23 12:37:02
15ad656f-207f-420d-9fbf-9fe91d9e0322	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	virement	11620.00	433209.00	421589.00	FCFA	Paiement facture	b03a8338-5679-4ed1-9ba5-d4a4cf3ff31d	2025-08-11 17:02:17	2025-10-23 12:37:02
d621946b-c7a6-4d98-97b8-0ce88b17c0b7	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	virement	19967.00	433209.00	413242.00	FCFA	Virement vers compte	37da1638-f10a-4a03-9eb4-9eb960273866	2025-10-05 02:06:12	2025-10-23 12:37:02
8c0b5d7a-d142-4085-8643-0af5626e1168	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	depot	12492.00	433209.00	445701.00	FCFA	Dépôt chèque	\N	2025-10-18 07:14:07	2025-10-23 12:37:02
48af7daf-38fb-4117-b18b-5371b4c6097b	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	virement	2799.00	433209.00	430410.00	FCFA	Transfert entre comptes	4497726b-2732-4f82-ac92-17bdbf1dbca5	2025-08-30 15:07:25	2025-10-23 12:37:02
30b1f84c-5460-41de-b4cf-cee97ed0220c	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	virement	31234.00	433209.00	401975.00	FCFA	Virement salaire	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	2025-04-28 19:15:00	2025-10-23 12:37:02
00203bc2-7b84-418f-a309-3361de7354a0	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	retrait	40582.00	433209.00	392627.00	FCFA	Retrait d'espèces	\N	2025-07-13 15:07:21	2025-10-23 12:37:02
009bee7f-f02e-47fa-91ea-658131b64704	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	retrait	27710.00	433209.00	405499.00	FCFA	Paiement par carte	\N	2025-05-13 20:34:37	2025-10-23 12:37:02
c9cc8e45-da16-4eff-9aeb-c84fb5af8b07	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	virement	35794.00	433209.00	397415.00	FCFA	Paiement facture	cb45ecae-4f73-42b2-870b-4f41321c9acd	2025-07-06 23:59:37	2025-10-23 12:37:02
e1635e61-78d9-499d-a135-31f6a14e8da2	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	retrait	2328.00	433209.00	430881.00	FCFA	Retrait guichet	\N	2025-07-29 01:22:45	2025-10-23 12:37:02
cc95cd3e-7249-4945-ab43-1382f4f86e56	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	retrait	19443.00	433209.00	413766.00	FCFA	Retrait d'espèces	\N	2025-07-08 05:41:27	2025-10-23 12:37:02
7c5b04d3-694f-4c24-966f-1278b95ba990	f1187d5e-8bc4-4bb1-b970-9a025a5048c4	virement	27259.00	433209.00	405950.00	FCFA	Transfert entre comptes	801e068b-fdc3-4606-bc83-42d2e3fc4a67	2025-10-08 02:40:47	2025-10-23 12:37:02
09df92b1-b9e3-4b61-abce-e59a7b9df914	5f5f316c-0963-43fc-b6d4-599439e88c6f	virement	17084.00	261323.00	244239.00	FCFA	Transfert bancaire	db289a68-fb56-4357-aa96-60bcaab5608f	2025-06-19 09:24:49	2025-10-23 12:37:02
ee8042b9-ddb3-402f-b45b-8a15800e83c4	5f5f316c-0963-43fc-b6d4-599439e88c6f	retrait	16459.00	261323.00	244864.00	FCFA	Retrait DAB	\N	2025-08-30 20:09:05	2025-10-23 12:37:02
18eb9883-3e9c-40ee-b780-f744cbf2f94a	5f5f316c-0963-43fc-b6d4-599439e88c6f	retrait	41510.00	261323.00	219813.00	FCFA	Retrait d'espèces	\N	2025-09-07 23:33:42	2025-10-23 12:37:02
5ffb740b-3ec6-4506-9b4d-04aca6fe3a84	5f5f316c-0963-43fc-b6d4-599439e88c6f	depot	28310.00	261323.00	289633.00	FCFA	Virement bancaire entrant	\N	2025-09-27 13:21:38	2025-10-23 12:37:02
ecef3105-483c-4997-9060-e2f56fd6553b	5f5f316c-0963-43fc-b6d4-599439e88c6f	retrait	33304.00	261323.00	228019.00	FCFA	Retrait d'espèces	\N	2025-07-01 02:59:04	2025-10-23 12:37:02
f9b8ebb0-2c5b-4514-9778-24c873df3ab9	5f5f316c-0963-43fc-b6d4-599439e88c6f	retrait	38646.00	261323.00	222677.00	FCFA	Retrait DAB	\N	2025-06-06 13:19:26	2025-10-23 12:37:02
eac25a9e-5ab5-4eff-98cd-3613462cd67b	5f5f316c-0963-43fc-b6d4-599439e88c6f	virement	37756.00	261323.00	223567.00	FCFA	Transfert entre comptes	f3e7fcff-56ce-42a9-bbf9-f2aa186da145	2025-06-19 00:56:11	2025-10-23 12:37:02
b7fa253a-0d51-4ad3-8442-3aa680f8df4b	5f5f316c-0963-43fc-b6d4-599439e88c6f	depot	1969.00	261323.00	263292.00	FCFA	Versement salaire	\N	2025-10-22 23:30:52	2025-10-23 12:37:02
fa5d9dd5-b304-4aaf-bbbd-cf1842dc5597	5f5f316c-0963-43fc-b6d4-599439e88c6f	retrait	38132.00	261323.00	223191.00	FCFA	Retrait d'espèces	\N	2025-09-16 13:08:54	2025-10-23 12:37:02
34e5e06a-99d1-4cff-a823-122e5ee30b31	5f5f316c-0963-43fc-b6d4-599439e88c6f	retrait	28017.00	261323.00	233306.00	FCFA	Retrait DAB	\N	2025-08-04 17:55:01	2025-10-23 12:37:02
4bce238e-f239-442c-996b-796ebbc3a26c	5f5f316c-0963-43fc-b6d4-599439e88c6f	retrait	39299.00	261323.00	222024.00	FCFA	Prélèvement automatique	\N	2025-05-07 06:30:39	2025-10-23 12:37:02
3a8760ff-6a14-4ce9-88ed-951d9e5f6b31	5f5f316c-0963-43fc-b6d4-599439e88c6f	retrait	25479.00	261323.00	235844.00	FCFA	Retrait guichet	\N	2025-09-08 20:42:22	2025-10-23 12:37:02
d6b08429-5d4d-4a86-a889-a5749892958f	5f5f316c-0963-43fc-b6d4-599439e88c6f	retrait	15381.00	261323.00	245942.00	FCFA	Retrait DAB	\N	2025-05-04 02:30:00	2025-10-23 12:37:02
1989f219-f3f8-47a3-8d37-cf1d0990b3c5	5f5f316c-0963-43fc-b6d4-599439e88c6f	retrait	9442.00	261323.00	251881.00	FCFA	Retrait guichet	\N	2025-09-14 08:12:09	2025-10-23 12:37:02
4faf3560-b293-436e-883e-c0e344bf855f	5f5f316c-0963-43fc-b6d4-599439e88c6f	retrait	11180.00	261323.00	250143.00	FCFA	Prélèvement automatique	\N	2025-09-21 05:40:10	2025-10-23 12:37:02
ef415146-4767-4988-9d41-2012f46fc40d	f3db8624-1334-47ff-83bb-04592844270f	depot	42254.00	318356.00	360610.00	FCFA	Dépôt espèces guichet	\N	2025-10-15 00:11:06	2025-10-23 12:37:02
002b2555-a76b-43ba-9468-267208b60292	f3db8624-1334-47ff-83bb-04592844270f	depot	11411.00	318356.00	329767.00	FCFA	Virement bancaire entrant	\N	2025-05-14 17:19:21	2025-10-23 12:37:02
c3862ce8-a192-4c0c-ac07-dfc557dd9fc2	f3db8624-1334-47ff-83bb-04592844270f	retrait	12753.00	318356.00	305603.00	FCFA	Retrait guichet	\N	2025-08-05 03:26:51	2025-10-23 12:37:02
34943348-c2c2-46bc-bd9e-6cb689156b65	f3db8624-1334-47ff-83bb-04592844270f	retrait	35065.00	318356.00	283291.00	FCFA	Retrait d'espèces	\N	2025-10-08 07:15:20	2025-10-23 12:37:02
c6c7bd70-ab51-430c-ae2e-148b4446730a	f3db8624-1334-47ff-83bb-04592844270f	virement	37525.00	318356.00	280831.00	FCFA	Transfert entre comptes	0006e5f7-4df5-46a5-8f9e-90089c5ea052	2025-07-31 00:46:20	2025-10-23 12:37:02
13d47695-7922-45b9-9c38-e51bb7220644	dd05cd28-6e89-41fd-8a78-cba1c4607efd	retrait	16071.00	272652.00	256581.00	FCFA	Prélèvement automatique	\N	2025-05-07 07:57:00	2025-10-23 12:37:02
1c733be2-2ca6-4dd8-b388-e999474f8ecd	dd05cd28-6e89-41fd-8a78-cba1c4607efd	virement	43043.00	272652.00	229609.00	FCFA	Virement salaire	916bbfef-cee4-457b-a001-da8e5b0be63d	2025-06-14 10:26:42	2025-10-23 12:37:02
afd756e3-e216-49e1-a4a0-f471d0b677cd	dd05cd28-6e89-41fd-8a78-cba1c4607efd	depot	21414.00	272652.00	294066.00	FCFA	Virement bancaire entrant	\N	2025-08-13 23:35:19	2025-10-23 12:37:02
6acdd252-41ad-4cd6-84c3-616b8a825ece	dd05cd28-6e89-41fd-8a78-cba1c4607efd	depot	42015.00	272652.00	314667.00	FCFA	Versement salaire	\N	2025-08-19 11:38:17	2025-10-23 12:37:02
6d79775a-8007-460d-8845-4efa45e7f990	dd05cd28-6e89-41fd-8a78-cba1c4607efd	retrait	40804.00	272652.00	231848.00	FCFA	Retrait d'espèces	\N	2025-06-23 06:14:16	2025-10-23 12:37:02
78610cad-a1c1-4c92-9e93-7a74b3164cc3	dd05cd28-6e89-41fd-8a78-cba1c4607efd	virement	30622.00	272652.00	242030.00	FCFA	Virement vers compte	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	2025-08-07 17:31:34	2025-10-23 12:37:02
c0e08ab4-245c-4c39-8806-cd635e3dd229	dd05cd28-6e89-41fd-8a78-cba1c4607efd	virement	3356.00	272652.00	269296.00	FCFA	Virement vers compte	1ec106c4-a50d-4ad8-8365-f7ad69dd5630	2025-07-04 08:35:15	2025-10-23 12:37:02
f1d3abb4-82de-4793-94ba-8fff6e388091	dd05cd28-6e89-41fd-8a78-cba1c4607efd	virement	29472.00	272652.00	243180.00	FCFA	Transfert entre comptes	aed8dd64-e196-4321-8ffc-52ce0cc7e7f7	2025-08-13 08:30:55	2025-10-23 12:37:02
71ed6908-6d7d-4623-b58a-2704ef21eef8	dd05cd28-6e89-41fd-8a78-cba1c4607efd	depot	14975.00	272652.00	287627.00	FCFA	Virement bancaire entrant	\N	2025-05-24 22:02:58	2025-10-23 12:37:02
187a2381-febc-4e82-a37f-ce036986afc0	dd05cd28-6e89-41fd-8a78-cba1c4607efd	virement	22208.00	272652.00	250444.00	FCFA	Virement vers compte	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	2025-05-30 06:24:44	2025-10-23 12:37:02
6c86a41e-b878-48b7-9a78-3a9f06282fa0	dd05cd28-6e89-41fd-8a78-cba1c4607efd	virement	13161.00	272652.00	259491.00	FCFA	Transfert entre comptes	b45a57c6-7bc2-48d6-a32a-4fa0a971ea9c	2025-09-06 20:45:12	2025-10-23 12:37:02
c6088366-bd5f-424a-811f-b940dbc38236	dd05cd28-6e89-41fd-8a78-cba1c4607efd	depot	43028.00	272652.00	315680.00	FCFA	Versement salaire	\N	2025-04-26 11:15:25	2025-10-23 12:37:02
74b6d931-6159-4ecd-b760-7ecb9425a013	3badd48d-41cc-4d4c-abfa-55dd1b3e0c1e	virement	34774.00	153442.00	118668.00	FCFA	Transfert entre comptes	269d3156-3edd-4bda-99b1-a6cdf48bccdd	2025-09-18 10:00:36	2025-10-23 12:37:02
089b5fbe-83b8-4b22-81e2-e1d0e86b45ef	3badd48d-41cc-4d4c-abfa-55dd1b3e0c1e	depot	45712.00	153442.00	199154.00	FCFA	Virement bancaire entrant	\N	2025-08-28 05:32:35	2025-10-23 12:37:02
a42fb33d-74c5-478a-bf98-713f041b69f6	3badd48d-41cc-4d4c-abfa-55dd1b3e0c1e	retrait	21488.00	153442.00	131954.00	FCFA	Retrait d'espèces	\N	2025-08-08 12:12:40	2025-10-23 12:37:02
a8420757-c624-4e78-856e-bfef0f0c3011	3badd48d-41cc-4d4c-abfa-55dd1b3e0c1e	virement	42638.00	153442.00	110804.00	FCFA	Transfert bancaire	609bd9a2-be5d-4c23-a32e-c1ae8d99ed71	2025-05-01 01:01:50	2025-10-23 12:37:02
db2bd2ba-53e2-4778-9472-c39b421827bb	3badd48d-41cc-4d4c-abfa-55dd1b3e0c1e	retrait	32673.00	153442.00	120769.00	FCFA	Retrait DAB	\N	2025-05-18 02:01:36	2025-10-23 12:37:02
23bb69bb-69fb-41a3-b995-c9fc51a321aa	3badd48d-41cc-4d4c-abfa-55dd1b3e0c1e	depot	30591.00	153442.00	184033.00	FCFA	Virement bancaire entrant	\N	2025-07-01 22:17:24	2025-10-23 12:37:02
c8452505-303c-4252-914a-8fe9d743048f	3badd48d-41cc-4d4c-abfa-55dd1b3e0c1e	depot	6321.00	153442.00	159763.00	FCFA	Dépôt espèces guichet	\N	2025-09-12 22:21:43	2025-10-23 12:37:02
16f940a9-d38a-437b-bd07-f24de517413f	3badd48d-41cc-4d4c-abfa-55dd1b3e0c1e	virement	43709.00	153442.00	109733.00	FCFA	Paiement facture	d725e859-df50-4ee3-8ab9-65d82dc7fd71	2025-06-10 13:25:43	2025-10-23 12:37:02
e7fafaf6-639b-4f53-8740-f82f1557a9b6	3badd48d-41cc-4d4c-abfa-55dd1b3e0c1e	depot	1041.00	153442.00	154483.00	FCFA	Versement salaire	\N	2025-05-05 13:46:18	2025-10-23 12:37:02
8fa47b9f-9f2e-4c75-a6c9-2f30ee8e3784	aed8dd64-e196-4321-8ffc-52ce0cc7e7f7	retrait	48612.00	150739.00	102127.00	FCFA	Prélèvement automatique	\N	2025-07-24 08:59:17	2025-10-23 12:37:02
800c57bd-f575-406b-8f71-9fe6ebe57199	aed8dd64-e196-4321-8ffc-52ce0cc7e7f7	virement	25309.00	150739.00	125430.00	FCFA	Virement salaire	54c98069-cb97-4a48-9c06-c8ed239ef726	2025-04-25 22:47:23	2025-10-23 12:37:02
5e037e8c-a694-4c9d-a3d0-919a4b173d68	aed8dd64-e196-4321-8ffc-52ce0cc7e7f7	virement	31623.00	150739.00	119116.00	FCFA	Virement vers compte	1a2a915d-173c-44e7-a655-e29b9a02fd18	2025-05-19 08:46:50	2025-10-23 12:37:02
d609155f-4494-4434-9c1b-a4c5b3a00fa8	aed8dd64-e196-4321-8ffc-52ce0cc7e7f7	retrait	48759.00	150739.00	101980.00	FCFA	Retrait d'espèces	\N	2025-06-19 00:23:11	2025-10-23 12:37:02
bf4d4298-0752-497e-8957-8f3104ed4870	aed8dd64-e196-4321-8ffc-52ce0cc7e7f7	retrait	22988.00	150739.00	127751.00	FCFA	Retrait guichet	\N	2025-07-31 09:16:04	2025-10-23 12:37:02
d56c114b-468c-4f59-ac30-a12b084e5a9e	aed8dd64-e196-4321-8ffc-52ce0cc7e7f7	retrait	25706.00	150739.00	125033.00	FCFA	Paiement par carte	\N	2025-04-28 07:46:01	2025-10-23 12:37:02
2bf85167-2208-49bc-adb2-759e48be5a34	b03a8338-5679-4ed1-9ba5-d4a4cf3ff31d	retrait	26748.00	174726.00	147978.00	FCFA	Paiement par carte	\N	2025-08-17 18:07:50	2025-10-23 12:37:02
6e8a3e5d-1724-4c3a-9498-f23c33af709a	b03a8338-5679-4ed1-9ba5-d4a4cf3ff31d	virement	36807.00	174726.00	137919.00	FCFA	Transfert entre comptes	f959068a-63bd-46ee-a42c-59d124c48cf6	2025-08-17 19:35:10	2025-10-23 12:37:02
6fe6e3bc-4e8f-4d02-a5c9-ff5243844c11	b03a8338-5679-4ed1-9ba5-d4a4cf3ff31d	retrait	2604.00	174726.00	172122.00	FCFA	Paiement par carte	\N	2025-07-12 03:15:06	2025-10-23 12:37:02
0d6d91d0-e1cc-49cf-ad5a-6d4c9f1b1055	b03a8338-5679-4ed1-9ba5-d4a4cf3ff31d	virement	46015.00	174726.00	128711.00	FCFA	Transfert bancaire	65da4070-27f5-40a7-99d9-db64e3163a65	2025-05-17 09:04:03	2025-10-23 12:37:02
bfe2e8a6-b2f3-4cb6-a863-2c79ff3d6e26	b03a8338-5679-4ed1-9ba5-d4a4cf3ff31d	virement	2717.00	174726.00	172009.00	FCFA	Virement salaire	43df68e0-310b-41d1-b272-3e281b325b72	2025-08-24 07:04:21	2025-10-23 12:37:02
1fa0e65e-1499-4134-a405-62c5dc6452c9	b03a8338-5679-4ed1-9ba5-d4a4cf3ff31d	depot	10450.00	174726.00	185176.00	FCFA	Dépôt d'espèces	\N	2025-05-04 12:00:35	2025-10-23 12:37:02
bef5b7f2-a7be-44e3-a2cc-65c75cd285c3	b03a8338-5679-4ed1-9ba5-d4a4cf3ff31d	virement	17318.00	174726.00	157408.00	FCFA	Paiement facture	22398797-8a57-4530-b835-7193f3b0fca0	2025-08-16 22:28:52	2025-10-23 12:37:02
62375f0e-e81e-409d-b99d-8f55138e1836	b03a8338-5679-4ed1-9ba5-d4a4cf3ff31d	depot	36304.00	174726.00	211030.00	FCFA	Dépôt espèces guichet	\N	2025-10-08 03:02:46	2025-10-23 12:37:02
148588fd-d55b-4940-ac1e-fa5b8f477eaf	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	retrait	7725.00	40167.00	32442.00	FCFA	Retrait DAB	\N	2025-06-22 09:08:07	2025-10-23 12:37:02
f401b236-5b2a-4328-b4d7-ae91884eab10	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	depot	18103.00	40167.00	58270.00	FCFA	Dépôt d'espèces	\N	2025-07-24 11:30:20	2025-10-23 12:37:02
c23540f8-fab3-441b-bcf9-089a6db2dda8	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	retrait	9390.00	40167.00	30777.00	FCFA	Paiement par carte	\N	2025-07-27 17:42:42	2025-10-23 12:37:02
7598bd57-6a67-4c9e-9b85-db0d403732b3	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	virement	4314.00	40167.00	35853.00	FCFA	Transfert entre comptes	e774b1e8-095f-4684-a770-c420e32f477a	2025-06-10 02:22:42	2025-10-23 12:37:02
4276dcff-d9c4-45e9-b89f-b9105a9d7845	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	virement	35658.00	40167.00	4509.00	FCFA	Paiement facture	914d5be6-2dc2-4063-8219-1ea664a8b058	2025-06-27 07:30:36	2025-10-23 12:37:02
a613f473-0006-4ba1-8dfc-1230fdafdb3e	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	retrait	14298.00	40167.00	25869.00	FCFA	Prélèvement automatique	\N	2025-04-23 13:13:45	2025-10-23 12:37:02
d0ae6b81-568e-439f-b474-1d2aade81fae	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	virement	20760.00	40167.00	19407.00	FCFA	Virement vers compte	027e5061-71c4-4a85-af3a-32a651974095	2025-10-17 07:18:42	2025-10-23 12:37:02
a20903a9-d6ad-40e8-b8ae-f5b2fe3d93fa	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	retrait	19831.00	40167.00	20336.00	FCFA	Retrait d'espèces	\N	2025-06-15 03:07:31	2025-10-23 12:37:02
51a8ad91-5a91-40f2-97b9-c52e33f99139	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	retrait	26965.00	40167.00	13202.00	FCFA	Prélèvement automatique	\N	2025-07-23 19:24:15	2025-10-23 12:37:02
2d5c58fa-06a9-4155-8e46-99f041ac682f	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	virement	45832.00	40167.00	0.00	FCFA	Transfert bancaire	b3c57074-cab3-490f-9d70-3da5066332f6	2025-10-01 03:52:30	2025-10-23 12:37:02
881becb8-ebf5-49a3-a1e4-ab73dffe8468	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	retrait	25029.00	40167.00	15138.00	FCFA	Prélèvement automatique	\N	2025-06-26 21:51:30	2025-10-23 12:37:02
97a45028-8987-4f77-8da5-3fb616a0046a	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	retrait	36723.00	40167.00	3444.00	FCFA	Retrait guichet	\N	2025-09-30 20:57:01	2025-10-23 12:37:02
02e4d4c6-5983-4ad7-bbe7-519848bed09e	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	retrait	40141.00	40167.00	26.00	FCFA	Paiement par carte	\N	2025-05-23 08:08:06	2025-10-23 12:37:02
6aecb8bd-9d75-441e-b888-c78e9000efeb	aefad6a9-6ff4-4250-b79c-50f551aaa60e	depot	2282.00	410403.00	412685.00	FCFA	Virement bancaire entrant	\N	2025-07-28 00:03:38	2025-10-23 12:37:02
3b49d4bf-d0c4-429a-9b86-75cb80694fdb	aefad6a9-6ff4-4250-b79c-50f551aaa60e	depot	31158.00	410403.00	441561.00	FCFA	Dépôt d'espèces	\N	2025-09-17 17:53:09	2025-10-23 12:37:02
d200f0d4-a8b5-4129-b6d9-7ec17cc3949e	aefad6a9-6ff4-4250-b79c-50f551aaa60e	virement	40843.00	410403.00	369560.00	FCFA	Virement salaire	13b0280b-a95f-48ee-9c35-9fb3c4786166	2025-07-03 08:28:40	2025-10-23 12:37:02
df2f3727-9c30-4f76-af17-3e920bd825c7	aefad6a9-6ff4-4250-b79c-50f551aaa60e	virement	33434.00	410403.00	376969.00	FCFA	Virement salaire	65da4070-27f5-40a7-99d9-db64e3163a65	2025-08-25 07:58:22	2025-10-23 12:37:02
38926b7d-b56f-429e-9350-888eda594eaa	aefad6a9-6ff4-4250-b79c-50f551aaa60e	retrait	14267.00	410403.00	396136.00	FCFA	Paiement par carte	\N	2025-05-06 05:19:34	2025-10-23 12:37:02
3a55a8a5-a1c0-4347-be4d-f399ce42dd94	aefad6a9-6ff4-4250-b79c-50f551aaa60e	depot	40832.00	410403.00	451235.00	FCFA	Versement salaire	\N	2025-08-18 16:49:20	2025-10-23 12:37:02
b59c4a04-36fb-4407-8e56-1aa9b5a65977	f959068a-63bd-46ee-a42c-59d124c48cf6	depot	26320.00	276876.00	303196.00	FCFA	Dépôt chèque	\N	2025-10-20 07:42:53	2025-10-23 12:37:02
b1b50eb9-2361-4de7-bf8e-c17b784594ea	f959068a-63bd-46ee-a42c-59d124c48cf6	depot	33565.00	276876.00	310441.00	FCFA	Virement bancaire entrant	\N	2025-06-14 14:35:15	2025-10-23 12:37:02
af2c81b4-3338-4c70-8080-a13ad5e60de6	f959068a-63bd-46ee-a42c-59d124c48cf6	retrait	43056.00	276876.00	233820.00	FCFA	Paiement par carte	\N	2025-10-21 16:00:37	2025-10-23 12:37:02
e6829b1f-bab8-43e3-98de-0cfa530a1feb	f959068a-63bd-46ee-a42c-59d124c48cf6	depot	37992.00	276876.00	314868.00	FCFA	Dépôt espèces guichet	\N	2025-05-17 11:26:44	2025-10-23 12:37:02
32be9501-b1f6-4be4-92f4-eee817503a5d	f959068a-63bd-46ee-a42c-59d124c48cf6	retrait	25779.00	276876.00	251097.00	FCFA	Retrait DAB	\N	2025-07-03 04:26:53	2025-10-23 12:37:02
c8e578ef-16a2-4aba-9f40-59c64815957b	f959068a-63bd-46ee-a42c-59d124c48cf6	depot	3725.00	276876.00	280601.00	FCFA	Dépôt espèces guichet	\N	2025-05-02 09:50:34	2025-10-23 12:37:02
58a0b7f6-2af5-48fc-87a9-aeccdac6d1e8	f959068a-63bd-46ee-a42c-59d124c48cf6	depot	37880.00	276876.00	314756.00	FCFA	Dépôt d'espèces	\N	2025-07-16 05:33:06	2025-10-23 12:37:02
b13f0c5e-50bd-49db-888f-cdaf746b9fa7	f959068a-63bd-46ee-a42c-59d124c48cf6	depot	20466.00	276876.00	297342.00	FCFA	Versement salaire	\N	2025-09-11 20:29:10	2025-10-23 12:37:02
93989979-5400-4991-bf98-b820a41415e6	f959068a-63bd-46ee-a42c-59d124c48cf6	retrait	5188.00	276876.00	271688.00	FCFA	Retrait DAB	\N	2025-07-25 03:56:46	2025-10-23 12:37:02
29eb66d2-2e4e-42d0-ba01-80482c48f7f0	f959068a-63bd-46ee-a42c-59d124c48cf6	depot	36028.00	276876.00	312904.00	FCFA	Dépôt d'espèces	\N	2025-05-30 05:38:30	2025-10-23 12:37:02
93f733eb-b20a-4cf5-a360-7ee3bd836ae5	f959068a-63bd-46ee-a42c-59d124c48cf6	virement	29769.00	276876.00	247107.00	FCFA	Virement salaire	b03a8338-5679-4ed1-9ba5-d4a4cf3ff31d	2025-10-16 23:17:00	2025-10-23 12:37:02
ec9ff7aa-b058-4d81-aa1d-b51cdc176a53	f959068a-63bd-46ee-a42c-59d124c48cf6	virement	39350.00	276876.00	237526.00	FCFA	Transfert entre comptes	473ba79b-f520-481d-82b7-0a94c75586be	2025-10-03 01:38:16	2025-10-23 12:37:02
018128ac-5b6a-4490-b26a-5ea3568976b8	28a8f0a8-46fa-4589-96fb-a4bf01b6df29	depot	8273.00	447123.00	455396.00	FCFA	Dépôt chèque	\N	2025-06-28 06:31:08	2025-10-23 12:37:02
52b4967c-c2b2-4354-8ad0-68fb5cf37c06	28a8f0a8-46fa-4589-96fb-a4bf01b6df29	depot	38643.00	447123.00	485766.00	FCFA	Virement bancaire entrant	\N	2025-05-08 19:52:15	2025-10-23 12:37:02
88bdcaa0-946b-49c3-a124-3ce15f3b96b5	28a8f0a8-46fa-4589-96fb-a4bf01b6df29	retrait	10056.00	447123.00	437067.00	FCFA	Retrait d'espèces	\N	2025-09-13 02:37:19	2025-10-23 12:37:02
135f517e-a93b-4a1f-ae15-8cb5a0e62a54	28a8f0a8-46fa-4589-96fb-a4bf01b6df29	virement	44178.00	447123.00	402945.00	FCFA	Transfert entre comptes	39ca01df-9037-4f1b-962a-164c3db984f0	2025-09-30 09:02:45	2025-10-23 12:37:02
751c10dc-9c4b-412c-bdd9-4c9622fcc633	28a8f0a8-46fa-4589-96fb-a4bf01b6df29	depot	47084.00	447123.00	494207.00	FCFA	Dépôt d'espèces	\N	2025-09-18 20:08:48	2025-10-23 12:37:02
660ef4f6-5fa2-458f-af94-5b8944d1af73	28a8f0a8-46fa-4589-96fb-a4bf01b6df29	retrait	29353.00	447123.00	417770.00	FCFA	Retrait guichet	\N	2025-08-09 19:37:56	2025-10-23 12:37:02
79e56b81-a274-4ecb-92f8-8d71993dc03c	28a8f0a8-46fa-4589-96fb-a4bf01b6df29	depot	3305.00	447123.00	450428.00	FCFA	Dépôt chèque	\N	2025-10-21 13:10:03	2025-10-23 12:37:02
da0a6b53-b8ba-4ca2-8c53-c3d47d9b0149	28a8f0a8-46fa-4589-96fb-a4bf01b6df29	virement	22714.00	447123.00	424409.00	FCFA	Transfert entre comptes	ce34889a-7b15-48e8-9003-f1522cf517f8	2025-09-23 20:35:30	2025-10-23 12:37:02
38750ef3-641f-483b-9764-5f0550f37447	28a8f0a8-46fa-4589-96fb-a4bf01b6df29	virement	37781.00	447123.00	409342.00	FCFA	Transfert entre comptes	f1e6f840-61c7-4618-bbfd-578d06a2431f	2025-05-04 04:19:49	2025-10-23 12:37:02
0aa2e5ca-3f64-482b-aa82-eaf04bcf73ea	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	retrait	6539.00	392278.00	385739.00	FCFA	Paiement par carte	\N	2025-05-08 11:52:36	2025-10-23 12:37:02
53f7eb83-1ca4-48ba-8c3b-4ec23ed0ed40	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	retrait	47980.00	392278.00	344298.00	FCFA	Retrait d'espèces	\N	2025-08-14 19:08:58	2025-10-23 12:37:02
2b5bf017-52b5-4c8e-96f9-f7cd36a9ce5e	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	retrait	24949.00	392278.00	367329.00	FCFA	Prélèvement automatique	\N	2025-09-05 01:26:15	2025-10-23 12:37:02
a30f6bda-9713-4085-a355-83517ab64e23	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	depot	38364.00	392278.00	430642.00	FCFA	Dépôt espèces guichet	\N	2025-04-26 18:30:32	2025-10-23 12:37:02
14728fde-4eef-4c43-aff9-684cb06fc8e2	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	retrait	45491.00	392278.00	346787.00	FCFA	Paiement par carte	\N	2025-07-04 11:44:00	2025-10-23 12:37:02
dde0ba36-68e0-486a-8f64-d5f6d19316df	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	retrait	31810.00	392278.00	360468.00	FCFA	Retrait DAB	\N	2025-10-19 05:52:11	2025-10-23 12:37:02
d356b4f2-d2b2-4a76-ad5c-0d5b771cce92	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	virement	23963.00	392278.00	368315.00	FCFA	Virement salaire	8cc906e8-f49e-48bf-97f7-063a96dd5855	2025-09-23 08:25:23	2025-10-23 12:37:02
5db01210-e8c1-47b6-95af-97ef91baa6c5	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	virement	29424.00	392278.00	362854.00	FCFA	Virement salaire	2bdeac76-dcb7-4710-9060-e9ca98012722	2025-07-18 11:35:41	2025-10-23 12:37:02
03da654a-59e5-49c6-9a09-a16e720b8f26	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	virement	19324.00	392278.00	372954.00	FCFA	Paiement facture	d0f4f273-6422-4408-950f-61e6f8d23373	2025-06-08 05:07:48	2025-10-23 12:37:02
1f717487-bdc8-483a-8743-a65282780a47	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	depot	47069.00	392278.00	439347.00	FCFA	Dépôt d'espèces	\N	2025-06-10 22:38:25	2025-10-23 12:37:02
e5bd419d-6185-411a-a9fa-adac49ba60db	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	virement	16850.00	392278.00	375428.00	FCFA	Virement vers compte	792c8ff4-749b-469b-95d0-9b98c2283684	2025-07-21 21:27:25	2025-10-23 12:37:02
f98fc622-7579-4727-ba8a-76b0328ab726	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	retrait	28305.00	392278.00	363973.00	FCFA	Retrait guichet	\N	2025-10-09 21:18:03	2025-10-23 12:37:02
deacff06-d2b3-455e-8562-04d95aaf78af	e2f7fd9b-5e83-4d6f-b86e-70b6e11b5207	virement	48471.00	392278.00	343807.00	FCFA	Transfert bancaire	087d0d47-8377-4f2f-82a8-6acbc6e148f1	2025-06-23 02:31:10	2025-10-23 12:37:02
cb6be9f9-a2c3-4fdf-8e81-3448a09b53ca	7bd3be9f-34e2-4eeb-9f78-a68c083c1a96	depot	44068.00	281164.00	325232.00	FCFA	Versement salaire	\N	2025-09-06 10:43:36	2025-10-23 12:37:02
5d0bb121-cbfc-43f0-b5f7-34520dff7061	7bd3be9f-34e2-4eeb-9f78-a68c083c1a96	retrait	38073.00	281164.00	243091.00	FCFA	Retrait d'espèces	\N	2025-06-15 21:41:38	2025-10-23 12:37:02
1bd832e9-aa16-47d0-a71d-3f13780dcfd4	7bd3be9f-34e2-4eeb-9f78-a68c083c1a96	retrait	20754.00	281164.00	260410.00	FCFA	Paiement par carte	\N	2025-10-02 08:55:44	2025-10-23 12:37:02
5871debd-669a-44ca-8cc2-31dafeb8337e	7bd3be9f-34e2-4eeb-9f78-a68c083c1a96	retrait	15683.00	281164.00	265481.00	FCFA	Retrait guichet	\N	2025-09-12 12:33:56	2025-10-23 12:37:02
d5b36596-b3c0-49bd-99cc-7cfb07ac9238	7bd3be9f-34e2-4eeb-9f78-a68c083c1a96	depot	13674.00	281164.00	294838.00	FCFA	Dépôt espèces guichet	\N	2025-07-30 01:56:38	2025-10-23 12:37:02
aedfb479-7215-467a-9058-0b1fb360d7eb	7bd3be9f-34e2-4eeb-9f78-a68c083c1a96	depot	43219.00	281164.00	324383.00	FCFA	Dépôt espèces guichet	\N	2025-06-26 12:22:28	2025-10-23 12:37:02
e9c7dbb8-bda2-4c79-b9da-3b883afccf72	7bd3be9f-34e2-4eeb-9f78-a68c083c1a96	retrait	4827.00	281164.00	276337.00	FCFA	Retrait d'espèces	\N	2025-07-01 17:58:45	2025-10-23 12:37:02
1534ddf2-388b-44b8-afa6-6856a8c0a83b	5d3634bb-39ae-4beb-a70d-3f7ac49f03cf	depot	7067.00	292214.00	299281.00	FCFA	Dépôt d'espèces	\N	2025-07-15 05:29:51	2025-10-23 12:37:02
e2e32af9-10ba-4946-8d5d-ebf239f266b5	5d3634bb-39ae-4beb-a70d-3f7ac49f03cf	retrait	5173.00	292214.00	287041.00	FCFA	Retrait d'espèces	\N	2025-08-19 04:59:35	2025-10-23 12:37:02
c8569e92-cddc-41fd-832c-ecdbff5d546e	5d3634bb-39ae-4beb-a70d-3f7ac49f03cf	retrait	30061.00	292214.00	262153.00	FCFA	Retrait guichet	\N	2025-10-21 09:44:56	2025-10-23 12:37:02
86cca5bc-39c3-4de2-b055-47858729a3d1	5d3634bb-39ae-4beb-a70d-3f7ac49f03cf	retrait	19472.00	292214.00	272742.00	FCFA	Retrait DAB	\N	2025-08-19 06:26:30	2025-10-23 12:37:02
435301ce-59b8-49ff-8c31-ed570ed5adb4	5d3634bb-39ae-4beb-a70d-3f7ac49f03cf	depot	5126.00	292214.00	297340.00	FCFA	Dépôt espèces guichet	\N	2025-10-15 20:03:36	2025-10-23 12:37:02
4962cd36-1bf5-4502-bad9-636b36fc3c47	5d3634bb-39ae-4beb-a70d-3f7ac49f03cf	depot	39098.00	292214.00	331312.00	FCFA	Dépôt chèque	\N	2025-09-16 06:33:18	2025-10-23 12:37:02
c1ae5c10-2e33-4916-b976-bf7a99191a71	5d3634bb-39ae-4beb-a70d-3f7ac49f03cf	retrait	29924.00	292214.00	262290.00	FCFA	Retrait guichet	\N	2025-06-29 16:01:48	2025-10-23 12:37:02
0c642839-e533-4b4d-a171-66538b853605	5d3634bb-39ae-4beb-a70d-3f7ac49f03cf	virement	30909.00	292214.00	261305.00	FCFA	Paiement facture	78038c23-dabc-4bd2-a4b5-e1c09089f492	2025-05-13 09:01:01	2025-10-23 12:37:02
9c385e13-e3f3-44fc-a47e-35ea6b3e5ac5	13b0280b-a95f-48ee-9c35-9fb3c4786166	virement	3088.00	14334.00	11246.00	FCFA	Virement vers compte	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	2025-04-30 14:26:11	2025-10-23 12:37:02
4fcaff8c-525d-4859-9ed1-e3df2fffa207	13b0280b-a95f-48ee-9c35-9fb3c4786166	virement	7070.00	14334.00	7264.00	FCFA	Transfert entre comptes	6a3575bc-ab64-4315-8ed7-124955e9c44f	2025-05-26 23:53:43	2025-10-23 12:37:02
b2dc70e0-20c3-4ec7-b24b-99240a5654ef	13b0280b-a95f-48ee-9c35-9fb3c4786166	depot	10586.00	14334.00	24920.00	FCFA	Dépôt d'espèces	\N	2025-10-22 03:12:57	2025-10-23 12:37:02
a2d417a2-155f-4a94-8110-6baad9db9af8	13b0280b-a95f-48ee-9c35-9fb3c4786166	retrait	2934.00	14334.00	11400.00	FCFA	Retrait DAB	\N	2025-10-11 22:28:41	2025-10-23 12:37:02
17085a8d-fb5d-40d7-bc27-960559d8d470	13b0280b-a95f-48ee-9c35-9fb3c4786166	retrait	11402.00	14334.00	2932.00	FCFA	Paiement par carte	\N	2025-06-19 10:12:45	2025-10-23 12:37:02
76795419-b333-48f2-942e-5c3e25fa9ca2	13b0280b-a95f-48ee-9c35-9fb3c4786166	virement	20159.00	14334.00	0.00	FCFA	Virement vers compte	3badd48d-41cc-4d4c-abfa-55dd1b3e0c1e	2025-06-29 09:11:00	2025-10-23 12:37:02
57e66043-39aa-4660-bc2b-af12aa2936ea	13b0280b-a95f-48ee-9c35-9fb3c4786166	virement	29010.00	14334.00	0.00	FCFA	Transfert entre comptes	36a3d1ae-e772-42c5-8ca9-b9ca00b1386e	2025-06-05 22:34:03	2025-10-23 12:37:02
a840d4fa-62b4-487c-95f9-cb02c4f18638	13b0280b-a95f-48ee-9c35-9fb3c4786166	retrait	10632.00	14334.00	3702.00	FCFA	Retrait guichet	\N	2025-10-05 05:18:23	2025-10-23 12:37:02
01956795-b09a-4d0b-bd16-f1a18cfef364	13b0280b-a95f-48ee-9c35-9fb3c4786166	depot	5129.00	14334.00	19463.00	FCFA	Dépôt chèque	\N	2025-10-13 21:15:06	2025-10-23 12:37:02
68d7ad99-d90a-4f4d-aea1-b585a15395d3	dbcd0804-e931-4453-9ad5-f978ceebb511	retrait	9312.00	322418.00	313106.00	FCFA	Retrait DAB	\N	2025-06-13 11:32:12	2025-10-23 12:37:02
11044ede-707c-442a-918f-aa984e2147a7	dbcd0804-e931-4453-9ad5-f978ceebb511	retrait	26918.00	322418.00	295500.00	FCFA	Retrait DAB	\N	2025-06-01 10:57:17	2025-10-23 12:37:02
218082b5-5603-48b8-8c5d-86c98ff7cf43	dbcd0804-e931-4453-9ad5-f978ceebb511	retrait	34297.00	322418.00	288121.00	FCFA	Paiement par carte	\N	2025-06-22 12:18:11	2025-10-23 12:37:02
de11b8b8-90ed-4459-a2a2-034e3e134235	dbcd0804-e931-4453-9ad5-f978ceebb511	retrait	20034.00	322418.00	302384.00	FCFA	Retrait guichet	\N	2025-05-18 18:48:45	2025-10-23 12:37:02
112c6972-977b-4971-bdf7-c26e9be33f22	dbcd0804-e931-4453-9ad5-f978ceebb511	retrait	47801.00	322418.00	274617.00	FCFA	Retrait DAB	\N	2025-09-02 20:08:10	2025-10-23 12:37:02
ebdc0d6e-b7ab-4593-aae5-a72c382f3818	dbcd0804-e931-4453-9ad5-f978ceebb511	virement	41872.00	322418.00	280546.00	FCFA	Virement salaire	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	2025-05-25 18:20:08	2025-10-23 12:37:02
e7593256-a261-41b1-a18b-a2ae6fc9d4a5	dbcd0804-e931-4453-9ad5-f978ceebb511	retrait	20919.00	322418.00	301499.00	FCFA	Paiement par carte	\N	2025-06-25 03:05:19	2025-10-23 12:37:02
6042bbb4-fc29-4986-ba54-d65db6f63e5d	dbcd0804-e931-4453-9ad5-f978ceebb511	virement	15960.00	322418.00	306458.00	FCFA	Virement vers compte	4bf8b802-4714-4aba-a825-d61404c9d50f	2025-07-21 04:30:49	2025-10-23 12:37:02
f577bb7f-dc4f-46b1-b019-b9354ca866a3	dbcd0804-e931-4453-9ad5-f978ceebb511	retrait	18049.00	322418.00	304369.00	FCFA	Prélèvement automatique	\N	2025-09-12 04:15:44	2025-10-23 12:37:02
9c9d31bd-910d-423d-af5c-4cbe5dbcb70c	dbcd0804-e931-4453-9ad5-f978ceebb511	retrait	2370.00	322418.00	320048.00	FCFA	Retrait guichet	\N	2025-09-03 05:45:00	2025-10-23 12:37:02
4a67c1dd-3787-44cf-9eba-59b6baf40c3a	dbcd0804-e931-4453-9ad5-f978ceebb511	retrait	25337.00	322418.00	297081.00	FCFA	Prélèvement automatique	\N	2025-08-24 16:52:12	2025-10-23 12:37:02
5f9921ba-8d23-482d-b753-ce649c206915	dbcd0804-e931-4453-9ad5-f978ceebb511	virement	31575.00	322418.00	290843.00	FCFA	Transfert entre comptes	edc37cd9-41c0-44ba-a8a4-f7da20914b48	2025-04-27 01:27:29	2025-10-23 12:37:02
85645ab6-117b-485b-ae8e-babb0dec6bcf	dbcd0804-e931-4453-9ad5-f978ceebb511	depot	41696.00	322418.00	364114.00	FCFA	Dépôt chèque	\N	2025-10-13 11:16:24	2025-10-23 12:37:02
898c5f0c-b184-426a-94b8-ce98043c6100	dbcd0804-e931-4453-9ad5-f978ceebb511	depot	25672.00	322418.00	348090.00	FCFA	Dépôt espèces guichet	\N	2025-10-13 07:33:04	2025-10-23 12:37:02
898a4552-beb5-49b3-8ecd-61b33b6a1158	dbcd0804-e931-4453-9ad5-f978ceebb511	virement	26095.00	322418.00	296323.00	FCFA	Transfert bancaire	0f731b08-109a-4e89-972b-71f8608c0c55	2025-10-02 00:24:55	2025-10-23 12:37:02
81da51b8-51a4-4ed1-bfac-f5fa4a29dd92	b9dbc5e1-4932-4b18-9442-6fbf74b31327	depot	27701.00	488240.00	515941.00	FCFA	Dépôt espèces guichet	\N	2025-09-15 02:05:06	2025-10-23 12:37:02
33e07a51-508a-4bdb-973a-a340979bcd5a	b9dbc5e1-4932-4b18-9442-6fbf74b31327	retrait	2922.00	488240.00	485318.00	FCFA	Prélèvement automatique	\N	2025-07-12 08:30:12	2025-10-23 12:37:02
97389205-a43e-417e-b1ca-9ee4fd8af512	b9dbc5e1-4932-4b18-9442-6fbf74b31327	depot	24754.00	488240.00	512994.00	FCFA	Dépôt d'espèces	\N	2025-07-06 02:03:42	2025-10-23 12:37:02
ad16ff93-fbfe-4c07-b71d-0afdedde5400	b9dbc5e1-4932-4b18-9442-6fbf74b31327	retrait	9460.00	488240.00	478780.00	FCFA	Retrait guichet	\N	2025-09-04 00:16:23	2025-10-23 12:37:02
ea14e2a9-592a-4dcf-967a-00fac6cd22df	b9dbc5e1-4932-4b18-9442-6fbf74b31327	depot	34529.00	488240.00	522769.00	FCFA	Dépôt chèque	\N	2025-08-16 17:34:13	2025-10-23 12:37:02
fbba9982-b5a0-4795-903a-80655af99ec4	b9dbc5e1-4932-4b18-9442-6fbf74b31327	retrait	18217.00	488240.00	470023.00	FCFA	Retrait guichet	\N	2025-07-28 05:01:05	2025-10-23 12:37:02
867672fc-4a55-4baf-ad06-fcdcad2e379f	b9dbc5e1-4932-4b18-9442-6fbf74b31327	retrait	23294.00	488240.00	464946.00	FCFA	Retrait DAB	\N	2025-06-26 23:47:04	2025-10-23 12:37:02
68fefaa3-25e4-4be8-929d-d31bc9e17549	b9dbc5e1-4932-4b18-9442-6fbf74b31327	depot	2163.00	488240.00	490403.00	FCFA	Versement salaire	\N	2025-08-22 06:30:31	2025-10-23 12:37:02
07472bd2-ebe5-4125-8441-272c29fcae1b	b9dbc5e1-4932-4b18-9442-6fbf74b31327	depot	4003.00	488240.00	492243.00	FCFA	Virement bancaire entrant	\N	2025-07-28 11:17:04	2025-10-23 12:37:02
e0cb8d12-4d52-426b-baec-79f53a995a76	5930a704-1cad-486a-bb5e-d5ebac8129b9	depot	41827.00	54493.00	96320.00	FCFA	Versement salaire	\N	2025-06-11 22:24:21	2025-10-23 12:37:02
6fcbd2a0-51cf-40c0-bbd0-5e78881641da	5930a704-1cad-486a-bb5e-d5ebac8129b9	retrait	29142.00	54493.00	25351.00	FCFA	Retrait d'espèces	\N	2025-05-31 01:29:25	2025-10-23 12:37:02
4b019251-e2d1-43d7-bff7-d352aba42e0f	5930a704-1cad-486a-bb5e-d5ebac8129b9	retrait	29229.00	54493.00	25264.00	FCFA	Retrait DAB	\N	2025-04-29 11:17:12	2025-10-23 12:37:02
151ce072-d25c-4612-aa03-677492138c95	5930a704-1cad-486a-bb5e-d5ebac8129b9	virement	21467.00	54493.00	33026.00	FCFA	Paiement facture	dbcd0804-e931-4453-9ad5-f978ceebb511	2025-10-19 01:05:20	2025-10-23 12:37:02
629cc209-884e-4aca-add5-1b7c0e750822	5930a704-1cad-486a-bb5e-d5ebac8129b9	depot	22819.00	54493.00	77312.00	FCFA	Virement bancaire entrant	\N	2025-10-06 07:16:53	2025-10-23 12:37:02
3883e734-67e0-41c8-ae67-36c0533578db	5930a704-1cad-486a-bb5e-d5ebac8129b9	retrait	28317.00	54493.00	26176.00	FCFA	Prélèvement automatique	\N	2025-06-01 11:14:48	2025-10-23 12:37:02
8adb51b1-11b2-459b-9a37-1778b29c9f91	5930a704-1cad-486a-bb5e-d5ebac8129b9	depot	4524.00	54493.00	59017.00	FCFA	Dépôt chèque	\N	2025-05-01 13:05:37	2025-10-23 12:37:02
335aac30-4b53-4b38-ad26-6b535e15747d	5930a704-1cad-486a-bb5e-d5ebac8129b9	retrait	8207.00	54493.00	46286.00	FCFA	Prélèvement automatique	\N	2025-09-12 00:08:34	2025-10-23 12:37:02
f237ca8e-6c64-4b6b-93c8-99fb3012d5cb	5930a704-1cad-486a-bb5e-d5ebac8129b9	depot	4958.00	54493.00	59451.00	FCFA	Dépôt d'espèces	\N	2025-04-25 07:21:26	2025-10-23 12:37:02
31ef320c-8bcc-4330-ac98-5e3a1aff7c0f	5930a704-1cad-486a-bb5e-d5ebac8129b9	depot	41166.00	54493.00	95659.00	FCFA	Versement salaire	\N	2025-06-04 09:54:48	2025-10-23 12:37:02
6395f183-a805-46bc-b6e4-a372e48f17a4	5930a704-1cad-486a-bb5e-d5ebac8129b9	depot	24042.00	54493.00	78535.00	FCFA	Dépôt chèque	\N	2025-07-01 08:04:29	2025-10-23 12:37:02
e880ee5c-326d-4d28-ae75-ac02b0e03fe0	5930a704-1cad-486a-bb5e-d5ebac8129b9	depot	12644.00	54493.00	67137.00	FCFA	Dépôt espèces guichet	\N	2025-07-12 10:28:49	2025-10-23 12:37:02
c7bc9ae5-38e3-4aee-ae51-5b092a3faabf	5930a704-1cad-486a-bb5e-d5ebac8129b9	virement	3186.00	54493.00	51307.00	FCFA	Virement vers compte	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	2025-10-02 04:09:00	2025-10-23 12:37:02
76b6a871-4b6b-47df-9218-5e2529761d63	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	retrait	42720.00	53357.00	10637.00	FCFA	Prélèvement automatique	\N	2025-07-30 22:58:50	2025-10-23 12:37:02
9550e9a4-b850-4309-92c9-611620c94c35	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	depot	22778.00	53357.00	76135.00	FCFA	Versement salaire	\N	2025-06-06 14:37:22	2025-10-23 12:37:02
ab8d0640-f69b-4ccb-ac87-bdf6ccf4c16a	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	retrait	33104.00	53357.00	20253.00	FCFA	Prélèvement automatique	\N	2025-05-24 17:27:37	2025-10-23 12:37:02
31e2c4cf-a208-4579-bec2-d1fa1d5f6864	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	virement	42461.00	53357.00	10896.00	FCFA	Virement vers compte	4e0954f5-1956-40db-b392-7a6ee455c257	2025-10-15 20:01:29	2025-10-23 12:37:02
8991ea99-9e45-4aaf-aad0-11bef5c0c209	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	retrait	34057.00	53357.00	19300.00	FCFA	Paiement par carte	\N	2025-09-02 02:01:57	2025-10-23 12:37:02
f90bb308-9c97-43a5-b505-06822328c3f9	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	virement	14285.00	53357.00	39072.00	FCFA	Virement salaire	e4d1caea-baee-4c55-aa8d-8208a299a3f7	2025-08-09 15:17:29	2025-10-23 12:37:02
500e47de-8cdd-4b44-a912-f7283175e216	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	retrait	26751.00	53357.00	26606.00	FCFA	Retrait guichet	\N	2025-04-29 04:27:19	2025-10-23 12:37:02
6f4286f1-91d8-4aef-85d2-5226c3bd52cf	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	depot	40305.00	53357.00	93662.00	FCFA	Virement bancaire entrant	\N	2025-09-07 04:26:55	2025-10-23 12:37:02
5a9d2fc2-f0f5-492c-ab97-c84770f71f50	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	retrait	3557.00	53357.00	49800.00	FCFA	Retrait DAB	\N	2025-08-24 18:10:47	2025-10-23 12:37:02
5e501739-391e-4ae6-84f5-560d408112d7	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	virement	9019.00	53357.00	44338.00	FCFA	Transfert bancaire	0f731b08-109a-4e89-972b-71f8608c0c55	2025-05-23 02:29:36	2025-10-23 12:37:02
4b97290f-ae03-4303-901f-423ce3b8fd62	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	virement	11556.00	53357.00	41801.00	FCFA	Transfert bancaire	4bf8b802-4714-4aba-a825-d61404c9d50f	2025-10-07 15:39:19	2025-10-23 12:37:02
5b7fa59c-70fc-498e-9006-722f38d5330b	5ba623c4-04fe-4bf9-a27e-bcd2bb6a1759	retrait	16116.00	53357.00	37241.00	FCFA	Retrait guichet	\N	2025-08-02 13:15:50	2025-10-23 12:37:02
7ac9c13e-24b5-41f3-b3e7-4362bdf87731	82b41651-c63d-4deb-85c6-3c688eddc121	depot	1135.00	140522.00	141657.00	FCFA	Versement salaire	\N	2025-09-13 01:19:33	2025-10-23 12:37:02
676ecd20-92dc-402d-81f5-66531e427745	82b41651-c63d-4deb-85c6-3c688eddc121	depot	39684.00	140522.00	180206.00	FCFA	Virement bancaire entrant	\N	2025-09-04 22:08:46	2025-10-23 12:37:02
a5f633da-ee7e-4665-9ebb-feddb09d8881	82b41651-c63d-4deb-85c6-3c688eddc121	retrait	37410.00	140522.00	103112.00	FCFA	Retrait guichet	\N	2025-09-15 17:26:41	2025-10-23 12:37:02
8966c506-3c20-47d3-a5e3-b652ededdc14	82b41651-c63d-4deb-85c6-3c688eddc121	retrait	25227.00	140522.00	115295.00	FCFA	Retrait d'espèces	\N	2025-07-11 01:08:40	2025-10-23 12:37:02
9b555874-9da3-4708-8843-b4b41da516d1	82b41651-c63d-4deb-85c6-3c688eddc121	virement	9179.00	140522.00	131343.00	FCFA	Transfert entre comptes	65a4491c-ce37-4732-aa4f-0de79bc822d1	2025-07-10 00:32:54	2025-10-23 12:37:02
e0ac5e70-1162-4845-a141-0ea871ab3110	82b41651-c63d-4deb-85c6-3c688eddc121	depot	10573.00	140522.00	151095.00	FCFA	Virement bancaire entrant	\N	2025-07-13 11:49:40	2025-10-23 12:37:02
5e6b2cc6-4936-4b16-bac6-75ea3937ec88	82b41651-c63d-4deb-85c6-3c688eddc121	depot	9854.00	140522.00	150376.00	FCFA	Dépôt espèces guichet	\N	2025-04-23 21:52:17	2025-10-23 12:37:02
c79c11a4-54ae-49fa-8fa1-54e8aeb523a9	82b41651-c63d-4deb-85c6-3c688eddc121	retrait	18909.00	140522.00	121613.00	FCFA	Retrait guichet	\N	2025-09-08 09:22:17	2025-10-23 12:37:02
7a4bf139-6b60-403e-8b83-0f81891dce2e	82b41651-c63d-4deb-85c6-3c688eddc121	retrait	23054.00	140522.00	117468.00	FCFA	Retrait guichet	\N	2025-07-28 09:39:53	2025-10-23 12:37:02
c25673b2-9b8d-4cb3-882b-b29aca904426	82b41651-c63d-4deb-85c6-3c688eddc121	depot	29003.00	140522.00	169525.00	FCFA	Virement bancaire entrant	\N	2025-06-07 13:35:52	2025-10-23 12:37:02
9a9f8cfb-6fe6-4163-b47c-d07a29f6db5d	82b41651-c63d-4deb-85c6-3c688eddc121	depot	40692.00	140522.00	181214.00	FCFA	Dépôt d'espèces	\N	2025-06-19 23:29:16	2025-10-23 12:37:02
099b44f9-9764-4d84-90d6-bcda0575ea2f	82b41651-c63d-4deb-85c6-3c688eddc121	virement	13254.00	140522.00	127268.00	FCFA	Virement salaire	3b545ec9-8048-4c12-a074-df603671d400	2025-07-04 12:29:23	2025-10-23 12:37:02
4b2634f8-da82-49ed-9835-516474735a85	82b41651-c63d-4deb-85c6-3c688eddc121	depot	25151.00	140522.00	165673.00	FCFA	Dépôt chèque	\N	2025-09-07 19:45:13	2025-10-23 12:37:02
d888d60d-2c8a-4385-8ad5-6977aaff30f2	82b41651-c63d-4deb-85c6-3c688eddc121	virement	16677.00	140522.00	123845.00	FCFA	Virement salaire	da2856ae-33c2-4d43-959c-2eb0fa7dcffd	2025-07-28 04:48:09	2025-10-23 12:37:02
02940a79-02fd-47d5-acc7-6e9fd82c238e	be33e282-23c2-42e0-8042-11f125606cb1	virement	32983.00	220301.00	187318.00	FCFA	Paiement facture	2afce742-17e9-45bc-99be-9389a26da3ca	2025-05-26 02:20:06	2025-10-23 12:37:02
40e4a743-07e2-4b17-96cd-a9bfd8c7ab1d	be33e282-23c2-42e0-8042-11f125606cb1	virement	19123.00	220301.00	201178.00	FCFA	Transfert entre comptes	bc779c73-ecf7-44f0-9794-281f495b5ff5	2025-05-27 13:57:17	2025-10-23 12:37:02
a8a53e9e-98f5-4723-b0fe-e23542d14948	be33e282-23c2-42e0-8042-11f125606cb1	retrait	22605.00	220301.00	197696.00	FCFA	Paiement par carte	\N	2025-07-13 17:53:31	2025-10-23 12:37:02
c26e2c73-da4c-4476-9c5b-04931b31a903	be33e282-23c2-42e0-8042-11f125606cb1	virement	17115.00	220301.00	203186.00	FCFA	Virement salaire	db289a68-fb56-4357-aa96-60bcaab5608f	2025-08-25 13:32:22	2025-10-23 12:37:02
1aa4dcb4-4d86-42c0-bab0-365b90205354	be33e282-23c2-42e0-8042-11f125606cb1	retrait	31722.00	220301.00	188579.00	FCFA	Retrait DAB	\N	2025-08-19 08:04:55	2025-10-23 12:37:02
45babd08-2b82-45c8-b0a4-4a118f10b88b	be33e282-23c2-42e0-8042-11f125606cb1	virement	20644.00	220301.00	199657.00	FCFA	Virement salaire	1b7cd94f-0234-49b8-9971-c35f0b951189	2025-05-10 20:19:41	2025-10-23 12:37:02
f80ce9b9-8e81-4471-9fff-f21148503b6b	be33e282-23c2-42e0-8042-11f125606cb1	retrait	21961.00	220301.00	198340.00	FCFA	Retrait d'espèces	\N	2025-06-27 22:15:28	2025-10-23 12:37:02
908e69fe-869d-4654-8a0e-1fc50e31afda	be33e282-23c2-42e0-8042-11f125606cb1	retrait	14034.00	220301.00	206267.00	FCFA	Retrait d'espèces	\N	2025-09-13 00:35:02	2025-10-23 12:37:02
7e669688-1bda-4abf-8ee2-a5792d665117	24e04f46-72df-4b0e-9024-19c114c552aa	depot	19765.00	95257.00	115022.00	FCFA	Dépôt chèque	\N	2025-06-15 20:29:06	2025-10-23 12:37:02
849f01b8-f551-44e5-8c52-7ab3516509b5	24e04f46-72df-4b0e-9024-19c114c552aa	retrait	48292.00	95257.00	46965.00	FCFA	Retrait guichet	\N	2025-10-15 02:48:59	2025-10-23 12:37:02
b33cb515-8a33-4e8a-b46d-015655bb1f10	24e04f46-72df-4b0e-9024-19c114c552aa	retrait	14783.00	95257.00	80474.00	FCFA	Retrait d'espèces	\N	2025-05-30 05:09:27	2025-10-23 12:37:02
aa912ed3-63df-468f-96d6-7a9f0a5b82d2	24e04f46-72df-4b0e-9024-19c114c552aa	virement	47101.00	95257.00	48156.00	FCFA	Transfert entre comptes	a175ac58-1dc5-4041-b54b-19f48d3900a8	2025-09-15 17:45:15	2025-10-23 12:37:02
ecfcc855-89a9-43a1-bdb4-fe1faaf3f23f	24e04f46-72df-4b0e-9024-19c114c552aa	virement	46142.00	95257.00	49115.00	FCFA	Virement vers compte	be33e282-23c2-42e0-8042-11f125606cb1	2025-07-14 12:18:08	2025-10-23 12:37:02
a1e5f76c-0c8e-413f-b02a-67810b125a26	24e04f46-72df-4b0e-9024-19c114c552aa	depot	15070.00	95257.00	110327.00	FCFA	Dépôt d'espèces	\N	2025-07-01 09:59:39	2025-10-23 12:37:02
5ad72736-5788-4ad3-90e7-8079e3ea7d5d	24e04f46-72df-4b0e-9024-19c114c552aa	retrait	29531.00	95257.00	65726.00	FCFA	Retrait d'espèces	\N	2025-04-24 06:06:21	2025-10-23 12:37:02
a963534b-3498-4516-adf3-f2f30cb3c6d4	24e04f46-72df-4b0e-9024-19c114c552aa	retrait	32798.00	95257.00	62459.00	FCFA	Retrait DAB	\N	2025-10-03 17:44:12	2025-10-23 12:37:02
2a5667fc-35a6-4e12-a279-fa6c75c8d972	24e04f46-72df-4b0e-9024-19c114c552aa	virement	24206.00	95257.00	71051.00	FCFA	Virement vers compte	fe405432-6112-461d-87cd-a720335c4092	2025-05-12 03:18:41	2025-10-23 12:37:02
87cce5a5-b060-4feb-bec1-9a8d70c9ed48	24e04f46-72df-4b0e-9024-19c114c552aa	depot	6038.00	95257.00	101295.00	FCFA	Dépôt d'espèces	\N	2025-04-26 14:16:41	2025-10-23 12:37:02
0f97d4a7-bda2-40c4-82ef-7aaec3726721	24e04f46-72df-4b0e-9024-19c114c552aa	retrait	13006.00	95257.00	82251.00	FCFA	Retrait d'espèces	\N	2025-08-06 13:12:49	2025-10-23 12:37:02
be2d7fbc-781c-415b-a6e6-c647be617f15	24e04f46-72df-4b0e-9024-19c114c552aa	virement	46398.00	95257.00	48859.00	FCFA	Virement salaire	c7cca6e7-9120-40e6-b0a2-2d86941c73f5	2025-10-16 10:49:36	2025-10-23 12:37:02
c3325efd-931f-4796-815d-79c7140f1f6b	24e04f46-72df-4b0e-9024-19c114c552aa	depot	47753.00	95257.00	143010.00	FCFA	Dépôt d'espèces	\N	2025-06-07 02:35:08	2025-10-23 12:37:02
3c91d342-d40f-4019-9034-674942717e66	24e04f46-72df-4b0e-9024-19c114c552aa	virement	48693.00	95257.00	46564.00	FCFA	Virement salaire	54c98069-cb97-4a48-9c06-c8ed239ef726	2025-10-20 15:37:13	2025-10-23 12:37:02
e5ec27c4-df19-4260-b308-105d1a8020af	24e04f46-72df-4b0e-9024-19c114c552aa	virement	13996.00	95257.00	81261.00	FCFA	Virement vers compte	6bda7cb5-64c7-4f15-a2ac-be3c6f701017	2025-05-09 20:38:35	2025-10-23 12:37:02
be744805-d8ce-4483-b770-11d1612cb2d2	887e3007-f4a2-4b73-aee8-c70039319c5f	retrait	10155.00	166144.00	155989.00	FCFA	Prélèvement automatique	\N	2025-08-24 03:10:38	2025-10-23 12:37:02
0e81c441-ca5b-421a-9bef-5e6e47560739	887e3007-f4a2-4b73-aee8-c70039319c5f	retrait	26254.00	166144.00	139890.00	FCFA	Retrait d'espèces	\N	2025-07-02 16:20:02	2025-10-23 12:37:02
a3608e16-795f-409e-80fc-e9227b487a2a	887e3007-f4a2-4b73-aee8-c70039319c5f	virement	4830.00	166144.00	161314.00	FCFA	Paiement facture	027e5061-71c4-4a85-af3a-32a651974095	2025-09-19 18:07:08	2025-10-23 12:37:02
bf57dfa0-8c1b-40ea-9d20-a3a4be849613	887e3007-f4a2-4b73-aee8-c70039319c5f	virement	39875.00	166144.00	126269.00	FCFA	Transfert bancaire	2bdeac76-dcb7-4710-9060-e9ca98012722	2025-08-31 14:50:21	2025-10-23 12:37:02
2d4803b9-72dd-461b-b872-1e8dcad2084e	887e3007-f4a2-4b73-aee8-c70039319c5f	depot	27465.00	166144.00	193609.00	FCFA	Dépôt d'espèces	\N	2025-04-27 06:35:59	2025-10-23 12:37:02
5c873f22-7317-4edd-bc92-0aaa88002bcf	720b3789-49c5-4ccc-b8af-be59906bc1d3	retrait	7770.00	342469.00	334699.00	FCFA	Retrait guichet	\N	2025-07-04 20:42:50	2025-10-23 12:37:02
f11917d9-7387-4c4b-83c2-31ef6ae24e8e	720b3789-49c5-4ccc-b8af-be59906bc1d3	retrait	14547.00	342469.00	327922.00	FCFA	Paiement par carte	\N	2025-08-30 16:14:43	2025-10-23 12:37:02
012c1548-4626-48bb-92c9-fb8c07b90063	720b3789-49c5-4ccc-b8af-be59906bc1d3	depot	46454.00	342469.00	388923.00	FCFA	Dépôt espèces guichet	\N	2025-08-15 03:10:09	2025-10-23 12:37:02
a1cd3092-2a3b-43f1-9c48-4a64da8902c0	720b3789-49c5-4ccc-b8af-be59906bc1d3	depot	8401.00	342469.00	350870.00	FCFA	Virement bancaire entrant	\N	2025-10-13 05:18:37	2025-10-23 12:37:02
92eefc3d-42f1-4d4a-a99f-95ec25d6a7b4	720b3789-49c5-4ccc-b8af-be59906bc1d3	depot	44944.00	342469.00	387413.00	FCFA	Versement salaire	\N	2025-09-15 01:47:27	2025-10-23 12:37:02
0a7fee5a-fefc-43b6-9125-2e4614a7238a	720b3789-49c5-4ccc-b8af-be59906bc1d3	depot	25225.00	342469.00	367694.00	FCFA	Dépôt espèces guichet	\N	2025-09-15 03:25:46	2025-10-23 12:37:02
f8e35421-2e67-44a1-af1d-37c79e16d703	720b3789-49c5-4ccc-b8af-be59906bc1d3	retrait	41100.00	342469.00	301369.00	FCFA	Prélèvement automatique	\N	2025-08-11 01:40:18	2025-10-23 12:37:02
d1b2e1a6-68a9-4707-8a2c-2cb1ebede570	720b3789-49c5-4ccc-b8af-be59906bc1d3	depot	1446.00	342469.00	343915.00	FCFA	Virement bancaire entrant	\N	2025-10-14 03:37:02	2025-10-23 12:37:02
175e2a8f-1826-4a09-bced-3991dac435fd	720b3789-49c5-4ccc-b8af-be59906bc1d3	retrait	10744.00	342469.00	331725.00	FCFA	Retrait d'espèces	\N	2025-10-12 11:36:48	2025-10-23 12:37:02
b8ac68fe-3a22-48ae-9f89-5be2dadd07be	720b3789-49c5-4ccc-b8af-be59906bc1d3	depot	36170.00	342469.00	378639.00	FCFA	Versement salaire	\N	2025-09-28 13:33:04	2025-10-23 12:37:02
73572b00-f3d6-489b-8053-d3596705a2ef	720b3789-49c5-4ccc-b8af-be59906bc1d3	virement	42832.00	342469.00	299637.00	FCFA	Transfert entre comptes	727ed0a8-67ac-4066-84fe-a29a0e13bb30	2025-05-14 22:00:28	2025-10-23 12:37:02
ef381be2-029b-4bf8-a28f-b3643cad0089	720b3789-49c5-4ccc-b8af-be59906bc1d3	retrait	47472.00	342469.00	294997.00	FCFA	Retrait guichet	\N	2025-07-22 18:04:45	2025-10-23 12:37:02
605b6600-d509-423d-a100-5fb9a10020d6	720b3789-49c5-4ccc-b8af-be59906bc1d3	depot	30771.00	342469.00	373240.00	FCFA	Versement salaire	\N	2025-08-13 20:39:07	2025-10-23 12:37:02
bcfc9e12-cb42-4b27-8952-5fa60c4219eb	4bc9a980-1950-4ed8-9b41-bbb0a53a929c	depot	10859.00	359155.00	370014.00	FCFA	Virement bancaire entrant	\N	2025-07-06 08:31:14	2025-10-23 12:37:02
02b2b146-21fc-4195-9ef5-94a30ad91feb	4bc9a980-1950-4ed8-9b41-bbb0a53a929c	virement	15692.00	359155.00	343463.00	FCFA	Transfert bancaire	af23b369-6d2d-416a-9f80-93ac47b6dde3	2025-08-22 17:20:58	2025-10-23 12:37:02
a18313e0-3f4e-404d-b857-72f1c1767f70	4bc9a980-1950-4ed8-9b41-bbb0a53a929c	virement	13807.00	359155.00	345348.00	FCFA	Paiement facture	8d706bac-d7d8-4172-8d94-d1a8cdf604db	2025-06-24 16:03:41	2025-10-23 12:37:02
bab1a8c1-453f-42ab-b99c-51cf676f9d74	4bc9a980-1950-4ed8-9b41-bbb0a53a929c	retrait	19261.00	359155.00	339894.00	FCFA	Retrait DAB	\N	2025-09-24 03:57:57	2025-10-23 12:37:02
ce50df61-fe8c-4c42-9dda-c3430fe8c8b2	4bc9a980-1950-4ed8-9b41-bbb0a53a929c	virement	36401.00	359155.00	322754.00	FCFA	Virement vers compte	bbc061f8-caa3-41a2-a8d5-d8ceed5691e8	2025-10-07 10:30:14	2025-10-23 12:37:02
5735e762-c4de-499d-8f2b-8c5c20d79373	4bc9a980-1950-4ed8-9b41-bbb0a53a929c	depot	48374.00	359155.00	407529.00	FCFA	Dépôt d'espèces	\N	2025-08-07 12:07:22	2025-10-23 12:37:02
d60e8553-c6c8-4cae-89e1-103d5c9e7045	4bc9a980-1950-4ed8-9b41-bbb0a53a929c	virement	21123.00	359155.00	338032.00	FCFA	Virement salaire	f46f2dde-ba75-4234-b729-67c0cd2a3ade	2025-06-29 19:17:39	2025-10-23 12:37:02
d6408711-1423-4883-a8bc-3f41d5c7f7d6	4bc9a980-1950-4ed8-9b41-bbb0a53a929c	retrait	47098.00	359155.00	312057.00	FCFA	Paiement par carte	\N	2025-08-26 11:47:12	2025-10-23 12:37:02
c377338c-e895-452e-bd94-b7070b7464c8	4bc9a980-1950-4ed8-9b41-bbb0a53a929c	depot	9803.00	359155.00	368958.00	FCFA	Dépôt espèces guichet	\N	2025-09-18 08:13:02	2025-10-23 12:37:02
a9e51420-750d-452c-a1f0-f478283173ad	4bc9a980-1950-4ed8-9b41-bbb0a53a929c	retrait	28594.00	359155.00	330561.00	FCFA	Prélèvement automatique	\N	2025-07-04 09:47:13	2025-10-23 12:37:02
d2fb700b-0cdb-4ad4-b900-9a9b59e279ec	0b052b84-a33e-44e8-90f7-d9d1bfe27464	depot	21737.00	472393.00	494130.00	FCFA	Virement bancaire entrant	\N	2025-08-12 07:16:50	2025-10-23 12:37:02
113f0931-ae3c-4952-800f-86ca5896ee3b	0b052b84-a33e-44e8-90f7-d9d1bfe27464	depot	14120.00	472393.00	486513.00	FCFA	Virement bancaire entrant	\N	2025-08-01 20:17:38	2025-10-23 12:37:02
6050563c-c0d7-47f7-a720-c1ef7b652093	0b052b84-a33e-44e8-90f7-d9d1bfe27464	retrait	45353.00	472393.00	427040.00	FCFA	Retrait DAB	\N	2025-09-07 12:17:32	2025-10-23 12:37:02
f12ad37b-7521-4aed-a683-b51e8414b665	0b052b84-a33e-44e8-90f7-d9d1bfe27464	depot	4441.00	472393.00	476834.00	FCFA	Dépôt espèces guichet	\N	2025-09-13 08:02:28	2025-10-23 12:37:02
fb27755c-baa7-4d9a-9c7d-cacdf1050353	0b052b84-a33e-44e8-90f7-d9d1bfe27464	retrait	8338.00	472393.00	464055.00	FCFA	Retrait d'espèces	\N	2025-07-02 01:29:46	2025-10-23 12:37:02
529e7714-6f23-4397-9409-7a96fce5c255	0b052b84-a33e-44e8-90f7-d9d1bfe27464	retrait	28447.00	472393.00	443946.00	FCFA	Prélèvement automatique	\N	2025-07-26 17:12:25	2025-10-23 12:37:02
18039081-7620-4aba-bb35-29a2d8f47d32	0b052b84-a33e-44e8-90f7-d9d1bfe27464	depot	24384.00	472393.00	496777.00	FCFA	Dépôt espèces guichet	\N	2025-07-22 18:11:23	2025-10-23 12:37:02
bd0bfc5f-f55b-4c84-a3b4-988038980439	0b052b84-a33e-44e8-90f7-d9d1bfe27464	virement	36929.00	472393.00	435464.00	FCFA	Transfert bancaire	aefad6a9-6ff4-4250-b79c-50f551aaa60e	2025-06-15 08:23:14	2025-10-23 12:37:02
709b4be6-5cac-481c-8308-10a820646358	0b052b84-a33e-44e8-90f7-d9d1bfe27464	retrait	7289.00	472393.00	465104.00	FCFA	Retrait DAB	\N	2025-07-25 04:24:26	2025-10-23 12:37:02
85ceccc1-40e7-4f05-8aa1-7fe7a5c2b8ff	0b052b84-a33e-44e8-90f7-d9d1bfe27464	virement	9552.00	472393.00	462841.00	FCFA	Transfert entre comptes	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	2025-08-01 03:13:57	2025-10-23 12:37:02
a18f7105-e467-4892-86e0-9185eb21e5da	0b052b84-a33e-44e8-90f7-d9d1bfe27464	retrait	40186.00	472393.00	432207.00	FCFA	Retrait DAB	\N	2025-05-17 06:44:58	2025-10-23 12:37:02
e26b9659-3eb4-45b4-b9ce-442f88dd12cb	4bf8b802-4714-4aba-a825-d61404c9d50f	retrait	28632.00	337412.00	308780.00	FCFA	Retrait DAB	\N	2025-05-26 10:35:00	2025-10-23 12:37:02
5b76a314-edeb-4e78-a677-807a69d3cbef	4bf8b802-4714-4aba-a825-d61404c9d50f	virement	25374.00	337412.00	312038.00	FCFA	Transfert entre comptes	e7088ab6-655b-4317-8cdf-46d3de12e2f0	2025-04-28 17:22:31	2025-10-23 12:37:02
0e1e8e13-ca26-4b03-9bce-7495515f678e	4bf8b802-4714-4aba-a825-d61404c9d50f	retrait	20846.00	337412.00	316566.00	FCFA	Prélèvement automatique	\N	2025-06-17 18:32:20	2025-10-23 12:37:02
9e686e96-f129-4987-81da-c166c1418938	4bf8b802-4714-4aba-a825-d61404c9d50f	virement	47484.00	337412.00	289928.00	FCFA	Transfert bancaire	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	2025-06-25 18:03:37	2025-10-23 12:37:03
b18529ac-016d-472f-b115-0030f5fa6f59	4bf8b802-4714-4aba-a825-d61404c9d50f	virement	40110.00	337412.00	297302.00	FCFA	Paiement facture	76b21c81-8380-4df8-87ad-4f2fa9ff5159	2025-06-14 13:28:21	2025-10-23 12:37:03
0895af9a-7bcb-4a07-a5a3-0255f4e81e7c	4bf8b802-4714-4aba-a825-d61404c9d50f	virement	30744.00	337412.00	306668.00	FCFA	Transfert entre comptes	74dbd6c0-5b7d-41ee-ba16-196ff2fec124	2025-08-30 01:19:17	2025-10-23 12:37:03
010836e1-78f5-4638-9a71-9ee8dd2ffbd3	4bf8b802-4714-4aba-a825-d61404c9d50f	depot	38646.00	337412.00	376058.00	FCFA	Dépôt espèces guichet	\N	2025-06-04 19:52:48	2025-10-23 12:37:03
7d9cd54a-680a-4787-852d-a42ede66a59b	4bf8b802-4714-4aba-a825-d61404c9d50f	virement	39229.00	337412.00	298183.00	FCFA	Transfert bancaire	4bb7fc9b-13d6-4883-b751-283b753d05ed	2025-07-06 12:48:14	2025-10-23 12:37:03
83df7e8a-0b4b-4cd4-b16d-aa99cda1dee9	4bf8b802-4714-4aba-a825-d61404c9d50f	virement	5320.00	337412.00	332092.00	FCFA	Transfert entre comptes	aed8dd64-e196-4321-8ffc-52ce0cc7e7f7	2025-08-27 14:23:16	2025-10-23 12:37:03
d2978214-80a8-4628-9649-992ef40e58ba	4bf8b802-4714-4aba-a825-d61404c9d50f	retrait	7626.00	337412.00	329786.00	FCFA	Paiement par carte	\N	2025-07-22 21:50:18	2025-10-23 12:37:03
28951939-abef-4236-9172-62c65932e115	4bf8b802-4714-4aba-a825-d61404c9d50f	virement	41500.00	337412.00	295912.00	FCFA	Transfert entre comptes	43df68e0-310b-41d1-b272-3e281b325b72	2025-07-15 11:46:09	2025-10-23 12:37:03
ca63c4e8-0e87-4dde-950d-9101c8697385	4bf8b802-4714-4aba-a825-d61404c9d50f	retrait	28884.00	337412.00	308528.00	FCFA	Prélèvement automatique	\N	2025-06-29 12:04:37	2025-10-23 12:37:03
a4c9f26e-0f5f-4995-aa18-01c9c7f42586	4bf8b802-4714-4aba-a825-d61404c9d50f	retrait	25943.00	337412.00	311469.00	FCFA	Retrait DAB	\N	2025-05-04 15:12:26	2025-10-23 12:37:03
700acc3b-5c52-4a1b-bb2d-8183fced5b55	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	virement	21330.00	295765.00	274435.00	FCFA	Transfert entre comptes	cc0d2546-7dab-4d38-a26e-fedf481485db	2025-07-31 03:01:40	2025-10-23 12:37:03
552e213b-6201-4767-83be-ea6af1329a04	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	retrait	13464.00	295765.00	282301.00	FCFA	Paiement par carte	\N	2025-10-05 02:30:13	2025-10-23 12:37:03
4f9d2fda-6ec0-4ae3-af46-f6865dc80c8e	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	depot	11878.00	295765.00	307643.00	FCFA	Virement bancaire entrant	\N	2025-06-01 21:39:32	2025-10-23 12:37:03
bb2d817a-f2ad-4b50-9cd8-a42ceeca5f08	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	retrait	5105.00	295765.00	290660.00	FCFA	Prélèvement automatique	\N	2025-05-19 14:50:51	2025-10-23 12:37:03
23e32a78-fb03-440a-b9c6-0fb2eae61d45	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	depot	24156.00	295765.00	319921.00	FCFA	Dépôt chèque	\N	2025-09-20 13:29:15	2025-10-23 12:37:03
e5bf7711-6f63-4c90-b2ae-656bca9037f6	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	depot	22000.00	295765.00	317765.00	FCFA	Dépôt espèces guichet	\N	2025-10-09 10:45:02	2025-10-23 12:37:03
caf0fbff-3431-4aa1-973f-397ed82e4d5b	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	retrait	1278.00	295765.00	294487.00	FCFA	Retrait d'espèces	\N	2025-06-22 19:45:11	2025-10-23 12:37:03
22089acd-a5a7-42e5-af7c-d694901e4720	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	depot	29044.00	295765.00	324809.00	FCFA	Dépôt espèces guichet	\N	2025-04-29 04:13:04	2025-10-23 12:37:03
3e66c9aa-ebfc-4081-9032-7e93f7a96495	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	virement	19520.00	295765.00	276245.00	FCFA	Transfert bancaire	69e0c091-ecb6-4dfa-93ab-590209fb6e8b	2025-07-07 10:01:05	2025-10-23 12:37:03
3ef9f6d7-a20e-4213-996c-19b0c1eeb945	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	depot	46085.00	295765.00	341850.00	FCFA	Dépôt espèces guichet	\N	2025-08-19 18:45:09	2025-10-23 12:37:03
fefa88db-d613-4294-98c5-33d109f0c51f	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	virement	38189.00	295765.00	257576.00	FCFA	Virement vers compte	168369a2-765d-4e68-9282-e69cf56154cf	2025-10-03 05:34:23	2025-10-23 12:37:03
d5e26c38-f39f-4d1a-a424-27988d90cf41	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	virement	3961.00	295765.00	291804.00	FCFA	Transfert entre comptes	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	2025-06-18 16:14:58	2025-10-23 12:37:03
647d0bed-dfc5-493e-84e5-dd19939cd04a	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	virement	23433.00	295765.00	272332.00	FCFA	Paiement facture	43543b43-8884-4451-8a39-e16cf1e52d3c	2025-09-04 07:23:17	2025-10-23 12:37:03
55f9b87f-560d-41d8-a6b4-b66a37846fbf	e395646e-bf89-4d5f-8b0e-f9d01ef4f48a	virement	17523.00	295765.00	278242.00	FCFA	Paiement facture	3f0ff463-6bd5-4818-bfeb-0de1b5b02f4c	2025-05-21 21:32:25	2025-10-23 12:37:03
59f623de-dc42-4d89-b920-9a3921a47d74	503088f6-053b-4cbc-a00a-335ae839d447	virement	12356.00	241198.00	228842.00	FCFA	Virement vers compte	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	2025-04-27 00:23:12	2025-10-23 12:37:03
b1081929-7a0b-4c92-aa7b-1b69d00c7b48	503088f6-053b-4cbc-a00a-335ae839d447	retrait	48171.00	241198.00	193027.00	FCFA	Retrait guichet	\N	2025-07-06 14:56:33	2025-10-23 12:37:03
b53d7dc1-9751-4c87-ae80-e87f738565a4	503088f6-053b-4cbc-a00a-335ae839d447	virement	34964.00	241198.00	206234.00	FCFA	Virement vers compte	66b42124-fa11-4ffb-a2a3-1fbd435829d3	2025-07-08 06:47:45	2025-10-23 12:37:03
7dad6ad1-8622-424f-9e24-3330d0117007	503088f6-053b-4cbc-a00a-335ae839d447	retrait	23723.00	241198.00	217475.00	FCFA	Retrait DAB	\N	2025-08-13 03:43:23	2025-10-23 12:37:03
00624e07-32ba-450b-98cc-9a1308353724	503088f6-053b-4cbc-a00a-335ae839d447	depot	2342.00	241198.00	243540.00	FCFA	Dépôt d'espèces	\N	2025-07-20 20:59:21	2025-10-23 12:37:03
7cbaefd1-fca6-4e24-ad65-91bfc579a3cb	12a1bcc9-6ded-4708-8db3-3ebeb5632e08	virement	29020.00	272817.00	243797.00	FCFA	Virement salaire	968e30c7-1be0-4c05-98ba-5cb8d986a863	2025-06-05 21:22:13	2025-10-23 12:37:03
fbb7dc4c-fb55-4665-9e79-d18b05f4d23e	12a1bcc9-6ded-4708-8db3-3ebeb5632e08	retrait	47847.00	272817.00	224970.00	FCFA	Retrait guichet	\N	2025-09-05 16:56:30	2025-10-23 12:37:03
c7af5abb-7508-4f61-8b01-0a30af4d0cb0	12a1bcc9-6ded-4708-8db3-3ebeb5632e08	virement	46843.00	272817.00	225974.00	FCFA	Transfert bancaire	c7cca6e7-9120-40e6-b0a2-2d86941c73f5	2025-09-30 00:23:40	2025-10-23 12:37:03
704c96d8-cdaa-4ea4-9d98-19dba7ca39bb	12a1bcc9-6ded-4708-8db3-3ebeb5632e08	virement	41776.00	272817.00	231041.00	FCFA	Transfert entre comptes	b9dbc5e1-4932-4b18-9442-6fbf74b31327	2025-07-09 04:41:13	2025-10-23 12:37:03
16efd667-462b-481c-a540-dd72e9d54ca7	12a1bcc9-6ded-4708-8db3-3ebeb5632e08	virement	5149.00	272817.00	267668.00	FCFA	Virement vers compte	7bd3be9f-34e2-4eeb-9f78-a68c083c1a96	2025-08-24 10:41:57	2025-10-23 12:37:03
d88c6cea-f7f6-4e56-9212-379be4fcb682	12a1bcc9-6ded-4708-8db3-3ebeb5632e08	virement	42072.00	272817.00	230745.00	FCFA	Transfert bancaire	0b7246d3-cd3d-4162-952a-709242caabaf	2025-10-02 15:47:49	2025-10-23 12:37:03
55302a67-9f9e-4ecb-909c-4cf6b1c34c5e	12a1bcc9-6ded-4708-8db3-3ebeb5632e08	retrait	42712.00	272817.00	230105.00	FCFA	Retrait guichet	\N	2025-07-28 05:47:44	2025-10-23 12:37:03
d0c9cf0b-c078-419f-b23f-07539b27fe11	db289a68-fb56-4357-aa96-60bcaab5608f	depot	8262.00	259671.00	267933.00	FCFA	Dépôt d'espèces	\N	2025-08-14 02:23:34	2025-10-23 12:37:03
081c9f97-bc9d-448b-ac9c-376da274e088	db289a68-fb56-4357-aa96-60bcaab5608f	virement	5474.00	259671.00	254197.00	FCFA	Transfert bancaire	670d47d5-c9b1-44ca-a2c9-0eb0b507cb28	2025-09-19 19:08:26	2025-10-23 12:37:03
947f953e-aa89-46f5-9b0d-b3f477263e6b	db289a68-fb56-4357-aa96-60bcaab5608f	virement	6451.00	259671.00	253220.00	FCFA	Paiement facture	dfc99cb2-c0a4-4a17-9b0f-fa24bad877c3	2025-05-05 04:35:29	2025-10-23 12:37:03
e226f173-aeca-4fbb-9790-69d01ce84f0b	db289a68-fb56-4357-aa96-60bcaab5608f	retrait	10168.00	259671.00	249503.00	FCFA	Retrait guichet	\N	2025-08-03 23:24:42	2025-10-23 12:37:03
19784860-9eb4-4d7a-8f2f-258b833bab66	db289a68-fb56-4357-aa96-60bcaab5608f	retrait	28753.00	259671.00	230918.00	FCFA	Paiement par carte	\N	2025-06-17 21:49:16	2025-10-23 12:37:03
2309c44f-5721-4080-bda2-e197a62859ae	db289a68-fb56-4357-aa96-60bcaab5608f	virement	33405.00	259671.00	226266.00	FCFA	Transfert bancaire	2b138895-6391-4bfe-b137-ca4fa7854a4a	2025-05-27 18:34:26	2025-10-23 12:37:03
87edcc80-41c1-4c90-a365-c40d8e663ae4	db289a68-fb56-4357-aa96-60bcaab5608f	depot	39191.00	259671.00	298862.00	FCFA	Dépôt d'espèces	\N	2025-07-30 03:45:37	2025-10-23 12:37:03
0ea99a76-48a9-42e6-8c2b-19e595497f4f	db289a68-fb56-4357-aa96-60bcaab5608f	virement	26754.00	259671.00	232917.00	FCFA	Transfert bancaire	ac230aec-8c74-4964-ad30-44dbe9e58cc6	2025-05-09 18:52:19	2025-10-23 12:37:03
5de72812-a3c3-4097-b746-2eb92c21d38e	db289a68-fb56-4357-aa96-60bcaab5608f	retrait	2754.00	259671.00	256917.00	FCFA	Paiement par carte	\N	2025-09-29 21:16:59	2025-10-23 12:37:03
28b3e185-330f-4cc4-80bf-4f8f112117eb	65a4491c-ce37-4732-aa4f-0de79bc822d1	virement	4038.00	114127.00	110089.00	FCFA	Virement salaire	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	2025-08-23 17:57:03	2025-10-23 12:37:03
9e9b4732-bf34-44c4-a11b-74a171b057a9	65a4491c-ce37-4732-aa4f-0de79bc822d1	retrait	33374.00	114127.00	80753.00	FCFA	Prélèvement automatique	\N	2025-10-20 00:23:14	2025-10-23 12:37:03
24adf3ba-9a59-4375-9aee-cc607dcc66d4	65a4491c-ce37-4732-aa4f-0de79bc822d1	retrait	43462.00	114127.00	70665.00	FCFA	Retrait DAB	\N	2025-09-01 19:04:07	2025-10-23 12:37:03
8a230ce5-f834-480e-bb28-2471138c56c6	65a4491c-ce37-4732-aa4f-0de79bc822d1	depot	18597.00	114127.00	132724.00	FCFA	Virement bancaire entrant	\N	2025-06-07 06:03:01	2025-10-23 12:37:03
c1c2b45c-33b3-4327-a714-4979fa70eb2b	65a4491c-ce37-4732-aa4f-0de79bc822d1	depot	47626.00	114127.00	161753.00	FCFA	Versement salaire	\N	2025-05-07 10:05:25	2025-10-23 12:37:03
6f2c7464-901e-4ae6-ae12-555f05f65c35	65a4491c-ce37-4732-aa4f-0de79bc822d1	retrait	26211.00	114127.00	87916.00	FCFA	Prélèvement automatique	\N	2025-08-11 09:34:34	2025-10-23 12:37:03
2f91e8fd-6dce-4165-8233-e3d608a43feb	65a4491c-ce37-4732-aa4f-0de79bc822d1	retrait	21099.00	114127.00	93028.00	FCFA	Retrait DAB	\N	2025-10-17 07:50:11	2025-10-23 12:37:03
b9c0483b-1f10-4caf-89d8-c9e7519983c4	65a4491c-ce37-4732-aa4f-0de79bc822d1	depot	6553.00	114127.00	120680.00	FCFA	Virement bancaire entrant	\N	2025-10-05 11:52:53	2025-10-23 12:37:03
c84b579b-f1e4-446f-8059-7f1b4a52f3a8	65a4491c-ce37-4732-aa4f-0de79bc822d1	virement	24436.00	114127.00	89691.00	FCFA	Paiement facture	93ec7354-821a-4306-8dcb-5b911268af75	2025-05-20 20:56:43	2025-10-23 12:37:03
fa6526fd-c903-4fe2-8f1a-b31a244a8862	65a4491c-ce37-4732-aa4f-0de79bc822d1	depot	20255.00	114127.00	134382.00	FCFA	Dépôt espèces guichet	\N	2025-06-11 18:17:32	2025-10-23 12:37:03
d04f66db-e5a1-479d-b2bb-299173076a71	65a4491c-ce37-4732-aa4f-0de79bc822d1	depot	2818.00	114127.00	116945.00	FCFA	Dépôt chèque	\N	2025-08-18 05:30:32	2025-10-23 12:37:03
a9d44583-8e82-410e-bafb-9b6e37dab783	65a4491c-ce37-4732-aa4f-0de79bc822d1	virement	18370.00	114127.00	95757.00	FCFA	Virement salaire	08360cab-6365-4da0-80a5-721ba954e61c	2025-08-18 03:31:41	2025-10-23 12:37:03
aa62d95a-7ef4-4179-a028-c552ac034a3d	66b42124-fa11-4ffb-a2a3-1fbd435829d3	retrait	16638.00	216661.00	200023.00	FCFA	Retrait guichet	\N	2025-07-09 19:55:43	2025-10-23 12:37:03
32f53039-ddf0-4817-ab65-a57dc0829c06	66b42124-fa11-4ffb-a2a3-1fbd435829d3	retrait	32727.00	216661.00	183934.00	FCFA	Retrait guichet	\N	2025-05-06 17:10:50	2025-10-23 12:37:03
583aa16f-a751-4185-9e62-d7e47ebe901b	66b42124-fa11-4ffb-a2a3-1fbd435829d3	retrait	48704.00	216661.00	167957.00	FCFA	Retrait guichet	\N	2025-09-13 22:10:29	2025-10-23 12:37:03
676b615a-baca-46e2-bbfd-ebd2cd38d2a3	66b42124-fa11-4ffb-a2a3-1fbd435829d3	virement	20687.00	216661.00	195974.00	FCFA	Transfert entre comptes	a35ef6df-7249-4f6b-9cd3-9e292984d6ce	2025-08-06 07:04:33	2025-10-23 12:37:03
9b46ba21-c606-48d8-9110-86c1024a927a	66b42124-fa11-4ffb-a2a3-1fbd435829d3	virement	35996.00	216661.00	180665.00	FCFA	Transfert entre comptes	8d706bac-d7d8-4172-8d94-d1a8cdf604db	2025-05-23 20:34:58	2025-10-23 12:37:03
7593ec80-c035-43e5-83d1-d322cbf1ea0f	66b42124-fa11-4ffb-a2a3-1fbd435829d3	virement	16102.00	216661.00	200559.00	FCFA	Transfert bancaire	9119854e-1ca4-4c65-b01a-83ab7cc6baa7	2025-07-18 03:55:45	2025-10-23 12:37:03
d9e1c9ee-2eb8-45e5-b5f0-b000c1f990dc	66b42124-fa11-4ffb-a2a3-1fbd435829d3	retrait	28665.00	216661.00	187996.00	FCFA	Retrait d'espèces	\N	2025-10-03 09:24:33	2025-10-23 12:37:03
9c6bb9ae-6814-4402-ae62-90735e8e4880	94b4fef5-88d3-4b9a-98c9-1e0c6c697c0a	depot	26612.00	84171.00	110783.00	FCFA	Versement salaire	\N	2025-07-15 12:24:10	2025-10-23 12:37:03
376fc6e1-ccbd-42f4-9e4c-b31d192ffefc	94b4fef5-88d3-4b9a-98c9-1e0c6c697c0a	retrait	16778.00	84171.00	67393.00	FCFA	Retrait d'espèces	\N	2025-09-02 06:44:33	2025-10-23 12:37:03
827ccbfd-db3f-4e42-a675-5701a2d7bff9	94b4fef5-88d3-4b9a-98c9-1e0c6c697c0a	virement	41727.00	84171.00	42444.00	FCFA	Paiement facture	7b3221a6-3b25-4cc8-a934-e795af882682	2025-09-16 02:07:56	2025-10-23 12:37:03
507d0c6b-070b-4c73-95e9-7fa4f835583b	94b4fef5-88d3-4b9a-98c9-1e0c6c697c0a	depot	21367.00	84171.00	105538.00	FCFA	Dépôt chèque	\N	2025-09-18 03:32:40	2025-10-23 12:37:03
205d7f91-1ac2-400b-bfca-3d821a7cbd49	94b4fef5-88d3-4b9a-98c9-1e0c6c697c0a	retrait	33428.00	84171.00	50743.00	FCFA	Retrait guichet	\N	2025-10-09 20:37:52	2025-10-23 12:37:03
c0845c38-b8e7-4fe9-b4bc-ceb9497293e7	94b4fef5-88d3-4b9a-98c9-1e0c6c697c0a	retrait	49686.00	84171.00	34485.00	FCFA	Retrait guichet	\N	2025-07-13 10:58:54	2025-10-23 12:37:03
e6d25ec1-6354-465e-b9c6-d29b10350e0c	94b4fef5-88d3-4b9a-98c9-1e0c6c697c0a	virement	7133.00	84171.00	77038.00	FCFA	Paiement facture	70c6ea5c-2191-4fee-9f68-4d9f08dd1b29	2025-10-14 03:04:19	2025-10-23 12:37:03
fbc1aa8e-a2a9-4d09-b7b5-143d6296c23a	94b4fef5-88d3-4b9a-98c9-1e0c6c697c0a	retrait	27290.00	84171.00	56881.00	FCFA	Paiement par carte	\N	2025-10-12 09:42:26	2025-10-23 12:37:03
e500789f-e14d-4db7-90fc-7bf48e22c153	94b4fef5-88d3-4b9a-98c9-1e0c6c697c0a	depot	21228.00	84171.00	105399.00	FCFA	Dépôt chèque	\N	2025-05-18 20:28:48	2025-10-23 12:37:03
09ddd813-938a-4cab-918e-2eee057c4e9e	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	retrait	39362.00	491241.00	451879.00	FCFA	Retrait d'espèces	\N	2025-04-25 21:33:07	2025-10-23 12:37:03
a184c6ab-3bd5-4276-a5f7-b3c5d7eaa311	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	virement	8840.00	491241.00	482401.00	FCFA	Virement salaire	aed8dd64-e196-4321-8ffc-52ce0cc7e7f7	2025-09-17 10:37:15	2025-10-23 12:37:03
53fae30f-c1f2-49b1-8e0f-436c3db11e87	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	retrait	47427.00	491241.00	443814.00	FCFA	Paiement par carte	\N	2025-10-10 21:15:32	2025-10-23 12:37:03
e924e7fd-8b6a-4212-bb65-f6230034330c	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	depot	13726.00	491241.00	504967.00	FCFA	Dépôt chèque	\N	2025-09-19 23:42:06	2025-10-23 12:37:03
be70d99d-dddb-474a-8de3-ffbe9b312b2b	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	retrait	23940.00	491241.00	467301.00	FCFA	Paiement par carte	\N	2025-07-30 22:16:22	2025-10-23 12:37:03
531633af-30e6-477e-9a00-184b9137e4a6	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	depot	22192.00	491241.00	513433.00	FCFA	Versement salaire	\N	2025-09-16 00:57:03	2025-10-23 12:37:03
bc14e022-b7ef-4b97-8b49-d4162d1da38d	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	depot	37345.00	491241.00	528586.00	FCFA	Dépôt d'espèces	\N	2025-06-04 18:12:04	2025-10-23 12:37:03
9df4dcab-637d-4a68-affe-1d8a16847003	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	depot	35203.00	491241.00	526444.00	FCFA	Dépôt chèque	\N	2025-09-20 19:26:55	2025-10-23 12:37:03
fd9e6db2-a19d-4c08-86b4-3d059bb566a0	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	depot	28004.00	491241.00	519245.00	FCFA	Dépôt chèque	\N	2025-08-10 08:28:04	2025-10-23 12:37:03
56a0b9c4-764a-40bc-a0f6-e5cb18399310	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	retrait	40336.00	491241.00	450905.00	FCFA	Retrait guichet	\N	2025-05-28 20:24:36	2025-10-23 12:37:03
da143f7b-7fd4-4fb0-a24e-150437b3f858	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	retrait	20358.00	491241.00	470883.00	FCFA	Prélèvement automatique	\N	2025-05-11 07:28:15	2025-10-23 12:37:03
afca64fd-33bd-4755-888c-eb14c97ea268	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	retrait	43682.00	491241.00	447559.00	FCFA	Prélèvement automatique	\N	2025-10-22 19:06:18	2025-10-23 12:37:03
da5d8ab6-7143-4a6a-870f-2326b35d2e74	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	retrait	14411.00	491241.00	476830.00	FCFA	Paiement par carte	\N	2025-08-30 20:21:17	2025-10-23 12:37:03
14bcd87d-ce8a-4293-9dd0-8ac637f86c6d	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	virement	36996.00	491241.00	454245.00	FCFA	Transfert entre comptes	08360cab-6365-4da0-80a5-721ba954e61c	2025-07-13 14:15:57	2025-10-23 12:37:03
b7758ae6-ec26-4a13-942c-3ee6a859363d	ac8e024e-b3cd-4e09-a58a-4b7aef86fe61	depot	6911.00	491241.00	498152.00	FCFA	Dépôt d'espèces	\N	2025-06-30 18:05:16	2025-10-23 12:37:03
7bebba5d-56d8-4219-a229-70d8e3d65dca	4e9d8251-8bd8-4460-957a-dd1af608920f	depot	4313.00	19679.00	23992.00	FCFA	Versement salaire	\N	2025-04-27 08:08:45	2025-10-23 12:37:03
6c67547c-a313-40ee-8763-0c348e7c1ae8	4e9d8251-8bd8-4460-957a-dd1af608920f	retrait	2030.00	19679.00	17649.00	FCFA	Retrait d'espèces	\N	2025-05-14 21:35:28	2025-10-23 12:37:03
a1f4d648-7b25-4da4-a63a-ec170a412019	4e9d8251-8bd8-4460-957a-dd1af608920f	depot	2071.00	19679.00	21750.00	FCFA	Versement salaire	\N	2025-07-10 18:47:26	2025-10-23 12:37:03
ea07dde2-5a05-4ba5-ac59-2ab9ca3f19eb	4e9d8251-8bd8-4460-957a-dd1af608920f	retrait	40652.00	19679.00	0.00	FCFA	Retrait d'espèces	\N	2025-08-24 18:21:51	2025-10-23 12:37:03
faa2333a-9cfb-440c-9237-9f42269340fc	4e9d8251-8bd8-4460-957a-dd1af608920f	depot	42474.00	19679.00	62153.00	FCFA	Virement bancaire entrant	\N	2025-05-06 15:38:17	2025-10-23 12:37:03
6e3133d2-79fd-4b55-a04e-0babd9193b62	4e9d8251-8bd8-4460-957a-dd1af608920f	retrait	31307.00	19679.00	0.00	FCFA	Retrait d'espèces	\N	2025-06-22 23:13:57	2025-10-23 12:37:03
59104d65-9548-4779-9f86-7b88db7643b3	4e9d8251-8bd8-4460-957a-dd1af608920f	depot	31086.00	19679.00	50765.00	FCFA	Versement salaire	\N	2025-05-13 19:15:01	2025-10-23 12:37:03
0a6d2508-90a8-4e16-9405-844c1b60b398	4e9d8251-8bd8-4460-957a-dd1af608920f	retrait	37343.00	19679.00	0.00	FCFA	Paiement par carte	\N	2025-04-27 04:27:53	2025-10-23 12:37:03
df6ebcd0-454c-4105-8170-6020c223f968	4e9d8251-8bd8-4460-957a-dd1af608920f	depot	30970.00	19679.00	50649.00	FCFA	Dépôt chèque	\N	2025-10-21 05:56:03	2025-10-23 12:37:03
7cda4944-dd70-4c6d-bf96-a66899720c96	4e9d8251-8bd8-4460-957a-dd1af608920f	depot	11592.00	19679.00	31271.00	FCFA	Virement bancaire entrant	\N	2025-06-09 07:57:08	2025-10-23 12:37:03
42b4a9c3-0cc1-4749-b866-d944d5389744	4e9d8251-8bd8-4460-957a-dd1af608920f	depot	37474.00	19679.00	57153.00	FCFA	Dépôt espèces guichet	\N	2025-10-10 07:28:59	2025-10-23 12:37:03
601ef4bb-5d8f-4783-8f99-e7eec22aadd5	64ee33cf-f4ed-4559-ab3c-48bccf04f75f	retrait	12805.00	99621.00	86816.00	FCFA	Paiement par carte	\N	2025-06-04 17:55:27	2025-10-23 12:37:03
da9456b3-c740-44f1-9947-fa771d321713	64ee33cf-f4ed-4559-ab3c-48bccf04f75f	depot	2498.00	99621.00	102119.00	FCFA	Virement bancaire entrant	\N	2025-05-10 04:15:23	2025-10-23 12:37:03
81df5b57-bf43-4a4a-85da-e17eb6279893	64ee33cf-f4ed-4559-ab3c-48bccf04f75f	retrait	1029.00	99621.00	98592.00	FCFA	Retrait DAB	\N	2025-08-01 02:28:48	2025-10-23 12:37:03
e8dfe89c-7e09-4dac-890c-031557d6494c	64ee33cf-f4ed-4559-ab3c-48bccf04f75f	retrait	42106.00	99621.00	57515.00	FCFA	Retrait DAB	\N	2025-08-15 10:55:28	2025-10-23 12:37:03
d7c89537-0e98-41bd-8b16-bba0e40c68b6	64ee33cf-f4ed-4559-ab3c-48bccf04f75f	depot	39001.00	99621.00	138622.00	FCFA	Versement salaire	\N	2025-07-18 22:45:28	2025-10-23 12:37:03
7338d6de-613d-4a1e-9c7a-0f8506786e0a	64ee33cf-f4ed-4559-ab3c-48bccf04f75f	depot	32767.00	99621.00	132388.00	FCFA	Virement bancaire entrant	\N	2025-09-08 09:10:04	2025-10-23 12:37:03
ee22271a-7e88-4ced-a629-f0e0b351867f	64ee33cf-f4ed-4559-ab3c-48bccf04f75f	retrait	20422.00	99621.00	79199.00	FCFA	Retrait DAB	\N	2025-10-09 07:48:37	2025-10-23 12:37:03
4f9cb27e-0319-4c49-8a28-12cf088a14c3	64ee33cf-f4ed-4559-ab3c-48bccf04f75f	retrait	41151.00	99621.00	58470.00	FCFA	Paiement par carte	\N	2025-06-04 10:10:35	2025-10-23 12:37:03
10985b20-a5cd-4c3a-a4b6-f174eb135562	64ee33cf-f4ed-4559-ab3c-48bccf04f75f	depot	1105.00	99621.00	100726.00	FCFA	Dépôt chèque	\N	2025-07-22 14:21:32	2025-10-23 12:37:03
178ccd70-d870-4d04-b4ae-37c94278090e	64ee33cf-f4ed-4559-ab3c-48bccf04f75f	retrait	24157.00	99621.00	75464.00	FCFA	Retrait d'espèces	\N	2025-08-10 12:42:55	2025-10-23 12:37:03
f4785c4c-5ada-4160-9486-5abc0c9a6f94	64ee33cf-f4ed-4559-ab3c-48bccf04f75f	retrait	40805.00	99621.00	58816.00	FCFA	Retrait guichet	\N	2025-05-16 07:06:17	2025-10-23 12:37:03
fd4d27fe-4cab-40b4-a327-468e73613b97	bc151b8f-a172-41b6-ab05-310ca341ebf3	retrait	35465.00	464200.00	428735.00	FCFA	Retrait d'espèces	\N	2025-09-08 23:07:01	2025-10-23 12:37:03
e2b414b8-e2e4-4e40-940e-a5aeedc231ee	bc151b8f-a172-41b6-ab05-310ca341ebf3	depot	9466.00	464200.00	473666.00	FCFA	Virement bancaire entrant	\N	2025-08-13 06:03:58	2025-10-23 12:37:03
93e361f9-9812-4795-b850-c83ecdc2bbdf	bc151b8f-a172-41b6-ab05-310ca341ebf3	depot	23979.00	464200.00	488179.00	FCFA	Virement bancaire entrant	\N	2025-07-02 05:54:01	2025-10-23 12:37:03
5d02a101-77f4-4f67-a21a-19a355353ce7	bc151b8f-a172-41b6-ab05-310ca341ebf3	retrait	39458.00	464200.00	424742.00	FCFA	Retrait d'espèces	\N	2025-05-25 16:01:23	2025-10-23 12:37:03
c935b681-6884-4386-90b4-243573901fe7	bc151b8f-a172-41b6-ab05-310ca341ebf3	depot	7771.00	464200.00	471971.00	FCFA	Dépôt espèces guichet	\N	2025-08-07 20:16:40	2025-10-23 12:37:03
512805a2-d0a4-4304-9fde-8251538ad153	bc151b8f-a172-41b6-ab05-310ca341ebf3	virement	18085.00	464200.00	446115.00	FCFA	Virement salaire	f3db8624-1334-47ff-83bb-04592844270f	2025-04-24 02:25:39	2025-10-23 12:37:03
489d12e6-1960-441e-8b68-4b7c289799c8	bc151b8f-a172-41b6-ab05-310ca341ebf3	virement	9951.00	464200.00	454249.00	FCFA	Transfert entre comptes	94b14a72-e4f3-4e5f-ae72-8e6f72e4e901	2025-05-25 06:21:13	2025-10-23 12:37:03
48087f32-8964-47ca-9730-7530b149d183	bc151b8f-a172-41b6-ab05-310ca341ebf3	virement	26043.00	464200.00	438157.00	FCFA	Virement vers compte	e7088ab6-655b-4317-8cdf-46d3de12e2f0	2025-07-23 15:35:49	2025-10-23 12:37:03
a18869a4-babc-476a-9d68-1dea843bd683	bc151b8f-a172-41b6-ab05-310ca341ebf3	virement	42438.00	464200.00	421762.00	FCFA	Virement vers compte	f61a5805-715d-476c-89ef-33958e3cf001	2025-05-12 08:03:32	2025-10-23 12:37:03
1e7e94df-665a-436f-aab3-2a8484422fab	bc151b8f-a172-41b6-ab05-310ca341ebf3	retrait	11054.00	464200.00	453146.00	FCFA	Paiement par carte	\N	2025-10-20 01:16:21	2025-10-23 12:37:03
e81c3ec9-7b00-44ab-b9ce-a53342e4c9bf	bc151b8f-a172-41b6-ab05-310ca341ebf3	depot	23352.00	464200.00	487552.00	FCFA	Dépôt d'espèces	\N	2025-05-02 01:44:21	2025-10-23 12:37:03
d122a275-adc3-4c0a-b451-83d11c65a6d5	bc151b8f-a172-41b6-ab05-310ca341ebf3	virement	37726.00	464200.00	426474.00	FCFA	Virement salaire	8b26ce5d-ad05-425f-8bf0-c4597bbea4ef	2025-10-09 03:09:12	2025-10-23 12:37:03
4e0d1cf2-e1d5-42a2-931b-334087767e1b	bc151b8f-a172-41b6-ab05-310ca341ebf3	virement	14603.00	464200.00	449597.00	FCFA	Paiement facture	a90e1a63-43fd-4956-af04-b3458780ca97	2025-08-16 18:18:46	2025-10-23 12:37:03
84dcab4d-89e7-4ff0-a1a8-cf8b3fdceb5e	f61a5805-715d-476c-89ef-33958e3cf001	retrait	27362.00	272545.00	245183.00	FCFA	Retrait d'espèces	\N	2025-04-30 07:02:48	2025-10-23 12:37:03
3561815c-6b9c-49f4-8c83-d2b51a69554e	f61a5805-715d-476c-89ef-33958e3cf001	virement	4795.00	272545.00	267750.00	FCFA	Transfert entre comptes	b30db983-96ad-4f5c-a50c-1637c25f3b46	2025-09-11 07:55:16	2025-10-23 12:37:03
1e888af4-99b9-4df8-83e9-3cb474c157f0	f61a5805-715d-476c-89ef-33958e3cf001	depot	7847.00	272545.00	280392.00	FCFA	Versement salaire	\N	2025-08-20 01:28:24	2025-10-23 12:37:03
962bff8e-6cb8-458a-bd57-c3c7eca2abb7	f61a5805-715d-476c-89ef-33958e3cf001	retrait	18445.00	272545.00	254100.00	FCFA	Retrait DAB	\N	2025-07-22 13:37:47	2025-10-23 12:37:03
e89e4786-f033-45be-abc6-009865a5043e	f61a5805-715d-476c-89ef-33958e3cf001	retrait	28502.00	272545.00	244043.00	FCFA	Paiement par carte	\N	2025-05-15 12:16:18	2025-10-23 12:37:03
829b9ad7-f7b9-44cc-ac7b-bf17680cb591	f61a5805-715d-476c-89ef-33958e3cf001	retrait	28962.00	272545.00	243583.00	FCFA	Paiement par carte	\N	2025-06-13 11:36:55	2025-10-23 12:37:03
ddfef8d4-8081-4271-ae46-0ed76d951267	f61a5805-715d-476c-89ef-33958e3cf001	virement	22366.00	272545.00	250179.00	FCFA	Virement vers compte	22398797-8a57-4530-b835-7193f3b0fca0	2025-09-27 20:46:27	2025-10-23 12:37:03
107eaaf8-22cd-42a5-ad2d-b22da3534180	f61a5805-715d-476c-89ef-33958e3cf001	depot	18585.00	272545.00	291130.00	FCFA	Dépôt espèces guichet	\N	2025-09-18 05:20:57	2025-10-23 12:37:03
c31c188f-30ab-45c1-ab0c-8dd10059d432	093dd33b-052d-4191-9176-9120502bd3b0	depot	45518.00	390548.00	436066.00	FCFA	Dépôt d'espèces	\N	2025-09-09 05:05:37	2025-10-23 12:37:03
0a6f3f79-a595-4329-b59d-4f293190243f	093dd33b-052d-4191-9176-9120502bd3b0	depot	47263.00	390548.00	437811.00	FCFA	Virement bancaire entrant	\N	2025-06-03 13:45:51	2025-10-23 12:37:03
42b56977-c789-4894-a464-ec00ff6674a9	093dd33b-052d-4191-9176-9120502bd3b0	virement	33552.00	390548.00	356996.00	FCFA	Virement vers compte	188bace1-4ea4-4d21-83df-7b0a3d7bfefc	2025-09-23 21:28:54	2025-10-23 12:37:03
00664c0b-71cf-4900-9114-3408f2ab5570	093dd33b-052d-4191-9176-9120502bd3b0	retrait	10674.00	390548.00	379874.00	FCFA	Retrait DAB	\N	2025-07-06 15:36:10	2025-10-23 12:37:03
83797057-351b-4b25-a7bc-fd081bbd2a04	093dd33b-052d-4191-9176-9120502bd3b0	virement	12116.00	390548.00	378432.00	FCFA	Paiement facture	bc779c73-ecf7-44f0-9794-281f495b5ff5	2025-06-07 18:19:06	2025-10-23 12:37:03
48fd8303-0968-409e-9dbf-2633690a07e8	093dd33b-052d-4191-9176-9120502bd3b0	retrait	28415.00	390548.00	362133.00	FCFA	Retrait guichet	\N	2025-07-02 07:43:13	2025-10-23 12:37:03
ef673732-63b6-4e3e-8849-2a6a9f1a34ed	093dd33b-052d-4191-9176-9120502bd3b0	depot	3716.00	390548.00	394264.00	FCFA	Virement bancaire entrant	\N	2025-10-21 02:39:31	2025-10-23 12:37:03
c75f7173-57ef-4e2d-8e55-361d2ededa63	093dd33b-052d-4191-9176-9120502bd3b0	retrait	42702.00	390548.00	347846.00	FCFA	Paiement par carte	\N	2025-09-24 00:46:38	2025-10-23 12:37:03
bcbfc0d2-6cba-4b69-b281-13ecc26a668b	093dd33b-052d-4191-9176-9120502bd3b0	virement	23377.00	390548.00	367171.00	FCFA	Transfert entre comptes	f959068a-63bd-46ee-a42c-59d124c48cf6	2025-05-07 12:20:06	2025-10-23 12:37:03
ce355737-e2f9-43be-814f-4e40fcc25c43	093dd33b-052d-4191-9176-9120502bd3b0	virement	47069.00	390548.00	343479.00	FCFA	Virement salaire	66b42124-fa11-4ffb-a2a3-1fbd435829d3	2025-07-25 18:12:42	2025-10-23 12:37:03
5e5cce39-d034-44ec-be21-d8f89ea7f633	093dd33b-052d-4191-9176-9120502bd3b0	virement	34540.00	390548.00	356008.00	FCFA	Virement salaire	0006e5f7-4df5-46a5-8f9e-90089c5ea052	2025-08-04 13:22:05	2025-10-23 12:37:03
0e682d8a-9acb-4951-98f6-bbe4023a1dad	093dd33b-052d-4191-9176-9120502bd3b0	virement	11469.00	390548.00	379079.00	FCFA	Virement salaire	e4ad8455-8e84-4a67-873f-6392338ba743	2025-09-19 23:28:01	2025-10-23 12:37:03
214b46dd-52f8-468a-a98f-d8c7435688d4	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	depot	37038.00	233122.00	270160.00	FCFA	Virement bancaire entrant	\N	2025-07-22 10:27:33	2025-10-23 12:37:03
e123e4ca-2ee7-4541-818e-fc8fb508f80f	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	virement	3715.00	233122.00	229407.00	FCFA	Virement vers compte	5a4fcbd8-2dcb-49a9-8291-3ad7ef1cd480	2025-09-26 03:54:18	2025-10-23 12:37:03
da7f4228-d9ab-46b7-aef7-9f1f8d52d8f7	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	retrait	26650.00	233122.00	206472.00	FCFA	Retrait guichet	\N	2025-06-21 07:55:32	2025-10-23 12:37:03
a686a7c4-0ff5-42b0-9cc1-2ddf9741819d	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	virement	29601.00	233122.00	203521.00	FCFA	Paiement facture	54d5e886-a7a4-4427-b256-7723400f3c4e	2025-10-06 02:07:31	2025-10-23 12:37:03
3d7fa525-498d-4c74-9b2e-5580c0a30a97	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	retrait	32234.00	233122.00	200888.00	FCFA	Retrait d'espèces	\N	2025-09-21 15:34:44	2025-10-23 12:37:03
f6e0653d-816e-4ee1-8610-03b066b85d74	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	retrait	10238.00	233122.00	222884.00	FCFA	Retrait guichet	\N	2025-05-11 21:32:23	2025-10-23 12:37:03
00b0f954-e92b-4104-b347-fa22edc6c532	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	retrait	23622.00	233122.00	209500.00	FCFA	Retrait d'espèces	\N	2025-06-26 19:52:20	2025-10-23 12:37:03
d12491cb-cc56-4a5b-a343-7621eed1d939	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	depot	36648.00	233122.00	269770.00	FCFA	Virement bancaire entrant	\N	2025-07-16 01:14:56	2025-10-23 12:37:03
a37b0d50-2074-4663-b502-ecb02b8ab5c5	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	virement	22125.00	233122.00	210997.00	FCFA	Paiement facture	5d3634bb-39ae-4beb-a70d-3f7ac49f03cf	2025-05-19 17:28:31	2025-10-23 12:37:03
3ce69a6f-cc89-4e9c-b134-22e02211990d	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	virement	28297.00	233122.00	204825.00	FCFA	Virement salaire	05c0a3e8-eeae-4976-88c2-848aec6bea96	2025-07-22 21:16:14	2025-10-23 12:37:03
5123c2ff-8175-4544-afab-940d280a2e1c	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	virement	28152.00	233122.00	204970.00	FCFA	Virement vers compte	9987f93d-ac57-4bee-aff6-41c16aebe2b4	2025-08-27 23:45:22	2025-10-23 12:37:03
d2541fcd-2682-4d21-aa91-301053be5e61	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	depot	9140.00	233122.00	242262.00	FCFA	Dépôt d'espèces	\N	2025-10-20 11:56:46	2025-10-23 12:37:03
9f575b5e-1149-4c06-a205-72b85457b304	5bf114ca-0666-47c1-b189-3f0b5e8a5f0a	depot	20847.00	233122.00	253969.00	FCFA	Dépôt d'espèces	\N	2025-07-30 06:50:25	2025-10-23 12:37:03
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mon_user
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, role, client_id) FROM stdin;
1	Admin User	admin@example.com	\N	$2y$12$gDAl4Nr0oN4/1e3AL5To4eoVfW941wzq4/skCFbHNtntGjlKOPVTC	\N	2025-10-22 04:41:13	2025-10-22 04:41:13	admin	\N
2	Client User	client@example.com	\N	$2y$12$2xSs/VIw0i5KLfl9d/EyIe5cx/LSzK8fiyv0yVFbwQWmIKfGKY4Vm	\N	2025-10-22 04:41:13	2025-10-22 04:41:13	client	e95d1e5d-938b-48e1-8619-f66bd722bef6
3	Hawa BB Wane	hawa.wane@example.com	\N	$2y$12$Y0JSA3b46/e9QxX.mXy/oO6/vbOG3.newtCkSaXNTaMfNPyWObf3e	\N	2025-10-22 05:16:28	2025-10-22 05:16:28	client	b417c745-fd9b-42fc-9660-f9da5e0d2c65
4	Mamadou Diallo	mamadou.diallo@example.com	\N	$2y$12$E8n8GYBSSDiTc8rh2bSZJeZXOX/CGinSEuxLvSWXwDASaYprHxDuS	\N	2025-10-22 05:17:25	2025-10-22 05:17:25	client	1347865b-d151-4ba1-99c9-999d44d7f725
5	Fatou Ndiaye	fatou.ndiaye@example.com	\N	$2y$12$F5CrDe8vpFhQDARtLfulceRjxcrfiWqKoCwGaTF.7Tpb2Fd4Y3zx.	\N	2025-10-22 05:18:17	2025-10-22 05:18:17	client	a631f43f-0401-4166-b917-c4a38abb6889
\.


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mon_user
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mon_user
--

SELECT pg_catalog.setval('public.migrations_id_seq', 11, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mon_user
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mon_user
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: clients clients_email_unique; Type: CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_email_unique UNIQUE (email);


--
-- Name: clients clients_nci_unique; Type: CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_nci_unique UNIQUE (nci);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: comptes comptes_numero_unique; Type: CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.comptes
    ADD CONSTRAINT comptes_numero_unique UNIQUE (numero);


--
-- Name: comptes comptes_pkey; Type: CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.comptes
    ADD CONSTRAINT comptes_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: clients_email_index; Type: INDEX; Schema: public; Owner: mon_user
--

CREATE INDEX clients_email_index ON public.clients USING btree (email);


--
-- Name: clients_nci_index; Type: INDEX; Schema: public; Owner: mon_user
--

CREATE INDEX clients_nci_index ON public.clients USING btree (nci);


--
-- Name: clients_titulaire_index; Type: INDEX; Schema: public; Owner: mon_user
--

CREATE INDEX clients_titulaire_index ON public.clients USING btree (titulaire);


--
-- Name: comptes_numero_index; Type: INDEX; Schema: public; Owner: mon_user
--

CREATE INDEX comptes_numero_index ON public.comptes USING btree (numero);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: mon_user
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: transactions_compte_id_created_at_index; Type: INDEX; Schema: public; Owner: mon_user
--

CREATE INDEX transactions_compte_id_created_at_index ON public.transactions USING btree (compte_id, created_at);


--
-- Name: transactions_type_index; Type: INDEX; Schema: public; Owner: mon_user
--

CREATE INDEX transactions_type_index ON public.transactions USING btree (type);


--
-- Name: comptes comptes_client_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.comptes
    ADD CONSTRAINT comptes_client_id_foreign FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE CASCADE;


--
-- Name: transactions transactions_compte_destination_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_compte_destination_id_foreign FOREIGN KEY (compte_destination_id) REFERENCES public.comptes(id) ON DELETE SET NULL;


--
-- Name: transactions transactions_compte_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_compte_id_foreign FOREIGN KEY (compte_id) REFERENCES public.comptes(id) ON DELETE CASCADE;


--
-- Name: users users_client_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: mon_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_client_id_foreign FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict cRbJEC0OKVuQ1x5Fad2Z02qzpvE0vmgAUh2JJLHmdCyZHMfS0oA6qUPoUy2WTga

