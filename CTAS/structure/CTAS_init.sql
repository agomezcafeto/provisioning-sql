
CREATE SCHEMA "${schema.name}";

CREATE TABLE service_type (
  id serial NOT NULL,
  description text,
  created_by character varying(32) NOT NULL,
  created_at date NOT NULL,
  modified_by character varying(32),
  modified_at date,
  CONSTRAINT service_type_pk PRIMARY KEY (id)
);

CREATE TABLE other_benefits (
  id serial NOT NULL,
  name character varying(255) NOT NULL,
  created_by character varying(64) NOT NULL,
  created_at date NOT NULL,
  modified_by character varying(64),
  modified_at date,
  CONSTRAINT other_benefits_pk PRIMARY KEY (id)
);

CREATE TABLE requisition (
  id serial NOT NULL,
  profile_definition integer,
  age_range integer,
  contract_type integer,
  service_type integer,
  organization_name character varying(255),
  salary character varying(128),
  schedule character varying(128),
  country character varying(128),
  state character varying(128),
  city character varying(128),
  observations text,
  status integer NOT NULL,
  created_by character varying(64) NOT NULL,
  created_at date NOT NULL,
  modified_by character varying(64),
  modified_at date,
  CONSTRAINT requisition_pk PRIMARY KEY (id),
  CONSTRAINT requisition_age_range_fk FOREIGN KEY (age_range)
      REFERENCES cua.age_range (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT requisition_contract_type_fk FOREIGN KEY (contract_type)
      REFERENCES cua.contract_type (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT requisition_profile_definition_fk FOREIGN KEY (profile_definition)
      REFERENCES profile_definition (profile_definition_id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT requisition_service_type_fk FOREIGN KEY (service_type)
      REFERENCES service_type (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE TABLE requisition_other_benefits (
  id serial NOT NULL,
  requisition_id integer NOT NULL,
  other_benefits_id integer NOT NULL,
  CONSTRAINT requisition_other_benefits_pk PRIMARY KEY (id),
  CONSTRAINT other_benefits_fk FOREIGN KEY (other_benefits_id)
      REFERENCES other_benefits (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT requisition_fk FOREIGN KEY (requisition_id)
      REFERENCES requisition (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
);