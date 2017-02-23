--
-- This source code is the confidential, proprietary information of
-- Cafeto Software S.A.S. here in, you may not disclose such Information,
-- and may only use it in accordance with the terms of the license
-- agreement you entered into with Cafeto Software S.A.S.
--
-- 2016: Cafeto Software S.A.S.
-- All Rights Reserved.
--


CREATE TABLE behavior (
    behavior_id integer DEFAULT nextval('behavior_id_seq'::regclass) NOT NULL,
    behavior_description text NOT NULL,
    skill integer,
    behavior_type integer NOT NULL
);

CREATE SEQUENCE behavior_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE behavior_types (
    behavior_type_id integer DEFAULT nextval('behavior_type_id_seq'::regclass) NOT NULL,
    behavior_type_name character varying(128) NOT NULL,
    description text,
    author_username character varying(128) NOT NULL,
    created_at date NOT NULL default CURRENT_DATE,
    modified_at date
);

CREATE SEQUENCE constraint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE "constraint" (
    constraint_id integer DEFAULT nextval('constraint_id_seq'::regclass) NOT NULL,
    name character varying(64) NOT NULL,
    description text,
    error_message character varying(128),
    regex character varying(128)
);

CREATE SEQUENCE option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE field_options (
    option_id integer DEFAULT nextval('option_id_seq'::regclass) NOT NULL,
    field_id integer NOT NULL,
    key character varying(128),
    value character varying(128) NOT NULL
);

CREATE SEQUENCE field_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE field_type (
    field_type_id integer DEFAULT nextval('field_type_id_seq'::regclass) NOT NULL,
    name character varying NOT NULL
);

CREATE SEQUENCE field_type_constraint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE field_type_constraint (
    field_type_constraint_id integer DEFAULT nextval('field_type_constraint_id_seq'::regclass) NOT NULL,
    field_type_id integer NOT NULL,
    constraint_id integer NOT NULL
);

CREATE SEQUENCE field_type_pattern_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE field_type_pattern (
    field_type_pattern_id integer DEFAULT nextval('field_type_pattern_id_seq'::regclass) NOT NULL,
    field_type_id integer NOT NULL,
    pattern_id integer NOT NULL
);

CREATE SEQUENCE form_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE form (
    form_id integer DEFAULT nextval('form_id_seq'::regclass) NOT NULL,
    form_name character varying(128) NOT NULL,
    form_description text,
    form_type_id integer NOT NULL,
    form_status character varying(64) NOT NULL,
    form_version integer,
    form_columns integer
);

CREATE SEQUENCE form_field_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE form_field (
    field_id integer DEFAULT nextval('form_field_id_seq'::regclass) NOT NULL,
    form_id integer NOT NULL,
    field_type_id integer NOT NULL,
    name character varying(64) NOT NULL,
    description text,
    label character varying(128),
    tool_tip character varying(256),
    required boolean NOT NULL,
    error_message character varying(128),
    min_value integer,
    max_value integer,
    min_length integer,
    max_length integer,
    max_decimal integer,
    default_value character varying(128),
    constraint_id integer,
    pattern_id integer,
    field_position integer
);

CREATE SEQUENCE form_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE form_type (
    form_type_id integer DEFAULT nextval('form_type_id_seq'::regclass) NOT NULL,
    form_type_name character varying(128) NOT NULL,
    form_type_description text
);

CREATE SEQUENCE global_option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE global_option_list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE global_option_list (
    global_option_list_id integer DEFAULT nextval('global_option_list_id_seq'::regclass) NOT NULL,
    global_option_list_name character varying NOT NULL
);

CREATE TABLE global_options (
    global_option_id integer DEFAULT nextval('global_option_id_seq'::regclass) NOT NULL,
    global_option_key character varying,
    global_option_value character varying,
    global_option_list_id integer NOT NULL
);

CREATE SEQUENCE pattern_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE pattern (
    pattern_id integer DEFAULT nextval('pattern_id_seq'::regclass) NOT NULL,
    name character varying(128) NOT NULL,
    expression character varying(128) NOT NULL,
    error_message character varying(128)
);

