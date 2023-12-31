PGDMP  )    4                {            ikli_db    16.1    16.1     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16398    ikli_db    DATABASE     ~   CREATE DATABASE ikli_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE ikli_db;
                postgres    false            �            1259    16425    ar_internal_metadata    TABLE     �   CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);
 (   DROP TABLE public.ar_internal_metadata;
       public         heap    postgres    false            �            1259    16433    id_transactions    SEQUENCE     x   CREATE SEQUENCE public.id_transactions
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.id_transactions;
       public          postgres    false            �            1259    16432    id_users    SEQUENCE     q   CREATE SEQUENCE public.id_users
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE public.id_users;
       public          postgres    false            �            1259    16434 
   id_wallets    SEQUENCE     s   CREATE SEQUENCE public.id_wallets
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE public.id_wallets;
       public          postgres    false            �            1259    16418    schema_migrations    TABLE     R   CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);
 %   DROP TABLE public.schema_migrations;
       public         heap    postgres    false            �            1259    16399    transactions    TABLE     �   CREATE TABLE public.transactions (
    id integer DEFAULT nextval('public.id_transactions'::regclass) NOT NULL,
    date timestamp without time zone,
    type_transaction character varying(10),
    idwallet integer,
    amount double precision
);
     DROP TABLE public.transactions;
       public         heap    postgres    false    221            �            1259    16404    users    TABLE     �  CREATE TABLE public.users (
    id integer DEFAULT nextval('public.id_users'::regclass) NOT NULL,
    name character varying(100) DEFAULT NULL::character varying,
    email character varying(100) DEFAULT NULL::character varying,
    password character varying(255) DEFAULT NULL::character varying,
    created_at date,
    updated_at date,
    password_digest character varying(255)
);
    DROP TABLE public.users;
       public         heap    postgres    false    220            �            1259    16412    wallets    TABLE     �   CREATE TABLE public.wallets (
    id integer DEFAULT nextval('public.id_wallets'::regclass) NOT NULL,
    balance numeric,
    idusers integer
);
    DROP TABLE public.wallets;
       public         heap    postgres    false    222            �          0    16425    ar_internal_metadata 
   TABLE DATA                 public          postgres    false    219   �       �          0    16418    schema_migrations 
   TABLE DATA                 public          postgres    false    218   �       �          0    16399    transactions 
   TABLE DATA                 public          postgres    false    215          �          0    16404    users 
   TABLE DATA                 public          postgres    false    216   N       �          0    16412    wallets 
   TABLE DATA                 public          postgres    false    217   9       �           0    0    id_transactions    SEQUENCE SET     >   SELECT pg_catalog.setval('public.id_transactions', 50, true);
          public          postgres    false    221            �           0    0    id_users    SEQUENCE SET     7   SELECT pg_catalog.setval('public.id_users', 12, true);
          public          postgres    false    220            �           0    0 
   id_wallets    SEQUENCE SET     8   SELECT pg_catalog.setval('public.id_wallets', 2, true);
          public          postgres    false    222            6           2606    16431 .   ar_internal_metadata ar_internal_metadata_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);
 X   ALTER TABLE ONLY public.ar_internal_metadata DROP CONSTRAINT ar_internal_metadata_pkey;
       public            postgres    false    219            4           2606    16424 (   schema_migrations schema_migrations_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);
 R   ALTER TABLE ONLY public.schema_migrations DROP CONSTRAINT schema_migrations_pkey;
       public            postgres    false    218            .           2606    16403    transactions transactions_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.transactions DROP CONSTRAINT transactions_pkey;
       public            postgres    false    215            0           2606    16411    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    216            2           2606    16416    wallets wallet_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallet_pkey PRIMARY KEY (id);
 =   ALTER TABLE ONLY public.wallets DROP CONSTRAINT wallet_pkey;
       public            postgres    false    217            �   
   x���          �   
   x���          �   3  x���=k1��O�M�3�yKr���A(��Zλ��FJ�}#���[�&Y~���_,W�Z,׏�p�l�Z�c�;Uu�����tM��*�������c����n�X��m�ũz�x��ԄM��h�f�3,���>kD��Zۦ��t�tH��n����4�`�` �!3� ��c�O�n~~�Y��{�a���`��V�f�q� V�t�ä&9�:͈�����`6��3�"�l�s9���1�_��	~0��ee0Fs*��SVf2��0S�"���*fr��.@yɿAf�,f���F�.Uۑ      �   �   x�M��j�@F�y��DaL�D��E�MiS���n�N2�ӚL��Z��5����|i���rH��Zǎ����@OV�9^�<hј��g]j��W;�\[���Urύ�����V�����D���&.�T�E�n��WX��+"�x��x��p�Ѥ[>E?����`|i��\�3u���I�q�7�בԂ��E����ϧ��T<`Пz��k�Q6      �   r   x���v
Q���W((M��L�+O��I-)V��L�QHJ�I�KN�Q�L)-N-*�Ts�	uV�0�Q0�3�Q04Ҵ��$�C�	��zp`b``hnnffana``aaT ��� [�/i     