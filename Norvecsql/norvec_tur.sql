--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

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
-- Name: musteri_ekle(integer, text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.musteri_ekle(IN p1 integer, IN p2 text)
    LANGUAGE sql
    AS $$
insert into musteri(mst_id, mst_adsoyad) values (p1,p2);
$$;


ALTER PROCEDURE public.musteri_ekle(IN p1 integer, IN p2 text) OWNER TO postgres;

--
-- Name: musterigetir(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.musterigetir(prmt character varying) RETURNS TABLE(idsutun integer, musteriadsoyad character varying)
    LANGUAGE plpgsql
    AS $$
Begin
	Return Query
	Select
	mst_id,
	mst_adsoyad
From
	musteri
Where
	mst_adsoyad like prmt;
End;
$$;


ALTER FUNCTION public.musterigetir(prmt character varying) OWNER TO postgres;

--
-- Name: test(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.test() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
update toplammusteri set sayi=sayi+1;
return new;
end;
$$;


ALTER FUNCTION public.test() OWNER TO postgres;

--
-- Name: test1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.test1() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
	uzunluk integer;
begin
uzunluk:=(select length(mst_adsoyad) from musteri order by mst_id desc limit 1);
update toplammusteriiki set sayi=sayi+uzunluk;
return new;
end;
$$;


ALTER FUNCTION public.test1() OWNER TO postgres;

--
-- Name: test2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.test2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
	karakter integer;
begin
karakter:=(select length(tur_ad) from tur order by tur_id desc limit 1);
update toplamturiki set sayi=sayi+karakter;
return new;
end;
$$;


ALTER FUNCTION public.test2() OWNER TO postgres;

--
-- Name: testtwo(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.testtwo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
update toplamtur set sayi=sayi+1;
return new;
end;
$$;


ALTER FUNCTION public.testtwo() OWNER TO postgres;

--
-- Name: tur_ekle(integer, text); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.tur_ekle(IN p1 integer, IN p2 text)
    LANGUAGE sql
    AS $$
insert into tur(tur_id, tur_ad) values (p1,p2);
$$;


ALTER PROCEDURE public.tur_ekle(IN p1 integer, IN p2 text) OWNER TO postgres;

--
-- Name: turgetir(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.turgetir(prmt character varying) RETURNS TABLE(idsutun integer, tur_adsutun character varying)
    LANGUAGE plpgsql
    AS $$
Begin
	Return Query
	Select
	tur_id,
	tur_ad
From
	tur
Where
	tur_ad like prmt;
End;
$$;


ALTER FUNCTION public.turgetir(prmt character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: fatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fatura (
    mst_id integer NOT NULL,
    mst_sehir character varying,
    mst_ucret bigint NOT NULL
);


ALTER TABLE public.fatura OWNER TO postgres;

--
-- Name: mst_tipi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mst_tipi (
    mst_tipiid integer NOT NULL,
    mst_id character varying(50) NOT NULL,
    mst_adsoyad character varying(50),
    mst_cinsiyet character varying(5)
);


ALTER TABLE public.mst_tipi OWNER TO postgres;

--
-- Name: mst_tur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mst_tur (
    id integer NOT NULL
);


ALTER TABLE public.mst_tur OWNER TO postgres;

--
-- Name: musteri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.musteri (
    mst_id integer NOT NULL,
    mst_adsoyad character varying(50),
    mst_cinsiyet character varying(5),
    mst_turid integer,
    mst_odano integer,
    mst_ucak integer,
    mst_tcno bigint,
    mst_tel character varying(20)
);


ALTER TABLE public.musteri OWNER TO postgres;

--
-- Name: otel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.otel (
    id integer NOT NULL,
    mst_odano character varying(50) NOT NULL,
    sure character varying(50),
    mst_id integer
);


ALTER TABLE public.otel OWNER TO postgres;

--
-- Name: rehber; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rehber (
    tur_id integer NOT NULL,
    id integer NOT NULL,
    rehber character varying(50) NOT NULL,
    mst_id integer
);


ALTER TABLE public.rehber OWNER TO postgres;

--
-- Name: sure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sure (
    mst_id integer NOT NULL,
    tur_id integer NOT NULL,
    sure character varying(50) NOT NULL
);


ALTER TABLE public.sure OWNER TO postgres;

--
-- Name: telefon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefon (
    id integer NOT NULL,
    mst_odano integer,
    mst_ucak integer,
    tel bigint,
    mst_id integer
);


ALTER TABLE public.telefon OWNER TO postgres;

--
-- Name: toplammusteri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.toplammusteri (
    sayi integer NOT NULL
);


ALTER TABLE public.toplammusteri OWNER TO postgres;

--
-- Name: toplammusteriiki; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.toplammusteriiki (
    sayi integer NOT NULL
);


ALTER TABLE public.toplammusteriiki OWNER TO postgres;

--
-- Name: toplamtur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.toplamtur (
    sayi integer NOT NULL
);


ALTER TABLE public.toplamtur OWNER TO postgres;

--
-- Name: toplamturiki; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.toplamturiki (
    sayi integer NOT NULL
);


ALTER TABLE public.toplamturiki OWNER TO postgres;

--
-- Name: tur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tur (
    tur_id integer NOT NULL,
    mst_id integer,
    tur_ad character varying(50) NOT NULL,
    tur_suresi character varying(50),
    tur_fatura character varying(50),
    yemek_id integer,
    rehber_id integer
);


ALTER TABLE public.tur OWNER TO postgres;

--
-- Name: ucak; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ucak (
    id integer NOT NULL,
    ucak character varying(50) NOT NULL,
    mst_id integer
);


ALTER TABLE public.ucak OWNER TO postgres;

--
-- Name: ucret; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ucret (
    id integer NOT NULL,
    mst_ucret bigint NOT NULL,
    mst_sehir character varying(50),
    mst_id integer
);


ALTER TABLE public.ucret OWNER TO postgres;

--
-- Name: yemek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yemek (
    id integer NOT NULL,
    yemek character varying(50) NOT NULL,
    sure character varying(50),
    mst_id integer
);


ALTER TABLE public.yemek OWNER TO postgres;

--
-- Data for Name: fatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fatura (mst_id, mst_sehir, mst_ucret) FROM stdin;
8	İstanbul	4000
7	İstanbul	4000
2	Sakarya	10000
1	Samsun	10000
\.


--
-- Data for Name: mst_tipi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mst_tipi (mst_tipiid, mst_id, mst_adsoyad, mst_cinsiyet) FROM stdin;
7	Ogrenci	Aybuke Simsek	\N
4	Ogrenci	Betul Cakir	\N
2	Yetiskin	Selin Sahin	\N
1	Yetiskin	Mustafa Karacukur	Bay
\.


--
-- Data for Name: mst_tur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mst_tur (id) FROM stdin;
\.


--
-- Data for Name: musteri; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.musteri (mst_id, mst_adsoyad, mst_cinsiyet, mst_turid, mst_odano, mst_ucak, mst_tcno, mst_tel) FROM stdin;
9	Volkan Demirel	Erkek	6	105	9	53235237572	(246) 127-4178
8	Ozan Tufan	Erkek	1	108	4	24322352342	(   )    -
123	Mustafa Korkmaz	Erkek	61	102	1	24172848712	(357) 375-7237
4	Çağla Şikel	Kadın	51	105	13	45746756738	(365) 637-2570
7	Kenan Yildiz	Erkek	195	106	4	10365981436	(   )    -
14	Sıla Uçar	Kadın	7	102	11	24127741827	(157) 828-7412
15	Burak Yılmaz	Erkek	4	109	1	74486378443	(634) 634-2787
10	Oğuzhan Özyakup	Erkek	2	105	5	24124124912	(421) 498-1949
1	Aziz Yıldırım	Erkek	1	102	1	11111111	(231) 949-1021
12	Defne Samyeli	Kadın	6	102	14	24172848712	(357) 375-7237
156	Ahmet Selim	Erkek	1903	107	9	53235237573	(246) 127-3698
3	Azra Dönmez	Kadın	4	103	9	85238329582	(347) 478-473
\.


--
-- Data for Name: otel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.otel (id, mst_odano, sure, mst_id) FROM stdin;
4	102	7	\N
3	101	7	\N
6	104	3	\N
5	103	3	\N
\.


--
-- Data for Name: rehber; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rehber (tur_id, id, rehber, mst_id) FROM stdin;
3	5	yok	\N
5	2	var	\N
6	1	var	\N
\.


--
-- Data for Name: sure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sure (mst_id, tur_id, sure) FROM stdin;
4	4	7
2	5	7
1	6	7
\.


--
-- Data for Name: telefon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telefon (id, mst_odano, mst_ucak, tel, mst_id) FROM stdin;
4	102	11	\N	\N
\.


--
-- Data for Name: toplammusteri; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.toplammusteri (sayi) FROM stdin;
22
\.


--
-- Data for Name: toplammusteriiki; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.toplammusteriiki (sayi) FROM stdin;
93
\.


--
-- Data for Name: toplamtur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.toplamtur (sayi) FROM stdin;
9
\.


--
-- Data for Name: toplamturiki; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.toplamturiki (sayi) FROM stdin;
15
\.


--
-- Data for Name: tur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tur (tur_id, mst_id, tur_ad, tur_suresi, tur_fatura, yemek_id, rehber_id) FROM stdin;
6	1	Elegant Kanada	7 gun	\N	\N	\N
5	2	Elegant Kanada	3 gun	\N	\N	\N
2	3	Toronto	7 gun	\N	\N	\N
3	5	Niagara Selalesi	3 gun	\N	\N	\N
4	4	Niagara Selalesi	7 gun	\N	\N	\N
1	6	Toronto	3 gun	\N	\N	\N
7	\N	Yilbasi Ozel Kanada	\N	\N	\N	\N
8	\N	Dogada Kanada	\N	\N	\N	\N
9	\N	Bungalov Kanada	\N	\N	\N	\N
\.


--
-- Data for Name: ucak; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ucak (id, ucak, mst_id) FROM stdin;
6	11	\N
5	10	\N
\.


--
-- Data for Name: ucret; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ucret (id, mst_ucret, mst_sehir, mst_id) FROM stdin;
1	10000	Samsun	\N
8	4000	İstanbul	\N
7	4000	İstanbul	\N
2	10000	Sakarya	\N
\.


--
-- Data for Name: yemek; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.yemek (id, yemek, sure, mst_id) FROM stdin;
8	var	3	\N
7	var	3	\N
\.


--
-- Name: fatura fatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fatura
    ADD CONSTRAINT fatura_pkey PRIMARY KEY (mst_id);


--
-- Name: mst_tipi mst_tipi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mst_tipi
    ADD CONSTRAINT mst_tipi_pkey PRIMARY KEY (mst_tipiid);


--
-- Name: mst_tur mst_tur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mst_tur
    ADD CONSTRAINT mst_tur_pkey PRIMARY KEY (id);


--
-- Name: musteri musteri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.musteri
    ADD CONSTRAINT musteri_pkey PRIMARY KEY (mst_id);


--
-- Name: otel otel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.otel
    ADD CONSTRAINT otel_pkey PRIMARY KEY (id);


--
-- Name: rehber rehber_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rehber
    ADD CONSTRAINT rehber_pkey PRIMARY KEY (id);


--
-- Name: sure sure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sure
    ADD CONSTRAINT sure_pkey PRIMARY KEY (tur_id);


--
-- Name: telefon telefon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefon
    ADD CONSTRAINT telefon_pkey PRIMARY KEY (id);


--
-- Name: toplammusteri toplammusteri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.toplammusteri
    ADD CONSTRAINT toplammusteri_pkey PRIMARY KEY (sayi);


--
-- Name: toplammusteriiki toplammusteriiki_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.toplammusteriiki
    ADD CONSTRAINT toplammusteriiki_pkey PRIMARY KEY (sayi);


--
-- Name: toplamtur toplamtur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.toplamtur
    ADD CONSTRAINT toplamtur_pkey PRIMARY KEY (sayi);


--
-- Name: toplamturiki toplamturiki_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.toplamturiki
    ADD CONSTRAINT toplamturiki_pkey PRIMARY KEY (sayi);


--
-- Name: tur tur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tur
    ADD CONSTRAINT tur_pkey PRIMARY KEY (tur_id);


--
-- Name: ucak ucak_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ucak
    ADD CONSTRAINT ucak_pkey PRIMARY KEY (id);


--
-- Name: ucret ucret_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ucret
    ADD CONSTRAINT ucret_pkey PRIMARY KEY (id);


--
-- Name: yemek yemek_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yemek
    ADD CONSTRAINT yemek_pkey PRIMARY KEY (id);


--
-- Name: fki_m; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_m ON public.telefon USING btree (id);


--
-- Name: fki_mst_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_mst_foreign ON public.mst_tur USING btree (id);


--
-- Name: fki_rehber_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_rehber_foreign ON public.tur USING btree (rehber_id);


--
-- Name: fki_tur_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_tur_foreign ON public.tur USING btree (mst_id);


--
-- Name: fki_turmst_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_turmst_foreign ON public.mst_tur USING btree (id);


--
-- Name: fki_ucaktel_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_ucaktel_foreign ON public.telefon USING btree (id);


--
-- Name: fki_yemek_foreign; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_yemek_foreign ON public.tur USING btree (yemek_id);


--
-- Name: musteri test1trig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER test1trig AFTER INSERT ON public.musteri FOR EACH ROW EXECUTE FUNCTION public.test1();


--
-- Name: tur test2trig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER test2trig AFTER INSERT ON public.tur FOR EACH ROW EXECUTE FUNCTION public.test2();


--
-- Name: musteri testtrig; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER testtrig AFTER INSERT ON public.musteri FOR EACH ROW EXECUTE FUNCTION public.test();


--
-- Name: tur testtrigtwo; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER testtrigtwo AFTER INSERT ON public.tur FOR EACH ROW EXECUTE FUNCTION public.testtwo();


--
-- Name: mst_tur mst_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mst_tur
    ADD CONSTRAINT mst_foreign FOREIGN KEY (id) REFERENCES public.musteri(mst_id) NOT VALID;


--
-- Name: tur rehber_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tur
    ADD CONSTRAINT rehber_foreign FOREIGN KEY (rehber_id) REFERENCES public.rehber(id) NOT VALID;


--
-- Name: mst_tur turmst_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mst_tur
    ADD CONSTRAINT turmst_foreign FOREIGN KEY (id) REFERENCES public.tur(tur_id) NOT VALID;


--
-- Name: tur yemek_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tur
    ADD CONSTRAINT yemek_foreign FOREIGN KEY (yemek_id) REFERENCES public.yemek(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

