PGDMP         -        
        {            db_incidencias    15.2    15.2 I    G           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            H           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            I           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            J           1262    32843    db_incidencias    DATABASE     �   CREATE DATABASE db_incidencias WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE db_incidencias;
                postgres    false                        2615    33116    sc_incidencias    SCHEMA        CREATE SCHEMA sc_incidencias;
    DROP SCHEMA sc_incidencias;
                postgres    false            �            1255    33099     sp_listar_acciones_inci(integer)    FUNCTION     �  CREATE FUNCTION public.sp_listar_acciones_inci(id_inci integer) RETURNS TABLE(acci_id integer, acci_descripcion text, acci_hora timestamp without time zone, acci_fecha date, acci_imagen character varying, inci_id integer, usua character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            a.tb_acci_id, 
			a.tb_acci_descripcion, 
			a.tb_acci_hora, 
			a.tb_acci_fecha,
			a.tb_acci_imagen,
			a.tb_inci_id,
			u.tb_usua_nombre
        FROM
            tb_accion a 
			INNER JOIN tb_usuario u ON u.tb_usua_id = a.tb_usua_id
		WHERE a.tb_inci_id=id_inci
		ORDER BY a.tb_acci_hora;
    RETURN;
END;
$$;
 ?   DROP FUNCTION public.sp_listar_acciones_inci(id_inci integer);
       public          postgres    false            �            1255    33076    sp_listar_areas()    FUNCTION     �   CREATE FUNCTION public.sp_listar_areas() RETURNS TABLE(area_id integer, area_nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT tb_area_id, tb_area_nombre
		FROM public.tb_area;

    RETURN;
END;
$$;
 (   DROP FUNCTION public.sp_listar_areas();
       public          postgres    false            �            1255    33111 @   sp_listar_inci_area_estado(character varying, character varying)    FUNCTION     j  CREATE FUNCTION public.sp_listar_inci_area_estado(narea character varying, estatus character varying) RETURNS TABLE(inci_id integer, inci_usuario character varying, inci_descripcion text, inci_ubicacion character varying, inci_estado character, inci_hora timestamp without time zone, inci_fecha date, tiin_id integer, inci_imagen character varying, tiin_nombre character varying, area_nombre character varying, sector_nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            i.tb_inci_id,
			u.tb_usua_nombre ,
			i.tb_inci_descripcion ,
			i.tb_inci_ubicacion ,
			i.tb_inci_estado,
			i.tb_inci_hora,
			i.tb_inci_fecha,
			i.tb_tiin_id,
			i.tb_inci_imagen,
			ti.tb_tiin_nombre,
			a.tb_area_nombre,
			u.tb_usua_sector
        FROM
            tb_incidencia i
            INNER JOIN tb_tipo_incidencia ti ON i.tb_tiin_id = ti.tb_tiin_id
            INNER JOIN tb_usuario u ON u.tb_usua_id = i.tb_usua_id 
			INNER JOIN tb_area a ON a.tb_area_id = ti.tb_area_id 
		WHERE a.tb_area_nombre=narea AND i.tb_inci_estado=estatus
		ORDER BY i.tb_inci_hora DESC;
    RETURN;
END;
$$;
 e   DROP FUNCTION public.sp_listar_inci_area_estado(narea character varying, estatus character varying);
       public          postgres    false            �            1255    33114 B   sp_listar_inci_sector_estado(character varying, character varying)    FUNCTION     m  CREATE FUNCTION public.sp_listar_inci_sector_estado(nsector character varying, estado character varying) RETURNS TABLE(inci_id integer, inci_usuario character varying, inci_descripcion text, inci_ubicacion character varying, inci_estado character, inci_hora timestamp without time zone, inci_fecha date, tiin_id integer, inci_imagen character varying, tiin_nombre character varying, area_nombre character varying, sector_nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            i.tb_inci_id,
			u.tb_usua_nombre ,
			i.tb_inci_descripcion ,
			i.tb_inci_ubicacion ,
			i.tb_inci_estado,
			i.tb_inci_hora,
			i.tb_inci_fecha,
			i.tb_tiin_id,
			i.tb_inci_imagen,
			ti.tb_tiin_nombre,
			a.tb_area_nombre,
			u.tb_usua_sector
        FROM
            tb_incidencia i
            INNER JOIN tb_tipo_incidencia ti ON i.tb_tiin_id = ti.tb_tiin_id
            INNER JOIN tb_usuario u ON u.tb_usua_id = i.tb_usua_id 
			INNER JOIN tb_area a ON a.tb_area_id = ti.tb_area_id
		WHERE u.tb_usua_sector=nsector AND i.tb_inci_estado=estado
		ORDER BY i.tb_inci_hora DESC;
    RETURN;
END;
$$;
 h   DROP FUNCTION public.sp_listar_inci_sector_estado(nsector character varying, estado character varying);
       public          postgres    false            �            1255    33104    sp_listar_incidencias_all()    FUNCTION     �  CREATE FUNCTION public.sp_listar_incidencias_all() RETURNS TABLE(inci_id integer, inci_usuario character varying, inci_descripcion text, inci_ubicacion character varying, inci_estado character, inci_hora timestamp without time zone, inci_fecha date, tiin_id integer, inci_imagen character varying, tiin_nombre character varying, area_nombre character varying, sector_nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            i.tb_inci_id,
			u.tb_usua_nombre ,
			i.tb_inci_descripcion ,
			i.tb_inci_ubicacion ,
			i.tb_inci_estado,
			i.tb_inci_hora,
			i.tb_inci_fecha,
			i.tb_tiin_id,
			i.tb_inci_imagen,
			ti.tb_tiin_nombre,
			a.tb_area_nombre,
			u.tb_usua_sector
        FROM
            tb_incidencia i
            INNER JOIN tb_tipo_incidencia ti ON i.tb_tiin_id = ti.tb_tiin_id
            INNER JOIN tb_usuario u ON u.tb_usua_id = i.tb_usua_id 
			INNER JOIN tb_area a ON a.tb_area_id = ti.tb_area_id
			ORDER BY i.tb_inci_hora DESC;
    RETURN;
END;
$$;
 2   DROP FUNCTION public.sp_listar_incidencias_all();
       public          postgres    false            �            1255    33105 -   sp_listar_incidencias_area(character varying)    FUNCTION     2  CREATE FUNCTION public.sp_listar_incidencias_area(narea character varying) RETURNS TABLE(inci_id integer, inci_usuario character varying, inci_descripcion text, inci_ubicacion character varying, inci_estado character, inci_hora timestamp without time zone, inci_fecha date, tiin_id integer, inci_imagen character varying, tiin_nombre character varying, area_nombre character varying, sector_nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            i.tb_inci_id,
			u.tb_usua_nombre ,
			i.tb_inci_descripcion ,
			i.tb_inci_ubicacion ,
			i.tb_inci_estado,
			i.tb_inci_hora,
			i.tb_inci_fecha,
			i.tb_tiin_id,
			i.tb_inci_imagen,
			ti.tb_tiin_nombre,
			a.tb_area_nombre,
			u.tb_usua_sector
        FROM
            tb_incidencia i
            INNER JOIN tb_tipo_incidencia ti ON i.tb_tiin_id = ti.tb_tiin_id
            INNER JOIN tb_usuario u ON u.tb_usua_id = i.tb_usua_id 
			INNER JOIN tb_area a ON a.tb_area_id = ti.tb_area_id 
		WHERE a.tb_area_nombre=narea
		ORDER BY i.tb_inci_hora DESC;
    RETURN;
END;
$$;
 J   DROP FUNCTION public.sp_listar_incidencias_area(narea character varying);
       public          postgres    false            �            1255    33109 /   sp_listar_incidencias_estado(character varying)    FUNCTION     <  CREATE FUNCTION public.sp_listar_incidencias_estado(estatus character varying) RETURNS TABLE(inci_id integer, inci_usuario character varying, inci_descripcion text, inci_ubicacion character varying, inci_estado character, inci_hora timestamp without time zone, inci_fecha date, tiin_id integer, inci_imagen character varying, tiin_nombre character varying, area_nombre character varying, sector_nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            i.tb_inci_id,
			u.tb_usua_nombre ,
			i.tb_inci_descripcion ,
			i.tb_inci_ubicacion ,
			i.tb_inci_estado,
			i.tb_inci_hora,
			i.tb_inci_fecha,
			i.tb_tiin_id,
			i.tb_inci_imagen,
			ti.tb_tiin_nombre,
			a.tb_area_nombre,
			u.tb_usua_sector
        FROM
            tb_incidencia i
            INNER JOIN tb_tipo_incidencia ti ON i.tb_tiin_id = ti.tb_tiin_id
            INNER JOIN tb_usuario u ON u.tb_usua_id = i.tb_usua_id 
			INNER JOIN tb_area a ON a.tb_area_id = ti.tb_area_id
			WHERE i.tb_inci_estado=estatus
			ORDER BY i.tb_inci_hora DESC;
		
    RETURN;
END;
$$;
 N   DROP FUNCTION public.sp_listar_incidencias_estado(estatus character varying);
       public          postgres    false            �            1255    33106 /   sp_listar_incidencias_sector(character varying)    FUNCTION     8  CREATE FUNCTION public.sp_listar_incidencias_sector(nsector character varying) RETURNS TABLE(inci_id integer, inci_usuario character varying, inci_descripcion text, inci_ubicacion character varying, inci_estado character, inci_hora timestamp without time zone, inci_fecha date, tiin_id integer, inci_imagen character varying, tiin_nombre character varying, area_nombre character varying, sector_nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            i.tb_inci_id,
			u.tb_usua_nombre ,
			i.tb_inci_descripcion ,
			i.tb_inci_ubicacion ,
			i.tb_inci_estado,
			i.tb_inci_hora,
			i.tb_inci_fecha,
			i.tb_tiin_id,
			i.tb_inci_imagen,
			ti.tb_tiin_nombre,
			a.tb_area_nombre,
			u.tb_usua_sector
        FROM
            tb_incidencia i
            INNER JOIN tb_tipo_incidencia ti ON i.tb_tiin_id = ti.tb_tiin_id
            INNER JOIN tb_usuario u ON u.tb_usua_id = i.tb_usua_id 
			INNER JOIN tb_area a ON a.tb_area_id = ti.tb_area_id 
		WHERE u.tb_usua_sector=nsector
		ORDER BY i.tb_inci_hora DESC;
    RETURN;
END;
$$;
 N   DROP FUNCTION public.sp_listar_incidencias_sector(nsector character varying);
       public          postgres    false            �            1255    33090    sp_listar_tipos_inci()    FUNCTION        CREATE FUNCTION public.sp_listar_tipos_inci() RETURNS TABLE(tiin_id integer, tiin_nombre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT tb_tiin_id, tb_tiin_nombre FROM public.tb_tipo_incidencia
    RETURN;
END;
$$;
 -   DROP FUNCTION public.sp_listar_tipos_inci();
       public          postgres    false            �            1255    33077    sp_listar_usuarios()    FUNCTION     x  CREATE FUNCTION public.sp_listar_usuarios() RETURNS TABLE(usua_id integer, usua_nombre character varying, usua_telefono character, usua_dni character, usua_password character varying, usua_sector character varying, usua_tipo character varying, usua_area character varying, tipo_id integer, area_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            u.tb_usua_id,
            u.tb_usua_nombre,
            u.tb_usua_telefono,
            u.tb_usua_dni,
            u.tb_usua_password,
            u.tb_usua_sector,
            tu.tb_tius_nombre AS tb_tius_id_nombre,
            a.tb_area_nombre AS tb_area_id_nombre,
			u.tb_tius_id,
			u.tb_area_id
        FROM
            tb_usuario u
            INNER JOIN tb_tipo_usuario tu ON u.tb_tius_id = tu.tb_tius_id
            INNER JOIN tb_area a ON u.tb_area_id = a.tb_area_id;

    RETURN;
END;
$$;
 +   DROP FUNCTION public.sp_listar_usuarios();
       public          postgres    false            �            1255    33080 /   sp_modificar_contra(integer, character varying)    FUNCTION     �   CREATE FUNCTION public.sp_modificar_contra(idusu integer, contra character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE public.tb_usuario 
		 SET tb_usua_password=contra 
		 where tb_usua_id=idusu;
		 return 1;
END;
$$;
 S   DROP FUNCTION public.sp_modificar_contra(idusu integer, contra character varying);
       public          postgres    false            �            1255    33108 ,   sp_modificar_inci_estado(integer, character)    FUNCTION     �   CREATE FUNCTION public.sp_modificar_inci_estado(idinci integer, valor character) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE tb_incidencia set
	tb_inci_estado = valor
	WHERE tb_inci_id = idinci;
END;
$$;
 P   DROP FUNCTION public.sp_modificar_inci_estado(idinci integer, valor character);
       public          postgres    false            �            1255    33082 k   sp_modificar_usuario(integer, character varying, character, character, character varying, integer, integer)    FUNCTION     �  CREATE FUNCTION public.sp_modificar_usuario(usua_id integer, usua_nombre character varying, usua_telefono character, usua_dni character, usua_sector character varying, tipo_id integer, area_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
   cant integer= (select count(*)from tb_usuario where tb_usua_dni=usua_dni);
   dnib character(8)= (select tb_usua_dni from tb_usuario where tb_usua_id=usua_id);
BEGIN
	IF (cant = 0  or dnib=usua_dni) THEN 
		 UPDATE public.tb_usuario 
		 SET tb_usua_dni=usua_dni, tb_usua_nombre=usua_nombre, tb_usua_sector=usua_sector, 
		 tb_usua_telefono=usua_telefono, tb_tius_id=tipo_id ,tb_area_id=area_id 
		 where tb_usua_id=usua_id;
		 return 1;
	ELSE 
		return 2;
	END IF;
END;
$$;
 �   DROP FUNCTION public.sp_modificar_usuario(usua_id integer, usua_nombre character varying, usua_telefono character, usua_dni character, usua_sector character varying, tipo_id integer, area_id integer);
       public          postgres    false            �            1255    33098 a   sp_registrar_accion(text, timestamp without time zone, date, character varying, integer, integer)    FUNCTION       CREATE FUNCTION public.sp_registrar_accion(acci_descripcion text, acci_hora timestamp without time zone, acci_fecha date, acci_imagen character varying, inci_id integer, usua_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
        INSERT INTO public.tb_accion(
			tb_acci_descripcion, 
			tb_acci_hora, 
			tb_acci_fecha,
			tb_acci_imagen,
			tb_inci_id,
			tb_usua_id
		)
        VALUES (
		acci_descripcion, 
		acci_hora, 
		acci_fecha,
		acci_imagen,
		inci_id,
		usua_id
		);
		
        RETURN 1;
END;
$$;
 �   DROP FUNCTION public.sp_registrar_accion(acci_descripcion text, acci_hora timestamp without time zone, acci_fecha date, acci_imagen character varying, inci_id integer, usua_id integer);
       public          postgres    false            �            1255    33091 x   sp_registrar_incidencia(text, character varying, timestamp without time zone, date, integer, character varying, integer)    FUNCTION     r  CREATE FUNCTION public.sp_registrar_incidencia(inci_descripcion text, inci_ubicacion character varying, inci_hora timestamp without time zone, inci_fecha date, tipo_inci integer, inci_imagen character varying, inci_usua integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
        INSERT INTO public.tb_incidencia(tb_inci_descripcion, tb_inci_ubicacion, tb_inci_estado,
            tb_inci_hora, tb_inci_fecha, tb_inci_imagen, tb_tiin_id, tb_usua_id)
        VALUES (inci_descripcion, inci_ubicacion, '0', inci_hora, inci_fecha,
            inci_imagen, tipo_inci, inci_usua);
        RETURN 1;
    
END;
$$;
 �   DROP FUNCTION public.sp_registrar_incidencia(inci_descripcion text, inci_ubicacion character varying, inci_hora timestamp without time zone, inci_fecha date, tipo_inci integer, inci_imagen character varying, inci_usua integer);
       public          postgres    false            �            1255    33079 u   sp_registrar_usuario(character varying, character, character, character varying, character varying, integer, integer)    FUNCTION     �  CREATE FUNCTION public.sp_registrar_usuario(usua_nombre character varying, usua_telefono character, usua_dni character, usua_password character varying, usua_sector character varying, tipo_id integer, area_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
	cant INT := (SELECT COUNT(*) FROM tb_usuario WHERE tb_usua_dni = usua_dni);
BEGIN
    IF cant = 0 THEN
        INSERT INTO public.tb_usuario(tb_usua_nombre, tb_usua_telefono, tb_usua_dni,
            tb_usua_password, tb_usua_sector, tb_tius_id, tb_area_id)
        VALUES (usua_nombre, usua_telefono, usua_dni, usua_password, usua_sector,
            tipo_id, area_id);
        RETURN 1;
    ELSE
        RETURN 2;
    END IF;
END;
$$;
 �   DROP FUNCTION public.sp_registrar_usuario(usua_nombre character varying, usua_telefono character, usua_dni character, usua_password character varying, usua_sector character varying, tipo_id integer, area_id integer);
       public          postgres    false            �            1255    33074    sp_verificar_usuario(character)    FUNCTION     �  CREATE FUNCTION public.sp_verificar_usuario(dni_input character) RETURNS TABLE(usua_id integer, usua_nombre character varying, usua_telefono character, usua_dni character, usua_password character varying, usua_sector character varying, tipo_usu character varying, area character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT
            u.tb_usua_id,
            u.tb_usua_nombre,
            u.tb_usua_telefono, -- Aseguramos que el tipo coincida con la definición de la tabla
            u.tb_usua_dni,
            u.tb_usua_password,
            u.tb_usua_sector,
            tu.tb_tius_nombre AS tb_tius_id_nombre,
            a.tb_area_nombre AS tb_area_id_nombre
        FROM
            tb_usuario u
            INNER JOIN tb_tipo_usuario tu ON u.tb_tius_id = tu.tb_tius_id
            INNER JOIN tb_area a ON u.tb_area_id = a.tb_area_id
		WHERE
   			 u.tb_usua_dni = dni_input;
    RETURN;
END;
$$;
 @   DROP FUNCTION public.sp_verificar_usuario(dni_input character);
       public          postgres    false            �            1259    32845 	   tb_accion    TABLE     /  CREATE TABLE public.tb_accion (
    tb_acci_id integer NOT NULL,
    tb_acci_descripcion text NOT NULL,
    tb_acci_hora timestamp without time zone NOT NULL,
    tb_acci_fecha date NOT NULL,
    tb_inci_id integer NOT NULL,
    tb_acci_imagen character varying(300) NOT NULL,
    tb_usua_id integer
);
    DROP TABLE public.tb_accion;
       public         heap    postgres    false            �            1259    32844    tb_accion_tb_acci_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_accion_tb_acci_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.tb_accion_tb_acci_id_seq;
       public          postgres    false    216            K           0    0    tb_accion_tb_acci_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.tb_accion_tb_acci_id_seq OWNED BY public.tb_accion.tb_acci_id;
          public          postgres    false    215            �            1259    32854    tb_area    TABLE     t   CREATE TABLE public.tb_area (
    tb_area_id integer NOT NULL,
    tb_area_nombre character varying(50) NOT NULL
);
    DROP TABLE public.tb_area;
       public         heap    postgres    false            �            1259    32853    tb_area_tb_area_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_area_tb_area_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.tb_area_tb_area_id_seq;
       public          postgres    false    218            L           0    0    tb_area_tb_area_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.tb_area_tb_area_id_seq OWNED BY public.tb_area.tb_area_id;
          public          postgres    false    217            �            1259    32861    tb_incidencia    TABLE     �  CREATE TABLE public.tb_incidencia (
    tb_inci_id integer NOT NULL,
    tb_inci_descripcion text NOT NULL,
    tb_inci_ubicacion character varying(200) NOT NULL,
    tb_inci_estado character(1) NOT NULL,
    tb_inci_hora timestamp without time zone NOT NULL,
    tb_inci_fecha date NOT NULL,
    tb_tiin_id integer NOT NULL,
    tb_inci_imagen character varying(300) NOT NULL,
    tb_usua_id integer
);
 !   DROP TABLE public.tb_incidencia;
       public         heap    postgres    false            �            1259    32860    tb_incidencia_tb_inci_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_incidencia_tb_inci_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.tb_incidencia_tb_inci_id_seq;
       public          postgres    false    220            M           0    0    tb_incidencia_tb_inci_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.tb_incidencia_tb_inci_id_seq OWNED BY public.tb_incidencia.tb_inci_id;
          public          postgres    false    219            �            1259    32870    tb_tipo_incidencia    TABLE     �   CREATE TABLE public.tb_tipo_incidencia (
    tb_tiin_id integer NOT NULL,
    tb_tiin_nombre character varying(50) NOT NULL,
    tb_area_id integer NOT NULL
);
 &   DROP TABLE public.tb_tipo_incidencia;
       public         heap    postgres    false            �            1259    32869 !   tb_tipo_incidencia_tb_tiin_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_tipo_incidencia_tb_tiin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.tb_tipo_incidencia_tb_tiin_id_seq;
       public          postgres    false    222            N           0    0 !   tb_tipo_incidencia_tb_tiin_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.tb_tipo_incidencia_tb_tiin_id_seq OWNED BY public.tb_tipo_incidencia.tb_tiin_id;
          public          postgres    false    221            �            1259    32877    tb_tipo_usuario    TABLE     |   CREATE TABLE public.tb_tipo_usuario (
    tb_tius_id integer NOT NULL,
    tb_tius_nombre character varying(50) NOT NULL
);
 #   DROP TABLE public.tb_tipo_usuario;
       public         heap    postgres    false            �            1259    32876    tb_tipo_usuario_tb_tius_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_tipo_usuario_tb_tius_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.tb_tipo_usuario_tb_tius_id_seq;
       public          postgres    false    224            O           0    0    tb_tipo_usuario_tb_tius_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.tb_tipo_usuario_tb_tius_id_seq OWNED BY public.tb_tipo_usuario.tb_tius_id;
          public          postgres    false    223            �            1259    32884 
   tb_usuario    TABLE     n  CREATE TABLE public.tb_usuario (
    tb_usua_id integer NOT NULL,
    tb_usua_nombre character varying(100) NOT NULL,
    tb_usua_telefono character(9) NOT NULL,
    tb_usua_dni character(8) NOT NULL,
    tb_usua_password character varying(100) NOT NULL,
    tb_usua_sector character varying(100),
    tb_tius_id integer NOT NULL,
    tb_area_id integer NOT NULL
);
    DROP TABLE public.tb_usuario;
       public         heap    postgres    false            �            1259    32883    tb_usuario_tb_usua_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tb_usuario_tb_usua_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.tb_usuario_tb_usua_id_seq;
       public          postgres    false    226            P           0    0    tb_usuario_tb_usua_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.tb_usuario_tb_usua_id_seq OWNED BY public.tb_usuario.tb_usua_id;
          public          postgres    false    225            �           2604    32848    tb_accion tb_acci_id    DEFAULT     |   ALTER TABLE ONLY public.tb_accion ALTER COLUMN tb_acci_id SET DEFAULT nextval('public.tb_accion_tb_acci_id_seq'::regclass);
 C   ALTER TABLE public.tb_accion ALTER COLUMN tb_acci_id DROP DEFAULT;
       public          postgres    false    215    216    216            �           2604    32857    tb_area tb_area_id    DEFAULT     x   ALTER TABLE ONLY public.tb_area ALTER COLUMN tb_area_id SET DEFAULT nextval('public.tb_area_tb_area_id_seq'::regclass);
 A   ALTER TABLE public.tb_area ALTER COLUMN tb_area_id DROP DEFAULT;
       public          postgres    false    217    218    218            �           2604    32864    tb_incidencia tb_inci_id    DEFAULT     �   ALTER TABLE ONLY public.tb_incidencia ALTER COLUMN tb_inci_id SET DEFAULT nextval('public.tb_incidencia_tb_inci_id_seq'::regclass);
 G   ALTER TABLE public.tb_incidencia ALTER COLUMN tb_inci_id DROP DEFAULT;
       public          postgres    false    220    219    220            �           2604    32873    tb_tipo_incidencia tb_tiin_id    DEFAULT     �   ALTER TABLE ONLY public.tb_tipo_incidencia ALTER COLUMN tb_tiin_id SET DEFAULT nextval('public.tb_tipo_incidencia_tb_tiin_id_seq'::regclass);
 L   ALTER TABLE public.tb_tipo_incidencia ALTER COLUMN tb_tiin_id DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    32880    tb_tipo_usuario tb_tius_id    DEFAULT     �   ALTER TABLE ONLY public.tb_tipo_usuario ALTER COLUMN tb_tius_id SET DEFAULT nextval('public.tb_tipo_usuario_tb_tius_id_seq'::regclass);
 I   ALTER TABLE public.tb_tipo_usuario ALTER COLUMN tb_tius_id DROP DEFAULT;
       public          postgres    false    224    223    224            �           2604    32887    tb_usuario tb_usua_id    DEFAULT     ~   ALTER TABLE ONLY public.tb_usuario ALTER COLUMN tb_usua_id SET DEFAULT nextval('public.tb_usuario_tb_usua_id_seq'::regclass);
 D   ALTER TABLE public.tb_usuario ALTER COLUMN tb_usua_id DROP DEFAULT;
       public          postgres    false    225    226    226            :          0    32845 	   tb_accion 
   TABLE DATA           �   COPY public.tb_accion (tb_acci_id, tb_acci_descripcion, tb_acci_hora, tb_acci_fecha, tb_inci_id, tb_acci_imagen, tb_usua_id) FROM stdin;
    public          postgres    false    216   �       <          0    32854    tb_area 
   TABLE DATA           =   COPY public.tb_area (tb_area_id, tb_area_nombre) FROM stdin;
    public          postgres    false    218   ߋ       >          0    32861    tb_incidencia 
   TABLE DATA           �   COPY public.tb_incidencia (tb_inci_id, tb_inci_descripcion, tb_inci_ubicacion, tb_inci_estado, tb_inci_hora, tb_inci_fecha, tb_tiin_id, tb_inci_imagen, tb_usua_id) FROM stdin;
    public          postgres    false    220   Ќ       @          0    32870    tb_tipo_incidencia 
   TABLE DATA           T   COPY public.tb_tipo_incidencia (tb_tiin_id, tb_tiin_nombre, tb_area_id) FROM stdin;
    public          postgres    false    222   Ǝ       B          0    32877    tb_tipo_usuario 
   TABLE DATA           E   COPY public.tb_tipo_usuario (tb_tius_id, tb_tius_nombre) FROM stdin;
    public          postgres    false    224   d�       D          0    32884 
   tb_usuario 
   TABLE DATA           �   COPY public.tb_usuario (tb_usua_id, tb_usua_nombre, tb_usua_telefono, tb_usua_dni, tb_usua_password, tb_usua_sector, tb_tius_id, tb_area_id) FROM stdin;
    public          postgres    false    226   ��       Q           0    0    tb_accion_tb_acci_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.tb_accion_tb_acci_id_seq', 19, true);
          public          postgres    false    215            R           0    0    tb_area_tb_area_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.tb_area_tb_area_id_seq', 1, false);
          public          postgres    false    217            S           0    0    tb_incidencia_tb_inci_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.tb_incidencia_tb_inci_id_seq', 22, true);
          public          postgres    false    219            T           0    0 !   tb_tipo_incidencia_tb_tiin_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.tb_tipo_incidencia_tb_tiin_id_seq', 8, true);
          public          postgres    false    221            U           0    0    tb_tipo_usuario_tb_tius_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.tb_tipo_usuario_tb_tius_id_seq', 4, true);
          public          postgres    false    223            V           0    0    tb_usuario_tb_usua_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.tb_usuario_tb_usua_id_seq', 9, true);
          public          postgres    false    225            �           2606    32852    tb_accion tb_accion_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.tb_accion
    ADD CONSTRAINT tb_accion_pkey PRIMARY KEY (tb_acci_id);
 B   ALTER TABLE ONLY public.tb_accion DROP CONSTRAINT tb_accion_pkey;
       public            postgres    false    216            �           2606    32859    tb_area tb_area_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.tb_area
    ADD CONSTRAINT tb_area_pkey PRIMARY KEY (tb_area_id);
 >   ALTER TABLE ONLY public.tb_area DROP CONSTRAINT tb_area_pkey;
       public            postgres    false    218            �           2606    32868     tb_incidencia tb_incidencia_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.tb_incidencia
    ADD CONSTRAINT tb_incidencia_pkey PRIMARY KEY (tb_inci_id);
 J   ALTER TABLE ONLY public.tb_incidencia DROP CONSTRAINT tb_incidencia_pkey;
       public            postgres    false    220            �           2606    32875 *   tb_tipo_incidencia tb_tipo_incidencia_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.tb_tipo_incidencia
    ADD CONSTRAINT tb_tipo_incidencia_pkey PRIMARY KEY (tb_tiin_id);
 T   ALTER TABLE ONLY public.tb_tipo_incidencia DROP CONSTRAINT tb_tipo_incidencia_pkey;
       public            postgres    false    222            �           2606    32882 $   tb_tipo_usuario tb_tipo_usuario_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.tb_tipo_usuario
    ADD CONSTRAINT tb_tipo_usuario_pkey PRIMARY KEY (tb_tius_id);
 N   ALTER TABLE ONLY public.tb_tipo_usuario DROP CONSTRAINT tb_tipo_usuario_pkey;
       public            postgres    false    224            �           2606    32889    tb_usuario tb_usuario_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tb_usuario
    ADD CONSTRAINT tb_usuario_pkey PRIMARY KEY (tb_usua_id);
 D   ALTER TABLE ONLY public.tb_usuario DROP CONSTRAINT tb_usuario_pkey;
       public            postgres    false    226            �           1259    32910    tb_usuario_area_idx    INDEX     P   CREATE INDEX tb_usuario_area_idx ON public.tb_usuario USING btree (tb_area_id);
 '   DROP INDEX public.tb_usuario_area_idx;
       public            postgres    false    226            �           1259    32916    tb_usuario_tius_idx    INDEX     P   CREATE INDEX tb_usuario_tius_idx ON public.tb_usuario USING btree (tb_tius_id);
 '   DROP INDEX public.tb_usuario_tius_idx;
       public            postgres    false    226            �           2606    32890 #   tb_accion tb_accion_tb_inci_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_accion
    ADD CONSTRAINT tb_accion_tb_inci_id_fkey FOREIGN KEY (tb_inci_id) REFERENCES public.tb_incidencia(tb_inci_id) NOT VALID;
 M   ALTER TABLE ONLY public.tb_accion DROP CONSTRAINT tb_accion_tb_inci_id_fkey;
       public          postgres    false    220    216    3227            �           2606    33093 $   tb_accion tb_accion_tb_usua_idi_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_accion
    ADD CONSTRAINT tb_accion_tb_usua_idi_fkey FOREIGN KEY (tb_usua_id) REFERENCES public.tb_usuario(tb_usua_id) NOT VALID;
 N   ALTER TABLE ONLY public.tb_accion DROP CONSTRAINT tb_accion_tb_usua_idi_fkey;
       public          postgres    false    226    3234    216            �           2606    32895 +   tb_incidencia tb_incidencia_tb_tiin_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_incidencia
    ADD CONSTRAINT tb_incidencia_tb_tiin_id_fkey FOREIGN KEY (tb_tiin_id) REFERENCES public.tb_tipo_incidencia(tb_tiin_id) NOT VALID;
 U   ALTER TABLE ONLY public.tb_incidencia DROP CONSTRAINT tb_incidencia_tb_tiin_id_fkey;
       public          postgres    false    220    3229    222            �           2606    33083 +   tb_incidencia tb_incidencia_tb_usua_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_incidencia
    ADD CONSTRAINT tb_incidencia_tb_usua_id_fkey FOREIGN KEY (tb_usua_id) REFERENCES public.tb_usuario(tb_usua_id) NOT VALID;
 U   ALTER TABLE ONLY public.tb_incidencia DROP CONSTRAINT tb_incidencia_tb_usua_id_fkey;
       public          postgres    false    3234    226    220            �           2606    32900 5   tb_tipo_incidencia tb_tipo_incidencia_tb_area_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_tipo_incidencia
    ADD CONSTRAINT tb_tipo_incidencia_tb_area_id_fkey FOREIGN KEY (tb_area_id) REFERENCES public.tb_area(tb_area_id);
 _   ALTER TABLE ONLY public.tb_tipo_incidencia DROP CONSTRAINT tb_tipo_incidencia_tb_area_id_fkey;
       public          postgres    false    3225    218    222            �           2606    32905 %   tb_usuario tb_usuario_tb_area_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_usuario
    ADD CONSTRAINT tb_usuario_tb_area_id_fkey FOREIGN KEY (tb_area_id) REFERENCES public.tb_area(tb_area_id);
 O   ALTER TABLE ONLY public.tb_usuario DROP CONSTRAINT tb_usuario_tb_area_id_fkey;
       public          postgres    false    226    218    3225            �           2606    32911 %   tb_usuario tb_usuario_tb_tius_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tb_usuario
    ADD CONSTRAINT tb_usuario_tb_tius_id_fkey FOREIGN KEY (tb_tius_id) REFERENCES public.tb_tipo_usuario(tb_tius_id);
 O   ALTER TABLE ONLY public.tb_usuario DROP CONSTRAINT tb_usuario_tb_tius_id_fkey;
       public          postgres    false    3231    224    226            :   �  x���a��0��S� �g��3T��RD�ӺJ���gϲ[�$���
BH��ޛ����^�5�������?�m}�1�HBj5i�X���`���*$d������Â�?N=k���^}>�y��#n8��y�C��~�"pY[0VRc��ݪeN`��=t	��1LWw�R�*��Q�� �nn�pn���Jөo�����E��ܔ&
)���,�*���8��Kyߵ~���)UhI��d�70���L�Ʌօ��8�"�n�dKz H���$U�jR%[	g;����!k7�Ҕ�5�.����\�&�E���.�4|s� �
�Ԅ��PT�����_,��P�8�����=4����2n͹���&�}HGfr�y?�A=<���c��ec��%MH#�\i�]�����I�>�鰢�Jg1q9-%Ŷ
���o�EQ|�;%�      <   �   x�u��N!�k�S��Qן�:�	d̰ceò$,l`��������Ť3SX���~9ɹ%����뷡��.� wdp�E�}9Go����?xp��brN!$�m��r�6���N�x\����<�Z��xZ�lb9��8�َ��_t�+G}Y���^b���&y7d;��7����h>̓`�h/��:��G�|�H�8M��#��gT#�_�/n�e�      >   �  x���Mn�0F��)� �ARR���H4@�E���84(Q�Ġ�r�]��� -Х�#��}���^�S{=�΂�ٝe-��`��,�e�s���ES�ь�v���"-�m.EUg�������
�Q�[c��FЃ���`Z�:�z밳� ʄ�^~X�� k�7�-d��(Ad�(���g��-eV���q���'��f�:A���EGb9X�4��w@ڤc����CHR4E�de4��W��j��]�}��4<�0kS i�f��'5�d����;�<��~�GE?���B����T�T'�"�&����C��p��w$�]=����^���;�� �&��gk��+���q²DT����s=�Xf��Z�+�jr�o)�TM��vu�%��t�^��Q��놨���A��D�G���z�W�����p���t��U��`�iL���KOu�{�0J�c�Aȷ���'O6I���� �      @   �   x���1D�v� i�.Gob���^��FitCc$g���n����D�&�b
<�^6�da�[�h��(����*�[��2��F_����(���p�s�54'���x�č]�-Dr���g�B�X�k��Γ����+o      B   8   x�3�tt����2��pr���2�t�uqtq���2���q�q����� �
�      D   �  x�e�K��: ��qz�$� AA ���u'�؊���<vu�p7v�sZ��n����_���|��m�o��HX@�D��%Yohx�����c�;��c�S��V�z*Ϫǆ,8�u��m�Qܷ3Sk�)@8�@��z�T��~�L���r���MT��x12((��y��@K�,��I걭�l���ht���6Jz;��r�%b&��e-�9��O�p�@���B��"E�J����_8�z�����=�v͖	#�����]a�vM����V�q�bV�6�YL=  4�@@|{!��^�	���v�2Λ����2K��-�zWO7Ӌ�u>��`�u�j���2�:�B�1�4d�O �1������Ne�#�n�E����2[�eš��1�~px�T����j��7�ٹ�7�є	:�L]�E�y-�����
�ڦ$�7��\�h��»e�W�m�����(79D������H_�xd�8���[
=J!D���OV�������\�5)���l�C�5I�/W��_>*�1�S��'�j �? �,�?��ʓ_F/�]kNn�b��EW꒤�}!՘�u�+�EE>6\R{5Wm���cPAlV�ȏ>������]�,K�zǯJ�wW5t�k+.u�v,�d�-w;�?n|�o��N�7�����&��o�z
�     