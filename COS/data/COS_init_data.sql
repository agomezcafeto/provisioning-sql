--
-- This source code is the confidential, proprietary information of
-- Cafeto Software S.A.S. here in, you may not disclose such Information,
-- and may only use it in accordance with the terms of the license
-- agreement you entered into with Cafeto Software S.A.S.
--
-- 2016: Cafeto Software S.A.S.
-- All Rights Reserved.
--


INSERT INTO behavior_types (behavior_type_name, description, author_username, created_at, modified_at) VALUES ('Comportamientos Colaboradores', 'Edición de Comportamientos para Colaboradores', 'default', '2016-12-14', '2016-12-14');
INSERT INTO behavior_types (behavior_type_name, description, author_username, created_at, modified_at) VALUES ('Comportamientos de líderes', 'Edición de Comportamientos para líderes', 'default', '2016-12-14', '2016-12-14');

INSERT INTO skill_type (name, description) VALUES ('ORG_SKILLS_LABEL', 'Son definidas como aquellas actitudes, habilidades o destrezas que deben poseer los miembros de una organización para el logro de objetivos o metas organizacionales, estas competencias tienen relación directa con las características y valores de la organización y deben estar presentes en todos los cargos de la compañía.');
INSERT INTO skill_type (name, description) VALUES ('LEADERSHIP_SKILLS_LABEL', 'Actitudes, habilidades o destrezas que deben poseer los miembros de una organización que tienen la responsabilidad de liderar procesos o áreas, direccionando el funcionamiento de un equipo de trabajo y velando por la consecución de los objetivos de la organización. Deben aparecer en la mayoría de los cargos tácticos y estratégicos de la compañía.');
INSERT INTO skill_type (name, description) VALUES ('SPECIFIC_SKILLS_LABEL', 'Son las habilidades, actitudes o destrezas que se necesitan para el desarrollo de un rol específico dentro de la compañía, se establecen en el perfil del cargo de acuerdo a la misión, objetivos y responsabilidades de éste. Son competencias críticas que el cargo requiere para su correcta ejecución.');

INSERT INTO business_division (name, description, color, author_username, creation_date) VALUES ('TI', 'Area de tecnologías informáticas.', '#46a3f4', 'deafult','2016-12-09');
INSERT INTO business_division (name, description, color, author_username, creation_date) VALUES ('Mercadeo', 'Area de mercadeo', '#56ff64', 'deafault', '2016-12-09');

INSERT INTO "constraint" (constraint_id, name, description, error_message, regex) VALUES (1, 'Alphabetic', 'Only alphabetic characters', 'ERROR_MESSAGE_CONSTRAINT_1', '/^[A-z]+$/');

INSERT INTO field_type (field_type_id, name) VALUES (2, 'text');
INSERT INTO field_type (field_type_id, name) VALUES (3, 'email');
INSERT INTO field_type (field_type_id, name) VALUES (4, 'select');
INSERT INTO field_type (field_type_id, name) VALUES (1, 'alphabetic');

INSERT INTO field_type_constraint (field_type_constraint_id, field_type_id, constraint_id) VALUES (1, 1, 1);

INSERT INTO field_type_pattern (field_type_pattern_id, field_type_id, pattern_id) VALUES (2, 3, 1);

INSERT INTO form_type (form_type_id, form_type_name, form_type_description) VALUES (1, 'Seleccion', 'Datos adicionales para seleccion');

INSERT INTO pattern (pattern_id, name, expression, error_message) VALUES (1, 'emailPattern', '(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)', 'EMAIL_ERROR_MESSAGE');