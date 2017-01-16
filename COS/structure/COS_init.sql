--
-- This source code is the confidential, proprietary information of
-- Cafeto Software S.A.S. here in, you may not disclose such Information,
-- and may only use it in accordance with the terms of the license
-- agreement you entered into with Cafeto Software S.A.S.
--
-- 2016: Cafeto Software S.A.S.
-- All Rights Reserved.
--

CREATE SEQUENCE skill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE skill_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE skill_type (
    skill_type_id integer NOT NULL,
    name character varying(255),
    description text,
    created_by character varying(256),
    created_at date,
    modified_at date
);

CREATE TABLE skills (
    skill_id integer DEFAULT nextval('skill_id_seq'::regclass) NOT NULL,
    name character varying(128) NOT NULL,
    description text,
    skill_type_id integer,
    code character varying(128),
    skill_status integer
);

CREATE TABLE organizational_structure (
  id serial NOT NULL,
  version integer,
  status integer,
  CONSTRAINT "organizational_structure_PK" PRIMARY KEY (id)
);

CREATE TABLE business_division (
  business_division_id serial NOT NULL,
  name character varying(255),
  description text,
  color character varying(255),
  author_username character varying(255),
  creation_date date,
  modification_date date,
  CONSTRAINT business_division_pk PRIMARY KEY (business_division_id)
);