CREATE SEQUENCE skill_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE skill_type (
    skill_type_id serial NOT NULL,
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

ALTER TABLE ONLY behavior
    ADD CONSTRAINT "behavior_PK" PRIMARY KEY (behavior_id);

ALTER TABLE ONLY behavior_types
    ADD CONSTRAINT "behavior_type_PK" PRIMARY KEY (behavior_type_id);

ALTER TABLE behavior ADD CONSTRAINT "behavior_type_FK" FOREIGN KEY (behavior_type)
      REFERENCES behavior_types (behavior_type_id) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "constraint"
    ADD CONSTRAINT constraint_id_pk PRIMARY KEY (constraint_id);

ALTER TABLE ONLY field_type_constraint
    ADD CONSTRAINT field_type_constraint_id_pk PRIMARY KEY (field_type_constraint_id);

ALTER TABLE ONLY field_type
    ADD CONSTRAINT field_type_id_pk PRIMARY KEY (field_type_id);

ALTER TABLE ONLY field_type_pattern
    ADD CONSTRAINT field_type_pattern_id_pk PRIMARY KEY (field_type_pattern_id);

ALTER TABLE ONLY form_field
    ADD CONSTRAINT form_field_id_pk PRIMARY KEY (field_id);

ALTER TABLE ONLY form
    ADD CONSTRAINT form_id_pk PRIMARY KEY (form_id);

ALTER TABLE ONLY form_type
    ADD CONSTRAINT form_type_id_pk PRIMARY KEY (form_type_id);

ALTER TABLE ONLY global_options
    ADD CONSTRAINT global_option_id_pk PRIMARY KEY (global_option_id);

ALTER TABLE ONLY global_option_list
    ADD CONSTRAINT global_option_list_id_pk PRIMARY KEY (global_option_list_id);

ALTER TABLE ONLY field_options
    ADD CONSTRAINT option_id_pk PRIMARY KEY (option_id);

ALTER TABLE ONLY pattern
    ADD CONSTRAINT pattern_id_pk PRIMARY KEY (pattern_id);

ALTER TABLE ONLY skills
    ADD CONSTRAINT "skill_id_PK" PRIMARY KEY (skill_id);

ALTER TABLE ONLY skill_type
    ADD CONSTRAINT skill_type_pk PRIMARY KEY (skill_type_id);

ALTER TABLE ONLY profile_level
    ADD CONSTRAINT profile_level_pk PRIMARY KEY (profile_level_id);

CREATE INDEX fki_constraint_fk ON field_type_constraint USING btree (constraint_id);

CREATE INDEX "fki_field_constraint_FK" ON form_field USING btree (constraint_id);

CREATE INDEX fki_field_type_fk ON field_type_constraint USING btree (field_type_id);

CREATE INDEX fki_field_type_form_field_fk ON form_field USING btree (field_type_id);

CREATE INDEX fki_field_type_pattern_fk ON field_type_pattern USING btree (field_type_id);

CREATE INDEX fki_form_field_fk ON field_options USING btree (field_id);

CREATE INDEX fki_form_id_fk ON form_field USING btree (form_id);

CREATE INDEX fki_form_type_fk ON form USING btree (form_type_id);

CREATE INDEX fki_global_option_list_fk ON global_options USING btree (global_option_list_id);

CREATE INDEX fki_pattern_field_type_pattern_fk ON field_type_pattern USING btree (pattern_id);

CREATE INDEX fki_skill_type_fk ON skills USING btree (skill_type_id);

ALTER TABLE ONLY field_type_constraint
    ADD CONSTRAINT constraint_fk FOREIGN KEY (constraint_id) REFERENCES "constraint"(constraint_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY form_field
    ADD CONSTRAINT "field_constraint_FK" FOREIGN KEY (constraint_id) REFERENCES "constraint"(constraint_id);

ALTER TABLE ONLY field_type_constraint
    ADD CONSTRAINT field_type_fk FOREIGN KEY (field_type_id) REFERENCES field_type(field_type_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY form_field
    ADD CONSTRAINT field_type_form_field_fk FOREIGN KEY (field_type_id) REFERENCES field_type(field_type_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY field_type_pattern
    ADD CONSTRAINT field_type_pattern_fk FOREIGN KEY (field_type_id) REFERENCES field_type(field_type_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY field_options
    ADD CONSTRAINT form_field_fk FOREIGN KEY (field_id) REFERENCES form_field(field_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY form_field
    ADD CONSTRAINT form_id_fk FOREIGN KEY (form_id) REFERENCES form(form_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY form
    ADD CONSTRAINT form_type_fk FOREIGN KEY (form_type_id) REFERENCES form_type(form_type_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY global_options
    ADD CONSTRAINT global_option_list_fk FOREIGN KEY (global_option_list_id) REFERENCES global_option_list(global_option_list_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY field_type_pattern
    ADD CONSTRAINT pattern_field_type_pattern_fk FOREIGN KEY (pattern_id) REFERENCES pattern(pattern_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY behavior
    ADD CONSTRAINT "skill_FK" FOREIGN KEY (skill) REFERENCES skills(skill_id) ON DELETE CASCADE;

ALTER TABLE ONLY skills
    ADD CONSTRAINT skill_type_fk FOREIGN KEY (skill_type_id) REFERENCES skill_type(skill_type_id);