CREATE SEQUENCE profile_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE profile (
  profile_id integer NOT NULL DEFAULT nextval('profile_seq'::regclass),
  parent integer,
  name character varying(100) NOT NULL,
  created_at date,
  modified_at date,
  created_by character varying(256),
  modified_by character varying(256),
  code character varying(32),
  business_division integer,
  organizational_structure integer,
  CONSTRAINT profile_pk PRIMARY KEY (profile_id),
  CONSTRAINT "organizational_structure_FK" FOREIGN KEY (organizational_structure)
        REFERENCES organizational_structure (id) MATCH SIMPLE
        ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT business_division_fk FOREIGN KEY (business_division)
      REFERENCES business_division (business_division_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT parent_fk FOREIGN KEY (parent)
      REFERENCES profile (profile_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT profile_profile_id_key UNIQUE (profile_id)
);

CREATE SEQUENCE profile_level_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE profile_level (
    profile_level_id integer DEFAULT nextval('profile_level_seq'::regclass) NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    created_at date,
    modified_at date,
    created_by character varying(256)
);

CREATE SEQUENCE profile_definition_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 26
  CACHE 1;

CREATE TABLE profile_definition (
  profile_definition_id integer NOT NULL DEFAULT nextval('profile_definition_seq'::regclass),
  profile integer,
  profile_level_id integer,
  purpose text,
  dependents_range_id integer NOT NULL,
  education_level_id integer,
  experience_range_id integer,
  adaptation_period numeric(5,2),
  status integer NOT NULL,
  is_leader boolean NOT NULL,
  other_aspects text,
  created_at timestamp without time zone,
  modified_at timestamp without time zone,
  created_by character varying(256),
  modified_by character varying(256),
  code character varying(64),
  version integer,
  CONSTRAINT profile_definition_pk PRIMARY KEY (profile_definition_id),
  CONSTRAINT "dependents_range_FK" FOREIGN KEY (dependents_range_id)
      REFERENCES cua.dependents_range (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "education_level_FK" FOREIGN KEY (education_level_id)
      REFERENCES cua.education_level (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "experience_range_FK" FOREIGN KEY (experience_range_id)
      REFERENCES cua.experience_range (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT profile_definition_profile_fk FOREIGN KEY (profile)
      REFERENCES profile (profile_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE SEQUENCE pair_profile_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE pair_profile (
  pair_profile_id integer NOT NULL DEFAULT nextval('pair_profile_seq'::regclass),
  profile_definition_id integer NOT NULL,
  profile_id integer NOT NULL,
  CONSTRAINT pair_profile_pk PRIMARY KEY (pair_profile_id),
  CONSTRAINT pair_profile_fk2 FOREIGN KEY (profile_id)
      REFERENCES profile (profile_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT profile_definition_pair_profile_fk FOREIGN KEY (profile_definition_id)
      REFERENCES profile_definition (profile_definition_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE SEQUENCE profile_internal_contact_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE profile_internal_contact (
  id integer NOT NULL DEFAULT nextval('profile_internal_contact_seq'::regclass),
  profile_definition_id integer NOT NULL,
  profile_id integer NOT NULL,
  responsibility text,
  frequency integer NOT NULL,
  CONSTRAINT profile_internal_contact_pk PRIMARY KEY (id),
  CONSTRAINT "internal_contact_frequency_FK" FOREIGN KEY (frequency)
      REFERENCES cua.contact_frequency (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT profile_internal_contact_fk1 FOREIGN KEY (profile_definition_id)
      REFERENCES profile_definition (profile_definition_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT profile_internal_contact_fk2 FOREIGN KEY (profile_id)
      REFERENCES profile (profile_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE SEQUENCE profile_external_contact_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE profile_external_contact (
  id integer NOT NULL DEFAULT nextval('profile_external_contact_seq'::regclass),
  profile_definition_id integer NOT NULL,
  name character varying(256),
  responsibility text,
  frequency integer NOT NULL,
  CONSTRAINT profile_external_contact_pk PRIMARY KEY (id),
  CONSTRAINT "contact_frequency_FK" FOREIGN KEY (frequency)
      REFERENCES cua.contact_frequency (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT profile_definition_external_contact_fk FOREIGN KEY (profile_definition_id)
      REFERENCES profile_definition (profile_definition_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE SEQUENCE profile_function_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE profile_function (
  id serial NOT NULL,
  profile_definition_id integer NOT NULL,
  description text NOT NULL,
  achievement_indicator text,
  CONSTRAINT profile_function_pk PRIMARY KEY (id),
  CONSTRAINT profile_definition_profile_function_fk FOREIGN KEY (profile_definition_id)
      REFERENCES profile_definition (profile_definition_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE SEQUENCE profile_skill_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE profile_skill (
  profile_skill_id integer NOT NULL DEFAULT nextval('profile_skill_seq'::regclass),
  profile_definition_id integer NOT NULL,
  skill_id integer NOT NULL,
  CONSTRAINT "profile_skill_PK" PRIMARY KEY (profile_skill_id),
  CONSTRAINT "profile_definition_skill_FK" FOREIGN KEY (profile_definition_id)
      REFERENCES profile_definition (profile_definition_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE SEQUENCE profile_occupation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE profile_occupation (
  profile_occupation_id integer NOT NULL DEFAULT nextval('profile_occupation_seq'::regclass),
  profile_definition_id integer NOT NULL,
  occupation_id integer NOT NULL,
  CONSTRAINT profile_occupation_pk PRIMARY KEY (profile_occupation_id),
  CONSTRAINT "occupation_FK" FOREIGN KEY (occupation_id)
      REFERENCES cua.occupation (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT profile_definition_occupation_fk FOREIGN KEY (profile_definition_id)
      REFERENCES profile_definition (profile_definition_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE SEQUENCE profile_further_training_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE profile_further_training (
  profile_further_training_id integer NOT NULL DEFAULT nextval('profile_further_training_seq'::regclass),
  profile_definition_id integer NOT NULL,
  further_training_id integer NOT NULL,
  CONSTRAINT profile_further_training_pk PRIMARY KEY (profile_further_training_id),
  CONSTRAINT "further_training_FK" FOREIGN KEY (further_training_id)
      REFERENCES cua.further_training (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT profile_definition_further_training_fk FOREIGN KEY (profile_definition_id)
      REFERENCES profile_definition (profile_definition_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE SEQUENCE profile_technical_skill_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE profile_technical_skill (
  profile_technical_skill_id integer NOT NULL DEFAULT nextval('profile_technical_skill_seq'::regclass),
  profile_definition_id integer NOT NULL,
  technical_skill_id integer NOT NULL,
  CONSTRAINT profile_technical_skill_pk PRIMARY KEY (profile_technical_skill_id),
  CONSTRAINT profile_technical_skill_fk FOREIGN KEY (profile_definition_id)
      REFERENCES profile_definition (profile_definition_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT "technical_skill_FK" FOREIGN KEY (technical_skill_id)
      REFERENCES cua.technical_skill (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE profile_authority (
  profile_authority_id serial NOT NULL,
  profile_definition_id integer NOT NULL,
  authority_type_id integer NOT NULL,
  description text NOT NULL,
  CONSTRAINT "profile_authority_FK" PRIMARY KEY (profile_authority_id),
  CONSTRAINT "authority_type_FK" FOREIGN KEY (authority_type_id)
      REFERENCES cua.authority_type (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT profile_definition_authority_type_fk FOREIGN KEY (profile_definition_id)
      REFERENCES profile_definition (profile_definition_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);
